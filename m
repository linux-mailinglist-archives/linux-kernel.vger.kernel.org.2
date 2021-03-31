Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B604E349BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhCYVlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhCYVlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:41:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E059C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:41:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e33so3118732pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D/4KZMAlbXLgx+1fzHn/h/cE3L4iWN9TmIPJM+L9kJQ=;
        b=HItToSmpEzU6HsTtaz98v51Y1qcQDS0ce2ocHCBvFaJVuu/op58RcGnubdB6xnrkmq
         45CtCSfjwiY0QKLkrvZJjIjI5qLNQg6xSVjJWAqyeEqvbyVEOaFdETnHpG83JhFGGhj1
         XsAllx0bRcReubr9IgnISK3YP7rliPVATSdaPjD5hL1AQGNUogxHFZ8verQwUkBBZFi2
         WYZQ9eavVbjkuhl/MhpuqYs94Bcwmx/HD9PbA94EnNAK++T1zJe0iVOZRq1532Nmsg1C
         o8TGozrnFvV7h9z4E9NXZLhh5GUIfHfQBScTip9TkliZGiEXwI/vAkJwwKeE9CfR8kWg
         RoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D/4KZMAlbXLgx+1fzHn/h/cE3L4iWN9TmIPJM+L9kJQ=;
        b=oK57h/X6hPRcUBstyNC5CbDYZwgUL53QMf8lm/czIs9z1zUy4lEzuUTtSnZq0NXGxq
         t6X+Hi4xqzD5wW56jo1J4GP1Tbdi5ou1UmFyKsG/JAGaEL+q78aM5ZAe2rihotmNcIco
         eWrCMem9DVy1S/A9+zRAZohtZv78NpGUzXiT2NuFEKc/ZpwPFGJx0LMwPVkwsYGrBsdf
         jgwyGKr7sOOFH5cl4IgSqM9ZA82rO20O1kuzNslNQdG/3aH6xwW0471tbx3NzGbacoMn
         NQK708ApjcAY/XpRRMVEu4AeCrYexgE90vI+y00XpxVbxK2ArlV4v6nALXDANw0ZJFM0
         HFKw==
X-Gm-Message-State: AOAM531OHDhwZIJ2bscdGvs3MkanhAQfDQb0+ZV/ZV3pjQPKQezWR9IV
        Sdy25XiB87XrHAqbzZgC5cTz7EtcVTs5Ig==
X-Google-Smtp-Source: ABdhPJz8FPXAYxfey9NelgCRRkP1MH4cnV1TkOpd4uNsyZm+oGKVpO3h0J3NqEMaY4nYicD0voMHSQ==
X-Received: by 2002:a63:1502:: with SMTP id v2mr9132692pgl.22.1616708470903;
        Thu, 25 Mar 2021 14:41:10 -0700 (PDT)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id j22sm6027328pjz.3.2021.03.25.14.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 14:41:10 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:41:06 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 0/7] ensure bios aren't split in middle of crypto data
 unit
Message-ID: <YF0DcnkXy2l5WJzW@google.com>
References: <20210114154723.2495814-1-satyat@google.com>
 <20210121171129.GA4122715@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121171129.GA4122715@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 05:11:29PM +0000, Christoph Hellwig wrote:
> On Thu, Jan 14, 2021 at 03:47:16PM +0000, Satya Tangirala wrote:
> > When a bio has an encryption context, its size must be aligned to its
> > crypto data unit size. A bio must not be split in the middle of a data
> > unit. Currently, bios are split at logical block boundaries, but a crypto
> > data unit size might be larger than the logical block size - e.g. a machine
> > could be using fscrypt (which uses 4K crypto data units) with an eMMC block
> > device with inline encryption hardware that has a logical block size of
> > 512 bytes. So we need to support cases where the data unit size is larger
> > than the logical block size.
> 
> I think this model is rather broken.  Instead of creating an -EIO path
> we can't handle anywhere make sure that the size limits exposed by the
> driver that wants to split always align to the crypto data units to
> avoid this issue to start with.
Hey Christoph,
Thanks for the suggestion. I finally sent out v2 for this patch at
https://lore.kernel.org/linux-block/20210325212609.492188-1-satyat@google.com/

I tried doing something similar to what you suggested to avoid
creating an -EIO path, but instead of changing the size limits exposed
by the driver, I changed the allowed data unit sizes based on the
exposed size limits. I did it that way because the limits that
interfere with inline encryption happen to be "hard limits" a driver
can't lie about, like having support for SG gaps or not requiring
chunk sectors. Another reason for doing it this way is so that we
don't interfere with regular unencrypted I/O by changing driver
exposed limits unconditionally (and I didn't think it was
straightforward to expose two different sets of limits of encrypted
and unencrypted I/O respectively). Please take a look at the new patch
series if you're able to. Thanks!
