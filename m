Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3122235DF86
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhDMM4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:56:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17326 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhDMMzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:55:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FKQW106NHzB09P;
        Tue, 13 Apr 2021 20:52:45 +0800 (CST)
Received: from [10.174.177.246] (10.174.177.246) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 20:54:55 +0800
Subject: Re:Re: [PATCH] x86: Accelerate copy_page with non-temporal in X86
To:     Borislav Petkov <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
References: <3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com>
 <20210413110137.GD16519@zn.tnic>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <bfa4fd38-0874-63b3-991a-1102af9f47a6@huawei.com>
Date:   Tue, 13 Apr 2021 20:54:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20210413110137.GD16519@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.246]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 2021/4/13 19:01, Borislav Petkov wrote:
> + linux-nvdimm
> 
> Original mail at https://lkml.kernel.org/r/3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com
> 
> On Tue, Apr 13, 2021 at 02:25:58PM +0800, Kemeng Shi wrote:
>> I'm using AEP with dax_kmem drvier, and AEP is export as a NUMA node in
> 
> What is AEP?
> 
AEP is a type of persistent memory produced by Intel. It's slower than
normal memory but is persistent.
>> my system. I will move cold pages from DRAM node to AEP node with
>> move_pages system call. With old "rep movsq', it costs 2030ms to move
>> 1 GB pages. With "movnti", it only cost about 890ms to move 1GB pages.
> 
> So there's __copy_user_nocache() which does NT stores.
> 
>> -	ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
>> +	ALTERNATIVE_2 "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD, \
>> +                      "jmp copy_page_nt", X86_FEATURE_XMM2
> 
> This makes every machine which has sse2 do NT stores now. Which means
> *every* machine practically.
> 
Yes. And NT stores should be better for copy_page especially copying a lot
of pages as only partial memory of copied page will be access recently.
> The folks on linux-nvdimm@ should be able to give you a better idea what
> to do.
> 
> HTH.
> 
Thanks for response and help.
