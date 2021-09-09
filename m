Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682C0405C85
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbhIISEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbhIISEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:04:40 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CB6C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:03:30 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 022E83EBD7;
        Thu,  9 Sep 2021 20:03:28 +0200 (CEST)
Subject: Re: [PATCH 3/7] arm64: dts: qcom: msm8998-xperia: Add support for
 wcn3990 Bluetooth
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        bjorn.andersson@linaro.org
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20210903180924.1006044-1-angelogioacchino.delregno@somainline.org>
 <20210903180924.1006044-3-angelogioacchino.delregno@somainline.org>
 <7032cf3a-2469-3d66-bfde-9754dbac58b9@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <dfd498d8-c87c-544a-5140-c5046df2cb81@somainline.org>
Date:   Thu, 9 Sep 2021 20:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <7032cf3a-2469-3d66-bfde-9754dbac58b9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/09/21 15:19, Dmitry Baryshkov ha scritto:
> On 03/09/2021 21:09, AngeloGioacchino Del Regno wrote:
>> This platform uses the WCN3990 Bluetooth chip, reachable on UART-3.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>> ---
>>   .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi   | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi 
>> b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
>> index 2fe53e4675d5..66b009ba72fe 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
>> @@ -179,6 +179,23 @@ &blsp1_i2c5_sleep {
>>       bias-disable;
>>   };
>> +&blsp1_uart3 {
>> +    status = "okay";
>> +
>> +    bluetooth {
>> +        compatible = "qcom,wcn3990-bt";
>> +
>> +        vddio-supply = <&vreg_s4a_1p8>;
>> +        vddxo-supply = <&vreg_l7a_1p8>;
>> +        vddrf-supply = <&vreg_l17a_1p3>;
>> +        vddch0-supply = <&vreg_l25a_3p3>;
>> +        max-speed = <3200000>;
>> +
>> +        clocks = <&rpmcc RPM_SMD_RF_CLK2_PIN>;
>> +    };
>> +};
> 
> There is an ongoing proposal to rework wcn3990 (bt and wifi) bindings, so we might 
> want to delay this a bit. Not a strict requirement, since the changes would be 
> backwards-compatible.
> 
> 

Delaying this patch is not a problem on my side - but if the changes are backwards
compatible, do we really have reasons to delay it?

In any case, I trust your judgement on this: if you want to delay it, I will send
the wcn3990 support after the rework.

Cheers,
- Angelo
