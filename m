Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D2B39DA2A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhFGKxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhFGKxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:53:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8A5C061795
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 03:51:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ba2so18046331edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2o3lod6/tQHJli1HMNUrlxY009C4XIUm342TOsfm420=;
        b=IDblBJOC6V9zP5f7LWfXEcaceHMvkrZvOa8yV6hifBe1VNPbmasGY76ZoNwEbmJUXf
         a4wuIkXjW0rajqvi8oEp4HLaxLJZI6ty3T3F8RT7HSQRirWsNev3zAiiqQ0Pt/JVkLAp
         tV/5UpfQ9JzyjPjjwHdOlEcNNhwNHRLsOQrFedTfKH1CEZAhMzONRY1VB/g9NbcsDpFk
         ZEPcY5l/UI4m/2ls2yq8wE4vp2YBTVXJUmD1y0K9F+1TjB+svCTAeo52AaxIeAU9oRQo
         oIqNsxa4GDByyI1en2vnRcN3rHSxMKLcEkS2JYdTFuu/hUonPuVmhjYmqRLGYtYTEHIh
         X2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2o3lod6/tQHJli1HMNUrlxY009C4XIUm342TOsfm420=;
        b=qxC/mjcmI63QkbB21IHRLY07TRBvi5eedyzAS+hJPz3JY5Ur4spfMuWxCzDPc120Ha
         Hp0aTlp3CmCiTGx3PV0oAO7/mUwI0ZfFvgm/fJaTKNil89M/idh1GaO6jTyY63RvrVLi
         JMEcUyT8YnesZ7NQu2Pgdpk6bhMI6FjWA1MV7RjWEWwwv6vG2NBirWeI7xBY5Ri7LMzZ
         Ze3G60U2OTvjO8A6NILafqODTpSTBaXm7fHHxwBTBuwsQxnTUKyhzAd1LvjEPG2oMKy1
         mBG4DzuEb5zPw9wXWeftV4i7+x1xurOM08ZKMmbzfeJnckQpi0jClb+IpBD6U+swtaFM
         ecKw==
X-Gm-Message-State: AOAM531w95q8Ibj4q2F/N7/6wHlQtmShb6a2PUc6xJp8tJoTc+hgWYj4
        dVF0FJIwmDSCOro3bX9QH3DVfQ==
X-Google-Smtp-Source: ABdhPJx4Ct/adIB5Q8H0U4N3keddlIjXCjd7JyHgiTLDw9+AlwtyGjYmdmxaLq1m06KpolO9YYNo1g==
X-Received: by 2002:a05:6402:31f3:: with SMTP id dy19mr19383237edb.153.1623063105759;
        Mon, 07 Jun 2021 03:51:45 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-76.xnet.hr. [88.207.96.76])
        by smtp.googlemail.com with ESMTPSA id f6sm6340003eja.108.2021.06.07.03.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 03:51:45 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, lee.jones@linaro.org,
        p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bgolaszewski@baylibre.com
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v5 6/6] MAINTAINERS: Add Delta Networks TN48M CPLD drivers
Date:   Mon,  7 Jun 2021 12:51:22 +0200
Message-Id: <20210607105122.2047212-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607105122.2047212-1-robert.marko@sartura.hr>
References: <20210607105122.2047212-1-robert.marko@sartura.hr>
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

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..82d9c2943c34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5096,6 +5096,15 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/platform/sti/delta
 
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
2.31.1

