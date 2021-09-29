Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FBC41C826
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345141AbhI2PTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345123AbhI2PTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:19:42 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD2C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=rjLdat9yjq8HJiW+J7pr/WIptZGdEDDoclvqwXbUkQY=; b=3CEN
        o1UUUnLZKR38/86YRTizDTxRbVFFPrXI8QuzlwgwFG60+HuKuUzGMEWzwqmRiLPAfHlVxVpIs/28F
        OcFPYiZqfv+3WYXY/yR26RjOyrhOMtrf8Co+ZSgn9XdCjMtotAwuMfccE0M/5hzvJ3Lya5hdRXnqK
        Xz7787w1WfNKf0k9kH54dBk8ME6xdqsPTc/aEkOCUnbbeAGd4YAJkZD61ZMNxIFAVrQhrfTemHlj+
        ufFUDyDV7kdbBxIpj10AG0SgxJoT2NW/mJCkyjpufd8rutsVfoJ3xYM4G8Uf/+tbsPziLWIDw2jUa
        agETGjBFi+l6mtv7OhdH4Z8oBO1vkw==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mVbLL-0005pI-2d; Wed, 29 Sep 2021 16:17:59 +0100
Date:   Wed, 29 Sep 2021 16:17:58 +0100
From:   John Keeping <john@metanate.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ALSA: rawmidi: Fix potential UAF from sequencer
 destruction
Message-ID: <20210929161758.49ce947f.john@metanate.com>
In-Reply-To: <s5hzgrvl9j0.wl-tiwai@suse.de>
References: <20210929113620.2194847-1-john@metanate.com>
        <s5hzgrvl9j0.wl-tiwai@suse.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 16:51:47 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> On Wed, 29 Sep 2021 13:36:20 +0200,
> John Keeping wrote:
> > 
> > If the sequencer device outlives the rawmidi device, then
> > snd_rawmidi_dev_seq_free() will run after release_rawmidi_device() has
> > freed the snd_rawmidi structure.
> > 
> > This can easily be reproduced with CONFIG_DEBUG_KOBJECT_RELEASE.
> > 
> > Keep a reference to the rawmidi device until the sequencer has been
> > destroyed in order to avoid this.
> > 
> > Signed-off-by: John Keeping <john@metanate.com>  
> 
> Thanks for the patch.  I wonder, though, how this could be triggered.
> Is this the case where the connected sequencer device is being used
> while the sound card gets released?  Or is it something else?

I'm not sure if it's possible to trigger via the ALSA API; I haven't
found a route that can trigger it, but that doesn't mean there isn't
one :-)

Mostly this is useful to make CONFIG_DEBUG_KOBJECT_RELEASE cleaner.


Regards,
John

> > ---
> >  sound/core/rawmidi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
> > index 6f30231bdb88..b015f5f69175 100644
> > --- a/sound/core/rawmidi.c
> > +++ b/sound/core/rawmidi.c
> > @@ -1860,6 +1860,7 @@ static void snd_rawmidi_dev_seq_free(struct snd_seq_device *device)
> >  	struct snd_rawmidi *rmidi = device->private_data;
> >  
> >  	rmidi->seq_dev = NULL;
> > +	put_device(&rmidi->dev);
> >  }
> >  #endif
> >  
> > @@ -1936,6 +1937,9 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
> >  #if IS_ENABLED(CONFIG_SND_SEQUENCER)
> >  	if (!rmidi->ops || !rmidi->ops->dev_register) { /* own registration mechanism */
> >  		if (snd_seq_device_new(rmidi->card, rmidi->device, SNDRV_SEQ_DEV_ID_MIDISYNTH, 0, &rmidi->seq_dev) >= 0) {
> > +			/* Ensure we outlive the sequencer (see snd_rawmidi_dev_seq_free). */
> > +			get_device(&rmidi->dev);
> > +
> >  			rmidi->seq_dev->private_data = rmidi;
> >  			rmidi->seq_dev->private_free = snd_rawmidi_dev_seq_free;
> >  			sprintf(rmidi->seq_dev->name, "MIDI %d-%d", rmidi->card->number, rmidi->device);
> > -- 
> > 2.33.0
> >   

