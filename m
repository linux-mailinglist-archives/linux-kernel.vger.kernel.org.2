Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F83F3BF7A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhGHJgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:36:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34758 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhGHJgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:36:49 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1m1QQ3-0006cT-6k
        for linux-kernel@vger.kernel.org; Thu, 08 Jul 2021 09:34:07 +0000
Received: by mail-wm1-f72.google.com with SMTP id p3-20020a05600c3583b02901f55d71e34aso2134323wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 02:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E0C7nCPw9ngmgHYShx7ewbeQGAOF1fcpotAi0fhHmT0=;
        b=gCaZ/tathkmvFbhMiUmx8Z68+6H25HlQdjfhAfo3FIvBORNp8q2iIboYt3eV475d8j
         niJkZa6Q9Wg/nSOFGxDXVMy/4hs/mXVugCBLbyOonnaAxZLf6NtflgDP4JzC1CEQRmVC
         O3v5XwONE/a5YIBHOg3gnc/PlIT+x3heKurDYwbKBrHKE2gqIYeNx8wgAgNjrxoftNe4
         ZjaumrhJsWX5wKhNuArJazIWkJJIVFzRo/D9mq10/RxvroCDeDsD4m4xNn0+sJGI4IgN
         ZX6BoSo6sVqa32KVd0qi42oja9khNcEGpDofLXQeH7nK56bA2HOPUjY5g0E92Y2GSHPU
         peVQ==
X-Gm-Message-State: AOAM530MRiqp5x9f+FYUeQvD1MY2C4vs6BrqwNvdC3piPDk6L0xL66xD
        neeYO+wjRVAp0T58JkGYMFhIDf4zpy+mAmCS2nEoNg2rbkUC8xruOf8AeBOimfp7pAAhD5bfpWN
        WuowCi6RmI5bfuqvq4PKNesa+77TkFZjVlFEJm3RIMw==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr32033339wrx.177.1625736846964;
        Thu, 08 Jul 2021 02:34:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6b2RvxjwXvMJgFoy20i+dUp4HtIQ58rbfVrXOuRcq9Ho/OovvbcDwRF9C+0n3tuxHzLL9uQ==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr32033308wrx.177.1625736846800;
        Thu, 08 Jul 2021 02:34:06 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id p7sm1637544wrr.21.2021.07.08.02.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 02:34:06 -0700 (PDT)
Subject: Re: [PATCH 4/9] memory: mtk-smi: Rename smi_gen to smi_type
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com
References: <20210616114346.18812-1-yong.wu@mediatek.com>
 <20210616114346.18812-5-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a3abe400-4172-4f62-1548-b78b9ec4c157@canonical.com>
Date:   Thu, 8 Jul 2021 11:34:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616114346.18812-5-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2021 13:43, Yong Wu wrote:
> This is a preparing patch for adding smi sub common.

Don't write "This patch". Use simple imperative:
"Prepare for adding smi sub common."

https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L89
 
> About the previou smi_gen, we have gen1/gen2 that stand for the generation
> number for HW. I plan to add a new type(sub_common), then the "gen" is not
> prober. this patch only change it to "type", No functional change.

Same.

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 

Best regards,
Krzysztof
