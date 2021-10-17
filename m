Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4254307CC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 12:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245294AbhJQKOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 06:14:49 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44202
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241777AbhJQKOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 06:14:44 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9DB2140067
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 10:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634465554;
        bh=z+Yvl5MxN7G24k69fezv+OIEbXw/e8Y8tbIyKV6Zeq0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kO/YApmHhqot8Q8hD8VannAf86TqIcrXttEJ2bYNydJS3QzdG9hKn/3f/n6YMljas
         MU04B84mYC/kAwJ8YLcAwBXfKcO+xjHA0XnbAS2DWI+dCw4xMTmB73OoY2yA0nw7EI
         nwoImBd1GhG/tt9Oxt3iiKAcGtH/AmAyM8arylRsW4M85xY6Rl1DK2DjhLDyNKucHz
         ouXIijPmc6QvBYWgrkNZFmt8H9K454hFVJla9NvJleGeMOvoNXngm9aL5DGLTPxX8R
         IaUTU8OvXiJxG+rPnBkdmYiHSdHIDjUb9XQR1pNJznvsOU2HMBbIC2XW95n0aeq2vj
         RQrFKNEwDCwnQ==
Received: by mail-lj1-f197.google.com with SMTP id o4-20020a2ebd84000000b00210ae894d18so262095ljq.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 03:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+Yvl5MxN7G24k69fezv+OIEbXw/e8Y8tbIyKV6Zeq0=;
        b=Q7EAak00lRfptYFf2bRaHmWuo6rmwyRSjhtn9d6W4ZLjxhHjwhZOgJR0A9Qq4bGBwQ
         PQlVTHP+ejtvbTK+5cwoTXVyYCk7bIkhHTOjYayjdIxJdgotu+p/q6uFVXYrzPXu75HT
         FGnCB3p3CMz3bpgl9S72Ubu4cKNfXueYQQ7tJ/Xnuih3faSiGH8o6Bi7KxcmVtHl6W6r
         oDEqw2INZOphOhAIOGXjNsq7mZddmmiMVPW6X0/Cgg6yoMj8iDMCbF4GFLq/ro+EC66T
         4c2uU/1XcKeQgYLnv+gpaPkiheP6xxpQ/z8PK7PeiROkzmAAIDVglM2VGFecWJfEocn/
         Xp4g==
X-Gm-Message-State: AOAM531Z/sAlznGEPze+ouAF3NavoiFax//SA3CdASKOzvTkjgR6rB7/
        THx3Dhq9mFR8d/YVc0ipwvzwfkXKNWRHHZiljwIWE3/BJIC/MI/71kxnguM22zBPiJKMMyCNhhw
        Qg79M2CHP8TSP5OZDaEpvRFQsan19kGM/9L5yNYP5zg==
X-Received: by 2002:a2e:bf18:: with SMTP id c24mr25315242ljr.408.1634465554149;
        Sun, 17 Oct 2021 03:12:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMeE/7DuZbSRa6Q/OCAhMpCb6zaUHxq/kojV6hdGyM8OLwBKoP7thjhaN90iCO0nLQXUFFqw==
X-Received: by 2002:a2e:bf18:: with SMTP id c24mr25315221ljr.408.1634465554013;
        Sun, 17 Oct 2021 03:12:34 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o26sm1263077ljg.92.2021.10.17.03.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 03:12:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 3/3] ARM: dts: s5pv210: add 'chassis-type' property
Date:   Sun, 17 Oct 2021 12:12:28 +0200
Message-Id: <20211017101228.19478-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211017101228.19478-1-krzysztof.kozlowski@canonical.com>
References: <20211017101228.19478-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new 'chassis-type' root node property has recently been approved for
the device-tree specification.

Add this property for end-user devices (such as laptops,
smartphones and tablets) based on Samsung S5Pv210 ARM SoCs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 1 +
 arch/arm/boot/dts/s5pv210-galaxys.dts     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
index b47d8300e536..7427c84f1126 100644
--- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
+++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
@@ -8,6 +8,7 @@
 / {
 	model = "Samsung Galaxy S Fascinate 4G (SGH-T959P) based on S5PV210";
 	compatible = "samsung,fascinate4g", "samsung,aries", "samsung,s5pv210";
+	chassis-type = "handset";
 
 	chosen {
 		stdout-path = &uart2;
diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
index 560f830b6f6b..eeec2bdece11 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -8,6 +8,7 @@
 / {
 	model = "Samsung Galaxy S1 (GT-I9000) based on S5PV210";
 	compatible = "samsung,galaxys", "samsung,aries", "samsung,s5pv210";
+	chassis-type = "handset";
 
 	chosen {
 		stdout-path = &uart2;
-- 
2.30.2

