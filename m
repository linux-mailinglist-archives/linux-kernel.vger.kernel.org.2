Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44263FB177
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 08:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhH3G5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 02:57:47 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50392
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232622AbhH3G5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 02:57:45 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 63B10407A9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 06:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630306611;
        bh=bJIz4Y19rg7/qUpPpJZXaZHk00J2jiCSJoqVtvYx8rM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=fxT5nLDxFQvGqRK9Dixxb0e2YJych8iDzHwbGcZhJiET0NpdQ5ZyibS10J9QE+pdL
         1iX+KIG5iNlnNs/NXbpv4T7p0Ds5OVTo4j9smmgogK42aEmHJvPypSMqNbirHCP6Q2
         5+X6UfwmNKLwVhCblxT6G0SOqKNKZVmG33h6CZ0+mJGszSmpGkcCppdKXesfvj8uBN
         /ZbmU91zVum7UQrwHJx7xJUPfIwvtDm0LSiPvJDggivgQhI8zFEcnInZSEVr19WkIw
         uvG/AuCxrqZXhhqW/Cdrp24QxWBpWLkOCEqqxP2jpD3cOI0SQlSoz7R/39ckqjc4to
         HYgoPxuvzwE4Q==
Received: by mail-wm1-f69.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so9646586wml.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 23:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bJIz4Y19rg7/qUpPpJZXaZHk00J2jiCSJoqVtvYx8rM=;
        b=qvLeFdngy8bzmmfsQRKHk+oIRCMWU3q0fb3hysQBUuu9ueO7Ynfh2joBcjDcnzDyoE
         bskwSso9BzZY6Q2tzN9pg4GgZ7nCCHfZmOPkPrGryE0EfxnT5K6CqHHx1Lm49cKHGvKb
         DUtTDqA339DamYJyK7+U+D+rd2y0E+yoj5+Ot7urKJ3/WsYyFB4V/5nZdiy6/BoelQtY
         3KwcxNN/lB8JgE+2d8RDP7B/9TfPaJOiL65iZcr0pjTuwxXQnfZEsnLYKh7QrFEl1gUk
         CsU/tHPSIqDX6bSPIO2DOFBo+MfUqAHqT+jQVLQ6xorWljefTIuVWHk5LPWJHiziZvov
         rsHA==
X-Gm-Message-State: AOAM531btj/x8g9DNkrP8/pIUP7ylHyVQfipRGpdig8UUkcUj/hAi6cR
        eW3rcPa52tRAuCp/RDxaEyS48F+tA/Kj36H2zB/2zqXGFsEpfDtq9Oclaayxk/rKP06Gzrp4/Gw
        eD5WwQX54ffxg9wF5oZRSdG40b/Mjg1fcR27rVKXZsA==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr20854924wmj.169.1630306611060;
        Sun, 29 Aug 2021 23:56:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK8X4s4FNWxNwNlnkSyjRacYY9cst9eFmFThFx2kZOVW+PU7vFqpTEqByV44UA+6qTAbJKBw==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr20854909wmj.169.1630306610948;
        Sun, 29 Aug 2021 23:56:50 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.112.21])
        by smtp.gmail.com with ESMTPSA id a10sm17991221wmj.44.2021.08.29.23.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 23:56:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] MAINTAINERS: clock: samsung: include S3C/S5P header bindings
Date:   Mon, 30 Aug 2021 08:56:47 +0200
Message-Id: <20210830065647.5386-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include S3C24xx, S3C64xx and S5Pv210 SoC clock headers with bindings in
the Samsung SoC Clock drivers entry.  The clock drivers for these SoCs
are already covered.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eee4c926003b..c17299c30ea7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16582,6 +16582,9 @@ F:	Documentation/devicetree/bindings/clock/samsung,s3c*
 F:	Documentation/devicetree/bindings/clock/samsung,s5p*
 F:	drivers/clk/samsung/
 F:	include/dt-bindings/clock/exynos*.h
+F:	include/dt-bindings/clock/s3c24*.h
+F:	include/dt-bindings/clock/s5pv210*.h
+F:	include/dt-bindings/clock/samsung,s3c64xx-clock.h
 F:	include/linux/clk/samsung.h
 F:	include/linux/platform_data/clk-s3c2410.h
 
-- 
2.30.2

