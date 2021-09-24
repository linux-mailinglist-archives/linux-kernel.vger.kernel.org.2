Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3205416D98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbhIXIVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:21:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53998
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244678AbhIXIVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:21:15 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 19AC34079D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632471582;
        bh=c0wuCPSc0x9xGVIhUquA9CgZ6k+TiKYwRjcwj4ZggoQ=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=dNb8MphmiCBhUFkGtyvdgckxgkSfRe9vfQGX+8PBRsQeMdtNHT1HQcgBbuv7q3trU
         8vT9BcAQ2F0XzTy1QGXl67NEw2JlutyYNye0oj2hrCQDas+2gkFlD3o3YhAu3zmZsS
         P96md0X+BYj7g9Yawl4Md+4KxkuIg+giyr94tQ2W60VzF76P7CYD/xMkn9xqWlNPc0
         1d8XQURpGpJeuslEfIHKzQMCt3UdGfKRrjNFb777HGo3G9Lo887wSV56bTwswcs05/
         G6zl5mqTgApPBIYSHz6Yk/NFwF3BBimakFKD62+ypvB4cEBHpPelk5orbE+fVU9nVz
         G/l3KCZlec/Nw==
Received: by mail-wr1-f71.google.com with SMTP id j16-20020adfa550000000b0016012acc443so7389123wrb.14
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 01:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c0wuCPSc0x9xGVIhUquA9CgZ6k+TiKYwRjcwj4ZggoQ=;
        b=tuRMh3rmTqScPnvJvNbWQafScovu1Ke2t4NrxQfa7vw2hukDDm4USXimWCOBZ7Mxnr
         498+J9mN6qyggPUmlXadPuq3kqpcmuLDwkKzCHXGZirTAMlPkmNd3yZjejIHz0whnTWn
         sXmKFnvH6yGAig5Nze7AOtxQZlbSytdyMtMSB1wehRuP0TrrJ+DvQycDDoeFmLAWHVY0
         z7llsXg6UoDPBO6NbWFw/zBVAMuCoatsxJ34f6zwMMX6FuLMK2T2yJcTdwHltmn2cQnw
         OchneBYQiBsb5X2jG0ouzvTJM8i9W9A7RZOLJLU4jjmtptkknKN1QVc/ttEi2NYnCoyM
         IZtw==
X-Gm-Message-State: AOAM5303/XgJWZzG1w0SurRCcxk+icxrA7sC7anHWkhalAfBUc07y81e
        yO7PI7h9a8RTX4YCpNKY55uZMXaO7aIO7ffJ0VpFpUIAWNbN3SbuPQMl1UTCKGZQ8VkZKhcxCdZ
        dLHs6bnM+DHwCK2kzHCK0OEMgi7aG83HDdS5xsCPPIA==
X-Received: by 2002:a1c:3b54:: with SMTP id i81mr732318wma.120.1632471581518;
        Fri, 24 Sep 2021 01:19:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1C+cVYdmRZUTlAjomfSJCurRjYJSJ+tIhqYru5qzoX0rLrdEtmb3ME8XHJhD/TSPVPDKbdQ==
X-Received: by 2002:a1c:3b54:: with SMTP id i81mr732302wma.120.1632471581386;
        Fri, 24 Sep 2021 01:19:41 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id r5sm7315447wrm.79.2021.09.24.01.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 01:19:41 -0700 (PDT)
Subject: Re: [PATCH 4/5] ARM: dts: imx6sl: fix mmc compatibles
To:     Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210923201238.2516844-1-andreas@kemnade.info>
 <20210923201238.2516844-5-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d556611b-a1ec-a492-55a8-3704fde2487f@canonical.com>
Date:   Fri, 24 Sep 2021 10:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923201238.2516844-5-andreas@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2021 22:12, Andreas Kemnade wrote:
> Binding specification only allows one compatible here.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
