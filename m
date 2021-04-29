Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF5936E4C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbhD2GVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbhD2GVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:21:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96E5C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:20:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s15so5776337plg.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7hePKxoNOOkqFqu1d3hBmli9l1XZ0VvBzkqyp1K/ilE=;
        b=gVZGBF0dYT3j0FfoxMhQqewQ6jHytPaedWryPYzcVR6Ox2Y+pqgC3+Zc4Oge8sbkaf
         7J+kJBDls78lV0YHy9a/7O6uKhwWITsSyEdy5KK/MwKc/6Srhl6lDNDScJyFPsuR44xt
         NmQAoECk56Kb3kRgSgY82QKF9RNu7png16Ke8fI19OboE+SlxURzWdJzyn1DiLnLIxxo
         yM0BAGraoySQoW0MtPby04m/f1LhYSVQB/hkzKUyLsXHWnA7S3L7XkIGnJjfRvI9EKHl
         8wOpaPgDHdCWxSaLT/UR/B3EZ6J1Fg+qC1+ZSt3ETuRQFRj6Cyxg6f2u6h+0KzH+OA2Q
         Ymaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7hePKxoNOOkqFqu1d3hBmli9l1XZ0VvBzkqyp1K/ilE=;
        b=gD5AYmjgGgh3cbZYxUnJ+zhDvMzoLVlokPWS2j/H9FyU4dMZMM24awZv1SovCtpdnT
         JSiGLo+4KO3z1EeCHujL/6e8lhK0ehvFt4cS4qQ0wFBW1IhIaYZTcxf9FSoCKYb8Bs71
         RbEVmotxscLW/MzT6AvLFpNOTKSKo8KKpTqM8xBFmvCvdUgm9jlttYHgg9egmpUlR9NE
         Om/UHuiDEmT+i+5zK308ZM88/43ZnHYAyaksCGW8IYeH4fqz6w8Bj7KXNIj2ukrYTwck
         wYl0u/oDt73WvMogsG3lmyPs4V5gzqtFsLA5VzPAVisczHDLvzQHsOR498nr3Atjxj/h
         4LWQ==
X-Gm-Message-State: AOAM530ZTQr4zNnN+qofZVfiarvJtEt4l053psCwRoLwUHolRy/Lumy+
        g/3fIN4PxF4/gPeAbBYgQi3AJg==
X-Google-Smtp-Source: ABdhPJzRBfomesl78AueVtTuhDjTaaxo5cN8KvQ7aPSpfRcJktsUaCLSusPQG+RipiPVQRHffC3dqg==
X-Received: by 2002:a17:90a:3948:: with SMTP id n8mr11729158pjf.32.1619677221257;
        Wed, 28 Apr 2021 23:20:21 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a7sm6994397pjm.0.2021.04.28.23.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 23:20:20 -0700 (PDT)
