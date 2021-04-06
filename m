Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB6A355CE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbhDFUbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:31:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45798 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhDFUbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:31:06 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lTsLh-0005vk-S4
        for linux-kernel@vger.kernel.org; Tue, 06 Apr 2021 20:30:57 +0000
Received: by mail-wm1-f71.google.com with SMTP id c195-20020a1c9acc0000b029011b91a22942so1248794wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 13:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7+94ZBJm+NXJ3TDW1eAiyPRLMTS6GuI8L2lEKPsy6k=;
        b=lnImYb/eULK58Voyk2GG/7fasyyK3FO9lYj6IRXFa+7F9yNfJvQEb0sxl1DSitb3gH
         qPHxGKi/5PX+bz/d92AqGR/CkxQ8qldi8k8k5ug6WffmR8TjKWDWWXQNAyFQFAdXllT0
         kzAoER54Sm7T7leqtff4Y0YM8Ab612jSLXa5349caVXraS9LJnd03ur0Yc+YeGnnNgaX
         y5Onke2qCM/gFie1RWK7hZ0TODuGNK82uwuV4hfM2rgxgyfHISZKoP977ss4iwvjKjTv
         vCcNTHnYQffyXhE0xGocQ055gMwQkni5bV+3+l6r9G/lG5Jh/n5029aj4AW5bO6pJ2wi
         HBVA==
X-Gm-Message-State: AOAM5311gZQKtu33wQwPkPRrwIo/s0CVmxZXbDs5pkDkeQwolnWxWfcz
        QfZL/lMZJpMAIR5OxwWDLyoJpAr1wxS4DHnKwvoyBPcbINv7sQr5dSiH1ljLHKq+B5lbH+h+e+U
        FBYQPPFLdHZhFtocb3+Fx20PZV2POiyUBNeIs6O0B+Q==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr5759662wmc.66.1617741056940;
        Tue, 06 Apr 2021 13:30:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBnGGIOJEWEgxIzcQNy0Vn7tOaFRBBj1SkjOKTIQQbKh6OtpW6JLsbpoc2kT2gebyRfxim2A==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr5759656wmc.66.1617741056797;
        Tue, 06 Apr 2021 13:30:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id o5sm34551051wrx.60.2021.04.06.13.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 13:30:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: exynos: correct kernel doc in platsmp
Date:   Tue,  6 Apr 2021 22:30:53 +0200
Message-Id: <161774104755.124746.8536738781662816687.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210405181605.52612-1-krzysztof.kozlowski@canonical.com>
References: <20210405181605.52612-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Apr 2021 20:16:05 +0200, Krzysztof Kozlowski wrote:
> Correct few kerneldoc issues, including W=1 compile warning:
> 
>   arch/arm/mach-exynos/platsmp.c:89: warning:
>     expecting prototype for exynos_core_power_down(). Prototype was for exynos_cpu_power_down() instead

Applied, thanks!

[1/1] ARM: exynos: correct kernel doc in platsmp
      commit: 6031008780efaada18087eba7ec84fe149f124a9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
