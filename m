Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98FC3B8166
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhF3Lpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 07:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhF3Lpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 07:45:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5493C061756;
        Wed, 30 Jun 2021 04:43:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so1345965wmc.2;
        Wed, 30 Jun 2021 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iODbWiouD0QpY2BGF1bz2zvH9cqIAWCPddrbkXWdpQM=;
        b=KJMKkEGNHAUHuk5D6X3LEbETeBJhBvD8t6AyN5xPMN8srDc19A0OEVyK5h+xIWRhjn
         sf96TLzwxbXF2IY2vE2ECZ+vYVA9vfrlK9+UMV2mRXlEkQ2CwUNlTgX+4pV+Dk0lPlSl
         gXcWGkkcQiAPfKb/9RbJN8cRbxFZQttUuDM9F0rfT5fOv9svEOYc5/t8EjqEI7wBQslv
         4BIyQ/qDfMdZU+sDbMcXWdqpPhD03cuH0md405YHkXj0WVR71Dp3I9b8m16zYqVzMWvr
         GqXAbjG7DXFE5RGXs6aLsphoD4lVqSdPD2smTytZ0yNJvrmlzFkvxdURMbmfFYM7ZEab
         6mEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iODbWiouD0QpY2BGF1bz2zvH9cqIAWCPddrbkXWdpQM=;
        b=MswxG6C67AdySymhocajWCA1b8LxgwuEyYZEwnTD1UrxhZdQqgWbYLqYiXd6Ec+fci
         gD7UHsiz3KIH99FZGh/xxtYgRBYwE6TJg49h5144nfk30Q1Y9gi1k7Ban0IzVekKY1jB
         LsTR47YNuhGdaEqayL9RJfOWrcjVlkgBh/+8s/DbGIbj9F6sUoNmBNq+RMJDxmYFk0D5
         5HA/QcqA33H6tmDwD3BqUyIoxkFubMJGXgCjb+p9NWhS/yZ5PylnWLs1jiDwOUyd4FmY
         HbHJN1nhFVlglTl+wRkw2i3wslSPfAwHmDLbH5Sxuv9gR/rreNbZr0U0bTG/3YOswxLa
         pHcQ==
X-Gm-Message-State: AOAM532eGmdy3Tk07rJAZZbgvqFCXz88g7srb7WFl5Ru4SzQtN1wzrvK
        hhGzREqB7L8hJ8JstmArNdE=
X-Google-Smtp-Source: ABdhPJyXaz/kDNmiMTIsGgDK7ph+Gfm+KdTCvu18y18r0ZCf+HsuoVtRyW3YnpWwR3RqHGNmyYOezw==
X-Received: by 2002:a05:600c:3b8b:: with SMTP id n11mr3977228wms.159.1625053400497;
        Wed, 30 Jun 2021 04:43:20 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id k5sm21380301wmk.11.2021.06.30.04.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 04:43:19 -0700 (PDT)
Subject: Re: [PATCH 03/22] clk: mediatek: Fix corner case of tuner_en_reg
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
 <20210616224743.5109-4-chun-jie.chen@mediatek.com>
 <CAGXv+5F2zTcqnjH2ud38vUD149KJtgxhPQME2Mk6-vGtQv+2YQ@mail.gmail.com>
 <ff6179e8-06f9-fbba-c704-a74381c2149a@gmail.com>
 <CAGXv+5FXuMnhsnytLYKKA9YE97bps7KnkDNADvv8f_wdTqnrfg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <be824462-4c2f-3bde-0a3d-c5470a5b0fbb@gmail.com>
Date:   Wed, 30 Jun 2021 13:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAGXv+5FXuMnhsnytLYKKA9YE97bps7KnkDNADvv8f_wdTqnrfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/06/2021 13:09, Chen-Yu Tsai wrote:
> On Wed, Jun 30, 2021 at 6:53 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>>
>>
>>
>> On 30/06/2021 09:31, Chen-Yu Tsai wrote:
>>> On Thu, Jun 17, 2021 at 7:01 AM Chun-Jie Chen
>>> <chun-jie.chen@mediatek.com> wrote:
>>>>
>>>> On MT8195, tuner_en_reg is moved to register offest 0x0.
>>>> If we only judge by tuner_en_reg, it may lead to wrong address.
>>>> Add tuner_en_bit to the check condition. And it has been confirmed,
>>>> on all the MediaTek SoCs, bit0 of offset 0x0 is always occupied by
>>>> clock square control.
>>>>
>>>> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>>>
>>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>>>
>>> Though you might want to consider converting these types of checks into feature
>>> flags.
>>>
>>
>> Yes I think adding a feature flag is the way to go. Luckily there are only a few
>> SoCs that will need updates at the same time.
> 
> I also see that the different clock modules are tied together using only clock
> names written in the drivers, instead of clock references in the device tree.
> 

Not sure I understand what you mean. Do you refer to something like [1]? That's
because the clock is probed by the DRM driver, as they share the same compatible
and IP block.

Regards,
Matthias

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/mediatek/clk-mt8173-mm.c?h=v5.13#n139

> Unfortunately reworking this would likely require a lot more work. I previously
> did a bit of internal reworking for the sunxi drivers. While not the same, I
> think the plumbing required is comparable.
> 
> ChenYu
> 
