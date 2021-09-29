Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF7A41CAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346163AbhI2Q6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346221AbhI2Q6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:58:16 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8C7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=ysDSBYfH+9lnSZYNya7VTHwC5qwPkWB2y4lW2wuez0U=; b=cAt/
        13l1UFAw8RgU6FSzt4+Cz85KwL81LYREyzxwZImjp+4LKn6cd9RKlhgP7dHY8btPe1OvMZ2U4rPlV
        IAdgZ5N4BqTDFA5PgmJ3DRvLPmDlkapvVrUzsIGgMejzGLXDDCw89CapH0tghCM5i4gSVZSd4Hoo8
        m88hzHtZBTviFSMA5TfVQxgzycF7LcKuDxDlQKxlqyFma8UUbb+0c/jNAhKoXKi4GhdRJBckGwZeR
        Z6uwk0hceUleiobObKqmog/J2IwNk1h4R4Yxjwsfv+H+639BjID8Hz4F1V7IkEWw7IR3Z06MGyn0I
        tTXpUOiPPL4N5G4Ws+drad9vtZof8Q==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mVcsi-000733-P6; Wed, 29 Sep 2021 17:56:32 +0100
Date:   Wed, 29 Sep 2021 17:56:32 +0100
From:   John Keeping <john@metanate.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ALSA: rawmidi: Fix potential UAF from sequencer
 destruction
Message-ID: <20210929175632.50b78be8.john@metanate.com>
In-Reply-To: <s5hv92jl7t2.wl-tiwai@suse.de>
References: <20210929113620.2194847-1-john@metanate.com>
        <s5hzgrvl9j0.wl-tiwai@suse.de>
        <20210929161758.49ce947f.john@metanate.com>
        <s5hv92jl7t2.wl-tiwai@suse.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 17:28:57 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> On Wed, 29 Sep 2021 17:17:58 +0200,
> John Keeping wrote:
> > 
> > On Wed, 29 Sep 2021 16:51:47 +0200
> > Takashi Iwai <tiwai@suse.de> wrote:
> >   
> > > On Wed, 29 Sep 2021 13:36:20 +0200,
> > > John Keeping wrote:  
> > > > 
> > > > If the sequencer device outlives the rawmidi device, then
> > > > snd_rawmidi_dev_seq_free() will run after release_rawmidi_device() has
> > > > freed the snd_rawmidi structure.
> > > > 
> > > > This can easily be reproduced with CONFIG_DEBUG_KOBJECT_RELEASE.
> > > > 
> > > > Keep a reference to the rawmidi device until the sequencer has been
> > > > destroyed in order to avoid this.
> > > > 
> > > > Signed-off-by: John Keeping <john@metanate.com>    
> > > 
> > > Thanks for the patch.  I wonder, though, how this could be triggered.
> > > Is this the case where the connected sequencer device is being used
> > > while the sound card gets released?  Or is it something else?  
> > 
> > I'm not sure if it's possible to trigger via the ALSA API; I haven't
> > found a route that can trigger it, but that doesn't mean there isn't
> > one :-)
> > 
> > Mostly this is useful to make CONFIG_DEBUG_KOBJECT_RELEASE cleaner.  
> 
> Hm, then could you check whether the patch below papers over it
> instead?

No, this patch doesn't solve it.  The issue is that the effect of the
final device_put() is delayed from the time it is called and there is no
way to guarantee the ordering without ensuring the sequencer has been
destroyed before the final reference to the rawmidi device is put.

Both of the functions involved are called from the core
device::release() hook.

I'm using the patch below to easily check that the sequencer has been
freed before the rawmidi data.  This can easily be triggered by
unplugging a USB MIDI device (it's not 100% since the kobject release
delays are random).

-- >8 --
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1571,7 +1571,10 @@ static int snd_rawmidi_alloc_substreams(struct snd_rawmidi *rmidi,
 
 static void release_rawmidi_device(struct device *dev)
 {
-       kfree(container_of(dev, struct snd_rawmidi, dev));
+       struct snd_rawmidi *rmidi = container_of(dev, struct snd_rawmidi, dev);
+
+       WARN_ON(rmidi->seq_dev);
+       kfree(rmidi);
 }
 
 /**
-- 8< --

> --- a/sound/core/seq/seq_ports.c
> +++ b/sound/core/seq/seq_ports.c
> @@ -415,11 +415,16 @@ static int subscribe_port(struct snd_seq_client *client,
>  			grp->count--;
>  		}
>  	}
> -	if (err >= 0 && send_ack && client->type == USER_CLIENT)
> +	if (err < 0)
> +		return err;
> +
> +	if (send_ack && client->type == USER_CLIENT)
>  		snd_seq_client_notify_subscription(port->addr.client, port->addr.port,
>  						   info, SNDRV_SEQ_EVENT_PORT_SUBSCRIBED);
> +	else if (client->type == KERNEL_CLIENT)
> +		get_device(&client->data.kernel.card->card_dev);
>  
> -	return err;
> +	return 0;
>  }
>  
>  static int unsubscribe_port(struct snd_seq_client *client,
> @@ -439,6 +444,8 @@ static int unsubscribe_port(struct snd_seq_client *client,
>  		snd_seq_client_notify_subscription(port->addr.client, port->addr.port,
>  						   info, SNDRV_SEQ_EVENT_PORT_UNSUBSCRIBED);
>  	module_put(port->owner);
> +	if (client->type == KERNEL_CLIENT)
> +		snd_card_unref(client->data.kernel.card);
>  	return err;
>  }
>  

