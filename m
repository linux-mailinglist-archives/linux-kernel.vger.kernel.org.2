Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD73BC11F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhGEPnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhGEPnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:43:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68203C06175F;
        Mon,  5 Jul 2021 08:40:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p8so22610614wrr.1;
        Mon, 05 Jul 2021 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+SRLE0tPUsz9JGstgxnhEOYaBDJCX4/2/ht+oLnNatg=;
        b=AnNCZDrC3XgFdjPmO4zWV+8xVX1Th2OcBIhf7ZUoCjVQqYTtQji90c/PaaZ998+M6x
         z+LgD+6xEdGuyQMtGu5eVL3xsvJRnlRlrbSnsrETnUchmH8g60zFl1eodg9a7wMptgt2
         mtJnBD4uyv0FmTr1SjqDvXieQ6XJ0jicfWlDxlN7vH3mPI3hUvpRwhGEqNZMPJkn9XvH
         h3GPLdT/qrgj9hrBLFogAitMbbhjNCHgUvAiWrBRkW5EZC/eDLGvSHphrlChLj4OyOT0
         uGOTXi3M91mqAwcxUIcmir3cGsRO0QSK03TgAP65Ykpr94a50/1JgBItbp5e0Op9AHUc
         3QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+SRLE0tPUsz9JGstgxnhEOYaBDJCX4/2/ht+oLnNatg=;
        b=Pe2RC8FpnkanqpIlgf0dW4cnM+X/oB1zCydKUaFa5sWA1l7T5OCpTJ5A6e/EjzyUdh
         h78wHAXZmpacOMq+fWCOTaC/A911IhMq0Iq/RRUY0kVlMSigb6ol+tX5CKTCN6kSXnRL
         QDQ2K3On9JGi8WGXyABtfqO+pn+JdT3H2I6ZvsbWTbTEc7wNKf72B97GBkDdfhNREa2g
         OxL0QZrXsxgvaLg01G0KG95cIR8wxg8zKLl1m6fr0JNrksmmVImbYSMjk6oBWzlFKWMc
         DCz4mcj0ObNkSL9FXyM6DY/OY0ql6AqirUzjqCeMwUQbK301RA6hpwbhsy0smqRmiuYo
         t9Pw==
X-Gm-Message-State: AOAM533eDfNYqw4xIFcsE0d2KaLB+y1ul2IkjrvtINFGXS2VYnvUVYxC
        f8Xat18hLNmW/Er6+53EfN0=
X-Google-Smtp-Source: ABdhPJzIVjdY5LyWZGNBnQbxixb6xvnvBMZ3/L2ZACruHYs5eHf+9pOKYeyPGKILeKujuggFhiDH3w==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr16172872wrs.259.1625499625999;
        Mon, 05 Jul 2021 08:40:25 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id 31sm14971533wrs.79.2021.07.05.08.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 08:40:25 -0700 (PDT)
Subject: Re: [v12 02/20] dt-bindings: ARM: Mediatek: Add mmsys document
 binding for MT8192
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
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <564fa3c8-1d85-5e98-f3f9-f83cb17e905a@gmail.com>
Date:   Mon, 5 Jul 2021 17:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210705033824.1934-3-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/07/2021 05:38, Chun-Jie Chen wrote:
> This patch adds the mmsys document binding for MT8192 SoC.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> index 78c50733985c..9712a6831fab 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> @@ -16,6 +16,7 @@ Required Properties:
>  	- "mediatek,mt8167-mmsys", "syscon"
>  	- "mediatek,mt8173-mmsys", "syscon"
>  	- "mediatek,mt8183-mmsys", "syscon"
> +	- "mediatek,mt8192-mmsys", "syscon"
>  - #clock-cells: Must be 1
>  
>  For the clock control, the mmsys controller uses the common clk binding from
> 
