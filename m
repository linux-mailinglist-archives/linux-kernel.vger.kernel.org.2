Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD7F3FEEAB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345166AbhIBNa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbhIBNaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:30:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718E3C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:29:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so1398543wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ivnC5t+kwzEH+N/lwdFwyYkZFXtqdXvtkdNGNrl+pyw=;
        b=1HcCAvg2il9akpcXzOUs8HyMDSI1KSiAnVYAsl62L7af0eG96ldqVLQb/3YBdeYLwV
         cIu693qcBr7CqppExod3FEtLhWx1fi4GZ0LWN42pFmyP7EXDKEqhkqu/9TixABY5MsQI
         jaqLkzxF+D8MQ21vtdFh0+D9BpZlyEElXAwAyUyyQ1q0z9MacbgjnACTTqFzhx6X267j
         Vr5tou3hzzDM7Lwz06IcN3f/u1n8BNeR9PR7B8Th+Ex0iUt/veZbRObtupzMz5WeWm0X
         gxSZWVpdiEofWzmWTIqurV7knf+9SFloLiA1bdYu1tPbxr8EOXPCl/QPl4AME2jciCeb
         Opng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ivnC5t+kwzEH+N/lwdFwyYkZFXtqdXvtkdNGNrl+pyw=;
        b=EEIesT70xLP/qmMyEQ9Sk7eHLvurFkTaljDG2JsgOY94tTD6/REX7NtGjofQsTg9AN
         N3nl0cl1GX6S7pUIrC9xNS0ZCaCLj68zZmeQvf+Mct9KLBJeIBhzn4pzoMLHZ3qWYeaC
         JuhX16cRT9KdJxmZLMWCcvA56EwpYIM5XYt9N+OiQ31/k6lNLkXQMgh6FnyWvXSKKZtx
         d6CF8oi98/vR9TLfsOoj9EDSFbcAm1EOZCN97JwdBR58DwNT399Lx0J/e6iID3io9WXc
         wzqIwO85BnMB+ctNBXPNee/qZcO2I9TK92eg48H0zNn/q66I+knTjqQkzj2FXpFj1OGI
         kmLw==
X-Gm-Message-State: AOAM533CWiwSWhPf111s6hbHIRA0AxV+jScxnU2bktgxr8kwPFRumQZL
        mY4+2YW6WdAW71C5nZD6ojOZRkc5ry6Vg+eq
X-Google-Smtp-Source: ABdhPJwidUUfhzH1N+y3nf6q0yaSEafQ9Mt8Zb9Ypp6EK721dFqZJXusGJx16rI1rSukALSGIuTvmA==
X-Received: by 2002:a1c:e904:: with SMTP id q4mr3195951wmc.26.1630589365913;
        Thu, 02 Sep 2021 06:29:25 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:98:6312:3c8:6531? ([2001:861:44c0:66c0:98:6312:3c8:6531])
        by smtp.gmail.com with ESMTPSA id p5sm2007079wrd.25.2021.09.02.06.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:29:25 -0700 (PDT)
Subject: Re: [PATCH 3/3] dt-bindings: arm: amlogic: add bindings for JetHub
 D1/H1
To:     Vyacheslav Bocharov <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vyacheslav Bocharov <devel@lexina.in>
References: <20210902130516.3892452-1-adeep@lexina.in>
 <20210902130516.3892452-4-adeep@lexina.in>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <e2216ba3-12cd-4d89-d330-e384f34a2ec0@baylibre.com>
Date:   Thu, 2 Sep 2021 15:29:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902130516.3892452-4-adeep@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/09/2021 15:05, Vyacheslav Bocharov wrote:
> From: Vyacheslav Bocharov <devel@lexina.in>
> 
> Add bindings for JetHome JetHub D1/H1
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> index 6423377710ee..b223d7829c3d 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -86,6 +86,7 @@ properties:
>            - enum:
>                - amlogic,p281
>                - oranth,tx3-mini
> +              - jethome,jethub-j80
>            - const: amlogic,s905w
>            - const: amlogic,meson-gxl
>  
> @@ -133,6 +134,7 @@ properties:
>          items:
>            - enum:
>                - amlogic,s400
> +              - jethome,jethub-j100
>            - const: amlogic,a113d
>            - const: amlogic,meson-axg
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Could you put this patch first and also CC devicetree@vger.kernel.org ?

Thanks,
Neil
