Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E23D35EC34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 07:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhDNFZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 01:25:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17329 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhDNFZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 01:25:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FKrTw06r5zB0gt;
        Wed, 14 Apr 2021 13:23:16 +0800 (CST)
Received: from [10.174.177.246] (10.174.177.246) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 13:25:31 +0800
Subject: Re: [PATCH] x86: Accelerate copy_page with non-temporal in X86
To:     Borislav Petkov <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
References: <3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com>
 <20210413110137.GD16519@zn.tnic>
 <bfa4fd38-0874-63b3-991a-1102af9f47a6@huawei.com>
 <20210413145315.GF16519@zn.tnic>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <7854092f-f37a-f95c-132a-1b2896d582fc@huawei.com>
Date:   Wed, 14 Apr 2021 13:25:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20210413145315.GF16519@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.246]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 2021/4/13 22:53, Borislav Petkov wrote:
> I thought "should be better" too last time when I measured rep; movs vs
> NT stores but actual measurements showed no real difference.
Mabye the NT stores make difference when store to slow dimms, like the
persistent memory I just tested. Also, it likely reduces unnecessary cache
load and flush, and benifits the running processes which have data cached.

-- 
Best wishes
Kemeng Shi
