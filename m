Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573EA4250F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbhJGK0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:26:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13876 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhJGK0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:26:31 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HQ6kv2Ss0z907Q;
        Thu,  7 Oct 2021 18:19:51 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 7 Oct 2021 18:24:36 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 7 Oct 2021 18:24:35 +0800
Subject: Re: [PATCH] arm64: defconfig: drop obsolete ARCH_* configs
To:     Catalin Marinas <catalin.marinas@arm.com>, <soc@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <wanghaibin.wang@huawei.com>, Arnd Bergmann <arnd@arndb.de>
References: <20210821030519.127-1-yuzenghui@huawei.com>
 <39c2b2f9-4de2-8e7d-2135-96f1dab750e0@canonical.com>
 <5991e347-18f0-30cd-58b9-9e3276bd98bd@huawei.com> <YV7HGniKSKe7nXp/@arm.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <1ebc899f-b7d7-fff4-9204-a0edd2be4387@huawei.com>
Date:   Thu, 7 Oct 2021 18:24:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <YV7HGniKSKe7nXp/@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/7 18:08, Catalin Marinas wrote:
> On Thu, Oct 07, 2021 at 05:42:46PM +0800, Zenghui Yu wrote:
>> On 2021/8/23 21:01, Krzysztof Kozlowski wrote:
>>> On 21/08/2021 05:05, Zenghui Yu wrote:
>>>> Per commit 4a9a1a5602d8 ("arm64: socfpga: merge Agilex and N5X into
>>>> ARCH_INTEL_SOCFPGA") and commit 89d4f98ae90d ("ARM: remove zte zx
>>>> platform"), they can be dropped from defconfig now.
>>>>
>>>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>>>> ---
>>>>  arch/arm64/configs/defconfig | 3 ---
>>>>  1 file changed, 3 deletions(-)
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> I have no idea about which tree should this patch go via, so a gentle
>> ping here. I've verified that this can still be applied cleanly on top
>> of today's -next.
> 
> Usually defconfig changes go in via the arm-soc tree rather than the
> arm64 one.

Thanks for the pointer!

[+ soc@kernel.org]

Zenghui
