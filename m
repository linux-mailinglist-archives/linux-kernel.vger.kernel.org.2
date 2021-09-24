Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7B7416D83
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbhIXISb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:18:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47008
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236281AbhIXISa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:18:30 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 43A2040264
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632471416;
        bh=adcnp4GPi618GC+howN5SjCFMJE5yHqabJDm1ADbxF8=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=QvZ69G/Kqv4BAVSrB/apQGUS4uOUPetmsmxCiwS73XquDU6UfS7uThhLTcB6JEKjW
         MhsvDD9EmMLhbj10IwUV7SAaMBGUQTQyS7dhnU1k3P0vh3R/mG83NS7QY92tFpeDOy
         iqUDni9zuX2YOVmsfZh9jfc31+9lBdAiwTLzTOI/ubbomRojynqiIZWs7elKxaGpzI
         YcI/DYDJOKMdFvAm0PW9aVoDMLzU3KX6WNgEftDm2fh/1gRPiXT20UTusmufClrPoI
         DPNgz/z4MhA7D3u73DtUqklkKjlN0060jSWI6jychovdN/9KvCBjEos8+FgLpMcKYz
         wzY7KVc8tfWmA==
Received: by mail-wr1-f71.google.com with SMTP id v1-20020adfc401000000b0015e11f71e65so7421181wrf.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 01:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=adcnp4GPi618GC+howN5SjCFMJE5yHqabJDm1ADbxF8=;
        b=b/uzBGjnca6KBLas421GWisyu6U4sSVECLs7LsPCdxE3Es/q2/DSVX1Gi68S4Iy0F2
         SQtoLtOwjdeu6S5B7EvjNnmONMC767yZHjDmQMd0bFJttaSoc9ZX2oQB8FrrYg77gve7
         8dNiYQflyCpKFtLErJ5PgFjnobfCnkMsfFQhJFVgT3TK1qa01C/pYE1540B1V5amNxwr
         aN7f6WCT8kfCWwdrkUqmAxmYVMg4WHx3fr8tqD3+PsKuGTuaRh3Nbqb26mxTr2xmwwrc
         WHA48CCEMuSTt+LNT5Mv7myK4KqDaagJf+ienONDSuI470oOkqJxPZb9783y/CNa0dER
         ENkQ==
X-Gm-Message-State: AOAM531bUsvOPuYKlGU8GjNUrSOORaCuaFwddm114KOXHh9m+u/dGaCG
        J9Ty5VRJ0eulDAJbf5pei8h2xmUgsfFRjoJdowtTHeLepk7wsXqwg7ySHl8kW3tflmcwcYq1iUp
        p3eA/w4awOgp0WQMDXw7yO1qBzzLvpx/BkK20V+jShA==
X-Received: by 2002:adf:e783:: with SMTP id n3mr952609wrm.37.1632471415592;
        Fri, 24 Sep 2021 01:16:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvvnOCjxbLIMKuMcM/FVctZ/YNg4/CfqO5LPRD+MR74KA2VUBrrE8zgWW4PyuxHSiQJ3DL0Q==
X-Received: by 2002:adf:e783:: with SMTP id n3mr952599wrm.37.1632471415468;
        Fri, 24 Sep 2021 01:16:55 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id c30sm7500467wrb.74.2021.09.24.01.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 01:16:55 -0700 (PDT)
Subject: Re: [PATCH 1/5] ARM: dts: imx: e60k02: correct led node name
To:     Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210923201238.2516844-1-andreas@kemnade.info>
 <20210923201238.2516844-2-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <09e3d314-ebe0-1310-073c-f63562a640bc@canonical.com>
Date:   Fri, 24 Sep 2021 10:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923201238.2516844-2-andreas@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2021 22:12, Andreas Kemnade wrote:
> Only led-X or led are allowed according to bindings definition.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/e60k02.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
