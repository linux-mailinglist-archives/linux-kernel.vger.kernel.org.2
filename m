Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615563CC197
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 08:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhGQG6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 02:58:53 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:35752 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhGQG6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 02:58:52 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GRf5P0WMxz1qwGh;
        Sat, 17 Jul 2021 08:55:53 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GRf5N6Vjqz1qqkp;
        Sat, 17 Jul 2021 08:55:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id S-rncmjGV8P5; Sat, 17 Jul 2021 08:55:51 +0200 (CEST)
X-Auth-Info: ttBBSncvPvWxCsoB24c5cQK0+OdIzsqtJ76ETM1VxzIZYm8dChFf2ksCeGRCMqv2
Received: from tiger.home (ppp-46-244-176-127.dynamic.mnet-online.de [46.244.176.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 17 Jul 2021 08:55:51 +0200 (CEST)
Received: by tiger.home (Postfix, from userid 1000)
        id DD1A748743; Sat, 17 Jul 2021 08:55:50 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Tong Tiangen <tongtiangen@huawei.com>, <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] riscv: add VMAP_STACK overflow detection
References: <20210621032855.130650-1-tongtiangen@huawei.com>
        <87pmvjtumc.fsf@igel.home> <20210716205332.5856df78@xhacker>
        <871r7yz241.fsf@igel.home> <20210717101805.2afabacb@xhacker>
X-Yow:  Now I'm concentrating on a specific tank battle toward
 the end of World War II!
Date:   Sat, 17 Jul 2021 08:55:50 +0200
In-Reply-To: <20210717101805.2afabacb@xhacker> (Jisheng Zhang's message of
        "Sat, 17 Jul 2021 10:18:05 +0800")
Message-ID: <875yx9qvih.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use
https://download.opensuse.org/repositories/home:/Andreas_Schwab:/riscv:/jeos/images/openSUSE-Tumbleweed-RISC-V-JeOS-efi.riscv64.raw.xz
and run it in qemu with u-boot as kernel.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
