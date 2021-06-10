Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB8A3A276C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFJIwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFJIwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:52:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8909C061574;
        Thu, 10 Jun 2021 01:50:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so6003875wmd.5;
        Thu, 10 Jun 2021 01:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=44JZKXW5mlJ+V66lNHP+kLdlMsmv+wQwqYhG+XePn7c=;
        b=M7yW14u97s0esMMs5NLjNyxtwj6BNY8fZyF5sZK8eL0iaCFu/ff14nbLM1WLXapT8c
         xP7B3ubFVTXi9zKXlwpz5T5vTGo23jRWOKqANUpzdn+rnOFbL+yzyg0rdCD0Qi4mkyXy
         W0FyMfdZ13WgAMGzxC5wF+A/vEhYx4C2Y2BE7ytxDwXGLkTBiNtfQE71ZDGT18v2CKfY
         jfrfHYgByJTSqEK+uybf+x3IEJ8H7rAO8ePDaBcvHs6FAtFlKnhTk6JA1UwImYLFt998
         etkfyMgFQDdru6TrrZTaXxFnR87EmbRST5fl46lwAsJcdKQFsCnWaQwodLq3I0AmOcLq
         p3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=44JZKXW5mlJ+V66lNHP+kLdlMsmv+wQwqYhG+XePn7c=;
        b=Uu9/wXqrdpSofsLLRkdICQ3FlIM80rB2aRa4/I80/UoAaLUI1Czm1LT76XUmJ/04uN
         cAIRs1WqpvppO5dwWVHuUj0C0TunEYPARqgQ6Ah+f1SvRWzpJb2QobcRXkRUEF4PowZt
         7Bg0XqN0EMiKSiDZvMtFtTBGbGypviycewQrZiikItcNHVLwIQnVjldOpaqnE2g1iOOP
         EV7PlE1ZJ/E/vokiJ+1UaGv3EyJHkJt7jDirSsyrLayTemCTMWVdhpAhohdQ3lJeEaCM
         I/DQdfrSD2DkfixxUFTDWPMPsoxpKdtINwYrwIK9ja70EcmoEHigXsVOIdjpdLxhIbWq
         MzAA==
X-Gm-Message-State: AOAM532ibKS7l97qi8tbyJN6Y2g2D7mTK4WZtgurjEDV27EKIYQDy2Sz
        Zv69vn/HfSFAgoSCqjFBzwg=
X-Google-Smtp-Source: ABdhPJzipKj0+rm+nYuqnnIexKWbIJ3xlkSONQUmo8ETNx/aSznC0DwV2AcZ+4LyWwkx6A/f1k88hw==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr3798921wmc.127.1623315019312;
        Thu, 10 Jun 2021 01:50:19 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id v7sm2650858wru.66.2021.06.10.01.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 01:50:18 -0700 (PDT)
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "chun-jie.chen" <chun-jie.chen@mediatek.corp-partner.google.com>
References: <20210610023614.5375-1-chun-jie.chen@mediatek.com>
 <20210610023614.5375-4-chun-jie.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/3] soc: mediatek: pm-domains: Add support for mt8195
Message-ID: <f050f072-1732-b6f0-f505-2d0a44563ce5@gmail.com>
Date:   Thu, 10 Jun 2021 10:50:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210610023614.5375-4-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Jie,

Thanks for the patch, comments below.

On 10/06/2021 04:36, Chun-Jie Chen wrote:
> From: "chun-jie.chen" <chun-jie.chen@mediatek.corp-partner.google.com>
> 
> Add the needed board data to support mt8195 SoC.
> 

Please try to come up with a better commit message. Especially mention that we
have to increase the SPM_MAX_BUS_PROT_DATA.

> Signed-off-by: chun-jie.chen <chun-jie.chen@mediatek.com>

I suppose your name would be "Chun-Jie Chen"

Please also fix your git settings to that From and Signed-off-by matches.

[...]

>  
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 8b86ed22ca56..1b8967b9829e 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -37,7 +37,7 @@
>  #define PWR_STATUS_AUDIO		BIT(24)
>  #define PWR_STATUS_USB			BIT(25)
>  
> -#define SPM_MAX_BUS_PROT_DATA		5
> +#define SPM_MAX_BUS_PROT_DATA		6
>  
>  #define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
>  		.bus_prot_mask = (_mask),			\
> @@ -72,8 +72,6 @@ struct scpsys_bus_prot_data {
>  	bool ignore_clr_ack;
>  };
>  
> -#define MAX_SUBSYS_CLKS 10
> -

Good catch, not needed define. Can you put that in a new patch please?

Regards,
Matthias
