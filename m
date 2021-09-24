Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025924171C2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245721AbhIXM0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:26:24 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57352
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245437AbhIXM0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:26:20 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2C6C14082A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632486287;
        bh=MSnDqZAnVcwcTc3AHKewpUeqeJxfFM7DuBuKMJowR+s=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=D4tguKU5p91J2sbp4k/6hCF9kZztTOz5/WaEejygGLFkojwXmzIftHblUoesLUWPR
         bkUZWMQg52JR5hWrBFI8j9lSF0DRNdRe3JfyVSsWL7p7kZB6ndGf+Hik19Opsbc721
         qtjLo3/MZBnmLyeGYqocFORPqAt6j9KSpymFRBFQA4/C34sDBgEFpRyi9a872ULoDU
         47aPq3OcClictQGspilOw9Ck/3krHKuXyTnSAN6yeWF5amINNtxKNbH5DxzjFVpyZU
         zyY4oGd31CQDHW4bR/vxl3A5vEJlHUUttmBOfdibdSTXhTCrs7WM7KF9ByoyBZp7ky
         ZKOAtGWjRfFIg==
Received: by mail-wr1-f72.google.com with SMTP id j16-20020adfa550000000b0016012acc443so7924254wrb.14
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MSnDqZAnVcwcTc3AHKewpUeqeJxfFM7DuBuKMJowR+s=;
        b=HAZwBdCjZYUWoq7EsHltyOiK9Q/2VyT2sz+guKCLpTPBhvlrajui9YTPOPwI1iRJAI
         xlS0N3fkoIHQ92T/YK9pPMZwRZ85IVQXqZEQaLlHlRI77nMb+gTcmV2wwnh7eHysW37x
         REqs1xpyWAVoBzZ70Ff+gH4W3BLsy6pvz4ghADIZsF3Q0DuIpz0pyU6/E/V262BUGf6T
         xgwbDejhNTCxP8fOxOjuirOcHQEVELPJ6VQhGEMVvXVjPlYnv3ez5O5y5r9DU/HNGL8O
         pR2iWHQqvUdawPzCJOwTlWGIMaLjAWmHhJZgG5AEkeKqJar2kmN5dE96jf6bYYUP8qRT
         o1uw==
X-Gm-Message-State: AOAM530mA7RSM/9KuxWscBCwTTO3OoZTNTLARXLcAS8g0kprHAPmvUee
        ptuLAnxxSD0yL9/5p/MCsaxUlUNAhyGlGx3I2/Lcow9F/VvafO4DBPF9iNL+xNYRrLZMqRxd/YL
        IQnh/44O6VpsUHbXqiA8mxRsbUuVFJShoJ7RH35ShKg==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr10955150wrd.31.1632486286850;
        Fri, 24 Sep 2021 05:24:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAOjGm4g+OeKFY3HI1DtFoi4p0HEcm9Sz6LIxq1ZeyRYPNibNHr87XSWZMh4Ww7ERtKqE0MQ==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr10955133wrd.31.1632486286714;
        Fri, 24 Sep 2021 05:24:46 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id k18sm7865957wrh.68.2021.09.24.05.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:24:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] power: supply: max17042: extend help/description
Date:   Fri, 24 Sep 2021 14:24:08 +0200
Message-Id: <20210924122408.101323-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924122408.101323-1-krzysztof.kozlowski@canonical.com>
References: <20210924122408.101323-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganize the Kconfig driver description and mention all supported
models.  This helps when choosing drivers for given system.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 6e4201922f59..ad93b3550d6d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -381,7 +381,7 @@ config BATTERY_MAX17040
 	  Driver can be build as a module (max17040_battery).
 
 config BATTERY_MAX17042
-	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
+	tristate "Maxim MAX17042/17047/17050/8997/8966 family Fuel Gauge"
 	depends on I2C
 	select REGMAP_I2C
 	help
@@ -389,8 +389,11 @@ config BATTERY_MAX17042
 	  in handheld and portable equipment. The MAX17042 is configured
 	  to operate with a single lithium cell. MAX8997 and MAX8966 are
 	  multi-function devices that include fuel gauages that are compatible
-	  with MAX17042. This driver also supports max17047/50 chips which are
-	  improved version of max17042.
+	  with MAX17042.
+	  Supported devices: max8966, max8997, max17042, max17047, max17050,
+	  max17055, max77693, max77849.
+
+	  Driver can be build as a module (max17042_battery).
 
 config BATTERY_MAX1721X
 	tristate "MAX17211/MAX17215 standalone gas-gauge"
-- 
2.30.2

