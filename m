Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6B34DCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 02:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhC3AWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 20:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhC3AVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 20:21:38 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2440AC061764
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 17:21:36 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id o19so7401096qvu.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 17:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protocubo.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ZkXqYoDX+FAm0xvt3yNtCo8uOVPksVsoKc/yRnHv20=;
        b=LlooFwGiDqHlX93thuHZmLBhQhle4oxNY85pRZKt7MEVMwacDPvwKGhOlPxcxSpI5v
         MGlsuMT2cBZvk6bvTnjJgP7v2bcUwx41pRyjwYDFp2q48cb5xgPxNsqaBSGX5L6U+FnW
         UKCEQ0OZR3tEZlleNIucf8FBJn2hwA9upfkoA+OPaMo5T+/ecSvKRIjM8Zmw/AcCzRHM
         z62EcDIzAPOjPOgnUV2/XOpdaXsC/AUFfefvE5xyjoZRZJ2hgzhexxtLP4uOZzwoIm0D
         sfdpA2FMiAl7uhhmaB1yTY1nK4NQOv6C2jOHjGSGT9CC7uDgycrRtDjSfkdGQS2sLgZ4
         bgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ZkXqYoDX+FAm0xvt3yNtCo8uOVPksVsoKc/yRnHv20=;
        b=t91ycJ+9WRUr4d8SvBtHE8TR2yernM9sCaPL0tKQ3Z/X4Nmx5Dz2iqcO2p1S8En60Q
         elSbzS1kEL8RfdsOeKOqvRPK6t/Q0zzX4rJVCkEk+9ZtDOFz5HSA0dfWU78HqXpQqtj0
         iEBjWwbeL44SAnJ/qUQ3kCWWZJPcrG1EVG+9FDtB4/bfNnCaZRz5GVE3QeRftTt0d7AI
         dULObb8ye+NX85WojNvRxR3KvcvFGzUBaJkZgTM0QiR9RdjctyFUl8bvwPcTdTYH5Rjp
         2wplK3HJbewcGirBPtlCCVq2VYgQpm/iuUGSymGA3YLKmCs+nHN2ofuY+BR+5C5uUodQ
         CMhQ==
X-Gm-Message-State: AOAM532MjxMtR3zOh1ZNtkkgeuCWkn8ri+nqTw6DGAjgfxImHSgmtQsF
        U1BWvzBTIhUSO3h/IUJ+0sNNEETvQp74FQ==
X-Google-Smtp-Source: ABdhPJwp2jMLY8S9kaEns2gA8JXnhvKTOIvu66IT+dRu/S7AidGLZj8p1bPAKRSYl/IzVlurKuBIaw==
X-Received: by 2002:ad4:4e0d:: with SMTP id dl13mr27462620qvb.56.1617063695349;
        Mon, 29 Mar 2021 17:21:35 -0700 (PDT)
Received: from calvin.localdomain ([2804:14d:5c5a:802e:bdc9:ded9:cc08:a4e9])
        by smtp.gmail.com with ESMTPSA id o36sm12317011qtd.89.2021.03.29.17.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 17:21:34 -0700 (PDT)
Date:   Mon, 29 Mar 2021 21:21:31 -0300
From:   Jonas Malaco <jonas@protocubo.io>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nzxt-kraken2) mark and order concurrent accesses
Message-ID: <20210330002131.s2qz3dr6bwr6jz25@calvin.localdomain>
References: <20210329082211.86716-1-jonas@protocubo.io>
 <20210329215339.GH220164@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210329215339.GH220164@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 02:53:39PM -0700, Guenter Roeck wrote:
> On Mon, Mar 29, 2021 at 05:22:01AM -0300, Jonas Malaco wrote:
> > To avoid a spinlock, the driver explores concurrent memory accesses
> > between _raw_event and _read, having the former updating fields on a
> > data structure while the latter could be reading from them.  Because
> > these are "plain" accesses, those are data races according to the Linux
> > kernel memory model (LKMM).
> > 
> > Data races are undefined behavior in both C11 and LKMM.  In practice,
> > the compiler is free to make optimizations assuming there is no data
> > race, including load tearing, load fusing and many others,[1] most of
> > which could result in corruption of the values reported to user-space.
> > 
> > Prevent undesirable optimizations to those concurrent accesses by
> > marking them with READ_ONCE() and WRITE_ONCE().  This also removes the
> > data races, according to the LKMM, because both loads and stores to each
> > location are now "marked" accesses.
> > 
> > As a special case, use smp_load_acquire() and smp_load_release() when
> > loading and storing ->updated, as it is used to track the validity of
> > the other values, and thus has to be stored after and loaded before
> > them.  These imply READ_ONCE()/WRITE_ONCE() but also ensure the desired
> > order of memory accesses.
> > 
> > [1] https://lwn.net/Articles/793253/
> > 
> 
> I think you lost me a bit there. What out-of-order accesses that would be
> triggered by a compiler optimization are you concerned about here ?
> The only "problem" I can think of is that priv->updated may have been
> written before the actual values. The impact would be ... zero. An
> attribute read would return "stale" data for a few microseconds.
> Why is that a concern, and what difference does it make ?

The impact of out-of-order accesses to priv->updated is indeed minimal.

That said, smp_load_acquire() and smp_store_release() were meant to
prevent reordering at runtime, and only affect architectures other than
x86.  READ_ONCE() and WRITE_ONCE() would already prevent reordering from
compiler optimizations, and x86 provides the load-acquire/store-release
semantics by default.

But the reordering issue is not a concern to me, I got carried away when
adding READ_ONCE()/WRITE_ONCE().  While smp_load_acquire() and
smp_store_release() make the code work more like I intend it to, they
are (small) costs we can spare.

I still think that READ_ONCE()/WRITE_ONCE() are necessary, including for
priv->updated.  Do you agree?

Thanks,
Jonas

P.S. Architectures other than x86 are admittedly a niche case for this
driver, but I would not rule them out.  Not only can the cooler be
adapted to mount on silicon other than mainstream Intel/AMD CPUs (and
there even exists a first-party adapter for graphics cards), but it can
trivially also be controlled by a secondary, possibly non-x86, system.
