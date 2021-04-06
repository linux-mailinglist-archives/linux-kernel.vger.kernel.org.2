Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88F8355623
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhDFOMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhDFOMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:12:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D37C06174A;
        Tue,  6 Apr 2021 07:11:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i18so10950602wrm.5;
        Tue, 06 Apr 2021 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a8N9uRf0Gjt1ZkH3EJX3OJhZkFtTCvTIIVUHYY2V8io=;
        b=kQ7gxb22p7W63SgC8m84/3xihthhDA1ahIEqalSfzZ00zH4G37Vm/jLGrYo+JCAc+l
         zW9LLcEWxNEReq/qn3RI9aL16LueImTpT7Mk9cCUWhFLeJQGr8EVi20lHdUeb4e003OX
         4fGKisRr8FjA4BeF5+dxN0Y61uzSEqikSIA8NazOI4N26MiKjmK1abdM9ameEov6LnO7
         1OnA8sieoOmZtHbsJxrX0kaCjzoZSJS+Aejkue1t3093T2PTUiqiErb061T44ampTbrz
         JWKXivMcAl7WKDeia366irfAGCowP6n/EglnMIWjREtIbs806zlOQgGYyWopxumGKvx8
         DwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a8N9uRf0Gjt1ZkH3EJX3OJhZkFtTCvTIIVUHYY2V8io=;
        b=krSEa03RR7pCvIY7t9A/opughQ6QoJBb0aXaeDXh7DAYFs8ub73WCy4ANpwKtRSpsI
         8W/pDxhY6N6h/N/I+vuVXB6Aq78bftWbLGbiQ7W2BIlPS2df57MCjpdOjrcBBGk/UwGI
         WpjkbymIWK6nAiy86HkyOpRYD3EjsN7Gons0XIRU/Wgx9SXa1z6JASFajFc2GS97crqN
         CQTnepTPaVMHiHjZR4goDGahjf+834LuYVw5FcVn6U35Q0mwBW/zHXb17GSsseQKw7gB
         UmFQJ8zDr9TgFrm2zF7pYYLz4cqR/cllObR9Uzc1ztMuSqNJK3NzHflG1XVMLKFC3ilh
         UVcg==
X-Gm-Message-State: AOAM531iXtWGzgTgCA0bFB8zgNx4aGkHftLcgfu5NXhahE3j2W32UfQ+
        mjG186Y+qA0uzVdBVcHjWRQ=
X-Google-Smtp-Source: ABdhPJymDec9IWKkYg2+xGqRr36VN4uhMN4N4sqp4Q1yp30rw9mejaDx1vJZTyQOQUnYrXOqaMhRPw==
X-Received: by 2002:adf:eb4a:: with SMTP id u10mr11674740wrn.409.1617718311352;
        Tue, 06 Apr 2021 07:11:51 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id c2sm3043611wmr.22.2021.04.06.07.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 07:11:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: mmsys: add mt1867 binding
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20201027160631.608503-1-fparent@baylibre.com>
 <20201030191714.GA4171611@bogus>
 <CAAOTY_8LwVDxZnSQAdK7mS8MAFZ1y_0EnSzj3UqeCxq-Tc5FuQ@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <0038ac16-4ffe-b141-a417-3639857a2998@gmail.com>
Date:   Tue, 6 Apr 2021 16:11:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAAOTY_8LwVDxZnSQAdK7mS8MAFZ1y_0EnSzj3UqeCxq-Tc5FuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

On 10/01/2021 00:17, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> Rob Herring <robh@kernel.org> 於 2020年10月31日 週六 上午3:17寫道：
>>
>> On Tue, 27 Oct 2020 17:06:29 +0100, Fabien Parent wrote:
>>> Add binding documentation for MT8167 SoC.
> 
> Even though the title need to change to 'mt8167', this patch looks
> good to me. How do you think about this patch? One drm patch [1]
> depend on this patch, if you like this patch, could you applied this
> patch first?
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20201023133130.194140-6-fparent@baylibre.com/
> 

I just pushed the latest version [1] of this to v5.12-next/soc-2

I'll try to get this in for v5.13, if not possible we can sync again on how to
fix this.

Regards,
Matthias

[1]
https://patchwork.kernel.org/project/linux-mediatek/patch/20210405200354.2194930-1-fparent@baylibre.com/

> Regards,
> Chun-Kuang.
> 
>>>
>>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>>> ---
>>>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
