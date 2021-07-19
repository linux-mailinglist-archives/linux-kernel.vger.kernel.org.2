Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA38B3CCCA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 05:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhGSDay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 23:30:54 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11340 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhGSDaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 23:30:52 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GSnH91YfYz7tjD;
        Mon, 19 Jul 2021 11:23:17 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 11:27:50 +0800
Received: from [10.174.177.250] (10.174.177.250) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 11:27:50 +0800
Subject: Re: [PATCH -next v2] riscv: add VMAP_STACK overflow detection
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
References: <20210621032855.130650-1-tongtiangen@huawei.com>
 <87pmvjtumc.fsf@igel.home> <20210716205332.5856df78@xhacker>
 <871r7yz241.fsf@igel.home> <20210717101805.2afabacb@xhacker>
 <875yx9qvih.fsf@linux-m68k.org>
CC:     <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From:   tongtiangen <tongtiangen@huawei.com>
Message-ID: <b9a2143b-a258-4404-704e-a94605b68eca@huawei.com>
Date:   Mon, 19 Jul 2021 11:27:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <875yx9qvih.fsf@linux-m68k.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.250]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/7/17 14:55, Andreas Schwab wrote:
> Please use
> https://download.opensuse.org/repositories/home:/Andreas_Schwab:/riscv:/jeos/images/openSUSE-Tumbleweed-RISC-V-JeOS-efi.riscv64.raw.xz
> and run it in qemu with u-boot as kernel.
>
> Andreas.
>

Hi andreas:
I used today's latest mainline code and .config provided by you, and I 
can't reproduce this panic.
Can you provide your code branch, I'll test and analyze it.

Thanks.
