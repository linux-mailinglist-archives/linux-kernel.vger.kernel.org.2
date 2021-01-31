Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB47309CE5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhAaO1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhAaN5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 08:57:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B55C061573;
        Sun, 31 Jan 2021 05:57:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 190so10407495wmz.0;
        Sun, 31 Jan 2021 05:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nHeARcn/Q6aiQfyYVeKjmAIHsqSRMrKsrSXo9hw+vQU=;
        b=Lzepv2tqN9yeWPHSfKs0R2te5ybUjX4CT6Gn4aEGExGi6FFISvmKVWg+7cuxXWf5M6
         yBG7PUDfrXL/MWCXDvl5b3v+1wPKUsc47ov3iN/matIiHcPeX4KS8UqghZcSXiz1J9gs
         hl5J4WmDx5lxJ/gni+4IQfEGbbl5lmO/NQx7F7/lIOTD2ramJ28G3Qm246Qpsq4d36Wh
         L5eqOF20G3Y9qphuI16i2CWoJoQYrN6uR6cvWJUhgAy8xiLHGEqlg0IGbU2NtXUVeJ2A
         ZdCh2XxmTAXQt0tFiSAQoSJ5TiV+y80NJmlT2gubbDrDEU0IiKe3Uuache74+pz2TpY0
         UscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nHeARcn/Q6aiQfyYVeKjmAIHsqSRMrKsrSXo9hw+vQU=;
        b=MIZ0YLQBjUaKp9eRClruBZbRO0OQ9+Ad/v1UP2pWWskWPUNC8TEB1Bm2WnnPEC+GxS
         wU2eCKkIVvnSpxCWkY3Q+SI9HJl0R5jXnUEIDVPsu/gXw8vN/nYDWnmTP9WMpxa9sKhJ
         pj04KfwciWmGu8TtxBO3g7BJdpxN+OO8hH7l/zPIYC7uAoTu5Me2ggUkXXSXRJTHWF1X
         s5VgFnT5WNgEU7tABzTbv87DcFWE/juNKfybKoV77rRYmf+cY11DFdCXvYYbU3Ox1+7W
         vC0hNO2YUFUx3CzXBY2j3eCiPdlR87DIQdAGjaQ0AdBuy2Nfm4fryJqTn+oK+dNEsVGH
         x8fQ==
X-Gm-Message-State: AOAM532+HuDk4xuTBpgFVdUkUhN91oo03TwHWw26bOOhlsdnaP4a4qRX
        IuhzoIDTUnTlDs3HzzWwX+o=
X-Google-Smtp-Source: ABdhPJwOXcBnG47rwt7FD9rXIgrGkvfK3gWjKr883xToeOLwqpyEflVWKOPI3xczregH0vw2xfFHBQ==
X-Received: by 2002:a1c:5454:: with SMTP id p20mr11057149wmi.128.1612101423496;
        Sun, 31 Jan 2021 05:57:03 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id 62sm18433568wmd.34.2021.01.31.05.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 05:57:02 -0800 (PST)
Subject: Re: [PATCH v3 1/2] dt-bindings: nvmem: mediatek: add support for
 MediaTek mt8192 SoC
To:     mtk23264 <Yz.Wu@mediatek.com>, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20201221061018.18503-1-Yz.Wu@mediatek.com>
 <20201221061018.18503-2-Yz.Wu@mediatek.com>
 <20210103162540.GA3983563@robh.at.kernel.org>
 <1611296911.30262.5.camel@mtksdccf07>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <8a6f9493-a17a-e679-bada-1dd355c9ce8d@gmail.com>
Date:   Sun, 31 Jan 2021 14:57:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1611296911.30262.5.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/01/2021 07:28, mtk23264 wrote:
> On Sun, 2021-01-03 at 09:25 -0700, Rob Herring wrote:
>> On Mon, Dec 21, 2020 at 02:10:19PM +0800, Yz.Wu@mediatek.com wrote:
>>> From: Ryan Wu <Yz.Wu@mediatek.com>
>>>
>>> This updates dt-binding documentation for MediaTek mt8192
>>>
>>> Signed-off-by: Ryan Wu <Yz.Wu@mediatek.com>
>>> ---
>>> This patch is based on v5.10-rc7.
>>> ---
>>>  Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
>>> index 0668c45a156d..e2f0c0f34d10 100644
>>> --- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
>>> +++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
>>> @@ -7,6 +7,7 @@ Required properties:
>>>  	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
>>>  	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
>>>  	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
>>> +	      "mediatek,mt8192-efuse" or "mediatek,efuse": for MT8192
>>
>> No, "mediatek,efuse" by itself is only for MT8173.
> Is it should be modify from "mediatek,mt8192-efuse" or "mediatek,efuse"
> to "mediatek,mt8192-efuse", "mediatek,efuse" ?
> 

Yes, as you can see "mediatek,mt8192-efuse" is not defined in the driver (and
should not as long as the HW has no difference from the already implemented driver).

Regards,
Matthias

> Regards,
> Yz
>>
>>>  - reg: Should contain registers location and length
>>>  
>>>  = Data cells =
>>> -- 
>>> 2.18.0
>>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
