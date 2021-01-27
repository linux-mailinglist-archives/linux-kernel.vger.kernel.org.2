Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66A306426
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344459AbhA0TdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:33:19 -0500
Received: from foss.arm.com ([217.140.110.172]:33826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344209AbhA0TcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:32:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66C20106F;
        Wed, 27 Jan 2021 11:31:21 -0800 (PST)
Received: from [10.57.47.135] (unknown [10.57.47.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B7D03F68F;
        Wed, 27 Jan 2021 11:31:19 -0800 (PST)
Subject: Re: [PATCH v2] of/device: Update dma_range_map only when dev has
 valid dma-ranges
To:     Rob Herring <robh+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>
Cc:     devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomasz Figa <tfiga@google.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20210119105203.15530-1-yong.wu@mediatek.com>
 <CAL_JsqJB=MMeMobznBiAUihJLBt5aeiiL+AtDWh6tajePu=Now@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9fb4c940-32e9-2da3-6e6a-eff5d1cd73ac@arm.com>
Date:   Wed, 27 Jan 2021 19:31:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJB=MMeMobznBiAUihJLBt5aeiiL+AtDWh6tajePu=Now@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-27 19:07, Rob Herring wrote:
> On Tue, Jan 19, 2021 at 4:52 AM Yong Wu <yong.wu@mediatek.com> wrote:
>>
>> The commit e0d072782c73 ("dma-mapping: introduce DMA range map,
>> supplanting dma_pfn_offset") always update dma_range_map even though it was
>> already set, like in the sunxi_mbus driver. the issue is reported at [1].
>> This patch avoid this(Updating it only when dev has valid dma-ranges).
> 
> only when dev *doesn't* have valid dma-ranges?

I believe the intent is to mean when a valid "dma-ranges" property is 
specified in DT. The implementation allows DT to take precedence even if 
platform code *has* already installed a dma_range_map, although we 
shouldn't expect that to ever happen (except perhaps in the wild early 
days of platform bringup).

Robin.

>> Meanwhile, dma_range_map contains the devices' dma_ranges information,
>> This patch moves dma_range_map before of_iommu_configure. The iommu
>> driver may need to know the dma_address requirements of its iommu
>> consumer devices.
>>
>> [1] https://lore.kernel.org/linux-arm-kernel/5c7946f3-b56e-da00-a750-be097c7ceb32@arm.com/
>>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Frank Rowand <frowand.list@gmail.com>
>> Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset"),
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   drivers/of/device.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index aedfaaafd3e7..1122daa8e273 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -162,9 +162,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>          mask = DMA_BIT_MASK(ilog2(end) + 1);
>>          dev->coherent_dma_mask &= mask;
>>          *dev->dma_mask &= mask;
>> -       /* ...but only set bus limit if we found valid dma-ranges earlier */
>> -       if (!ret)
>> +       /* ...but only set bus limit and range map if we found valid dma-ranges earlier */
>> +       if (!ret) {
>>                  dev->bus_dma_limit = end;
>> +               dev->dma_range_map = map;
>> +       }
>>
>>          coherent = of_dma_is_coherent(np);
>>          dev_dbg(dev, "device is%sdma coherent\n",
>> @@ -172,6 +174,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>
>>          iommu = of_iommu_configure(dev, np, id);
>>          if (PTR_ERR(iommu) == -EPROBE_DEFER) {
>> +               /* Don't touch range map if it wasn't set from a valid dma-ranges */
>> +               if (!ret)
>> +                       dev->dma_range_map = NULL;
>>                  kfree(map);
>>                  return -EPROBE_DEFER;
>>          }
>> @@ -181,7 +186,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>
>>          arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>>
>> -       dev->dma_range_map = map;
>>          return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(of_dma_configure_id);
>> --
>> 2.18.0
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
