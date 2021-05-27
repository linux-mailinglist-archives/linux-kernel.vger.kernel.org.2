Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F7239331B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbhE0QDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:03:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41834 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhE0QDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:03:13 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmIS3-0003BQ-I6
        for linux-kernel@vger.kernel.org; Thu, 27 May 2021 16:01:39 +0000
Received: by mail-vs1-f69.google.com with SMTP id h19-20020a67fd730000b029024df27884fdso200390vsa.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 09:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VT2B96LV3Sud6lFqUqI11ryilsp1126vHCKGDpUyUJM=;
        b=CrKT8xflHyQvhrwYvqUne6+EphJg/tsUoIPtSrM6M5K27X43LbYVhnD5skEVCEzjhh
         z2fojx/aoLW6mongVvIW7fCU3KD6EoWfqaLCeIO71eVR7A0ySPU7hdRPQRU+G2Xb13a5
         rbCHrF+iXBkfYDdPp9gm8F7ASAq1UewagnqDmmgXfqR3VJhAZgUgSNPkGG6h5fjTZDnn
         623X34B3MkDpvVtkewpA3JRO6vn9JsM5oyGgWMztO33b4fr5BHm/nAjryooKxdnBh2y7
         nB/BcM7pR9M9fZHiGF+XfeW2J2rg75DgUp/geGlWwq3ZL9coTDsvQiX8GVBvvE55vvNU
         LD1w==
X-Gm-Message-State: AOAM5305YHPIjJ5vwjxdHz9JzfDOC/qUQTE80Otlvb2Cxow9x8Xz4bB/
        nMsirFfH/hjSpHJakd3KNvMHEkfyQU8pgDS2fz1x5O899tVUivquX4PfQ2ldV+e4sE0k1TMoo0a
        ybh1DKgwlxTXMOblsnVK3aBpSS97mStZnHM7h2hgyZw==
X-Received: by 2002:ab0:4507:: with SMTP id r7mr3173272uar.28.1622131298298;
        Thu, 27 May 2021 09:01:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsgj2B5pbbVzbAMrL6Yx0irK7rICPVdIXuyTA9xUcByUWQGFiKYpETQbEAAtWdKJLaTMrsjQ==
X-Received: by 2002:ab0:4507:: with SMTP id r7mr3173252uar.28.1622131298122;
        Thu, 27 May 2021 09:01:38 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id i13sm368094vkp.45.2021.05.27.09.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 09:01:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: (subset) [PATCH 1/5] clocksource/drivers/samsung_pwm: Minor whitespace cleanup
Date:   Thu, 27 May 2021 12:01:30 -0400
Message-Id: <162213127799.85759.10470691755359057532.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
References: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 16:27:25 -0400, Krzysztof Kozlowski wrote:
> Cleanup the code to be slightly more readable and follow coding
> convention - only whitespace.  This fixes checkpatch warnings:
> 
>   WARNING: Block comments should align the * on each line
>   WARNING: please, no space before tabs
>   WARNING: Missing a blank line after declarations
>   CHECK: Alignment should match open parenthesis

Applied, thanks!

[5/5] MAINTAINERS: Include Samsung PWM in Samsung SoC entry
      commit: a6419e53c779302f8d5dd409eccf5b41ffa184a4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
