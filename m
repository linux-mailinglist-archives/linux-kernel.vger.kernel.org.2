Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3342417161
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 13:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245046AbhIXL6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 07:58:35 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56530
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244681AbhIXL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 07:58:32 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0240B40784
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 11:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632484619;
        bh=GX1knPnuUXedW7zKBIwh7buu4qnYLP5gHJJI8M92Q5Y=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pOggI9vERhZL87htktEobI/vThl+wGmNIC2N5XlC0hIoeJtAU9CHFmZ6PJBspqCVY
         JNzmto5f4/BtRIP659XfUR+DYCEv8Kfllx7iDjEoocBjrgr1aLdohV+Jsd0V8MQR4S
         9ieO/58uoEqfxNtwGYL7DEE4cesK2x2Yh6r56LgffZxDVjwA4BzTDFXsVbEKjyngnD
         8GyUTO5tgfHW+IQAciLKJzv7vTJJug8/paMsi6W5xpjWuzQaaJPRkk8zv6/N7sGQ4R
         vRejfoB6H6T7lWawfBvLijA0KxB8ou0L+Fvsa2xOc/n+hH2s1IlcnlICIhU57/6k1A
         ySljgXikgaISw==
Received: by mail-wr1-f70.google.com with SMTP id a17-20020adfed11000000b00160525e875aso317809wro.23
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 04:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GX1knPnuUXedW7zKBIwh7buu4qnYLP5gHJJI8M92Q5Y=;
        b=St9LwsVJ5SQ9iBV/Kwfvj2n43/SnejPwFbGhZvx0SUFu6XPkgdTp8mQa3hcC1feZhw
         3CUsUTggGXEcaHMBJSOk3D4Wzy7Nv1T1yVx/iJv5ISOTcrVWCellmDbEw+Ya1cTjvUyw
         fAmQ3jX6GOTD88yuwuK0suSzOb0InR0umZf+CYWTXoJzE+39yUswG2NzWCoWdJZsX5Gb
         9YL16hF0U2LeimrmephDjjuwfIkxa4KpDp53WhtUyJSyPAQ37C945BZVeoG3Jh/mn43H
         be760+rstTkp5w3WjBLAsGz+ibT+vkvWbLkQYe+R+9C9USogTb8+su+7pIKieq1iHDIa
         iW1Q==
X-Gm-Message-State: AOAM530DGPXyQ1319WGiRfUAKZHWhhvYKl5hAgd7sv9ljq8G0bvtd99C
        YyDAyzCtlhOum4ieF/f5fhIqT6527Re6PKx5G2YdR24qfcVahFJx/Ur+3yKLHQUPXGdbLW2WruH
        STEgffii+VVtwxgOPmpNMfbdfLe49R7xtwgrny3qQKA==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr1634139wmi.77.1632484618754;
        Fri, 24 Sep 2021 04:56:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXJb4pwOnliV1jgLnmbC3kFVKrJQ1Obb4/nVSeDv38AOCQxLVJrgwBjsv3xE4VMIzLKHTqNQ==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr1634127wmi.77.1632484618628;
        Fri, 24 Sep 2021 04:56:58 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id z17sm8076664wrr.49.2021.09.24.04.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 04:56:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: power: supply: max17040: add entry with reviewers
Date:   Fri, 24 Sep 2021 13:56:19 +0200
Message-Id: <20210924115619.52927-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924115619.52927-1-krzysztof.kozlowski@canonical.com>
References: <20210924115619.52927-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Maxim max17040 fuel gauge driver supports several devices used on
multiple different boards.  The driver is incomplete and has few known
issues.  Fixing these might break other platforms so mention recent
contributors who can provide feedback.  This way most of interested
parties might help reviewing the patches.

Cc: Iskren Chernev <iskren.chernev@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Matheus Castello <matheus@castello.eng.br>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index da9d5383af04..9f925d0f8a3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11429,6 +11429,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
 F:	drivers/iio/proximity/mb1232.c
 
+MAXIM MAX17040 FAMILY FUEL GAUGE DRIVERS
+R:	Iskren Chernev <iskren.chernev@gmail.com>
+R:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+R:	Marek Szyprowski <m.szyprowski@samsung.com>
+R:	Matheus Castello <matheus@castello.eng.br>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
+F:	drivers/power/supply/max17040_battery.c
+
 MAXIM MAX17042 FAMILY FUEL GAUGE DRIVERS
 R:	Hans de Goede <hdegoede@redhat.com>
 R:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
-- 
2.30.2

