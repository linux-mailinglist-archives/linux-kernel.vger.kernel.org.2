Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98D13A8607
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhFOQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhFOQG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:06:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CFDC061767
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:04:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u18so8081708plc.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gw2oHDXVQvWw8DrWhZyesLBZX3xqY81dz1Mhcj9xl+k=;
        b=JUj8pZ1qVRjRKHnjaHS6ATWMhYGJXuJFfwnPVcwawU8F2l82PYCA0YXSokUWXzlDYw
         4Qoeg1yhPj/ROVk2H8Dvdf7baXXiS3XBOnWcwSEHJVrIGuh0QhysI7TuvwVfXq1z2fWR
         LjwsPmoJ2izkzV0M79i3QbpKU9hNx5rnq/DNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gw2oHDXVQvWw8DrWhZyesLBZX3xqY81dz1Mhcj9xl+k=;
        b=tG6NV49z1l/Ltouv6299jnX3cj3cxJp9P3crO4bJWtDX1Yw9LoHzJiEK0ABgL7uBEr
         9HFLXjF9MPbhTWQl9HBrjYcmAUd9W/iWfs3PPZvCiUcxwYZtmItVTQM4vXkTi4O4FUx/
         QkwrUO1N4io5Hyc0ovQpju0vp81/00srIwbOURphqKtcZ2dd8gq/OUEmacSNTxGqDm0D
         /VVrdAdZNdqJ9H8X27QfW/NaS52JJ/q6lbu5SI5LhqET0RfNlvqwN7lk+eJNlYOE7EfE
         TCcIS+ouW0ZtvJIYram007Y0O58V4Nz8jZpeM6/BXKOXxlFLA9dAxx30uH60yRKcX1L0
         9UXQ==
X-Gm-Message-State: AOAM532x2CQEcujsa9vu4FOzpholO850HsYLDjlILm6ajzeBPhqo/6Xv
        fMr/pmtsWmb6Y8LyE6B10Cm9gA==
X-Google-Smtp-Source: ABdhPJz2rstwVgeIvxg+8DgWOqz5xdzUNTzL+mT2t2ebQfbCN6I6QmLAsdV7xTYxLJni7w57LHv67A==
X-Received: by 2002:a17:90a:f013:: with SMTP id bt19mr5421357pjb.201.1623773061310;
        Tue, 15 Jun 2021 09:04:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ei10sm15551868pjb.8.2021.06.15.09.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:04:20 -0700 (PDT)
Date:   Tue, 15 Jun 2021 09:04:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>, axboe@kernel.dk,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pstore/blk: Use the normal block device I/O path
Message-ID: <202106150854.30F58015@keescook>
References: <20210614200421.2702002-1-keescook@chromium.org>
 <20210615123118.GA14239@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210615123118.GA14239@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 02:31:18PM +0200, Christoph Hellwig wrote:
> > -	if (!dev || !dev->total_size || !dev->read || !dev->write)
> > +	if (!dev || !dev->total_size || !dev->read || !dev->write) {
> > +		if (!dev)
> > +			pr_err("NULL device info\n");
> > +		else {
> > +			if (!dev->total_size)
> > +				pr_err("zero sized device\n");
> > +			if (!dev->read)
> > +				pr_err("no read handler for device\n");
> > +			if (!dev->write)
> > +				pr_err("no write handler for device\n");
> > +		}
> >  		return -EINVAL;
> > +	}
> 
> This is completely unrelated and should be a separate patch.  And it
> also looks rather strange, I'd at very least split the dev check out
> and return early without the weird compound statement, but would probably
> handle each one separate.  All assuming that we really need all these
> debug printks.

Agreed -- I've moved it to a separate patch.

> >  /*
> >   * This takes its configuration only from the module parameters now.
> >   */
> >  static int __register_pstore_blk(void)
> 
> This needs a __init annotation now.

Ah yes, good point. I've rearranged things to avoid this.

> >  {
> > +	struct pstore_device_info dev = {
> > +		.read = psblk_generic_blk_read,
> > +		.write = psblk_generic_blk_write,
> > +	};
> 
> On-stack method tables are a little odd..

struct pstore_device_info is mainly an argument passing structure, not
an ops structure. There is some weird over-engineering here, which I'll
fix up in a follow-up patch.

> > +	if (!__is_defined(MODULE)) {
> 
> This looks a little weird.  Can we define a rapper for this in config.h
> that is a little more self-explanatory, e.g. in_module()?

I've adjusted this.

> 
> > +	if (!psblk_file->f_mapping)
> > +		pr_err("missing f_mapping\n");
> 
> Can't ever be true.
> 
> > +	else if (!psblk_file->f_mapping->host)
> > +		pr_err("missing host\n");
> 
> Can't ever be true either.
> 
> > +	else if (!I_BDEV(psblk_file->f_mapping->host))
> > +		pr_err("missing I_BDEV\n");
> > +	else if (!I_BDEV(psblk_file->f_mapping->host)->bd_inode)
> > +		pr_err("missing bd_inode\n");
> 
> І_BDEV just does pointer arithmetics, so it can't ever return NULL.
> And there are no block device inodes without bd_inode either.  And
> all of this is per definition present for open S_ISBLK inodes.

Okay, good. There were a lot of dead-ends in here, and after the removal
of i_bdev, it wasn't obvious which things were going to exist. I've
removed all these checks.

One thing I noticed it that it seems we're missing a global helper for
"->f_mapping->host", which I see repeated a lot. (There is a local
helper bdev_file_inode().)

$ git grep '\bf_mapping->host\b' | wc -l
149


Thanks for the review! I'll send a v2 series.

-- 
Kees Cook
