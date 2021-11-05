Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9654462EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 12:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhKELmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhKELly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 07:41:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39057C061203
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 04:39:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c8so15294804ede.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 04:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6adjk580AwBpX7D5EH7ECcA7MO/6lGH/OQuhWqLcWr0=;
        b=PTQpkE73T8VhxCQRE4WhJJhCyojtElJ0yQxQdOzz5Kl+xX4aemHEcBHvP6EZJxRBuU
         9vpKIEUzjbSmIKckHblGxPQqM9gtg4xaftYzThbZNdc3qfm8fdEdxSd9Z+A0LkkwxDpH
         eqVivy7eeSQj5jY3hYsVhIy6f8kpeuo9YkC64fT1DhLh2daYpAGMXnXK9JrYxGe7uUw9
         XBshf2mbqTRFHg5C3IujZ9aexhgtHB0pyAoUIPBbkm1+sEWudTVk1zBhQvBaoi+VPHLK
         J3mHxYakJ5WcIxNmwG0swQ96Cr2e8coDykUXYth71g/rSvhNF76+2xo+0SmQe39GS1Aq
         6ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6adjk580AwBpX7D5EH7ECcA7MO/6lGH/OQuhWqLcWr0=;
        b=DjxxfSgcxRrYltTMWdhhehF8vnhRTtIzIBz+k8PYDQWrGQzXRseNjab6Mh6NW23Ds7
         RyIGri8gimqAvnEszUriWtywdkEfnRqtSt0XKrL57rEwTAAunyGIjOUyBo3CO1YAHphA
         5bRNwTrCbFDoUzyqpS7usbyzphA8MowXnKsfZNvX9ZVijMuxAHYjEitWDY1O2+EuBB0S
         V88fgGO3H59fQp6T7inCqz0rMF9tQMGLKB096un3mqtFpWBcoHifiWf+r2frr6LBgiM6
         Z9ybbCmrnLSaD/0sclaYZ1ryhMhBNslDq08UX21YnLWixsOMGlBfnDyIJSVSLWQuWNTU
         8XSg==
X-Gm-Message-State: AOAM5330ekDNRbeyWqur3A3AVxEoSne7VNIm7Zl0G/DdnOPGecXUWHyQ
        sO9WK9dOwrjx70UNa2lj1SrNUQ==
X-Google-Smtp-Source: ABdhPJx46W7TaP6K14Q54kzOmy38rYsDTGuuLKLlGkvE7kcQnhyX5+lM6JcOLz6QRswp8wsbzNEwnQ==
X-Received: by 2002:a05:6402:1d4a:: with SMTP id dz10mr5712600edb.172.1636112353778;
        Fri, 05 Nov 2021 04:39:13 -0700 (PDT)
Received: from fedora.. (dh207-99-83.xnet.hr. [88.207.99.83])
        by smtp.googlemail.com with ESMTPSA id bn20sm4011325ejb.5.2021.11.05.04.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 04:39:13 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        michael@walle.cc
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 6/6] MAINTAINERS: Add Delta Networks TN48M CPLD drivers
Date:   Fri,  5 Nov 2021 12:38:59 +0100
Message-Id: <20211105113859.101868-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105113859.101868-1-robert.marko@sartura.hr>
References: <20211105113859.101868-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers entry for the Delta Networks TN48M
CPLD MFD drivers.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
* Add reset driver documentation

Changes in v2:
* Drop no more existing files
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7b4f32875a9..92747bfc01db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5289,6 +5289,15 @@ S:	Maintained
 F:	Documentation/hwmon/dps920ab.rst
 F:	drivers/hwmon/pmbus/dps920ab.c
 
+DELTA NETWORKS TN48M CPLD DRIVERS
+M:	Robert Marko <robert.marko@sartura.hr>
+S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
+F:	Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
+F:	Documentation/devicetree/bindings/reset/delta,tn48m-reset.yaml
+F:	drivers/gpio/gpio-tn48m.c
+F:	include/dt-bindings/reset/delta,tn48m-reset.h
+
 DENALI NAND DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.33.1

