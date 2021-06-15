Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309113A7B65
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhFOKHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:07:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6507 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhFOKHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:07:20 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G43lH6BjBzZhJt;
        Tue, 15 Jun 2021 18:02:19 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 18:05:06 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 18:05:05 +0800
Subject: Re: [PATCH] KVM: arm64: Trival coding style fixes for all
 vgic-related files
To:     Marc Zyngier <maz@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <yuzenghui@huawei.com>, <wanghaibin.wang@huawei.com>
References: <20210615035019.35808-1-wangyanan55@huawei.com>
 <87o8c7ihlf.wl-maz@kernel.org>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <df4aa056-e15b-ae5f-ace1-1f6e5561dfd8@huawei.com>
Date:   Tue, 15 Jun 2021 18:05:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87o8c7ihlf.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/15 17:48, Marc Zyngier wrote:
> On Tue, 15 Jun 2021 04:50:19 +0100,
> Yanan Wang <wangyanan55@huawei.com> wrote:
>> These fixes introduce no functional change but just adjustment about
>> coding style issues for ARM64 vgic code. They mainly include identation
>> fix of function parameters/arguments, identation fix of structure
>> initialization, identation fix of comment, also the deletion of some
>> superfluous space lines.
> Please don't. This sort of patches bring little value, and make the
> backporting of important fixes more difficult because of pointless
> context change.
Oh, this is an point that I didn't notice but indeed worths considering.
> Fixing these cosmetic details is fine when you are modifying the
> code. But as a standalone patch, this brings more pain than benefit.
Ok, I will just drop this stuff. Sorry for the noise.

Thanks,
Yanan
> Thanks,
>
> 	M.
>

