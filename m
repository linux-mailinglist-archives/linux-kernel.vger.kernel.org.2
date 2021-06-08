Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84C039F97C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhFHOr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbhFHOr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:47:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC3DC061574;
        Tue,  8 Jun 2021 07:45:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g204so1999986wmf.5;
        Tue, 08 Jun 2021 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WhGg1GY2JArUC9JhigDKpkZ6Xe7W1oA3+93jKzq1f38=;
        b=B4mRSioLZ6j//5zPneKMUDsP/wpDVCY3Wj2qLzdp4992p9GhKUIipAyWaUGsLm80Zw
         7lOh10qeX5l99QNrs9GjEE0SrT9dVncEr473I1EEqcy6ycFzWJZEMzhRtb5qQB1qGoXB
         n1qvMWoAU8FNr7m/0F3eLqtYp0M1FHOwPye6OgsWl4PIZXfTNb3xwWgOxJSyqSTd/M4O
         hdtLDsr2QZ0beBYVm12UCEW8zy46M+XbtSIUCmVORs4b2ycGQgGOrK2W/LPyGcGIjkWN
         dJ9dpdHl1qGnl2p3UDlMIf38FqT3dgYleFzwXRqEa71m7/zO11Hk/98O6f9f/4ECXNBA
         s7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WhGg1GY2JArUC9JhigDKpkZ6Xe7W1oA3+93jKzq1f38=;
        b=LvpR36MOeDkIxqu3X7FZ7ZxoPbm3SEuhLldAx4HBxJOtRTIN33n0mgBocVXC2oCv1d
         e1zurAFIYqWFn7TMfhHmER3jb/hNuV4ReSKazy7NywHry2fYMDLAcO9aUKrxZgML9qYP
         Ff45PE23XAyWBDgOBR98AkJo+7ARs2zRlTK1D/MX9k0te/SgKxKbg1aUCtOFq1wZeM4o
         f1hwZXVyA3n9cRKEPHbvD9c6Gy2DIQY5C7kqLhnzXMDqGyKMDSr0ojx+ULBdF5DZrOGY
         /YN/K2MCfWAZjLK2bm83sZlV0PvatLKo5ijuBA1wyPUxUSD/jO2qDJtAhCcgYsoimfBg
         rxfg==
X-Gm-Message-State: AOAM532AGh6V/yZEafK/Qth5ThfdAj1Aymy/prbuOCovA1R56SFnIwi8
        E4gD/PGBibEh0qTD++DKspl36niDP1I+/g==
X-Google-Smtp-Source: ABdhPJzQhcjeRmC8c9aR3UirCowVfXJEx+lHuSu9dvfO3W5sxgdTcQ+GcLNJJx7hbfaGgRDGOE7ieg==
X-Received: by 2002:a05:600c:1c84:: with SMTP id k4mr4726772wms.164.1623163551514;
        Tue, 08 Jun 2021 07:45:51 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id n10sm7990257wri.77.2021.06.08.07.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 07:45:50 -0700 (PDT)
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>
References: <20210524122053.17155-1-chun-jie.chen@mediatek.com>
 <20210524122053.17155-2-chun-jie.chen@mediatek.com>
 <20210602171201.GA3566462@robh.at.kernel.org>
 <66e017401ab93aa02c5d2bbf11be9589b36649ac.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v9 01/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of imp i2c wrapper controller
Message-ID: <1f59ed31-4a0e-9719-bf84-1fe4cdd6c57d@gmail.com>
Date:   Tue, 8 Jun 2021 16:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <66e017401ab93aa02c5d2bbf11be9589b36649ac.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/2021 07:20, Chun-Jie Chen wrote:
> On Wed, 2021-06-02 at 12:12 -0500, Rob Herring wrote:
>> On Mon, May 24, 2021 at 08:20:32PM +0800, Chun-Jie Chen wrote:
>>> This patch adds the new binding documentation of imp i2c wrapper
>>> controller
>>> for Mediatek MT8192.
>>>
>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>> Signed-off-by: chun-jie.chen <chun-jie.chen@mediatek.com>
>>> ---
>>>  .../arm/mediatek/mediatek,imp_iic_wrap.yaml   | 80
>>> +++++++++++++++++++
>>>  1 file changed, 80 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wra
>>> p.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_w
>>> rap.yaml
>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_w
>>> rap.yaml
>>> new file mode 100644
>>> index 000000000000..fb6cb9e60ee2
>>> --- /dev/null
>>> +++
>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_w
>>> rap.yaml
>>> @@ -0,0 +1,80 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: 
>>> http://devicetree.org/schemas/arm/mediatek/mediatek,imp_iic_wrap.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek IMP I2C Wrapper Controller
>>> +
>>> +maintainers:
>>> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
>>> +
>>> +description:
>>> +  The Mediatek imp i2c wrapper controller provides functional
>>> configurations and clocks to the system.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - mediatek,mt8192-imp_iic_wrap_c
>>> +          - mediatek,mt8192-imp_iic_wrap_e
>>> +          - mediatek,mt8192-imp_iic_wrap_s
>>> +          - mediatek,mt8192-imp_iic_wrap_ws
>>> +          - mediatek,mt8192-imp_iic_wrap_w
>>> +          - mediatek,mt8192-imp_iic_wrap_n
>>
>> Looks to me like these are all the same h/w, but just have differing 
>> sets of clocks. That's not really a reason to have different 
>> compatibles. 
>>
>> If you need to know what clocks are present, you can walk the DT for 
>> all 'clocks' properties matching this clock controller instance. Or
>> use 
>> 'clock-indices' to define which ones are present.
>>
>> Rob
> 
> Some module is divided to sub-modules which are designed in different
> h/w blocks for different usage, and if we want to use the same
> compatible to present these h/w blocks, we need to move the clock data
> provided by these h/w blocks to dts, but we usually use different
> compatible to get the h/w blocks data in
> Mediatek's clock driver, so do you suggest to register clock provided
> by different h/w blocks using same compatible?
> 

The mapping of them is as following:
imp_iic_wrap_c:  11007000
imp_iic_wrap_e:  11cb1000
imp_iic_wrap_s:  11d03000
imp_iic_wrap_ws: 11d23000
imp_iic_wrap_w:  11e01000
imp_iic_wrap_n:  11f02000

Regards,
Matthias
