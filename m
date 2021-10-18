Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E11432020
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhJROqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhJROqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:46:44 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA3C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:44:32 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x123so1736346qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vN5nqmj1WlcxLJ+rQIW/ePZp+WbX9gxxe2P+vg9O754=;
        b=VnV9gDCQdDEZyxHiiSxXRkPdJCyPKP27xwRGLygbIV5ibm8Cs7NEvklWG7vdAUPAIZ
         eF2DsE7smxpcWMXu76/F+6bk8RqGktiZWim/7pGtDZpyGD1kijvSXfdD6be6Fib7XGox
         Ub2bSeMJ38nbGUg0WME/Z74PxWLeROMosWahINeUYKHVJvpj7ivBSgQwcj4ujWU9+lkq
         YMC4WJ+Hu5ok05yH8taK5/6Ee7LlAoH/rsQkme14qpWFOt4yKXyw/X7GXQrsl/HqTxu5
         OCsRIXP0qihywHEgyE+6Cy6nYSWRz3A1rCq8rNzJ3h5az9UcsLqf6ugpqWF8JvLGiGTG
         JeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vN5nqmj1WlcxLJ+rQIW/ePZp+WbX9gxxe2P+vg9O754=;
        b=yITZIbppI9VUPhF4o3U7x352/ksKr3P/7fQ8XwWpNLCnxHGLCpv43RyR7xeZF1FOuf
         NTR2S+RyuC6afdvxv34Qj7UuFTpSklkVmRxpZrT5SviDu16B7hyPFSl0HVGIXT4YGLla
         rn45SLyfkIeJbNkwn0U+kTQxI9j1kNJyCcBejkuyNu0aMXx4bnXUmkpokmz70vjQAzBq
         1plJIoZsTO1ttApn3afoUp08ycEQkq2gSvvoqw6v4zymNLfqBXP30jsUnjndRh/2/Y4A
         2YwytQVuAnO0Oiy/aqnS6iDcwTdyx8CYPEQXuAKby34xzBy+adfmCtVfmbrP02ZADKkk
         Y4FA==
X-Gm-Message-State: AOAM531gC36DOCExR49STbId629h3ou+Bsls3ii5fvLRQb1J3E4g2yWf
        Kkr74nnfPn0cvSu7xO7GXU24SGdkmAxNKxPeKPs=
X-Google-Smtp-Source: ABdhPJwhZIR79Cfcs+p0JwwwHmASDeNf8SJ0WJWKYtZ5gr5N9VQNTcf+eH52qVahEKXLJ6F7DK86SOvBzzHBrkFDYdc=
X-Received: by 2002:a37:bd01:: with SMTP id n1mr22353641qkf.274.1634568271766;
 Mon, 18 Oct 2021 07:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <1631177151-53723-1-git-send-email-wujinhua@linux.alibaba.com>
 <YTnWXIB42sCLbM2k@zn.tnic> <bf6fe59d-c760-40d4-8201-4170cd90ffc3.wujinhua@linux.alibaba.com>
 <YTnq/3rzmD6ADyZm@zn.tnic> <CAJRGBZxHQ3tPrvWWoz9xb0pf=tZ0vrrQYX-Tjr5c=UbxntPtew@mail.gmail.com>
 <1cac1499-6b00-3c18-b64c-a22f269a2706@linux.alibaba.com> <YWrSKeT+R2S/+udL@zn.tnic>
 <7b07f141-12f5-397d-9e45-1d507cacae84@linux.alibaba.com> <YW1sCxRUZBX8iL6w@zn.tnic>
In-Reply-To: <YW1sCxRUZBX8iL6w@zn.tnic>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Mon, 18 Oct 2021 22:44:20 +0800
Message-ID: <CAJRGBZzr05c6cOhN=d+O=v_jom-yMDdKQ31m+QfsbRkBWj+fiw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E5=9B=9E=E5=A4=8D=EF=BC=9A=5BPATCH=5D_perf=3A_optimize_clear_page_in_In?=
        =?UTF-8?Q?tel_specified_model_with_movq_instruction?=
To:     Borislav Petkov <bp@alien8.de>
Cc:     JY Ni <jiayu.ni@linux.alibaba.com>,
        wujinhua <wujinhua@linux.alibaba.com>, x86 <x86@kernel.org>,
        "zelin.deng" <zelin.deng@linux.alibaba.com>,
        ak <ak@linux.intel.com>, "luming.yu" <luming.yu@intel.com>,
        "fan.du" <fan.du@intel.com>,
        "artie.ding" <artie.ding@linux.alibaba.com>,
        "tony.luck" <tony.luck@intel.com>, tglx <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "pawan.kumar.gupta" <pawan.kumar.gupta@linux.intel.com>,
        "fenghua.yu" <fenghua.yu@intel.com>, hpa <hpa@zytor.com>,
        "ricardo.neri-calderon" <ricardo.neri-calderon@linux.intel.com>,
        peterz <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 8:43 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Oct 18, 2021 at 03:43:46PM +0800, JY Ni wrote:
