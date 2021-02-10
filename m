Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E42B3166E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhBJMjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhBJMgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:36:47 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34DDC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:36:06 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j11so1694009wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hDKOpaktEStTreJr6wPyslF3miCA2TzjjN6jRt7iPts=;
        b=MrdG9kg6X4KPiSGmo1DrNL18ceyfSYusJI3mskQH0LSvKNMm/WYcibKYxde2grkDwA
         lfRYUMI+VGtFN6mcff2wRbB1VDk/nfeGXF+thBLQWEY7pglU3AujIpTInlvDRDqQmHbF
         X9nSW12/I7Fc9rss3x+U4UClyuNyAX5HmHZD+36pZ33Syrsvcbc3BB9GM7IShNPKO4Az
         BJUPdcg+DolMWdEKLgP5kF5tDx4V7+JCDHlR5TwGMqvtRTPw2mYkVFuKxD+BPUZJnYPz
         UK8NejyKFQehkmOWOhWe7zmeTijKvVaQUJ2bY7dQc/jWeMJEoSqbrkApJovnC2LXV4uR
         kAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hDKOpaktEStTreJr6wPyslF3miCA2TzjjN6jRt7iPts=;
        b=TFV7/gO6O22VRA+ZZIFEzey4yhZIQgyddWcNJG5JDiLYWZRaeSQNqGSxIghCs/tx9i
         3fCpcI2uWaiSmk3e5oP/JmKKVmp3hyzWax5pxjGNCjVhFmiZ3MpmmAuJ2+oD70/P0sqI
         BPWOOlWhcb0BSwoWNHiPxG6jdZ2YxIkRSPrNfPweIbzIk7l87SqazOiiRcb5sD3rCct3
         SLUexPkDpSeV3GemPJ950sGBQ8FYF2lbm4aN3MBX3lx5dxHivodyIxdGiGm8MEY/61Of
         cumWhgmAu31HEOnY64cwSlY23OEGMsuFaCN8YtDT0lVc4Qq2/XY0E3wKyg+qUe+6GNAV
         Ap+w==
X-Gm-Message-State: AOAM531ZARRXkCGeQXysVHxXNVh0OckTtf7b+Q5qD/Bqqi/iE0zrh+d3
        uw2+djX4VZyWMpp+TRdlVl0RIQZcfW55Un/l
X-Google-Smtp-Source: ABdhPJwMyaa98MzWtViUgyDn/EoQoFW2AbbhBoAJhFVNN/hjyjBxi4bL5f3ApCiy1wnIScJOHnwxOA==
X-Received: by 2002:a05:600c:4314:: with SMTP id p20mr2778220wme.52.1612960565373;
        Wed, 10 Feb 2021 04:36:05 -0800 (PST)
Received: from localhost ([49.207.131.89])
        by smtp.gmail.com with ESMTPSA id i10sm3152614wrp.0.2021.02.10.04.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 04:36:04 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:05:53 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] staging: ralink-gdma: Fix checkpatch.pl CHECK
Message-ID: <20210210123553.bzkipyhvedvlcvcc@xps.yggdrail>
References: <20210210120348.262328-1-aakashhemadri123@gmail.com>
 <20210210121915.GX2696@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210121915.GX2696@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/10 03:19PM, Dan Carpenter wrote:
> On Wed, Feb 10, 2021 at 05:33:48PM +0530, Aakash Hemadri wrote:
> > Remove CHECK: Lines should not end with a '('
> >
> > Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> > ---
> >
> >  drivers/staging/ralink-gdma/ralink-gdma.c | 28 ++++++++++++-----------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
> > index 655df317d0ee..a11f915f3308 100644
> > --- a/drivers/staging/ralink-gdma/ralink-gdma.c
> > +++ b/drivers/staging/ralink-gdma/ralink-gdma.c
> > @@ -135,8 +135,7 @@ struct gdma_data {
> >  	int (*start_transfer)(struct gdma_dmaengine_chan *chan);
> >  };
> >
> > -static struct gdma_dma_dev *gdma_dma_chan_get_dev(
> > -	struct gdma_dmaengine_chan *chan)
> > +static struct gdma_dma_dev *gdma_dma_chan_get_dev(struct gdma_dmaengine_chan *chan)
> >  {
> >  	return container_of(chan->vchan.chan.device, struct gdma_dma_dev,
> >  		ddev);
> > @@ -510,10 +509,11 @@ static void gdma_dma_issue_pending(struct dma_chan *c)
> >  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> >  }
> >
> > -static struct dma_async_tx_descriptor *gdma_dma_prep_slave_sg(
> > -		struct dma_chan *c, struct scatterlist *sgl,
> > -		unsigned int sg_len, enum dma_transfer_direction direction,
> > -		unsigned long flags, void *context)
> > +static struct dma_async_tx_descriptor
> > +	*gdma_dma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
>
> Don't do it like this...  The original code is better so, I guess, lets
> leave it as is.  There are two accepted ways to start a function in the
> kernel:
>
> ONE:
> static type
> function_name(paramenters)
>
> TWO
> static type function_name(paramenters)
>
> Either option will let you grep for the names of the functions:
>
> 	egrep "^[a-zA-Z]" dir/file.c | grep '('
>
> regards,
> dan carpenter
>
>

Appreciate the explanation,
Will drop it

thanks,
aakash hemadri
