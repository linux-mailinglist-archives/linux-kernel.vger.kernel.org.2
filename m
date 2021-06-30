Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2263B80FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 12:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhF3K4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 06:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhF3K4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 06:56:15 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC99C061756;
        Wed, 30 Jun 2021 03:53:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o35-20020a05600c5123b02901e6a7a3266cso1235315wms.1;
        Wed, 30 Jun 2021 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PZFzBqSOdUpz5FT+hQMzB/lYUpMOqyWwY2MXqol8E/c=;
        b=CCPqh2dcRpmJ1iA0K0EdwI1Ea1pkAN3Urdc8lYQcKza9hBZhxgi9f+enAwppX9BEAG
         h3UxWGct/W2ghCmFDRvEhjUpZ4DNY2G6i66Uj4grL564A9n9adn5HEFTJJ9j4cRLGoB2
         03LivvjUwnOFYuasEXYxoDluU9F/CVUU8ePE5wU3SYcOmuDfVqrmUILMPbgVVsEIsNw3
         1Tw9iUpxQRxnPDHDrg7WceI2ALjRx3SDqF8JGKXxKBqeztxwx8RPHkMzfNIWyzsfMnHW
         MIYfRchmkE3JLd9uJDRT2g6/NOr00y0y+syiuAC8YsjxFpdz7W200Z2XqVLsXSqKRgab
         dOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PZFzBqSOdUpz5FT+hQMzB/lYUpMOqyWwY2MXqol8E/c=;
        b=XalUVcpwcddDZuxhLMO6QkEf3rkk2yKkchy9crY2Q09/d4PPIIeUMy7S0A9rYb7nMn
         QJRwuwTNyiMKOL56iq98LnFU2ay0L9NDWcNITjLTo8fEaPSIZlzWvLRln97dJq3slf9O
         Zo9cKRt/AdVwTE0g6i2Askxq0AsUP8HVu/DQ3EJgs6JjoJZRC9t9/RS6AXMET9YFCC0L
         WSjxtdeQ9Wwodc9VF4Cke8obUN4X2a+UER3YX76JkN6Gpw4gANBDbQP+VoOKBguixozr
         rWo809GL3s7PFdnEG5Lg93TM+apM0Sky+nksyaxDEBbUwAW3ALYKmfsSANCAqCxIMDDC
         +dow==
X-Gm-Message-State: AOAM530I+ybpS+zEVE8X+ESq+qaL0AVwI+C2rFJBGRvhQ0X9r9u+stYm
        BibRepIOVgff1lLX94wj/hSk81sMiqhgxQ==
X-Google-Smtp-Source: ABdhPJxKwjKHQVMFn0QeH9g983FURvqrIYYL21hZCZYr1rBktxqZ/45EQfXuMwY8xvPQjOWp3FOceQ==
X-Received: by 2002:a05:600c:358e:: with SMTP id p14mr23666369wmq.136.1625050424146;
        Wed, 30 Jun 2021 03:53:44 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id h10sm5930905wmb.40.2021.06.30.03.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 03:53:43 -0700 (PDT)
Subject: Re: [PATCH 03/22] clk: mediatek: Fix corner case of tuner_en_reg
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
 <20210616224743.5109-4-chun-jie.chen@mediatek.com>
 <CAGXv+5F2zTcqnjH2ud38vUD149KJtgxhPQME2Mk6-vGtQv+2YQ@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <ff6179e8-06f9-fbba-c704-a74381c2149a@gmail.com>
Date:   Wed, 30 Jun 2021 12:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAGXv+5F2zTcqnjH2ud38vUD149KJtgxhPQME2Mk6-vGtQv+2YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/06/2021 09:31, Chen-Yu Tsai wrote:
> On Thu, Jun 17, 2021 at 7:01 AM Chun-Jie Chen
> <chun-jie.chen@mediatek.com> wrote:
>>
>> On MT8195, tuner_en_reg is moved to register offest 0x0.
>> If we only judge by tuner_en_reg, it may lead to wrong address.
>> Add tuner_en_bit to the check condition. And it has been confirmed,
>> on all the MediaTek SoCs, bit0 of offset 0x0 is always occupied by
>> clock square control.
>>
>> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> Though you might want to consider converting these types of checks into feature
> flags.
> 

Yes I think adding a feature flag is the way to go. Luckily there are only a few
SoCs that will need updates at the same time.

Regards,
Matthias
