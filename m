Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E53339A1B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 00:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhCLXmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 18:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbhCLXmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 18:42:09 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026B8C061765
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 15:42:09 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so1592354ool.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 15:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21zeFFqBGNddK9Mlkb6U9/W5aAS8G3U7m4JdsT+PmgI=;
        b=gwBmuyq3TEG2mDz2JBBDSbAmrKnyut6h3xCSJmWI9udOrP/IHHjepA1wRDSYlMrl0z
         tCImgv+wn7F3F9d9dmpfSLBHsq74RSaQsA1beIb62xfXqf6CFrkC1YPNn9MCPkrrbZ+m
         YRhQBC3bVQYxEBRuSR1pP6SsJuT9KK7nOniOuIrsh2lGE6jKz+7ZZ0c3aIPkQHbAGThe
         R3PnxFZEVfOLyFWWafDrA4fMLuXeHDMPiNmzBchqbhf7SaUvaT0whBieOhmEjAZrzkR7
         GFp9NHsoFCP8X3vdOA2jc9LpzVi/Wce4AwTt/Kov5+h6GdXXRB2fphTJlkRFbimaI/5W
         wf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21zeFFqBGNddK9Mlkb6U9/W5aAS8G3U7m4JdsT+PmgI=;
        b=Pxwg5nPrf0sEJdXe6zF8nxuHitpqdZtk6xk/BgRzpR9+HliD5ENtBiljwOYfzfha6X
         sXQIsBKZyaYY6HKV07HzjdtJ605wyvGH7jsgS7NQg2d7wvbx6hmfViL1ciEEFMfzkuej
         nAwMywv6fmYVYXY7LCgBkMJ/Lnn+6Fo5Tu1AWQ2JqvV1uax42J/9qN/kSd6TUIuukHUW
         5Y8Yv/VsLnMkqQpq490RbJWZoCn/VrR4Txd/IP9rUXnO2cQB6+Lcgkpfe73QDUc3NNgr
         PUhJ/Kw5ELTr4VxumweBZRIdBAnLq5senVtXdyYM1ga/oRSQ8If69LPtLa/V6M067I/P
         lN0g==
X-Gm-Message-State: AOAM531smo3U2Id8ltIS39ToC+6WyYceQpxI1JwwVCHd4HlH+4DwAkPe
        gHIgbtzQB8G3qpaxxvsC+/0Cck3tsjKDxA==
X-Google-Smtp-Source: ABdhPJxmjIePLKkb3galACPRbz1sMG/joH1alqggh8DfqNNTCbkkUeDq+7ZqQRdvQS7WrcMCrhhbwA==
X-Received: by 2002:a4a:b987:: with SMTP id e7mr5142060oop.92.1615592528332;
        Fri, 12 Mar 2021 15:42:08 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p20sm2030554oot.30.2021.03.12.15.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 15:42:08 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: sdm850-yoga: Enable IPA
Date:   Fri, 12 Mar 2021 15:43:10 -0800
Message-Id: <20210312234310.3490809-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312234310.3490809-1-bjorn.andersson@linaro.org>
References: <20210312234310.3490809-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipa_fws.elf found in the Lenovo Yoga C630 isn't packed like the one
found in e.g. the MTP, so it doesn't fit in the "standard" ipa_fws
memory region. Further more, authentication of ipa_fws at the usual base
address is rejected by the Peripheral Authentication Service (in
TrustZone), so some shuffling and trial and error was used to come up
with acceptable regions.

With this in order, enable the IPA device.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 7d84f8a2db4d..f40fcd5d08d3 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -73,28 +73,23 @@ rmtfs_mem: memory@88f00000 {
 			qcom,vmid = <15>;
 		};
 
-		ipa_fw_mem: memory@8c400000 {
-			reg = <0 0x8c400000 0 0x10000>;
+		wlan_msa_mem: memory@8c400000 {
+			reg = <0 0x8c400000 0 0x100000>;
 			no-map;
 		};
 
-		ipa_gsi_mem: memory@8c410000 {
-			reg = <0 0x8c410000 0 0x5000>;
+		gpu_mem: memory@8c515000 {
+			reg = <0 0x8c515000 0 0x2000>;
 			no-map;
 		};
 
-		gpu_mem: memory@8c415000 {
-			reg = <0 0x8c415000 0 0x2000>;
+		ipa_fw_mem: memory@8c517000 {
+			reg = <0 0x8c517000 0 0x5a000>;
 			no-map;
 		};
 
-		adsp_mem: memory@8c500000 {
-			reg = <0 0x8c500000 0 0x1a00000>;
-			no-map;
-		};
-
-		wlan_msa_mem: memory@8df00000 {
-			reg = <0 0x8df00000 0 0x100000>;
+		adsp_mem: memory@8c600000 {
+			reg = <0 0x8c600000 0 0x1a00000>;
 			no-map;
 		};
 
@@ -486,6 +481,11 @@ ecsh: hid@5c {
 	};
 };
 
+&ipa {
+	status = "okay";
+	memory-region = <&ipa_fw_mem>;
+};
+
 &mdss {
 	status = "okay";
 };
-- 
2.29.2

