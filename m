Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C75306445
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbhA0Tjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:39:53 -0500
Received: from foss.arm.com ([217.140.110.172]:34058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344566AbhA0ThV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:37:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95AF5106F;
        Wed, 27 Jan 2021 11:36:34 -0800 (PST)
Received: from [10.57.47.135] (unknown [10.57.47.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C789B3F68F;
        Wed, 27 Jan 2021 11:36:31 -0800 (PST)
Subject: Re: [PATCH v2] of/device: Update dma_range_map only when dev has
 valid dma-ranges
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
References: <20210119105203.15530-1-yong.wu@mediatek.com>
 <YBFj9whLvqlV2erm@aptenodytes> <159d4486-bb7e-249d-2bad-f5bba839041d@arm.com>
 <CAL_JsqKgGOAe-ZSw9qJ7POVv5nJuX+UoJE-MS3drKrM119pw-w@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8f742f94-4087-7fb6-4b7c-9058593b67cf@arm.com>
Date:   Wed, 27 Jan 2021 19:36:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKgGOAe-ZSw9qJ7POVv5nJuX+UoJE-MS3drKrM119pw-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-27 19:09, Rob Herring wrote:
> On Wed, Jan 27, 2021 at 7:13 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> [ + Christoph, Marek ]
>>
>> On 2021-01-27 13:00, Paul Kocialkowski wrote:
>>> Hi,
>>>
>>> On Tue 19 Jan 21, 18:52, Yong Wu wrote:
>>>> The commit e0d072782c73 ("dma-mapping: introduce DMA range map,
>>>> supplanting dma_pfn_offset") always update dma_range_map even though it was
>>>> already set, like in the sunxi_mbus driver. the issue is reported at [1].
>>>> This patch avoid this(Updating it only when dev has valid dma-ranges).
>>>>
>>>> Meanwhile, dma_range_map contains the devices' dma_ranges information,
>>>> This patch moves dma_range_map before of_iommu_configure. The iommu
>>>> driver may need to know the dma_address requirements of its iommu
>>>> consumer devices.
>>>
>>> Just a gentle ping on this issue, it would be nice to have this fix merged
>>> ASAP, in the next RC :)
>>
>> Ack to that - Rob, Frank, do you want to take this through the OF tree,
>> or shall we take it through the DMA-mapping tree like the original culprit?
> 
> I've already got some fixes queued up and can take it.

Brilliant, thanks!

> Suggested-by doesn't mean you are happy with the implementation. So
> Acked-by or Reviewed-by?

It still feels slightly awkward to give a tag to say "yes, this is 
exactly what I suggested", but for the avoidance of doubt,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.
