Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9243CC147
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 06:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhGQFAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 01:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhGQE7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 00:59:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FDFC061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:56:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c15so6306038pls.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+99X6tDDuJ/XktfbyFhmKZGyLFxw8e69PtMLfb60Jwk=;
        b=nx0dOqNc1L+tIbRTHbQkMSV2014cdIVo8H/lvQberVUn4cI+XevZ9dCVXN5aOLOiHX
         4YaNWo+HBXs89M5jks4zav8jJB2syiB66tMR6UcJcaaMO55B0fPpohWRTkAHN0Fgohzn
         /KLQTp0ZrJMlToyvUoUuScaiYEE/96V5wKrwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+99X6tDDuJ/XktfbyFhmKZGyLFxw8e69PtMLfb60Jwk=;
        b=NNpMSoctRdabBcEpKuoMjD4kfHtSK8hGX5TAF0kTR7Lur1lwBE9Djblb7odGEwDD0Y
         6+iFgB7vyLQpF7nKMuILfRfB5Qm6rOJ6/aoL5GDQxGSkcfCv2YBZ4LsQ4vWoSGlnxAxe
         wuA4kDdpJ5ovad973jg8lKuHSD4XDEAUr5kYWF6IksCiXiiqtH2AsJqJZUhhzF0An/4I
         vJGCGJ7r7Rmtk2jH2lUGIbJOSQtqd19XVsyn7m9XfUYMRmNSvNrovczAnztvjMMCMkuc
         qbcXsLmpQFhilT2biChouMjD9rggqXBnSz+vI0fV7dPDrEyJF+xM5zPD+m5aH3tD4euN
         b7Zw==
X-Gm-Message-State: AOAM530jtEMvm5I6KRXmvZaS62zh22df+T1ZBM3ZII0BqiU08bv04AwJ
        4RS6w2yzXa2mIb4zjR992TJl4Q==
X-Google-Smtp-Source: ABdhPJyQzZHeaw/dbUZRfEWWOtOv3kUyMj1TQQA3beExPEf0SUosVfBZyHlIhMXCZ4guT4+66ErGZw==
X-Received: by 2002:a17:902:e2d3:b029:129:70aa:990 with SMTP id l19-20020a170902e2d3b029012970aa0990mr10524774plc.34.1626497813793;
        Fri, 16 Jul 2021 21:56:53 -0700 (PDT)
Received: from shiro.work (p866038-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.60.38])
        by smtp.googlemail.com with ESMTPSA id w2sm12522885pjf.2.2021.07.16.21.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 21:56:53 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, romain.perier@gmail.com,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 05/10] ARM: dts: mstar: Set gpio compatible for ssd20xd
Date:   Sat, 17 Jul 2021 13:56:22 +0900
Message-Id: <20210717045627.1739959-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717045627.1739959-1-daniel@0x0f.com>
References: <20210717045627.1739959-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there is gpio support for ssd20xd set the right compatible in the gpio node.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
index 7a5e28b33f96..6f067da61ba3 100644
--- a/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
@@ -6,6 +6,11 @@
 
 #include "mstar-infinity2m.dtsi"
 
+&gpio {
+	compatible = "sstar,ssd20xd-gpio";
+	status = "okay";
+};
+
 &smpctrl {
 	compatible = "sstar,ssd201-smpctrl", "mstar,smpctrl";
 	status = "okay";
-- 
2.32.0