Date:   Wed, 28 Apr 2021 23:20:20 -0700 (PDT)
X-Google-Original-Date: Wed, 28 Apr 2021 23:12:31 PDT (-0700)
Subject:     Re: [PATCH] riscv: patch: remove lockdep assertion on lock text_mutex
In-Reply-To: <20210417023532.354714-1-changbin.du@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        changbin.du@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     changbin.du@gmail.com
Message-ID: <mhng-6a0fd653-64f8-4d0d-a265-d80cecdc1b84@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 19:35:32 PDT (-0700), changbin.du@gmail.com wrote:
> The function patch_insn_write() expects that the text_mutex is already
> held. There's a case that text_mutex is acquired by ftrace_run_update_code()
> under syscall context but then patch_insn_write() will be executed under the
> migration kthread context as we involves stop machine. So we should remove
> the assertion, or it can cause warning storm in kernel message.
>
> [  104.641978] ------------[ cut here ]------------
> [  104.642327] WARNING: CPU: 0 PID: 13 at arch/riscv/kernel/patch.c:63 patch_insn_write+0x166/0x17c
> [  104.643587] Modules linked in:
> [  104.644691] CPU: 0 PID: 13 Comm: migration/0 Not tainted 5.12.0-rc7-00067-g9cdbf6467424 #102
> [  104.644907] Hardware name: riscv-virtio,qemu (DT)
> [  104.645068] Stopper: multi_cpu_stop+0x0/0x17e <- 0x0
> [  104.645349] epc : patch_insn_write+0x166/0x17c
> [  104.645467]  ra : patch_insn_write+0x162/0x17c
> [  104.645534] epc : ffffffe0000059c6 ra : ffffffe0000059c2 sp : ffffffe002a33c70
> [  104.645580]  gp : ffffffe0019e5518 tp : ffffffe002a232c0 t0 : ffffffe01295e8a8
> [  104.645622]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffffffe002a33cc0
> [  104.645675]  s1 : ffffffe000007f72 a0 : 0000000000000000 a1 : ffffffffffffffff
> [  104.645716]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : 0000000000000001
> [  104.645757]  a5 : ffffffe0799e45c8 a6 : 00000000000ca097 a7 : 0000000000000000
> [  104.645798]  s2 : 0000000000000008 s3 : 0000000000000f72 s4 : ffffffe002a33ce0
> [  104.645839]  s5 : 0000000000000f7a s6 : 0000000000000003 s7 : 0000000000000003
> [  104.645880]  s8 : 0000000000000004 s9 : 0000000000000002 s10: 0000000000000000
> [  104.645920]  s11: 0000000000000002 t3 : 0000000000000001 t4 : ffffffe000c615c8
> [  104.645958]  t5 : 0000000000007fff t6 : 0000000000000380
> [  104.645998] status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
> [  104.646081] Call Trace:
> [  104.646147] [<ffffffe0000059c6>] patch_insn_write+0x166/0x17c
> [  104.646280] [<ffffffe0000059ec>] patch_text_nosync+0x10/0x32
> [  104.646317] [<ffffffe000007d0c>] ftrace_update_ftrace_func+0x74/0xac
> [  104.646352] [<ffffffe0000d338a>] ftrace_modify_all_code+0x9c/0x144
> [  104.646387] [<ffffffe0000d3444>] __ftrace_modify_code+0x12/0x1c
> [  104.646420] [<ffffffe0000c4c2c>] multi_cpu_stop+0xa8/0x17e
> [  104.646451] [<ffffffe0000c4474>] cpu_stopper_thread+0xb2/0x156
> [  104.646489] [<ffffffe00003645e>] smpboot_thread_fn+0x102/0x1ea
> [  104.646524] [<ffffffe0000311b0>] kthread+0x132/0x148
> [  104.646556] [<ffffffe000002e02>] ret_from_exception+0x0/0x14
> [  104.646657] ---[ end trace ccf71babb9de4d5b ]---
> [  104.647444] ------------[ cut here ]------------
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  arch/riscv/kernel/patch.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 0b552873a577..6d2ed9c15065 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -49,19 +49,18 @@ static void patch_unmap(int fixmap)
>  }
>  NOKPROBE_SYMBOL(patch_unmap);
>
> +
> +/*
> + * Before reaching here, it was expected to lock the text_mutex
> + * already, so we don't need to give another lock here and could
> + * ensure that it was safe between each cores.
> + */
>  static int patch_insn_write(void *addr, const void *insn, size_t len)
>  {
>  	void *waddr = addr;
>  	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
>  	int ret;
>
> -	/*
> -	 * Before reaching here, it was expected to lock the text_mutex
> -	 * already, so we don't need to give another lock here and could
> -	 * ensure that it was safe between each cores.
> -	 */
> -	lockdep_assert_held(&text_mutex);
> -
>  	if (across_pages)
>  		patch_map(addr + len, FIX_TEXT_POKE1);

Well, we definately need the lock -- otherwise concurrent callers will 
install conflicting maps for FIX_TEXT_POKE*, step on each other, and 
install the wrong patch.  I just sent out a patch to use an explicit 
lock here, as sharing text_mutex doesn't seem safe.
