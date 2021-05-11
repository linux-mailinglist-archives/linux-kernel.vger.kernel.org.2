Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9653237A6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhEKMjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:39:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51160 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhEKMjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:39:05 -0400
Received: from mail-vk1-f199.google.com ([209.85.221.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgReA-0002ke-ES
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 12:37:58 +0000
Received: by mail-vk1-f199.google.com with SMTP id t190-20020a1f46c70000b02901eba03cbf81so2396588vka.16
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 05:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YhaXTvaayEOzoq0QjzmBPdXnRVsB0DBQyw7HOMA/2VM=;
        b=qXl9us+CMa5dj9ABOMQV04TEawPM9031R2ybUgVQmOpL3MfIjyDPkZPD9DA8ChAGvj
         MWZb/V5tgTAo9+QwHcDwwkfDi5hPfUd+q263YWnfpvLXv95MdkwUHOQ2pTt3zVDF0pk1
         O+q+rkvW42wS1AorsbAaXKBPu268nlR1sCSPgmB9HlZXhY9BMUGxVL/G5zDJ4naLOT/i
         FBfzKWB0Fr9aiVgut+oqUwLUaCRi7Y2ICvCWmIcsQr/KTm2F7ppY6O5qAEgkD3O3HgaT
         6d8dRH76++3yRJ1HiTvO9X/IX1RLeoJPHAMlSDyYb61u7gENKI7MYJsag+UM2lfw/Z/9
         OZaQ==
X-Gm-Message-State: AOAM532AX95ORtq9mFMdjD3AhzYgmH+U7THYcF8ktottdNZ0+IYjYko5
        nx4NzV5KGlDJPWAe9RFnuR8SO/nt6yoHRpZCDsS53gDOpg32nQlcdDe/Vrs7ZxLDI8Ue1WxPcUi
        wrL13Eb7nfT2LWebJ5AqL49w/7bf83j4FGG8PUfyjcA==
X-Received: by 2002:ab0:596f:: with SMTP id o44mr25517832uad.8.1620736675846;
        Tue, 11 May 2021 05:37:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXNWN45OqkMAHJDZh/zGUfEUXLkG+LvL4VP0sEIb56QoNjxAOq9rxkqZYo4mO9Z+Y5kcvoUA==
X-Received: by 2002:ab0:596f:: with SMTP id o44mr25517783uad.8.1620736675545;
        Tue, 11 May 2021 05:37:55 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.2])
        by smtp.gmail.com with ESMTPSA id c69sm823434vke.48.2021.05.11.05.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:37:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: s5pv210: remove unused Atmel touchscreen properties in Goni
Date:   Tue, 11 May 2021 08:37:42 -0400
Message-Id: <162073661213.12308.11074899946393736120.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506152044.37579-1-krzysztof.kozlowski@canonical.com>
References: <20210506152044.37579-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 11:20:44 -0400, Krzysztof Kozlowski wrote:
> The Atmel bindings and driver do not use custom properties like
> x/y-size, burst length, threshold and so on.  The driver gets necessary
> data from the device directly.  Remove unused properties to fix
> dtbs_check warning:
> 
>   arch/arm/boot/dts/s5pv210-goni.dt.yaml: touchscreen@4a:
>     'atmel,burst-length', 'atmel,orientation', 'atmel,threshold', 'atmel,x-line', 'atmel,x-size',
>     'atmel,y-line', 'atmel,y-size' do not match any of the regexes

Applied, thanks!

[1/1] ARM: dts: s5pv210: remove unused Atmel touchscreen properties in Goni
      commit: 8b7e0f72ef7123460b31fbe0652e1871603d2b70

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
