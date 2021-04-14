Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F55B35F094
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhDNJRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhDNJRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:17:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DFCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:16:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m11so13323424pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jiuyang-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUKHKB+V5H8dUAiGZbJrFX0fnMyjSFlwunjPC1r4S+8=;
        b=WQ/HJS/WRTpXqT9pdtTnpECEN0jLG1Q0EG5TGIesfGM98eg4eAXypwvCnl+em4WRS3
         JVgC/vRDah+VSLHwUMOweaHAGBlKcXG1ILdpgojFr6VFutwSDuvhxOLazsWf8PQJm7nu
         XdG1yrEnGP4l1GhCxVzX7oIN2BxGb+LvjrWNgkOtTmFo6cSQvsk0o6vqqBHBybcau7U+
         ekQGS07FgjtQ+vH8o9KtRx6vqea20RocvxPFHDWlagKGfjtH+8KueInEzu15WQtR+8eZ
         9/PNC0zzi7cKmVEcgZr/kHdEMA8Eoc3xJjHdDSK5hQCefdfpqPEKrvqa5sDOjwDIF2XI
         djsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUKHKB+V5H8dUAiGZbJrFX0fnMyjSFlwunjPC1r4S+8=;
        b=dKx/xZCiCmy0a8cUZHFLYsghVrXSBGcWVr4sWKR6RTuQ8vS6i1hX9DaoY7hrk2Jv4F
         U51VKTSpticy5oDNe/LjSsLJYQcGeditGXCOfDsUY1XyRYmliirimMVlXH1rewBN2+9E
         IV9eFYQh9KqyS19FhGASayF2Z+HeTMgDlbtibsJFo/ovKJqx6DKQicgWtHC4yNoIH64g
         hYWlohMcsBLfsseT4cSnmnbq2Mxm/lXOVe05jMUXUEr821Lk6CQCToF6hGa9iHGRB3rj
         lzztdplAFh++WyyIcRmig1cC+qYz6sqcaUi19WlT/GjhabDh4mMC6EszuqrtzUWB54TG
         KAPA==
X-Gm-Message-State: AOAM533K2U8Y8eFVLNb4ZplZdlEHzaRPs+uTf5GsRAFRdueCTbJXwhCm
        1dkfoKSEa9+LUye3LUbUX0Q9/w==
X-Google-Smtp-Source: ABdhPJzCZKNt5XptTVToHYyMvOfdvSlm6eAy3Y0NSlPvGMTscX6/QCrkUYH3Y75IpqVzljYp2nSvWA==
X-Received: by 2002:a63:707:: with SMTP id 7mr35442934pgh.319.1618391800504;
        Wed, 14 Apr 2021 02:16:40 -0700 (PDT)
Received: from nuc.localnet ([193.110.201.196])
        by smtp.gmail.com with ESMTPSA id v6sm11267255pfb.130.2021.04.14.02.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 02:16:40 -0700 (PDT)
From:   Jiuyang Liu <liu@jiuyang.me>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Alex Ghiti <alex@ghiti.fr>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <waterman@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] implement flush_cache_vmap for RISC-V
Date:   Wed, 14 Apr 2021 09:16:34 +0000
Message-ID: <9908880.BHKHtspdbC@nuc>
In-Reply-To: <18d198ac-7bc0-934d-e1e9-eca01b790d61@ghiti.fr>
References: <20210412000531.12249-1-liu@jiuyang.me> <20210412150817.33f49be8@xhacker.debian> <18d198ac-7bc0-934d-e1e9-eca01b790d61@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 14, 2021 7:03:13 AM UTC you wrote:
> Hi,
>=20
> Le 4/12/21 =E0 3:08 AM, Jisheng Zhang a =E9crit :
> > Hi Jiuyang,
> >=20
> > On Mon, 12 Apr 2021 00:05:30 +0000 Jiuyang Liu <liu@jiuyang.me> wrote:
> >> This patch implements flush_cache_vmap for RISC-V, since it modifies P=
TE.
> >> Without this patch, SFENCE.VMA won't be added to related codes, which
> >> might introduce a bug in the out-of-order micro-architecture
> >> implementations.
> >>=20
> >> Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
> >> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
> >> Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
> >=20
> > IIRC, Palmer hasn't given this Reviewed-by tag.
> >=20
> >> ---
> >=20
> > Could you plz add version and changes? IIRC, this is the v3.
> >=20
> >>   arch/riscv/include/asm/cacheflush.h | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>=20
> >> diff --git a/arch/riscv/include/asm/cacheflush.h
> >> b/arch/riscv/include/asm/cacheflush.h index 23ff70350992..3fd528badc35
> >> 100644
> >> --- a/arch/riscv/include/asm/cacheflush.h
> >> +++ b/arch/riscv/include/asm/cacheflush.h
> >> @@ -30,6 +30,12 @@ static inline void flush_dcache_page(struct page
> >> *page)
> >>=20
> >>   #define flush_icache_user_page(vma, pg, addr, len) \
> >>  =20
> >>          flush_icache_mm(vma->vm_mm, 0)
> >>=20
> >> +/*
> >> + * flush_cache_vmap is invoked after map_kernel_range() has installed
> >> the page + * table entries, which modifies PTE, SFENCE.VMA should be
> >> inserted.>=20
> > Just my humble opinion, flush_cache_vmap() may not be necessary.
> > vmalloc_fault can take care of this, and finally sfence.vma is inserted
> > in related path.
> I believe Palmer and Jisheng are right, my initial proposal to implement
> flush_cache_vmap is wrong.
>=20
> But then, Jiuyang should not have noticed any problem here, so what's
> wrong? @Jiuyang: Does implementing flush_cache_vmap fix your issue?
Yes, I just checked this today, it did fix our issue.
But I'm happy to rework on this, thanks for your help! This week I will try=
 to=20
trace wave of our core, and give a more detail email then.
> And regarding flush_cache_vunmap, from Jisheng call stack, it seems also
> not necessary.
>=20
> @Jiuyang: Can you tell us more about what you noticed?
>=20
> > Regards
> >=20
> >> + */
> >> +#define flush_cache_vmap(start, end) flush_tlb_all()
> >> +
> >>=20
> >>   #ifndef CONFIG_SMP
> >>  =20
> >>   #define flush_icache_all() local_flush_icache_all()
> >>=20
> >> --
> >> 2.31.1
> >=20
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks,
Jiuyang


