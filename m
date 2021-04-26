Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7F136BB18
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhDZVQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbhDZVQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:16:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3916C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:15:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n21so10325635eji.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZFlhpygn8M9EkNHixa9n8+YKO0Uh75M+mziq2r4Nds=;
        b=fWgz6f4yosjxvhK4oBJWUk//RGRkA5YzgIO8cuEHztdUjOnp1b8XsIYsoB/pCBJJjY
         Jlyafl1sV6eNHsZabINsp8uAb2fEpHvEqNurFqdHiujovezcXHGhm/LLnVR/LTjeRnCH
         7xKFou6fU45nCDikjE5XRopc4GayoCnWNGECAVKL+DQAHUkTOSFDaPi2qZJr8RCehjUm
         E8arJ3jNbv8LzH9WCPlo2pu8FD0pMB9cIB6wXnCi2rplaaADuazTLt4B5+5e9lL02tF4
         8BR2p3GONx4jeFsBPgveLcp8LdU8gqchxyfQzCJtS/DAVxjymBAZyxMENgnZyGwx/aRq
         LP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZFlhpygn8M9EkNHixa9n8+YKO0Uh75M+mziq2r4Nds=;
        b=N/NRXNMBZ8iplFuKS+i03Pi2TZ0daHo2BpM1oZDwQV5DYdi6spfHAqB5Xv82zFUkn2
         QXWHwvON8v7apg5A1xxTk8GPt7U0xpLwiwoJMlfeoIPlPnY7t9yBi3Q/ayiG5fiPBl3K
         3dcR1t1wK/+GVQP/xocpg5b+Q9Blj4PaNm/wxW2n33imz4Ap4Q00WU21s6sLjwFLhNWs
         Jrtk+arGHB7kXDP1AQ76T4eZOJlaAC1FPR/EmJVrfB1gMvkugmocxsasFbpaXqPEn5dH
         F21OhnGj0X74ElKYVAS0/OsH3/zifJAWwRWJdbrqXb0G9UxtS+2pVX4dKnszXW71Z2YU
         GHug==
X-Gm-Message-State: AOAM533Fq7VyjSyqmYjmE47WrWHgK5FV6s2OaawRJblLfFYMmmL5ymtj
        m9rihrLgKcLIZvwX19eIyQA=
X-Google-Smtp-Source: ABdhPJxcQnmKb0hGu52KiMZlWh4alDUzBnl4/bSO/ZkRymltqG5TaE2LDvOQDdi8IVDhWWtD/jR10A==
X-Received: by 2002:a17:906:e105:: with SMTP id gj5mr8964318ejb.388.1619471742561;
        Mon, 26 Apr 2021 14:15:42 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id sb20sm1390477ejb.100.2021.04.26.14.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 14:15:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [PATCH v3] staging: unisys: visorhba: Convert module from IDR to XArray
Date:   Mon, 26 Apr 2021 23:15:40 +0200
Message-ID: <107967147.Ip005GxVp3@linux.local>
In-Reply-To: <20210426192101.GQ235567@casper.infradead.org>
References: <20210426184245.12269-1-fmdefrancesco@gmail.com> <20210426192101.GQ235567@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 26, 2021 9:21:01 PM CEST Matthew Wilcox wrote:
> On Mon, Apr 26, 2021 at 08:42:45PM +0200, Fabio M. De Francesco wrote:
> > +static void setup_scsitaskmgmt_handles(struct xarray *xa, struct 
uiscmdrsp *cmdrsp,
> > 
> >  				       wait_queue_head_t *event, 
int *result)
> >  
> >  {
> > 
> > -	/* specify the event that has to be triggered when this */
> > -	/* cmd is complete */
> > -	cmdrsp->scsitaskmgmt.notify_handle =
> > -		simple_idr_get(idrtable, event, lock);
> > -	cmdrsp->scsitaskmgmt.notifyresult_handle =
> > -		simple_idr_get(idrtable, result, lock);
> > +	u32 id;
> > +	int ret;
> > +
> > +	/* specify the event that has to be triggered when this cmd is 
complete */
> > +	id = (u32)cmdrsp->scsitaskmgmt.notify_handle;
> > +	ret = xa_alloc_irq(xa, &id, event, XA_LIMIT(1, INT_MAX), 
GFP_KERNEL);
> 
> OK, think this one through a bit.  When xa_alloc_irq() stores the ID that
> it assigned into 'id', what happens to it next?
>
Oh, I overlooked that... The ID in 'id' is lost when the function exits and 
the stack frame is unwound.

Now I have another problem: xa_alloc_irq() writes id u32* but I have an u64* 
in 'id'. What happens if I cast 'id' to an u32* when passing it to 
xa_alloc_irq()?

u64 *id;
int ret;
id = &cmdrsp->scsitaskmgmt.notify_handle;
ret = xa_alloc_irq(xa, (u32 *)id, event, XA_LIMIT(1, INT_MAX), GFP_KERNEL);

Do I destroy the information stored in 'id' with that cast?
> 
> > +	id = (u32)cmdrsp->scsitaskmgmt.notifyresult_handle;
> > +	ret = xa_alloc_irq(xa, &id, result, XA_LIMIT(1, INT_MAX), 
GFP_KERNEL);
> > 
> >  }
> > 
> > @@ -1053,8 +1018,6 @@ static int visorhba_probe(struct visor_device *dev)
> > 
> >  	if (err)
> >  	
> >  		goto err_debugfs_info;
> > 
> > -	idr_init(&devdata->idr);
> 
> You still need to initialise the XArray, either with xa_init() or by
> using DEFINE_XARRAY.  Since it's dynamically allocated, the former is
> correct.
>
I had read that XArray must be initialized with xa_init(). However, when I 
deleted the line with the initialization of the IDR, I forgot to replace it 
with a statement that uses xa_init().

Thanks,

Fabio




