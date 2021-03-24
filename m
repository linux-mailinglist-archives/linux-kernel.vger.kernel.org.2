Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CB4347295
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhCXH1i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Mar 2021 03:27:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3920 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhCXH1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:27:30 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F50Bb6K1Yz5hRL;
        Wed, 24 Mar 2021 15:25:27 +0800 (CST)
Received: from dggpemm100011.china.huawei.com (7.185.36.112) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 24 Mar 2021 15:27:04 +0800
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm100011.china.huawei.com (7.185.36.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 15:27:04 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2106.013;
 Wed, 24 Mar 2021 15:27:04 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will.deacon@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        liuyanshi <liuyanshi@huawei.com>,
        wuzengkun <wuzengkun@hisilicon.com>
Subject: [question] insert ko failed because count_plts return 0 when
 CONFIG_RANDOMIZE_BASE is not set
Thread-Topic: [question] insert ko failed because count_plts return 0 when
 CONFIG_RANDOMIZE_BASE is not set
Thread-Index: AQHXIH8WXlqb5UrgakG+rdPSQ9Lizw==
Date:   Wed, 24 Mar 2021 07:27:04 +0000
Message-ID: <6c819e1944044bfa8f88574beb094ef5@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.53]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I make a Image for arm64 (without CONFIG_RANDOMIZE_BASE). And a ko (13M) 
can not be inserted.

WARNING: CPU: 2 PID: 1998 at arch/arm64/kernel/module-plts.c:39
module_emit_plt_entry+0x100/0x118
..
Call trace:
module_emit_plt_entry+0x100/0x118
apply_relocate_add+0x34c/0x570
..

I think the problem is that:
in apply_relocate_add:
                  case R_AARCH64_CALL26:
                      ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 26,
                                               AARCH64_INSN_IMM_26);

                      if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
                          ovf == -ERANGE) {
                              val = module_emit_plt_entry(me, sechdrs, 
loc, &rel[i], sym); realoc_insn_imm return -ERANGE (because the ko is 
too big?)

in module_emit_plt_entry:
WARN_ON(pltsec->plt_num_entries > pltsec->plt_max_entries)
pltsec->plt_max_entries is 0 if CONFIG_RANDOMIZE_BASE is not be set.

a257e02 arm64/kernel: don't ban ADRP to work around Cortex-A53 erratum
#843419
   static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int 
num,
-                              Elf64_Word dstidx)
+                              Elf64_Word dstidx, Elf_Shdr *dstsec)
   {
..
                  switch (ELF64_R_TYPE(rela[i].r_info)) {
                  case R_AARCH64_JUMP26:
                  case R_AARCH64_CALL26:
+                       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+                               break;
+

Why we need break if !IS_ENABLED(CONFIG_RANDOMIZE_BASE)? or any 
restrictions on ko?

I comment out this part of the code. the ko could be inserted, and seems 
to work well. So is it a accepted way? or any solution for my case?

--
Regards
Chen Jun

