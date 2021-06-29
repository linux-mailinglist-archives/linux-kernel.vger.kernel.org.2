Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2533B714D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhF2L2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 07:28:31 -0400
Received: from regular1.263xmail.com ([211.150.70.198]:59232 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhF2L2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 07:28:30 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jun 2021 07:28:29 EDT
Received: from localhost (unknown [192.168.167.105])
        by regular1.263xmail.com (Postfix) with ESMTP id A4493F12;
        Tue, 29 Jun 2021 19:18:33 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.10] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13110T140560568407808S1624965510067257_;
        Tue, 29 Jun 2021 19:18:33 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3fcf2cd44b3224a230bc17c7e69a24d8>
X-RL-SENDER: andy.yan@rock-chips.com
X-SENDER: yxj@rock-chips.com
X-LOGIN-NAME: andy.yan@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 7
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH] drm/rockchip: Check iommu itself instead of it's parent
 for device_is_available
To:     Robin Murphy <robin.murphy@arm.com>, hjc@rock-chips.com,
        heiko@sntech.de, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210627084737.309163-1-andy.yan@rock-chips.com>
 <66fb4977-4e6f-f7ed-0dac-18710ebd782a@arm.com>
From:   Andy Yan <andy.yan@rock-chips.com>
Message-ID: <f20e1547-649e-2d9b-cd90-7b8291d505a6@rock-chips.com>
Date:   Tue, 29 Jun 2021 19:18:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <66fb4977-4e6f-f7ed-0dac-18710ebd782a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin:

On 6/28/21 5:54 PM, Robin Murphy wrote:
> On 2021-06-27 09:47, Andy Yan wrote:
>> When iommu itself is disabled in dts, we should
>> fallback to non-iommu buffer, check iommu parent
>> is meanless here.
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> ---
>>
>>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c 
>> b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>> index 212bd87c0c4a..0d20c8cc1ffa 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>> @@ -366,7 +366,7 @@ static int rockchip_drm_platform_of_probe(struct 
>> device *dev)
>>           }
>>             iommu = of_parse_phandle(port->parent, "iommus", 0);
>> -        if (!iommu || !of_device_is_available(iommu->parent)) {
>> +        if (!iommu || !of_device_is_available(iommu)) {
>
> Just wondering, could you use device_iommu_mapped() to avoid poking at 
> the DT at all here, or is it that you need to check remote graph 
> endpoints whose struct device may not be ready yet?


device_iommu_mapped(dev)  can't be called from rockchip_drm_init_iommu, 
as there is no  iommu dev(vop) in these function.

>
> Robin.
>
>>               DRM_DEV_DEBUG(dev,
>>                         "no iommu attached for %pOF, using non-iommu 
>> buffers\n",
>>                         port->parent);
>>
>
>
>


