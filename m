Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB56347EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhCXRMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:12:38 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:37441 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbhCXRMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:12:21 -0400
Received: by mail-io1-f53.google.com with SMTP id b10so22263987iot.4;
        Wed, 24 Mar 2021 10:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kfyvyp1Ln5yTnaTV7CcKtsoEbrgL8xSGq9FGtJAW0mA=;
        b=J/ZzUnfzEgagxQDb45hZXtkZMTLK+k/MqZlMu6hMbnfUmkIyEXYI26L1ahsyzvUEO7
         JcR60vNmUht6wUoExVor1zVy9RG5Dx5BSFg8LmMRSd+EmLIe6Ek3r+35p1EfWt48nKtW
         ATYTyeePiLxgoCRjsfW4qkUcFK73Th/hyyOtSNThI0qGzka7f1DzO1/7XnwzJ4xgSQs5
         Js5F+4zQUut/RofRtJOEPDnhlFilecVpIU5sc4yUCLd2h2q8NWWVLW0r/LPRiXqDPT5f
         /YqgyWZ5Ps6Iv48IG7/5oJhjZ1St8bZniRtV7QeZENbbHxD7GGG8HZZfHTyWvgtreRXQ
         NkaA==
X-Gm-Message-State: AOAM531JdeI3Rf0D9fCrMTB5Kfm6YFgZfvu2PpQdLYAX9noAbyyi61Ar
        oZ8j0vrzXyqLKlbzcI8oDQ==
X-Google-Smtp-Source: ABdhPJzRb9p2nx4RVdyDBLdyoKqhTBxwu57ERtx6jXb/Pon7xXueKAeC6ubejPFeiotv0m6IHkNtpg==
X-Received: by 2002:a5d:9807:: with SMTP id a7mr3302492iol.7.1616605940764;
        Wed, 24 Mar 2021 10:12:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m20sm1358405ilj.66.2021.03.24.10.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:12:19 -0700 (PDT)
Received: (nullmailer pid 3264026 invoked by uid 1000);
        Wed, 24 Mar 2021 17:12:17 -0000
Date:   Wed, 24 Mar 2021 11:12:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     qii.wang@mediatek.com
Cc:     matthias.bgg@gmail.com, wsa@the-dreams.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com
Subject: Re: [PATCH] dt-bindings: i2c: Add device clock-stretch time via dts
Message-ID: <20210324171217.GA3262580@robh.at.kernel.org>
References: <1615622829-15167-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615622829-15167-1-git-send-email-qii.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 04:07:09PM +0800, qii.wang@mediatek.com wrote:
> From: Qii Wang <qii.wang@mediatek.com>
> 
> tSU,STA/tHD,STA/tSU,STOP maybe out of spec due to device
> clock-stretching or circuit loss, we could get device
> clock-stretch time from dts to adjust these parameters
> to meet the spec via EXT_CONF register.
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
> index 7f0194f..97f66f0 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
> @@ -32,6 +32,7 @@ Optional properties:
>    - mediatek,have-pmic: platform can control i2c form special pmic side.
>      Only mt6589 and mt8135 support this feature.
>    - mediatek,use-push-pull: IO config use push-pull mode.
> +  - clock-stretch-ns: Slave device clock-stretch time.

Should be a common I2C property?

>  
>  Example:
>  
> -- 
> 1.9.1
> 
