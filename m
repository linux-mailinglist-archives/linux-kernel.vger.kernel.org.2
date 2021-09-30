Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE8141D7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350023AbhI3K3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349962AbhI3K3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:29:40 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC9C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=gvuAQCRw/XgU+VwBMCubv+50avjq2QI/UZMSE20Vryg=; b=jGC4
        8KlySDCZaLLu0jF60pqzGinnCKWUB155J745yCcZ6kL0mhR2nB/0iyHwVxC1YLQ3J2GdIovt5FEPZ
        bcU9sTS6U+KEig4rnmPGEYIhRbTMaqkRmHJiQqL5mYNZtO0hX930frISATwUFj4c4/dZzWV6OVYCe
        2QfWINZ5dH2cGvB8+o8Q0SRihMZArfnJxOcdqJEUaPWSUrQAUXvFWC59jUu156uzwttMy/dJ3ZCwc
        Md2snBEV+vjrsa3y4gBRiSA6wDYapgJUsK/4K5UsWVdIjc65z27G0OWtbJ2/N5/VExQKCDULkeVD5
        ZxYX5oHyiZD5LoLGdThBScBpQ/5/IQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mVtIA-000314-AG; Thu, 30 Sep 2021 11:27:54 +0100
Date:   Thu, 30 Sep 2021 11:27:53 +0100
From:   John Keeping <john@metanate.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ALSA: rawmidi: Fix potential UAF from sequencer
 destruction
Message-ID: <20210930112753.40e1efa6.john@metanate.com>
In-Reply-To: <s5hczoqlfgn.wl-tiwai@suse.de>
References: <20210929113620.2194847-1-john@metanate.com>
        <s5hzgrvl9j0.wl-tiwai@suse.de>
        <20210929161758.49ce947f.john@metanate.com>
        <s5hv92jl7t2.wl-tiwai@suse.de>
        <20210929175632.50b78be8.john@metanate.com>
        <s5hfstmlgkj.wl-tiwai@suse.de>
        <s5hczoqlfgn.wl-tiwai@suse.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 08:55:52 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> On Thu, 30 Sep 2021 08:31:56 +0200,
> Takashi Iwai wrote:
> > 
> > On Wed, 29 Sep 2021 18:56:32 +0200,
> > John Keeping wrote:
> > > 
> > > On Wed, 29 Sep 2021 17:28:57 +0200
> > > Takashi Iwai <tiwai@suse.de> wrote:
> > > 
> > > > On Wed, 29 Sep 2021 17:17:58 +0200,
> > > > John Keeping wrote:
> > > > > 
> > > > > On Wed, 29 Sep 2021 16:51:47 +0200
> > > > > Takashi Iwai <tiwai@suse.de> wrote:
> > > > >   
> > > > > > On Wed, 29 Sep 2021 13:36:20 +0200,
> > > > > > John Keeping wrote:  
> > > > > > > 
> > > > > > > If the sequencer device outlives the rawmidi device, then
> > > > > > > snd_rawmidi_dev_seq_free() will run after release_rawmidi_device() has
> > > > > > > freed the snd_rawmidi structure.
> > > > > > > 
> > > > > > > This can easily be reproduced with CONFIG_DEBUG_KOBJECT_RELEASE.
> > > > > > > 
> > > > > > > Keep a reference to the rawmidi device until the sequencer has been
> > > > > > > destroyed in order to avoid this.
> > > > > > > 
> > > > > > > Signed-off-by: John Keeping <john@metanate.com>    
> > > > > > 
> > > > > > Thanks for the patch.  I wonder, though, how this could be triggered.
> > > > > > Is this the case where the connected sequencer device is being used
> > > > > > while the sound card gets released?  Or is it something else?  
> > > > > 
> > > > > I'm not sure if it's possible to trigger via the ALSA API; I haven't
> > > > > found a route that can trigger it, but that doesn't mean there isn't
> > > > > one :-)
> > > > > 
> > > > > Mostly this is useful to make CONFIG_DEBUG_KOBJECT_RELEASE cleaner.  
> > > > 
> > > > Hm, then could you check whether the patch below papers over it
> > > > instead?
> > > 
> > > No, this patch doesn't solve it.  The issue is that the effect of the
> > > final device_put() is delayed from the time it is called and there is no
> > > way to guarantee the ordering without ensuring the sequencer has been
> > > destroyed before the final reference to the rawmidi device is put.
> > > 
> > > Both of the functions involved are called from the core
> > > device::release() hook.
> > > 
> > > I'm using the patch below to easily check that the sequencer has been
> > > freed before the rawmidi data.  This can easily be triggered by
> > > unplugging a USB MIDI device (it's not 100% since the kobject release
> > > delays are random).
> > 
> > Hm, it's strange.  I suppose you're *not* using the MIDI device,
> > right?
> > 
> > The release path for the USB-audio driver is:
> >   usb_audio_disconnect() ->
> >     snd_card_free_when_closed() ->
> >       release_card_device() (via put_device(&card->card_dev)) ->
> >         snd_card_do_free()
> > 
> > And here in snd_card_do_free(), the snd_device free-callback chains
> > are called at the beginning (snd_device_free_all()).
> > As it's executed in a reverse loop, snd_rawmidi_dev_seq_free() shall
> > be called before snd_rawmidi_dev_free().  Since the final put_device()
> > for the rawmidi device is called in the latter function, the device
> > release must not happen before snd_rawmidi_dev_seq_free()...
> 
> Correction: now I finally understood what I misunderstood.
> Although the snd_device call chain mentioned above itself is correct,
> the snd_rawmidi_dev_seq_free() function isn't called directly from the
> snd_device chain, but it's rater the own private_free of
> snd_seq_device object.  That is, the call of snd_seq_device
> private_free is done in a wrong place; it should be called in the
> snd_device call chain instead of the device release.
> 
> A fix patch is something like below.  Could you check whether this
> fixes the problem?

Yes, this fixes it!


Thanks,
John

> --- a/sound/core/seq_device.c
> +++ b/sound/core/seq_device.c
> @@ -156,6 +156,8 @@ static int snd_seq_device_dev_free(struct snd_device *device)
>  	struct snd_seq_device *dev = device->device_data;
>  
>  	cancel_autoload_drivers();
> +	if (dev->private_free)
> +		dev->private_free(dev);
>  	put_device(&dev->dev);
>  	return 0;
>  }
> @@ -183,11 +185,7 @@ static int snd_seq_device_dev_disconnect(struct snd_device *device)
>  
>  static void snd_seq_dev_release(struct device *dev)
>  {
> -	struct snd_seq_device *sdev = to_seq_dev(dev);
> -
> -	if (sdev->private_free)
> -		sdev->private_free(sdev);
> -	kfree(sdev);
> +	kfree(to_seq_dev(dev));
>  }
>  
>  /*
> 
> 
> 

