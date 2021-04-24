Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D4F36A1B0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 16:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhDXOxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 10:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhDXOxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 10:53:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A69EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 07:52:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso2709773pjg.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RMSJtaAHljPHWIgA5eXWHY4jUU8kVnxr1/o96vxGPvc=;
        b=jwVFj7fFi04Uih5yN7dyCcSkNWQ9KZYO2uLF+dc5/x2665s4Zmzwgd6VOXVSxPRDO3
         J8ByLiQl0kpbJjm+BO6dkwT1ztPipgR+f8pDY8jGkK5lCJwiBS6vOHxPNn9KPesYC0uy
         Tfh3j3LA1xTSvksA3O/w9vYqFPVU0n5EtxlDxoVZaX1uzUMr2ug+ca4T9/2YimV6N5/2
         WHggJzFQQhykN3t+C6JKF607YhZ3n0DZB+OupuajsJEk780zCpbp2dHgSYbPUNVJya83
         SVvR0De+1ZR/lvSaM+Q5sIk/+doMx5hNFSBGyLqOpSvHcVFob+azM/sp6zHgAEvav+Cc
         7hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RMSJtaAHljPHWIgA5eXWHY4jUU8kVnxr1/o96vxGPvc=;
        b=a4YCzjF4JQsyLQ2wYFhKrQWmPAmhtQiG9GkPWql0IXcjyJbGy+hZrGxxARPHCGqWlX
         L7DpgamwUvuNemEHJvo5dALgMxKN2jT2B65kRfvHjQvTSkUsGov6qnLad490NCcayhvV
         GhcxIR182edvWRry8pudcmohQN9B1c0Q9P+emopjcrpMreh6i92F4W0iMuM0MMArLtyf
         mZi++aGAJPeMwNwBp0TiEoY5aaXU/0gYd65Le/T2IaB8aD1j1m9Zk66qpKffLyN2jND3
         YDntrom86K5AFPmidsy49faK7wqubCEDhWp/mZiWmL6czdUct3Xjne2ChxcwtkOtAKCv
         UYCA==
X-Gm-Message-State: AOAM5316QcsS/uuT4O8XlTWjdJnv7h2v+TrgxtBKhfTVRvfWNFzKkIoy
        IrKVQhcpB9F/UXQXfZm4Z/qiH8BymdS7xQ==
X-Google-Smtp-Source: ABdhPJyUzsgfNHHoGwE1pWlcUUULlzKI2lEw4N+jvpKQhcnfsoPUnXeg/CKR+rnZvJlf5q0IsqVvpw==
X-Received: by 2002:a17:90b:1646:: with SMTP id il6mr11713235pjb.27.1619275972061;
        Sat, 24 Apr 2021 07:52:52 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id w134sm7712902pfd.173.2021.04.24.07.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 07:52:51 -0700 (PDT)
Date:   Sat, 24 Apr 2021 22:52:26 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: patch: remove lockdep assertion on lock text_mutex
Message-ID: <20210424145226.ky74umiehhqgkjhc@mail.google.com>
References: <20210417023532.354714-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417023532.354714-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping for review status. This issue makes ftrace hard to use on riscv.

On Sat, Apr 17, 2021 at 10:35:32AM +0800, Changbin Du wrote:
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
>  
> -- 
> 2.27.0
> 

-- 
Cheers,
Changbin Du
