Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4E0445E9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 04:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhKEDb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 23:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhKEDb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 23:31:56 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627DCC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 20:29:17 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bk21-20020a05620a1a1500b004631b196a46so6259362qkb.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 20:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7CQtFRKLxqx+qqsUKVRUJaYz4sr4nG/VYl5q0lBwYzk=;
        b=RIX6Y8FM251JQ3iML3SYH6Qs2eJhQ75+DtnYzmjHfU2udUaG852cuVUKAGsbWh4UXD
         PSuQvdQTLXOtL3wTkorMbZ/2vd2susg3jHJZIAWjupqhPDuAXbdDb3CAWffPzAHDcUSs
         sn2GbOL4iXc5fNSQiAhftUYrTNNqBe8zJpUc0/ViLatwZIY56aVFjcy8HvVEt6d9ZLV2
         Pguxyb3Cn3qpfwi5FDs7ZjET/j0qtn2O87N4Qt1ljMqTMbet4N1uOKdwu2Bvd6ivzHAN
         EKvnvtnk9wzYgYYUPXrc/zaT0eb4U9eRvf6y6MVP9d6+Bm5B6zXhCLLm95RRxNS8z1hg
         +3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7CQtFRKLxqx+qqsUKVRUJaYz4sr4nG/VYl5q0lBwYzk=;
        b=HiDAfYcupILTcVN8ZB+uSYlzbrUSjZ+6cGMbmM8tw9cv9i32H1N1wRTeMH6stkQrD4
         WffuC+nLXAnWnOvuWaLZYGD7Tqw/kDQ1pVfVvPIbkxH4eojlJVpTF4KMZbOShWxhzdCv
         +m1qZxCeX4QCzbUHqakT9EHILAmrYcaN5o0rbewsHlyvXjJLeAqYgg5WipIGG4hSaBYT
         EJe8++tv+94UtI36FIqDzoEEpml4ZLD+AputxSVrQrZRFNV+I4nIQJriDwjW/nWph+Ix
         18+XvPJ8EG9c2vzRfoW1h6fM951BhCJWSJrRHGOgTBy13dHQg9yDx4QiPRYO2igveSE3
         lrdA==
X-Gm-Message-State: AOAM530pnuQ5sXEUdbLmLgQ8Kw69xV/cmjZi6MUjV19RJUnzwNRHKIwF
        +Pc5khMHlTYOOCwJsHLjQW3N2iA=
X-Google-Smtp-Source: ABdhPJyvMunnH5NqggnkiHuCluQZLQysSAvHHDAAqWNSvkewifEK1juuQ/FVxnm0Kw0Pcv6Dit8AhCs=
X-Received: from osk.cam.corp.google.com ([2620:15c:93:a:54be:9375:f9b:ec02])
 (user=osk job=sendgmr) by 2002:ac8:5ac9:: with SMTP id d9mr47311556qtd.383.1636082956536;
 Thu, 04 Nov 2021 20:29:16 -0700 (PDT)
Date:   Thu,  4 Nov 2021 23:29:10 -0400
Message-Id: <20211105032910.446492-1-osk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v3] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
From:   Oskar Senft <osk@google.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Oskar Senft <osk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change updates the configuration for the nct7802 hardware
monitor to correctly configure its temperature sensors.

Signed-off-by: Oskar Senft <osk@google.com>
---
Changes from PATCH v2:
- Add missing address-cells, size-cells configuration.
- Add missing new line between channel 0 and 1.

Changes from PATCH v1:
- Removed superfluous "status" from channels.
---
 arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
index 68f332ee1886..60ac6d3f03b5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
@@ -213,6 +213,30 @@ &i2c0 {
 	nct7802@28 {
 		compatible = "nuvoton,nct7802";
 		reg = <0x28>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@0 { /* LTD */
+			reg = <0>;
+		};
+
+		channel@1 { /* RTD1 */
+			reg = <1>;
+			sensor-type = "temperature";
+			temperature-mode = "thermistor";
+		};
+
+		channel@2 { /* RTD2 */
+			reg = <2>;
+			sensor-type = "temperature";
+			temperature-mode = "thermistor";
+		};
+
+		channel@3 { /* RTD3 */
+			reg = <3>;
+			sensor-type = "temperature";
+		};
 	};
 
 	/* Also connected to:
-- 
2.34.0.rc0.344.g81b53c2807-goog

