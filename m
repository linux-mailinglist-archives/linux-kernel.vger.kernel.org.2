Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF70F3B9589
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhGARdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhGARda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:33:30 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6993C061762;
        Thu,  1 Jul 2021 10:30:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso5396476wmc.1;
        Thu, 01 Jul 2021 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wB59Tcol7WFyeIqJfVL0G5i3exPR6uZKms17tlCBAcA=;
        b=Y8ARRoqc+A3kGi68cV34ZqpfYcUNQk7PR0cfnBlk9Lcy+jS9GLKKIaDT7LnqR/4ZfU
         lwW5OFcVy3apvlrcNpRuQlclhWKkBfiXPOVsVU6zs5R1lQg+pY5NfjCJCCw+qkhWXdFg
         rW5B/pXvj7RKYopYjO2IqgNVUK2J/RMfhxt6T0O4mNfmLMnWnUXclbMK4Sa1zXyooqlI
         2KA4NIfDYFtih3LTEiBF03jeOBMny4UpdGyswCqm3Dg33cIXDLZLcm9YjRa09h6BXx00
         zP2eQmh9gpMCXo8f9GNMR2gkSTZux1HfhOlN7ZV8huXyRgTx8aKg3jdAmNuuvhckdxqn
         26rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wB59Tcol7WFyeIqJfVL0G5i3exPR6uZKms17tlCBAcA=;
        b=HViwnbfopQgr/1Q9iuHAa2yKlWYV7RDMOD5d8YVplZVRc72S7AvsyikrbJ40TAQp85
         Z6ahM3hpn6vU6WIlSmkVRzReDAknWHhf0YMFgh9lSwBobisz6DQZsknVWsXup14yQE86
         4Ir2hcxL97tEKsfYAuqGleFNvcaRDzYIHf11afaTGHf2M9eDwbc9gjcmC+D9EDAFTAXT
         eMbpd/S77vVFvy3g5P1cC5Ua8+oHmcEx1IaJ1EfsXFUpDtrdtLz8eu4Q8V7AA4R02y67
         6wRLr6zoFZ+87B9aNYmSCXlrlGduMM+5DLRRAG+j1I0FKuoL1KQorUS6XvasWn1yjmXk
         QB/w==
X-Gm-Message-State: AOAM533nGPWWrPtLQTHa+zeP9ctS3Yobe3oWnkJ4lLEaJT+AjKDRuDzx
        tnlAkLTeYugcrUK6bqeQeOk=
X-Google-Smtp-Source: ABdhPJxq0hqSO0GgKP+IeHAM+Sv/K9Ww1tFO+oYT06t29roLupBgPd6bCKR7iRCdUtEV8d+GtGdsgg==
X-Received: by 2002:a1c:8097:: with SMTP id b145mr11874162wmd.54.1625160657555;
        Thu, 01 Jul 2021 10:30:57 -0700 (PDT)
Received: from ziggy.stardust ([213.195.127.100])
        by smtp.gmail.com with ESMTPSA id y7sm10089139wma.22.2021.07.01.10.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 10:30:57 -0700 (PDT)
Subject: Re: [v11 01/19] dt-bindings: ARM: Mediatek: Add new document bindings
 of MT8192 clock
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210630132804.20436-1-chun-jie.chen@mediatek.com>
 <20210630132804.20436-2-chun-jie.chen@mediatek.com>
 <CAAOTY_8SgZ5SN9Q0nfL_jQVTbB7ZDqgoGFRkKe8+QJwUi55Hew@mail.gmail.com>
 <da0db357ac7e41ca6ec2007eccccbb465049cd01.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <775b61ab-8a23-ab78-f7a8-11d09d7ded3f@gmail.com>
Date:   Thu, 1 Jul 2021 19:30:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <da0db357ac7e41ca6ec2007eccccbb465049cd01.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/07/2021 04:13, Chun-Jie Chen wrote:
> On Wed, 2021-06-30 at 22:30 +0800, Chun-Kuang Hu wrote:
>> Hi, Chun-Jie:
>>
>> Chun-Jie Chen <chun-jie.chen@mediatek.com> 於 2021年6月30日 週三 下午9:30寫道：
>>>
>>> This patch adds the new binding documentation for system clock
>>> and functional clock on Mediatek MT8192.
>>>
>>> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>
>> [snip]
>>
>>> +
>>> +  - |
>>> +    mmsys: clock-controller@14000000 {
>>
>> mmsys is a system controller rather than clock controller, isn't it?
>>
>> Regards,
>> Chun-Kuang.
>>
>>> +        compatible = "mediatek,mt8192-mmsys";
>>> +        reg = <0x14000000 0x1000>;
>>> +        #clock-cells = <1>;
>>> +    };
>>> +
> 
> Thanks for you reminder, I will move mmsys to system clock controller.
> 

The mmsys should be documented in mediatek,mmsys.txt

Regards,
Matthias
