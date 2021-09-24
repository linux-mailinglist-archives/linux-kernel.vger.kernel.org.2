Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB229416D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244718AbhIXIVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:21:41 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54122
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244707AbhIXIVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:21:35 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C1A32402DA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632471601;
        bh=/FpPJ6HUKh570GzSsZQ+WyAXS4zfQoVYPICEt0qHWjE=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=YJd1yfmuovSX2k/Ro1Cu5/LhLvCugxS10ZBC+yBTMJKi90gH1cXnZam779S1055bw
         /2M+7m7khj0gXtU5dDHyqq2GRv/W7HKAx6t3PYs9W7SPShoHCKTGlfexrXQuPdhEgl
         x7DMfs0JP4ArIAkPkcNeYIJl3QVplOCyXtS8gOp2HxRJXwGKJW8xqB/VEcl7DbLGW6
         kW02gzVJgf/LuRWa4vWDFYntwX98BpN8mneyLx8Mtp/WlgqqSq1M1ri69iZPAB4Y0Z
         ecV4JypSoFboDRBQvIt77epegKQhnK6I5+y57YhZS3Q0VNR1Ez5cFZDSvJndMcAGYl
         P+zFcNW2MusqA==
Received: by mail-wr1-f71.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso7352319wrb.20
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 01:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/FpPJ6HUKh570GzSsZQ+WyAXS4zfQoVYPICEt0qHWjE=;
        b=DKs7PhF/EkoHevGwSz085p235K6jShlZdZPzPEPVWjrL/8H+RbJLK+u9EfYyGZz/V/
         glCysOG2H5EPkHRWc/SohuyHZlLtyAkLsSWTXAGUq6sGYqcMcojEO4t2A1OjZT2lr2qA
         7NKHB+onGs2SNvuDndPRGXy4Q0lynUqZfQ51L90m1A+F5YQR6eedhMXUuMy7wOSNe3gD
         JngnUlNMHuDco4f918hvWyyDynhnhwxH1gDFXTKNLs0GbPP4SdkygXzkQyqLdZ7gnZeE
         c4qFkwxI/bEWXC9m1SuLwXTfcG2Bial08uh7WD53zxHYe2TH9gd7XF3PmT+VV7hSQnGt
         49AQ==
X-Gm-Message-State: AOAM533rQCdWzMs+op2dS+AwyJsKWDkp5BuiJF4hoJqgHo6IMcbazYEx
        n0rCDNcjyX8yGy/oTy2KaEu9+Gda3oRlQ8W7PyNo85vUOYxGiKkbIK3d59qUkHwZJ+XuzP3o6v2
        DHrhlaccr3jePzUOlW8R1qSVGUroUikiw1vGDYWfxXA==
X-Received: by 2002:a05:600c:22d4:: with SMTP id 20mr667842wmg.177.1632471601562;
        Fri, 24 Sep 2021 01:20:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyovs07/NpPqs+7EX8hqtEtUX7GPNasLzXOlMR532keOm9gCjirjHV0aIV/QaKqpQCZ0XtFTQ==
X-Received: by 2002:a05:600c:22d4:: with SMTP id 20mr667818wmg.177.1632471601360;
        Fri, 24 Sep 2021 01:20:01 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id c135sm11874595wme.6.2021.09.24.01.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 01:20:01 -0700 (PDT)
Subject: Re: [PATCH 5/5] ARM: dts: imx6sll: fix mmc compatibles
To:     Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210923201238.2516844-1-andreas@kemnade.info>
 <20210923201238.2516844-6-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <c4723e89-a6aa-ab0b-f55a-0d6734a19c34@canonical.com>
Date:   Fri, 24 Sep 2021 10:20:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923201238.2516844-6-andreas@kemnade.info>
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
>  arch/arm/boot/dts/imx6sll.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
