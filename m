Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5540C439
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbhIOLR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:17:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59304 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232540AbhIOLRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:17:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631704557; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: To:
 Subject: Sender; bh=ariktyMIf7Dayb70iaKJjrmLCHgnkUzRmqPEPsHm0rU=; b=bL2oeJ9ZFpw/x2zHgijTyfmTvj6gdgzE1mIWS5EDd5o48j5wTDFeXaW5nrSdzRtzwsRxii4J
 FWK7q5sSb35zFqXN/DppQyu3KU4PfpI3EWSY0G6OZ8ITlrAysm+zWGf8A16jxeNWPi+4kyZi
 561CmsUyIUH0H7Icw73EUdKDPBg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6141d5e7e0f78151d620a1a2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Sep 2021 11:15:51
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2BF75C43618; Wed, 15 Sep 2021 11:15:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [10.242.137.170] (unknown [202.46.23.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97A1DC4338F;
        Wed, 15 Sep 2021 11:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 97A1DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v2 1/2] ASoC: google: dt-bindings: Add sc7280-herobrine
 machine bindings
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz, plai@codeaurora.org,
        robh+dt@kernel.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, tiwai@suse.com
References: <1631539062-28577-1-git-send-email-srivasam@codeaurora.org>
 <1631539062-28577-2-git-send-email-srivasam@codeaurora.org>
 <CAE-0n50=ABP+fs1U3JjiqMSKphfxFsZBqQQYwVH2o_iOE1Wu_g@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Organization: Qualcomm India Private Limited.
Message-ID: <e1e84488-2af5-2272-010a-474788a498a3@codeaurora.org>
Date:   Wed, 15 Sep 2021 16:45:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n50=ABP+fs1U3JjiqMSKphfxFsZBqQQYwVH2o_iOE1Wu_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/2021 1:21 AM, Stephen Boyd wrote:
> Quoting Srinivasa Rao Mandadapu (2021-09-13 06:17:41)
>> diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
>> new file mode 100644
>> index 0000000..e0d705f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
>> @@ -0,0 +1,169 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/google,sc7280-herobrine.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Google SC7280-Herobrine ASoC sound card driver
>> +
>> +maintainers:
>> +  - Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>> +  - Judy Hsiao <judyhsiao@chromium.org>
>> +
>> +description:
>> +  This binding describes the SC7280 sound card which uses LPASS for audio.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - google,sc7280-herobrine
>> +
>> +  audio-routing:
>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> +    description:
>> +      A list of the connections between audio components. Each entry is a
>> +      pair of strings, the first being the connection's sink, the second
>> +      being the connection's source.
>> +
>> +  model:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: User specified audio sound card name
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +patternProperties:
>> +  "^dai-link@[0-9a-f]$":
>> +    description:
>> +      Each subnode represents a dai link. Subnodes of each dai links would be
>> +      cpu/codec dais.
>> +
>> +    type: object
>> +
>> +    properties:
>> +      link-name:
>> +        description: Indicates dai-link name and PCM stream name.
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        maxItems: 1
>> +
>> +      reg:
>> +        maxItems: 1
>> +        description: dai link address.
>> +
>> +      cpu:
>> +        description: Holds subnode which indicates cpu dai.
>> +        type: object
>> +        properties:
>> +          sound-dai: true
> Shouldn't sound-dai be required?
Sorry. I didn't get your Query. You mean in below "required:" properties 
need to add sound-dai also?
>
>> +
>> +      codec:
>> +        description: Holds subnode which indicates codec dai.
>> +        type: object
>> +        properties:
>> +          sound-dai: true
> Shouldn't sound-dai be required? I don't know but maybe also additional
> properties is false for this node too?
>
>> +
>> +    required:
>> +      - link-name
>> +      - cpu
>> +      - codec
> Should 'reg' be required?
Okay. I think reg is required. will check and update it.
>
>> +
>> +    additionalProperties: false

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

