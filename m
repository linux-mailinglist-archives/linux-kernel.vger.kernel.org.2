Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566113BC12A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhGEPru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhGEPrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:47:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D2BC061574;
        Mon,  5 Jul 2021 08:45:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l5so5850070wrv.7;
        Mon, 05 Jul 2021 08:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iRm7ng62vz94LNteI1Cih0zeAdgyP1p1V+2xJCFvsqg=;
        b=VKCvWgx307Vniav5+5GwJdAoX+BqLeBProcFBWAg1Db+3j859JQYDj247SVBafkYz6
         tp3+x3bLx5Wq9bbY3k5uQWCBDyVRH6A8ILbuys1nMGOFw44HHEteT6ZLYgzVqj4WYhhd
         h7RMf1Z+1W/z6H+JYAK+u9jv/TkqCFSRWe9o69Nhv1sfaFpsiKtbZvjJ89VHwU90ujhW
         4axxUUHR2NVjRciPhafM1vWaObcE3qqgdp4o/nPV1bdtbdn6acDXtJa/UHrF61BBSJ4M
         mHpT7TTEhMn8Jq6729O34Yhk8jZiSX5cT+QYsciOIOgPJjQa8f5oS0ASk5/rM1kMWTax
         Pf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iRm7ng62vz94LNteI1Cih0zeAdgyP1p1V+2xJCFvsqg=;
        b=GOPPTuEFLuWLbBkTbrPXFAcSrUlbcWlrkkxfoPxsg8PdUlSUytMKjw8+SS3sMurSvY
         Wtbkx5XHexQyTXqyWJgWj2L9tLoWh9suHihbbPTFgYk37QVo2md28u3mWyZgtQFcPtt9
         iXEVIBMHqKAN/kkWmSrJePlKlWo3k/tRoxCrAh4gma/Y41UYxPf8MXXmQ8jcOGszt0NN
         22KF1UB7T/TFujAKBisDAXcE1KhFLXxuLrNMPa2gvS/37wtde6FZ9ZEb31aEOUwvT/Vg
         +Qm04ZjyBHtyIvBJWGs16I3Oci2kMdSoOSts7cPMNEz/BUj8vjkHd2Nk45YpIVLlhOp+
         x4jQ==
X-Gm-Message-State: AOAM5339ctzbNUkBxS9CefuoY5q3v7PR0xZI1VvqXxZHzttvXGXNjcT1
        8ZqqxUWU2TYytNdofzGInQY=
X-Google-Smtp-Source: ABdhPJzc63RLP0dLTZRU0oPe/Q+B3XBpkwNbTucwsbP8b4phCD5U2diRKEdWeN26wMIkt907FvnvNg==
X-Received: by 2002:a05:6000:118d:: with SMTP id g13mr16362365wrx.191.1625499910517;
        Mon, 05 Jul 2021 08:45:10 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id v25sm13917133wrd.65.2021.07.05.08.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 08:45:10 -0700 (PDT)
Subject: Re: [v12 02/20] dt-bindings: ARM: Mediatek: Add mmsys document
 binding for MT8192
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210705033824.1934-1-chun-jie.chen@mediatek.com>
 <20210705033824.1934-3-chun-jie.chen@mediatek.com>
 <564fa3c8-1d85-5e98-f3f9-f83cb17e905a@gmail.com>
Message-ID: <15d27282-54b2-2cfe-7f44-2df3be11dd40@gmail.com>
Date:   Mon, 5 Jul 2021 17:45:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <564fa3c8-1d85-5e98-f3f9-f83cb17e905a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2021 17:40, Matthias Brugger wrote:
> 
> 
> On 05/07/2021 05:38, Chun-Jie Chen wrote:
>> This patch adds the mmsys document binding for MT8192 SoC.
>>
>> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 

Of course, that's not what we need here...

Now pushed to v5.14-tmp/dts64 until v5.14-rc1 is released.

Thanks!
Matthias

>> ---
>>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>> index 78c50733985c..9712a6831fab 100644
>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>> @@ -16,6 +16,7 @@ Required Properties:
>>  	- "mediatek,mt8167-mmsys", "syscon"
>>  	- "mediatek,mt8173-mmsys", "syscon"
>>  	- "mediatek,mt8183-mmsys", "syscon"
>> +	- "mediatek,mt8192-mmsys", "syscon"
>>  - #clock-cells: Must be 1
>>  
>>  For the clock control, the mmsys controller uses the common clk binding from
>>

