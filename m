Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC2C43F8D7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 10:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhJ2IdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 04:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhJ2IdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:33:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E06AC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 01:30:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 087021F45730
Subject: Re: [PATCH] arm64: defconfig: Enable SC7180 interconnect driver
To:     Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, bjorn.andersson@linaro.org
Cc:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        krzk@kernel.org, geert+renesas@glider.be, vkoul@kernel.org,
        jagan@amarulasolutions.com, agx@sigxcpu.org,
        biju.das.jz@bp.renesas.com, aford173@gmail.com, nm@ti.com,
        andrey.zhizhikin@leica-geosystems.com, saravanak@google.com,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        Collabora Kernel ML <kernel@collabora.com>,
        "kernelci@groups.io" <kernelci@groups.io>
References: <20211011154003.904355-1-angelogioacchino.delregno@collabora.com>
 <5fd543da-fd49-23c5-f4ba-531aaf8cb377@kernel.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <f8dbb399-9f18-4b7a-4863-1719263cc615@collabora.com>
Date:   Fri, 29 Oct 2021 09:30:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5fd543da-fd49-23c5-f4ba-531aaf8cb377@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2021 11:49, Georgi Djakov wrote:
> On 11.10.21 18:40, AngeloGioacchino Del Regno wrote:
>> On SC7180 device trees, almost all of the nodes are declaring
>> interconnect properties, including the QUP nodes: at least on
>> some machines, leaving this configuration option disabled, or
>> as a module, the kernel appears to hang while initializing the
>> QUP node containing the UART device.
>>
>> To solve this issue, enable the interconnect driver for this
>> SoC as built-in.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Acked-by: Georgi Djakov <djakov@kernel.org>

Tested-by: "kernelci.org bot" <bot@kernelci.org>

https://staging.kernelci.org/test/plan/id/6177be0c2554c2fd1ba6c464/

Thanks,
Guillaume

>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index fc40ae9e9bdb..171848ace3ac 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1172,6 +1172,7 @@ CONFIG_INTERCONNECT_IMX8MQ=m
>>   CONFIG_INTERCONNECT_QCOM=y
>>   CONFIG_INTERCONNECT_QCOM_MSM8916=m
>>   CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>> +CONFIG_INTERCONNECT_QCOM_SC7180=y
>>   CONFIG_INTERCONNECT_QCOM_SDM845=y
>>   CONFIG_INTERCONNECT_QCOM_SM8150=m
>>   CONFIG_INTERCONNECT_QCOM_SM8250=m
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

