Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47424433820
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhJSOP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhJSOP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:15:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A26C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:13:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q16so6453692ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xOf0sXy4r35p6gXgfs572/QVIu+3RqyjsQzstLELFKo=;
        b=xOzg9dDLFJ2rIaTnWwrjon0eSXJL9XxQdU0uVA3N6jx041/RkHqwl2YULEw3kckCHk
         tpoxMWz5/sAEs0hRLL/tOLiDIgtnUOmhF2mSfmhnenpwaMowoiLTioQBJMWsrzPT9p+S
         CbhJXTbaM4u7Ysf5W8W1hublkFZH2AZFWWCEGw3EnTnqoHxJN6ieozBRhOEm81yDwRZf
         GoOvQsmRfAV0kh4aYI4GPaAwH8F0l5k2hm1NyvjnwMbM8fmnJ44spbnr3lhIpv3uK7ix
         bNs2AmFZ4TVfQjKuGJRABruNdp0H0T87n+UFDj/HjbnazX3IzjLYzEDnWs7cJtizQVsM
         +ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xOf0sXy4r35p6gXgfs572/QVIu+3RqyjsQzstLELFKo=;
        b=0eX4rqzaK3ndTbQ0XJ6o1sk1siXjvZ3NXtrUY9WGMXFRv6M3b/XaCkxYXql0Ykgfl8
         f4GjQkNT3rvMfMfOY90pfM1yqROQQeUhw10s+iNqHKteksvXQGM1ncND2zvIzOk4CWck
         NIX95TldXpa9kxCZzmU119g7lAMNS/7PPdGrRqGPK/ITE8wpAQx3diZzoigqWnWLJBC9
         lD+VvgvYr9elzSLD1RALB9gAOUL1fTF1NFxIwvZV6qUXJKTYgj20GOWyCeQMKatmYPAE
         LaROalckp5PA6GBw8gQQUPW7KKAOWc9+yi9C/qr3qfnmvTNV0vOln+gdvLZNGnJgDs4b
         Wbkg==
X-Gm-Message-State: AOAM533kUwmAqkBGsNMCQrYKpAi28KGVHrnMvBFDSerZdXYMy+aw8qxm
        6fLnPCcaS/B+38XMBQ31SDO9IA==
X-Google-Smtp-Source: ABdhPJwB5/NUjhIzDhmdfovwpekqaEGkErkI7uh6Y4F08p8/rAjaHeGJTWShQGEc56ngqQAFoTpCZQ==
X-Received: by 2002:a2e:9b12:: with SMTP id u18mr6952241lji.447.1634652791875;
        Tue, 19 Oct 2021 07:13:11 -0700 (PDT)
Received: from grasshopper.googchameleon.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id d24sm1957805ljc.2.2021.10.19.07.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 07:13:11 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     dinguyen@kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, upstream@semihalf.com,
        mw@semihalf.com, jam@semihalf.com, ka@semihalf.com,
        tn@semihalf.com, amstan@google.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v4 1/2] socfpga: dts: move arria10 aliases to socfpga_arria10.dtsi
Date:   Tue, 19 Oct 2021 16:12:27 +0200
Message-Id: <20211019141228.1271617-2-pan@semihalf.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019141228.1271617-1-pan@semihalf.com>
References: <20211019141228.1271617-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

socfpga_arria10_socdk.dtsi declares aliases which will most likely
be used by other arria10 boards in the exact same way. move these
aliases to the parent file.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi       | 13 +++++++++++++
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi |  7 +------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index a574ea91d9d3..26b1662cc00f 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -10,6 +10,19 @@ / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index 7edebe20e859..e9bb56ec15f1 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -8,14 +8,9 @@ / {
 	model = "Altera SOCFPGA Arria 10";
 	compatible = "altr,socfpga-arria10", "altr,socfpga";
 
-	aliases {
-		ethernet0 = &gmac0;
-		serial0 = &uart1;
-	};
-
 	chosen {
 		bootargs = "earlyprintk";
-		stdout-path = "serial0:115200n8";
+		stdout-path = "serial1:115200n8";
 	};
 
 	memory@0 {
-- 
2.25.1

