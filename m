Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4453E184B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbhHEPlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242168AbhHEPlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFAAC061765;
        Thu,  5 Aug 2021 08:41:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n12so7162112wrr.2;
        Thu, 05 Aug 2021 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mVQSQN7gzFUu+SQZHn++i1EQsf1unkn38HuidAPY1jk=;
        b=EnSWxeBF1ZgrkW2cs8zQj6XSQRMdMi2KJwuWBliPKMN5E5fwIQrR6W1KoP6J2MZOQp
         qtlLcHlvJqbZ9kkwlszodvYM6HSw+1S0fM/KiF1iiDgw0jzZXilEehO5hojIG31rU4RP
         u2MkbGtI/Di7NufyLVvJwiXbrjChWzgElYtWu2HrlED5EDf0exg/hnt9lJNZp5G39obB
         BmCx4i3hSxbOhjJnanOoxP75P3guSfyF4RI5AqvlYL4sPfgLVe93T7jHsW5lSeuR+3uO
         CcKh6CDjt9tfz4Y2U0d6QacHzN5zDz7e8Ed+o7RDYzsMFw7FlMt2lOY36XtW8E/Xtk9k
         JHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mVQSQN7gzFUu+SQZHn++i1EQsf1unkn38HuidAPY1jk=;
        b=BdFBArsk+Cw06sIAMNdUcQmsXoQ+vIiVTdeyzFZ5qkwlIZA3q+texc5gf8+8R+ozU8
         YiVepWC0KB/sz5IKd4//fcSfOotNQaIf9L6gufdT7ldH1iaRF6XLygYpayS9iPKyvu8h
         Hal0OqIy+/DO+EB/Y9VA7QN9TkrD43Zd9TQplQ0rkmreBhxXmHbhUdaw8ltMc/DFhzru
         mYX2Z7eaIHRQ9Oo9WVgC4On+6HryXbih/SuHbM2ZWnQtUmoxbzwJmaOkZj8WfnOieLT1
         a9uOK+frRwyN6eFNp1ZVENqapOLtbpgEmY9gitz1eZo2Ra46hnT1QImHJ4dg9VWCcNrR
         fD6w==
X-Gm-Message-State: AOAM531YB/aqkEtNhUmeT0WUcstpTEKDIOvU+G8p0wyPz/SWIAEHjmS2
        fxEUt6M4Q+TkXmYkYb+wQ6A=
X-Google-Smtp-Source: ABdhPJxCtpqIunU/mFZBvCoYDNuqfTLTZ2pUolhGj+wx3TK++qKad7kmgUfuhNZIAOYiVXXE+6nQ4Q==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr6099277wru.254.1628178065390;
        Thu, 05 Aug 2021 08:41:05 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id l4sm6504709wrw.32.2021.08.05.08.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 08:41:04 -0700 (PDT)
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
 <15d27282-54b2-2cfe-7f44-2df3be11dd40@gmail.com>
Message-ID: <e3210d22-7960-f8e4-c12d-d49ac5465463@gmail.com>
Date:   Thu, 5 Aug 2021 17:41:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <15d27282-54b2-2cfe-7f44-2df3be11dd40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2021 17:45, Matthias Brugger wrote:
> On 05/07/2021 17:40, Matthias Brugger wrote:
>>
>>
>> On 05/07/2021 05:38, Chun-Jie Chen wrote:
>>> This patch adds the mmsys document binding for MT8192 SoC.
>>>
>>> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
> 
> Of course, that's not what we need here...
> 
> Now pushed to v5.14-tmp/dts64 until v5.14-rc1 is released.
> 

Given that the change to yaml was taken by Rob Herring I drop this patch from my
queue.

Regards,
Matthias

> Thanks!
> Matthias
> 
>>> ---
>>>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>>> index 78c50733985c..9712a6831fab 100644
>>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>>> @@ -16,6 +16,7 @@ Required Properties:
>>>  	- "mediatek,mt8167-mmsys", "syscon"
>>>  	- "mediatek,mt8173-mmsys", "syscon"
>>>  	- "mediatek,mt8183-mmsys", "syscon"
>>> +	- "mediatek,mt8192-mmsys", "syscon"
>>>  - #clock-cells: Must be 1
>>>  
>>>  For the clock control, the mmsys controller uses the common clk binding from
>>>
> 

