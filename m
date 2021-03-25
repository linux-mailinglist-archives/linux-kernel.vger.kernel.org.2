Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD2D34987C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhCYRmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:42:36 -0400
Received: from foss.arm.com ([217.140.110.172]:55098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhCYRmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:42:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20CB5143D;
        Thu, 25 Mar 2021 10:42:17 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CED793F718;
        Thu, 25 Mar 2021 10:42:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] iommu/mediatek-v1: Alloc building as module
To:     Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@chromium.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Krzysztof Kozlowski <krzk@kernel.org>, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
References: <20210323055801.16885-1-yong.wu@mediatek.com>
 <20210325171614.GA15433@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6fb1f2b1-3b85-ee91-a447-8aca8f4057d6@arm.com>
Date:   Thu, 25 Mar 2021 17:42:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325171614.GA15433@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

^^Nit: presumably you meant "Allow" in the subject.

On 2021-03-25 17:16, Will Deacon wrote:
> On Tue, Mar 23, 2021 at 01:58:00PM +0800, Yong Wu wrote:
>> This patch only adds support for building the IOMMU-v1 driver as module.
>> Correspondingly switch the config to tristate.
>>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>> ---
>> rebase on v5.12-rc2.
>> ---
>>   drivers/iommu/Kconfig        | 2 +-
>>   drivers/iommu/mtk_iommu_v1.c | 9 ++++-----
>>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> Both of these patches look fine to me, but you probably need to check
> the setting of MODULE_OWNER after:
> 
> https://lore.kernel.org/r/f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com

Right, furthermore I would rather expect these patches on their own to 
hit the problem that my patch tries to avoid - where since mtk_iommu_ops 
is const, the current version of iommu_device_set_ops() is liable to 
blow up trying to write to rodata.

In fact I do wonder a little why that wasn't happening already - maybe 
the compiler is clever enough to tell that the assignment is redundant 
when THIS_MODULE == 0, and elides it :/

Robin.
