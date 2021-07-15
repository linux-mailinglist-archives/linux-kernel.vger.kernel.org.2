Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83FF3CA233
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhGOQZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:25:24 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:54428 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhGOQZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:25:23 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GQflx2N84z1sFhS;
        Thu, 15 Jul 2021 18:22:21 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GQflx1VZfz1qqkP;
        Thu, 15 Jul 2021 18:22:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 6d6OuwsxCZ1H; Thu, 15 Jul 2021 18:22:20 +0200 (CEST)
X-Auth-Info: br3tlGgw4vIUf1Ch6+xeO/8ruM6sgiE8T8bKkq2wu8SAavokerfEAnRbwSVoSWqf
Received: from igel.home (ppp-46-244-186-22.dynamic.mnet-online.de [46.244.186.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 15 Jul 2021 18:22:20 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 89C322C21E9; Thu, 15 Jul 2021 18:22:19 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] riscv: add VMAP_STACK overflow detection
References: <20210621032855.130650-1-tongtiangen@huawei.com>
X-Yow:  Sometime in 1993 NANCY SINATRA will lead a BLOODLESS COUP on GUAM!!
Date:   Thu, 15 Jul 2021 18:22:19 +0200
In-Reply-To: <20210621032855.130650-1-tongtiangen@huawei.com> (Tong Tiangen's
        message of "Mon, 21 Jun 2021 11:28:55 +0800")
Message-ID: <87pmvjtumc.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 21 2021, Tong Tiangen wrote:

> This patch adds stack overflow detection to riscv, usable when
> CONFIG_VMAP_STACK=y.

This breaks get_wchan:

[   65.609696] Unable to handle kernel paging request at virtual address ffffffd0003bbde8
[   65.610460] Oops [#1]
[   65.610626] Modules linked in: virtio_blk virtio_mmio rtc_goldfish btrfs blake2b_generic libcrc32c xor raid6_pq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs
[   65.611670] CPU: 2 PID: 1 Comm: systemd Not tainted 5.14.0-rc1-1.g34fe32a-default #1 openSUSE Tumbleweed (unreleased) c62f7109153e5a0897ee58ba52393ad99b070fd2
[   65.612334] Hardware name: riscv-virtio,qemu (DT)
[   65.613008] epc : get_wchan+0x5c/0x88
[   65.613334]  ra : get_wchan+0x42/0x88
[   65.613625] epc : ffffffff800048a4 ra : ffffffff8000488a sp : ffffffd00021bb90
[   65.614008]  gp : ffffffff817709f8 tp : ffffffe07fe91b80 t0 : 00000000000001f8
[   65.614411]  t1 : 0000000000020000 t2 : 0000000000000000 s0 : ffffffd00021bbd0
[   65.614818]  s1 : ffffffd0003bbdf0 a0 : 0000000000000001 a1 : 0000000000000002
[   65.615237]  a2 : ffffffff81618008 a3 : 0000000000000000 a4 : 0000000000000000
[   65.615637]  a5 : ffffffd0003bc000 a6 : 0000000000000002 a7 : ffffffe27d370000
[   65.616022]  s2 : ffffffd0003bbd90 s3 : ffffffff8071a81e s4 : 0000000000003fff
[   65.616407]  s5 : ffffffffffffc000 s6 : 0000000000000000 s7 : ffffffff81618008
[   65.616845]  s8 : 0000000000000001 s9 : 0000000180000040 s10: 0000000000000000
[   65.617248]  s11: 000000000000016b t3 : 000000ff00000000 t4 : 0c6aec92de5e3fd7
[   65.617672]  t5 : fff78f60608fcfff t6 : 0000000000000078
[   65.618088] status: 0000000000000120 badaddr: ffffffd0003bbde8 cause: 000000000000000d
[   65.618621] [<ffffffff800048a4>] get_wchan+0x5c/0x88
[   65.619008] [<ffffffff8022da88>] do_task_stat+0x7a2/0xa46
[   65.619325] [<ffffffff8022e87e>] proc_tgid_stat+0xe/0x16
[   65.619637] [<ffffffff80227dd6>] proc_single_show+0x46/0x96
[   65.619979] [<ffffffff801ccb1e>] seq_read_iter+0x190/0x31e
[   65.620341] [<ffffffff801ccd70>] seq_read+0xc4/0x104
[   65.620633] [<ffffffff801a6bfe>] vfs_read+0x6a/0x112
[   65.620922] [<ffffffff801a701c>] ksys_read+0x54/0xbe
[   65.621206] [<ffffffff801a7094>] sys_read+0xe/0x16
[   65.621474] [<ffffffff8000303e>] ret_from_syscall+0x0/0x2
[   65.622169] ---[ end trace f24856ed2b8789c5 ]---
[   65.622832] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
