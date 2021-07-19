Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812AE3CCE73
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 09:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhGSH0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 03:26:16 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59279 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbhGSH0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 03:26:14 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GStbw4pHKz1sV5l;
        Mon, 19 Jul 2021 09:23:08 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GStbw3hpYz1qqyd;
        Mon, 19 Jul 2021 09:23:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id aRUODCvb6Yuk; Mon, 19 Jul 2021 09:23:07 +0200 (CEST)
X-Auth-Info: 1CstQ3u+O2HFe6LzD1x0TTLWObtmaqWeNE8K1bc6w4modteebGK53/t8CZlh0FL4
Received: from igel.home (ppp-46-244-168-116.dynamic.mnet-online.de [46.244.168.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 19 Jul 2021 09:23:07 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id A37E52C1DCD; Mon, 19 Jul 2021 09:23:06 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     tongtiangen <tongtiangen@huawei.com>
Cc:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] riscv: add VMAP_STACK overflow detection
References: <20210621032855.130650-1-tongtiangen@huawei.com>
        <87pmvjtumc.fsf@igel.home> <20210716205332.5856df78@xhacker>
        <871r7yz241.fsf@igel.home> <20210717101805.2afabacb@xhacker>
        <875yx9qvih.fsf@linux-m68k.org>
        <b9a2143b-a258-4404-704e-a94605b68eca@huawei.com>
X-Yow:  I will SHAVE and buy JELL-O and bring my MARRIAGE MANUAL!!
Date:   Mon, 19 Jul 2021 09:23:06 +0200
In-Reply-To: <b9a2143b-a258-4404-704e-a94605b68eca@huawei.com>
        (tongtiangen@huawei.com's message of "Mon, 19 Jul 2021 11:27:50
        +0800")
Message-ID: <87bl6yrcmd.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 19 2021, tongtiangen wrote:

> On 2021/7/17 14:55, Andreas Schwab wrote:
>> Please use
>> https://download.opensuse.org/repositories/home:/Andreas_Schwab:/riscv:/jeos/images/openSUSE-Tumbleweed-RISC-V-JeOS-efi.riscv64.raw.xz
>> and run it in qemu with u-boot as kernel.
>>
>> Andreas.
>>
>
> Hi andreas:
> I used today's latest mainline code and .config provided by you, and I
> can't reproduce this panic.

Did you test it like I said above?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
