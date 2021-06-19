Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85AB3ADB18
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 19:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhFSRa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 13:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbhFSRaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 13:30:19 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE4AC061574;
        Sat, 19 Jun 2021 10:28:08 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id im10so5309662qvb.3;
        Sat, 19 Jun 2021 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2fuqk2Uq9ZlnrXPo4v18ajx4HA0ZizExc9F16VvNLus=;
        b=qxauMLGYdJHmLOE9NAzDcQ4rSL85U6WRsaTxi4imvMzlgh5aaGSsVHCMoZjKDWfc1Z
         Cubw6ucf2e5ThDITSXLpj8lXuA/QAGwzzQ5Nfy2UWCVIL8wE1U47Ul27IyhLywGouc2E
         SpcL+ZJD+4x3oQz1b8wjCLWq7L+xnBbhIyykl5NAD6zvpj0RngxFgatT/NhHugR1HVhl
         O1TWLIqVpFeDGMV+lzAODOWEFdTqjgTofcG41PaNfAMZyIJE2XoNGsfURSyrLyt/pIoC
         ruqZLiAf7f4icv3fFwdK1wv3xRo+6QEfXO1I+87XozfQ2wLyzoDdx1Gv6qfKHYTYIsxe
         ISNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2fuqk2Uq9ZlnrXPo4v18ajx4HA0ZizExc9F16VvNLus=;
        b=lu7If7699HpDnFxYT7PY/+augD3i82anxHfRaKzYvcqNv56XK+RdU1eSKNxiTL3JIe
         PwkOiUXvl4NbS2kb5PCjhHHt5AO3Pn0rMit7RZLm2anCWtI1TXYCt0LHg86MQ7fNbcWc
         xCpPqIG/60SrJiEXhZ9ruhmAxt4mJVGpiDSLt8oIVPXMyxf5IZAR73ZgqbPdaCBFIVCM
         9qtALHFpIDCCr4CuBXhbXsC6FZAeLDYeDViRyLbIfMC7thQVfVH0lto0PxZM0xqf8ER3
         rclDPhMCoe8ywPvIuG20h1mUMy5IqKhUowMchJq/3iqJS6u1lC2vQvaDrCslmWT11xmV
         PlJw==
X-Gm-Message-State: AOAM533l3RS/MoiX+ZqeHs1MDuvG2AjYrgYUDM33E11Cvwt8nC/5lyEy
        Q6E5AeqBqx5riK5rcwrqgcI=
X-Google-Smtp-Source: ABdhPJysdpI6MAT1dIYZqEk3e1RnK3iKjOdCfxTZEgVQY//BnW2jEuzNa1kYw342QMQlR/jxfpPjbw==
X-Received: by 2002:ad4:5f0e:: with SMTP id fo14mr11491351qvb.16.1624123687363;
        Sat, 19 Jun 2021 10:28:07 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id 186sm877814qkf.29.2021.06.19.10.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 10:28:07 -0700 (PDT)
Date:   Sat, 19 Jun 2021 10:28:06 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Klimov <aklimov@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/3] find: micro-optimize for_each_{set,clear}_bit()
Message-ID: <YM4pJpNphEwvUF2F@yury-ThinkPad>
References: <20210618195735.55933-1-yury.norov@gmail.com>
 <20210618195735.55933-3-yury.norov@gmail.com>
 <87bl81ddqo.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl81ddqo.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2021 at 05:24:15PM +0100, Marc Zyngier wrote:
> On Fri, 18 Jun 2021 20:57:34 +0100,
> Yury Norov <yury.norov@gmail.com> wrote:
> > 
> > The macros iterate thru all set/clear bits in a bitmap. They search a
> > first bit using find_first_bit(), and the rest bits using find_next_bit().
> > 
> > Since find_next_bit() is called shortly after find_first_bit(), we can
> > save few lines of I-cache by not using find_first_bit().
> 
> Really?
> 
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/linux/find.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/find.h b/include/linux/find.h
> > index 4500e8ab93e2..ae9ed52b52b8 100644
> > --- a/include/linux/find.h
> > +++ b/include/linux/find.h
> > @@ -280,7 +280,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
> >  #endif
> >  
> >  #define for_each_set_bit(bit, addr, size) \
> > -	for ((bit) = find_first_bit((addr), (size));		\
> > +	for ((bit) = find_next_bit((addr), (size), 0);		\
> 
> On which architecture do you observe a gain? Only 32bit ARM and m68k
> implement their own version of find_first_bit(), and everyone else
> uses the canonical implementation:

And those who enable GENERIC_FIND_FIRST_BIT - x86, arm64, arc, mips
and s390.

> #ifndef find_first_bit
> #define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
> #endif
> 
> These architectures explicitly have different implementations for
> find_first_bit() and find_next_bit() because they can do better
> (whether that is true or not is another debate). I don't think you
> should remove this optimisation until it has been measured on these
> two architectures.

This patch is based on a series that enables separate implementation
of find_first_bit() for all architectures; according to my tests,
find_first* is ~ twice faster than find_next* on arm64 and x86.

https://lore.kernel.org/lkml/20210612123639.329047-1-yury.norov@gmail.com/T/#t

After applying the series, I noticed that my small kernel module that
calls for_each_set_bit() is now using find_first_bit() to just find
one bit, and find_next_bit() for all others. I think it's better to
always use find_next_bit() in this case to minimize the chance of
cache miss. But if it's not that obvious, I'll try to write some test.
