Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08BA3505BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhCaRth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhCaRtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:49:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:49:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w28so9366126lfn.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UimNxwJoYZS3sDcoLAFHg1XgOU6byqCGrwSzGeFyK34=;
        b=WGT0TTz5qY44ENRe/DvmbHevzV+k2y3KKXrPZhVaLn8LhV7JZwMqVbd8rC12Ao28sP
         jU2R29E7GDC39OfcPr2BEX0m3HuiSEOgOcroOBgYP0sgAzjNizHGKRe0UPz91/BeUFZJ
         TecOStsZIP3LdzUgypR7J1ps0GvORD7u3lIhr9F5Y/lKBnte2iasSBhUR5DEpXlnAZ9+
         7bCHGNW5f6baK7UHoAnv0DgY2DMqdFIJhuKUcZw7o3PT1vLoAc6Vu8iSeTtLcEcG5HGx
         F2ZIkB9K5oSmioZEhf0rja3Qf/EdcCxn5eWYDGtpvbR7dKXY45PX5nm0MomF5XNYW2KX
         dXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UimNxwJoYZS3sDcoLAFHg1XgOU6byqCGrwSzGeFyK34=;
        b=ESD76vni82OtMXl0iuxHuzQYjAMz2YhuYGfk3jwsajZwl5yR0+5sMg+czwSh1kNbyb
         frFgI683Fd+WsE/xKPw3ndcqYZPsIcS+FcESenTtsgtNJOkqO4UVBUkv98guorDzc9jD
         BemhIu2WmnxEoFXc+lkQzMOIoORmBXAomdfRrVJJu2KHBPMhyQdS4xQRiKlBlJGguF7L
         eu8VZWV64M39mnNNx4qr7PIYHgv0LerTXRsmxUlDCrE1+Y8OvsHeIMtLqen0noy/G52u
         4EyZ/sgJyDSio8U5+uIcEMTSj8u3jSTxmLWNfswR8GU4f0uzgK1ypqCDfwBs+Q3lvM8Z
         STNw==
X-Gm-Message-State: AOAM530ipCm0KDFV7Lxh5yG+3RqpGkhK2CCis/Mzfa90JeZyWLV8i906
        LFEpCouD2ipMJsmS5KbZRVxH5kmFf8ZcdEe9zlCsOQ==
X-Google-Smtp-Source: ABdhPJxa4qBrTmru0LnzqwHkNThGBdWSDpJJzefQFGGnKzM5Jz6D5vFXSt/eihztehXqFUM6JOjN1A8YHHZ4z2uqQds=
X-Received: by 2002:ac2:538e:: with SMTP id g14mr2818245lfh.543.1617212956228;
 Wed, 31 Mar 2021 10:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <1617177624-24670-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1617177624-24670-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 31 Mar 2021 10:49:05 -0700
Message-ID: <CAKwvOd=9BjO4HbZOq59kKh6ZPSq1EKG4e5ZQ=c5MXSke1hiegg@mail.gmail.com>
Subject: Re: [PATCH] x86/kernel: remove unneeded dead-store initialization
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 1:00 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> make clang-analyzer on x86_64 defconfig caught my attention with:
>
> arch/x86/kernel/cpu/cacheinfo.c:880:24: warning: Value stored to
> 'this_cpu_ci' during its initialization is never read
> [clang-analyzer-deadcode.DeadStores]
> struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> ^
>
> So, simply remove this unneeded dead-store initialization to make
> clang-analyzer happy.
>
> As compilers will detect this unneeded assignment and optimize this anyway,
> the resulting object code is identical before and after this change.
>
> No functional change. No change to object code.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Looks like this is from when this code was introduced in
commit 0d55ba46bfbe ("x86/cacheinfo: Move cacheinfo sysfs code to
generic infrastructure")
though this file was moved from arch/x86/kernel/cpu/intel_cacheinfo.c
to arch/x86/kernel/cpu/cacheinfo.c in
commit 1d200c078d0e ("x86/CPU: Rename intel_cacheinfo.c to cacheinfo.c")
(So I don't think a Fixes tag for 0d55ba46bfbe would be appropriate).

Thanks for the patch!

>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/cacheinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index 3ca9be4..d66af29 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -877,7 +877,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
>  static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
>                                     struct _cpuid4_info_regs *base)
>  {
> -       struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +       struct cpu_cacheinfo *this_cpu_ci;
>         struct cacheinfo *this_leaf;
>         int i, sibling;
>
> --
> 1.8.3.1
>


-- 
Thanks,
~Nick Desaulniers
