Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D633D4420
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 02:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhGXARm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 20:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbhGXARj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 20:17:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5CC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:58:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so4871068plr.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vCPnA7IeT+1hjcpO3XpnPqAK8HPq6UrGaHaA0kO+qzY=;
        b=M+kZLvEoxZ29UvAOrnVgnF3KSsbu1JRIGRWRoSp5bf9EwJANF6nEj+Z58uDplkpHsL
         qn/w2qY7ASgP7n+BV5JliL7bBivpzL4LxMoQNnsZOVFCqFQV+81eRjBzNe3qCbryzqUg
         kEUq2efMky5Y5w+5iuwLfFNVN+18ryT4xzuebxd78O3fl1BzATSiZOArFXdQwaHhUca+
         h/mg/8aB8WTkbNhPMHkgCAJTlYkcnh8I3Y0rWdEtkTKDNalBTiPaPlNm/MPOy7eeHt72
         L6eVBpgvPSBF344a+uGbLwZVwhDn+zYT4VUs5IdIRoHHYIRoLPCV2dOfE6FCMzvMiKK4
         5nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vCPnA7IeT+1hjcpO3XpnPqAK8HPq6UrGaHaA0kO+qzY=;
        b=GSvtqLcp5E0Cj20NHTsJsHBAVnp2X/L09jCdASgQQ288jtyN06fcKyPWeb2X6hZaAe
         GWaYat0D3onA5nNzOqVjCCcJNjw39IvbgaFlX6r6yMkXRprE2RcJ1qiOHBuSOQ/Ndejk
         jli2546Hw1/0DLrDgZhNZVNoXDtHlKTfEh8cTLU/Ad4mrreAFWeRe4uHY5I5E1PiwsI1
         9AFvTjhTWZGVpF5i4aFlJh6+jMIhPkQ5XWNv0zy/Yk0iwR4faHV4E3FpWH4hNZCunrZL
         Vd+GKG9US1+Mfk4cjIZQIReJb4RT/BuHlEhXfzfeksdGLZUDYdJXFCsChNWU/C+kA479
         GM3g==
X-Gm-Message-State: AOAM5311JO9YV45zvsQy6gxSoEm2MA7Ot4WKTFkYZdQVXe5KrI2TnBgk
        XFAydLN6pmvjNYd66EHVEh33Rw==
X-Google-Smtp-Source: ABdhPJxIBNPvadCNK7jQpm/kPWrtZmYT1yF1DSR9HmcCxzy24G3S/GGCR15AWv4T0egdgTvfp2lqqw==
X-Received: by 2002:aa7:93cd:0:b029:328:9d89:a790 with SMTP id y13-20020aa793cd0000b02903289d89a790mr6783536pff.71.1627088291326;
        Fri, 23 Jul 2021 17:58:11 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e3sm30458869pjw.20.2021.07.23.17.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 17:58:10 -0700 (PDT)
Date:   Fri, 23 Jul 2021 17:58:10 -0700 (PDT)
X-Google-Original-Date: Fri, 23 Jul 2021 17:43:59 PDT (-0700)
Subject:     Re: [PATCH] riscv: stacktrace: pin the task's stack in get_wchan
In-Reply-To: <20210723082226.7b7b4707@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        schwab@linux-m68k.org, atishp@atishpatra.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-cf2c0120-e598-4cfe-b76e-aba76b722f19@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 17:22:26 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Pin the task's stack before calling walk_stackframe() in get_wchan().
> This can fix the panic as reported by Andreas when CONFIG_VMAP_STACK=y:
>
> [   65.609696] Unable to handle kernel paging request at virtual address ffffffd0003bbde8
> [   65.610460] Oops [#1]
> [   65.610626] Modules linked in: virtio_blk virtio_mmio rtc_goldfish btrfs blake2b_generic libcrc32c xor raid6_pq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs
> [   65.611670] CPU: 2 PID: 1 Comm: systemd Not tainted 5.14.0-rc1-1.g34fe32a-default #1 openSUSE Tumbleweed (unreleased) c62f7109153e5a0897ee58ba52393ad99b070fd2
> [   65.612334] Hardware name: riscv-virtio,qemu (DT)
> [   65.613008] epc : get_wchan+0x5c/0x88
> [   65.613334]  ra : get_wchan+0x42/0x88
> [   65.613625] epc : ffffffff800048a4 ra : ffffffff8000488a sp : ffffffd00021bb90
> [   65.614008]  gp : ffffffff817709f8 tp : ffffffe07fe91b80 t0 : 00000000000001f8
> [   65.614411]  t1 : 0000000000020000 t2 : 0000000000000000 s0 : ffffffd00021bbd0
> [   65.614818]  s1 : ffffffd0003bbdf0 a0 : 0000000000000001 a1 : 0000000000000002
> [   65.615237]  a2 : ffffffff81618008 a3 : 0000000000000000 a4 : 0000000000000000
> [   65.615637]  a5 : ffffffd0003bc000 a6 : 0000000000000002 a7 : ffffffe27d370000
> [   65.616022]  s2 : ffffffd0003bbd90 s3 : ffffffff8071a81e s4 : 0000000000003fff
> [   65.616407]  s5 : ffffffffffffc000 s6 : 0000000000000000 s7 : ffffffff81618008
> [   65.616845]  s8 : 0000000000000001 s9 : 0000000180000040 s10: 0000000000000000
> [   65.617248]  s11: 000000000000016b t3 : 000000ff00000000 t4 : 0c6aec92de5e3fd7
> [   65.617672]  t5 : fff78f60608fcfff t6 : 0000000000000078
> [   65.618088] status: 0000000000000120 badaddr: ffffffd0003bbde8 cause: 000000000000000d
> [   65.618621] [<ffffffff800048a4>] get_wchan+0x5c/0x88
> [   65.619008] [<ffffffff8022da88>] do_task_stat+0x7a2/0xa46
> [   65.619325] [<ffffffff8022e87e>] proc_tgid_stat+0xe/0x16
> [   65.619637] [<ffffffff80227dd6>] proc_single_show+0x46/0x96
> [   65.619979] [<ffffffff801ccb1e>] seq_read_iter+0x190/0x31e
> [   65.620341] [<ffffffff801ccd70>] seq_read+0xc4/0x104
> [   65.620633] [<ffffffff801a6bfe>] vfs_read+0x6a/0x112
> [   65.620922] [<ffffffff801a701c>] ksys_read+0x54/0xbe
> [   65.621206] [<ffffffff801a7094>] sys_read+0xe/0x16
> [   65.621474] [<ffffffff8000303e>] ret_from_syscall+0x0/0x2
> [   65.622169] ---[ end trace f24856ed2b8789c5 ]---
> [   65.622832] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/stacktrace.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index ff467b98c3e3..ac7593607fa6 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -132,8 +132,12 @@ unsigned long get_wchan(struct task_struct *task)
>  {
>  	unsigned long pc = 0;
>
> -	if (likely(task && task != current && !task_is_running(task)))
> +	if (likely(task && task != current && !task_is_running(task))) {
> +		if (!try_get_task_stack(task))
> +			return 0;
>  		walk_stackframe(task, NULL, save_wchan, &pc);
> +		put_task_stack(task);
> +	}
>  	return pc;
>  }

Thanks, this is on fixes.