> > _*Precondition:*__*do tests on a Intel CPX server.*_ CPU information of my
> > test machine is in backup part._*
>
> My machine:
>
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 106
> stepping        : 4
>
> That's a SKYLAKE_X.
>
> I ran
>
> ./tools/perf/perf stat --repeat 5 --sync --pre=/root/bin/pre-build-kernel.sh -- make -s -j96 bzImage
>
> on -rc6, building allmodconfig each of the 10 times.
>
> pre-build-kernel.sh is
>
> ---
> #!/bin/bash
>
> make -s clean
> echo 3 > /proc/sys/vm/drop_caches
> ---
>
> Results are below but to me that's all "in the noise" with around one
> percent if I can trust the stddev. Which is not even close to 40%.
>
> So basically you're wasting your time.
>
> 5.15-rc6
> --------
>
> # ./tools/perf/perf stat --repeat 5 --sync --pre=/root/bin/pre-build-kernel.sh -- make -s -j96 bzImage
>
>  Performance counter stats for 'make -s -j96 bzImage' (5 runs):
>
>       3,072,392.92 msec task-clock                #   51.109 CPUs utilized            ( +-  0.05% )
>          1,351,534      context-switches          #  440.257 /sec                     ( +-  0.99% )
>            224,862      cpu-migrations            #   73.248 /sec                     ( +-  1.39% )
>         85,073,723      page-faults               #   27.712 K/sec                    ( +-  0.01% )
>  8,743,357,421,495      cycles                    #    2.848 GHz                      ( +-  0.06% )
>  7,643,946,991,468      instructions              #    0.88  insn per cycle           ( +-  0.00% )
>  1,705,128,638,240      branches                  #  555.440 M/sec                    ( +-  0.00% )
>     37,637,576,027      branch-misses             #    2.21% of all branches          ( +-  0.03% )
> 22,511,903,971,150      slots                     #    7.333 G/sec                    ( +-  0.03% )
>  7,377,211,958,188      topdown-retiring          #     32.5% retiring                ( +-  0.02% )
>  3,145,247,374,138      topdown-bad-spec          #     13.9% bad speculation         ( +-  0.27% )
>  8,018,664,899,041      topdown-fe-bound          #     35.2% frontend bound          ( +-  0.07% )
>  4,167,103,609,622      topdown-be-bound          #     18.3% backend bound           ( +-  0.09% )
>
>             60.114 +- 0.112 seconds time elapsed  ( +-  0.19% )
>
>
>
> 5.15-rc6 + patch
> ----------------
>
>  Performance counter stats for 'make -s -j96 bzImage' (5 runs):
>
>       3,033,250.65 msec task-clock                #   51.243 CPUs utilized            ( +-  0.05% )
>          1,329,033      context-switches          #  438.210 /sec                     ( +-  0.64% )
>            225,550      cpu-migrations            #   74.369 /sec                     ( +-  1.36% )
>         85,080,938      page-faults               #   28.053 K/sec                    ( +-  0.00% )
>  8,629,663,367,477      cycles                    #    2.845 GHz                      ( +-  0.05% )
>  7,696,237,813,803      instructions              #    0.89  insn per cycle           ( +-  0.00% )
>  1,709,909,494,107      branches                  #  563.793 M/sec                    ( +-  0.00% )
>     37,719,552,337      branch-misses             #    2.21% of all branches          ( +-  0.02% )
> 22,214,249,023,820      slots                     #    7.325 G/sec                    ( +-  0.06% )
>  7,412,342,725,008      topdown-retiring          #     33.0% retiring                ( +-  0.01% )
>  3,141,090,408,028      topdown-bad-spec          #     14.1% bad speculation         ( +-  0.17% )
>  7,996,077,873,517      topdown-fe-bound          #     35.6% frontend bound          ( +-  0.03% )
>  3,862,154,886,962      topdown-be-bound          #     17.3% backend bound           ( +-  0.28% )
>
>             59.193 +- 0.302 seconds time elapsed  ( +-  0.51% )

I'm trying to duplicate the difference and get noticed that  time && perf stat
might have a different scale view about the real time spent on the job.

And jiayu.ni's time diff showed the best at 32 jobs and the worst at 96 jobs.

[linux-5.15-rc6]# time make -s bzImage -j96

real    1m8.922s
user    55m25.750s
sys     7m30.666s

[linux-5.15-rc6]# make -s clean

[linux-5.15-rc6]# perf stat  make -s bzImage -j96
..
      61.461679693 seconds time elapsed


    2756.927852000 seconds user
     369.365209000 seconds sys

If kbuild time that jiayu.ni has shared  is not a solid proof for the
optimization idea can be accepted,
we can try other clear_page heavy workloads.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
