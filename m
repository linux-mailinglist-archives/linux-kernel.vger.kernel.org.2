Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C07935E21B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345397AbhDMO6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:58:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58457 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345327AbhDMO62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:58:28 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWKUO-0005B6-Tq
        for linux-kernel@vger.kernel.org; Tue, 13 Apr 2021 14:58:05 +0000
Received: by mail-ed1-f71.google.com with SMTP id m18-20020a0564025112b0290378d2a266ebso1415096edd.15
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yJ2s7SvtJMvGXXT2TcTaXG1f4Lh8es6VQIDWtx4JoOk=;
        b=tQFhTFJsqDyiUrZ1H/dQMYhOsEU4Fm1S7AQnlWQfX6bb1XX23dDM6Dg5mxbXijUW7/
         izzeqr8EmxW72r6GWe1xRT9mLzdho0wJIcPzCK2LHSWcFM9GjVJKv1emdrazk3NRcNZt
         E9HBKy5Ly6ag7IaI37a5zG/KV2s23J6MwzuOb1haiTd20iGmW0TJ6xmI3ML6xpXZE4CB
         Zw0H+GwIKo2uqHdKA4KdHXGbtEDU4uxhNA16wlJ6ZLIk1w7pZ2bZeWNP9uAs0+ON2sLP
         OSzS9/BnIMpYcr2Vn3eqkAO6u5AM4o5vnBS7FGwloejI/xv5gwAUGxoSneMfwaVl+/Jb
         Iduw==
X-Gm-Message-State: AOAM532PSuyu4I7cQU4HCsccT5T6mbkjDiBSv2EV7wMV7wQ5iTStQMFy
        QMfgoD9yEs0DmOVdGEuTF6yn7BxFY43RuEJvetlmISGrektusNFQZDFRnN6Z/Y9I26siNwhpNNu
        qFNe8HRiS8cSuf3C6CJQ5W5GOPECPujRinJlmyEkVGw==
X-Received: by 2002:a17:906:f1cb:: with SMTP id gx11mr13865150ejb.106.1618325884586;
        Tue, 13 Apr 2021 07:58:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBS4f8/FtSKZIitrByeXvJ1+6fxGya2GdvXhrTkGICEYkSUaRVVNDzAJfvhqZqrKTZYiywqw==
X-Received: by 2002:a17:906:f1cb:: with SMTP id gx11mr13865137ejb.106.1618325884439;
        Tue, 13 Apr 2021 07:58:04 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id c16sm8258136ejx.81.2021.04.13.07.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 07:58:04 -0700 (PDT)
Subject: Re: [PATCH v5 04/16] memory: mtk-smi: Add device-link between
 smi-larb and smi-common
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, eizan@chromium.org, acourbot@chromium.org
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-5-yong.wu@mediatek.com>
 <ea7ed30f-050d-2d38-7c61-1e0c192f6ded@canonical.com>
 <1618293876.20053.19.camel@mhfsdcap03>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d3b5b48a-82dc-361b-91f7-df0a73629b67@canonical.com>
Date:   Tue, 13 Apr 2021 16:58:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1618293876.20053.19.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2021 08:04, Yong Wu wrote:
> On Sat, 2021-04-10 at 14:40 +0200, Krzysztof Kozlowski wrote:
>> On 10/04/2021 11:11, Yong Wu wrote:
>>> Normally, If the smi-larb HW need work, we should enable the smi-common
>>> HW power and clock firstly.
>>> This patch adds device-link between the smi-larb dev and the smi-common
>>> dev. then If pm_runtime_get_sync(smi-larb-dev), the pm_runtime_get_sync
>>> (smi-common-dev) will be called automatically.
>>>
>>> Also, Add DL_FLAG_STATELESS to avoid the smi-common clocks be gated when
>>> probe.
>>>
>>> CC: Matthias Brugger <matthias.bgg@gmail.com>
>>> Suggested-by: Tomasz Figa <tfiga@chromium.org>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>  drivers/memory/mtk-smi.c | 19 ++++++++++---------
>>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> I understood this is a dependency for other patches, so:
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> If I am wrong and I can take it via memory tree, let me know.
> 
> Hi Krzysztof,
> 
> Thanks very much for your quickly review.
> 
> I think it is ok if it go through memory tree. In the original patch, we
> pm_runtime_get(smi-common-dev) in the smi-larb's pm resume callback.
> This patch only use device-link do this. thus, this patch have no
> function change. it only adjusts the SMI internal code flow.

Hm, okay, I took it then for v5.13.

> 
> In addition, [14/16] expects your Acked-by. and that one should be
> merged with the others.

Thanks for reminder.

Best regards,
Krzysztof
