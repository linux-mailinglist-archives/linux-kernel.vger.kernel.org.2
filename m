Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A2438E44C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhEXKpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhEXKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:45:37 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C88C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 03:44:08 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso24828369ote.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lm7Gf5l6+Uynkbqk4GtdH2oEI1Y/KJJqCdfCW8M4N7s=;
        b=Tnso7OauhAPDGDP64ZOxfwIHUy6x6Z1X2aleLmGVW8wCSI3OnJwP3Gof3Q7g9j29fq
         EB2B4MahZoWs7xtfkzfu2eQnT+fSXWYkOeDzyicdkuBQzWdc4ZGDVtNOoRjEsCxU51XX
         735Tdvlp46D2fKpGKziiLVDht8WSxapXN4yB5UnxHLZJh5zSTYpVk/AzAO0FhJ8urYW+
         4sa3CMyBQPfNHIn9bWJtKc23peS8+dhKRa/WKpPNFc/4SpLQLVSYzu+KhNtEweLnskEJ
         ZzBZCD2X3pQwB4KKktEBH7lZmw5y882ArJV13qkKhtoM2zPnoHSHhvQ01oKaHQ8lmowm
         5/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lm7Gf5l6+Uynkbqk4GtdH2oEI1Y/KJJqCdfCW8M4N7s=;
        b=tJtZPPU0vPgmi1l2PMCevly447CHZL40LtxPRg+lqF4JJtH2QJGTA51RI6i6S224IM
         U9V9XmVLqb2UIHC5/Bdhy0EmTB/ABJdeOoyV3DaNO4X7GvFF4IH3n1Pa2N3kWn7A36nk
         5HMYGxy20HodJkUSIeMrlLCZFTyZ7hVYYPPXwTP2pSTchud6QYBWon7zjJbDvDc6DXot
         vgTGzxlUUTsHK7u5wQlrE8s5lq0SrwocvD9ZCtv0M/xnjr2ByPTNKU/Xx+jNfsS9N4+7
         +gQQmbek3pWRKQn9mB5RAVSmDr9DE+2wFWTgEDcYTZFSpgknkag5mZTPCzfO7Xk8ZKDa
         UmtQ==
X-Gm-Message-State: AOAM531vj5YDDAmQzezgTwTx8Uf5l4Y/GBvIK0myL1ZARPeif3dDMplX
        7JCPn9jhjfBj1J55eDt5yd7zW0QjInHgxlJIzqLN4g==
X-Google-Smtp-Source: ABdhPJzmafRfqvS67+cS3RbgBlqcB+ySyXyHW8rTUuF82bHama8GPy47Hqdrybp11RVPQyaN6TCvHKs4jMeNcZltzv0=
X-Received: by 2002:a05:6830:3154:: with SMTP id c20mr641177ots.233.1621853047806;
 Mon, 24 May 2021 03:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210524153659.58a707a9@xhacker.debian> <20210524103740.GD1040@C02TD0UTHF1T.local>
In-Reply-To: <20210524103740.GD1040@C02TD0UTHF1T.local>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 May 2021 12:43:56 +0200
Message-ID: <CANpmjNM5tgDDO_baxi2s8p9FQTr564sMHF8LKEYt=TKk2xTgOw@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: don't use CON and BLK mapping if KFENCE is enabled
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 at 12:37, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, May 24, 2021 at 03:36:59PM +0800, Jisheng Zhang wrote:
> > Fix below warning if KFENCE=y but RODATA_FULL=n:
> >
> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] WARNING: CPU: 0 PID: 0 at mm/memory.c:2462 apply_to_pmd_range+0xec/0x190
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-rc1+ #10
> > [    0.000000] Hardware name: linux,dummy-virt (DT)
> > [    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO BTYPE=--)
> > [    0.000000] pc : apply_to_pmd_range+0xec/0x190
> > [    0.000000] lr : __apply_to_page_range+0x94/0x170
> > [    0.000000] sp : ffffffc010573e20
> > [    0.000000] x29: ffffffc010573e20 x28: ffffff801f400000 x27: ffffff801f401000
> > [    0.000000] x26: 0000000000000001 x25: ffffff801f400fff x24: ffffffc010573f28
> > [    0.000000] x23: ffffffc01002b710 x22: ffffffc0105fa450 x21: ffffffc010573ee4
> > [    0.000000] x20: ffffff801fffb7d0 x19: ffffff801f401000 x18: 00000000fffffffe
> > [    0.000000] x17: 000000000000003f x16: 000000000000000a x15: ffffffc01060b940
> > [    0.000000] x14: 0000000000000000 x13: 0098968000000000 x12: 0000000098968000
> > [    0.000000] x11: 0000000000000000 x10: 0000000098968000 x9 : 0000000000000001
> > [    0.000000] x8 : 0000000000000000 x7 : ffffffc010573ee4 x6 : 0000000000000001
> > [    0.000000] x5 : ffffffc010573f28 x4 : ffffffc01002b710 x3 : 0000000040000000
> > [    0.000000] x2 : ffffff801f5fffff x1 : 0000000000000001 x0 : 007800005f400705
> > [    0.000000] Call trace:
> > [    0.000000]  apply_to_pmd_range+0xec/0x190
> > [    0.000000]  __apply_to_page_range+0x94/0x170
> > [    0.000000]  apply_to_page_range+0x10/0x20
> > [    0.000000]  __change_memory_common+0x50/0xdc
> > [    0.000000]  set_memory_valid+0x30/0x40
> > [    0.000000]  kfence_init_pool+0x9c/0x16c
> > [    0.000000]  kfence_init+0x20/0x98
> > [    0.000000]  start_kernel+0x284/0x3f8
> >
> > Fixes: 840b23986344 ("arm64, kfence: enable KFENCE for ARM64")
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>
> It would be good if the commit message could explain the problem more
> thoroughly, e.g.
>
> | When we added KFENCE support for arm64, we intended that it would
> | force the entire linear map to be mapped at page granularity, but we
> | only enforced this in arch_add_memory() and not in map_mem(), so
> | memory mapped at boot time can be mapped at a larger granularity.
> |
> | When booting a kernel with KFENCE=y and RODATA_FULL=n, this results in
> | the following WARNING at boot:
> |
> | < warning here >
>
> With that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

We also need "Cc: stable@vger.kernel.org", right?

Acked-by: Marco Elver <elver@google.com>

Thank you both!

-- Marco
