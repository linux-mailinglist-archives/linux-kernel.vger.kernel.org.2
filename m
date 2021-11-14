Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B50F44F716
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 08:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhKNHO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 02:14:59 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27130 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhKNHOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 02:14:51 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HsNjs0VLxz1DJQ7;
        Sun, 14 Nov 2021 15:09:37 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 14 Nov 2021 15:11:55 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sun, 14 Nov 2021 15:11:54 +0800
Subject: Re: [PATCH] KVM: arm64: remove unneeded comparison
To:     Jason Wang <wangborong@cdjrlc.com>
CC:     <catalin.marinas@arm.com>, <maz@kernel.org>, <will@kernel.org>,
        <james.morse@arm.com>, <alexandru.elisei@arm.com>,
        <suzuki.poulose@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
References: <20211114064026.277024-1-wangborong@cdjrlc.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <2b9f6a42-825f-1141-06db-932732a0cf99@huawei.com>
Date:   Sun, 14 Nov 2021 15:11:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20211114064026.277024-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/11/14 14:40, Jason Wang wrote:
> The unsigned expression compared with zero `target < 0' is
> unneeded and its result is always false. we can also check the
> target's value returned from `kvm_target_cpu' is one of the
> KVM_* macros, and these macros are defined greater than or equal
> to 0.
> Therefore, the comparison code block:
>     if (target < 0)
>         return -ENODEV;
> is unneeded. We can safely remove it.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/arm64/kvm/guest.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 5ce26bedf23c..1605cb71dd52 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -873,9 +873,6 @@ int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
>  {
>  	u32 target = kvm_target_cpu();
>  
> -	if (target < 0)
> -		return -ENODEV;
> -
>  	memset(init, 0, sizeof(*init));
>  
>  	/*

FYI there's already a similar change in mainline now:

https://git.kernel.org/torvalds/c/08e873cb70f3

Thanks,
Zenghui
