Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D023482DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbhCXUYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbhCXUYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:24:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C577C06174A;
        Wed, 24 Mar 2021 13:24:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l4so35015048ejc.10;
        Wed, 24 Mar 2021 13:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+q8Gd1+pbo1oAawe9rmDsOu0NCdQjASjyNmuKAHwY/4=;
        b=RIOzvg9ymCE0uJfI54wYuyV/8UDc9u3knm+uSsN0TbeeZqAaF98ooNjdeiJZnoDBgB
         11BO25F1qP9tjGntYxMYxGU7ImduC5+0D0VXIrJhwJ0N4GtOReiOqIY4bag/wJzfsyYo
         bZwA+v9D3Vx//tlbmp1fqlK5FAlKrxD8P4ngjFaMGsGNlHIqBmHAa2Ezv4h2mxzOu2z5
         Z2r3wxc6gs7AlcOUMcRTV5FCLgOz139icPAe1rLXvOZ5oQNoFqRsfzkd0rN1BI8xoWve
         wgTBO4DqlLxmAzYTQBI8x1b9ckvtybgoTV/jQbpXWiUAd3NA6kVUBFbCvSFSs+/9zPZb
         Ntdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+q8Gd1+pbo1oAawe9rmDsOu0NCdQjASjyNmuKAHwY/4=;
        b=QN5mChEY95axsp6hhKJbEnmLL3t1lxULQdPAo9o6CJmfcidhF8Oz7lcZQZnrOkUv3c
         y1SmXTFZDIZIk2cS5CKY/fIor0Hk6hSjPiBLvuIyNyi5aBRGs1w6kdxNSFsS+7AsIPcj
         ISQVzPcrpdz9+XHWoMyac8Rcex6n933ycRJziptXPytqp+PCn/EMuj8spMzo/5d+oP7y
         CN4bTxx22/8dJJszztoMXZzqeCqKBrhISxE4TBYHmff9WgxAP9ChQP6Wh6lxB0U+m7MM
         P8Y8ao5rETqnNmkNgcU1D3DnuBZj8O8im8DxHklUP1IcxdhsHXnj4nQ7EsiQiFek2KGA
         B1mA==
X-Gm-Message-State: AOAM531QlZd2066lfN8e2rr9HEo9klExD0gOt2eXg66tQCmHLzBbD//e
        9Uy/xnaxbmGxqUG2Iw1PrDc=
X-Google-Smtp-Source: ABdhPJyYI3yjerlWh21l+V1Vqkxtk4mAP1KFJWD9PVTrNJeHNGzT1kNDfcJoaHaC+Y2d7wCROjB+oQ==
X-Received: by 2002:a17:907:2093:: with SMTP id pv19mr5773430ejb.134.1616617469891;
        Wed, 24 Mar 2021 13:24:29 -0700 (PDT)
Received: from LEGION ([111.119.187.22])
        by smtp.gmail.com with ESMTPSA id cw14sm1689338edb.8.2021.03.24.13.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 13:24:29 -0700 (PDT)
Message-ID: <abc46d0ad37b9e59ac71288d04e43c9911f71072.camel@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix missing return assignment
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, colin.king@canonical.com
Date:   Thu, 25 Mar 2021 01:24:23 +0500
In-Reply-To: <20210324185047.GP1667@kadam>
References: <20210324172604.GA380592@LEGION> <20210324185047.GP1667@kadam>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-24 at 21:50 +0300, Dan Carpenter wrote:
> On Wed, Mar 24, 2021 at 10:26:04PM +0500, Muhammad Usama Anjum wrote:
> > Return value of usb_driver_claim_interface should not be ignored.
> > Instead it should be stored in err variable and returned from
> > this function.
> > 
> > Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> > ---
> >  sound/usb/quirks.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> > index 9e5e37eff10e..dd32ceaef18a 100644
> > --- a/sound/usb/quirks.c
> > +++ b/sound/usb/quirks.c
> > @@ -427,10 +427,10 @@ static int create_autodetect_quirks(struct snd_usb_audio *chip,
> >  
> >  		err = create_autodetect_quirk(chip, iface, driver);
> >  		if (err >= 0)
> 
> create_autodetect_quirk() never returns positive values.  Flip this
> condition.  (Always do error handling, don't do success handling).
> 
> 		if (err)
> 			continue;

Got it. I'll send a patch.
> 
> 
> > -			usb_driver_claim_interface(driver, iface, (void *)-1L);
> > +			err = usb_driver_claim_interface(driver, iface, (void *)-1L);
> 
> This is in a loop so only the last return value is used.  Which seems
> sort of weird and pointless that the last value would matter more than
> the others.
> 
Correct. Lets not store the return value. To stop the static analyzers
to report the missing return assignment, can we add (void) in start of
this function call? I've not seen use of (void) this way in the
kernel. Is there any other way used in the kernel?

> >  	}
> >  
> > -	return 0;
> > +	return err;
> 
> regards,
> dan carpenter
> 

