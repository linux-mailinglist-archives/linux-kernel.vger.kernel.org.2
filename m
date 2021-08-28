Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C313FA574
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhH1L2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbhH1L2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:28:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E253C061756;
        Sat, 28 Aug 2021 04:27:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e26so86709wmk.2;
        Sat, 28 Aug 2021 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XbxYRCxGlOAahUO0II9Gv1UWU1girKn2umf4+x6scis=;
        b=OijA5ObtzElwb+QGxO2B/m0jf8s0y1hOubR7IKZvTdl6nmVvPh5+D/9RGN4qyMO5fw
         d6cUcGgteOQ3/ev+MxE3S7Ay0bBJUIYHV910eGB4T+1ce73oHA1nXs9jF4cRvlGy+Wkb
         nZ6WGBcaYecRzs7av1Va40X9dSVVIpQzBGUyOVm+jUe9PYGqdK5RgtJamsPJdRR98gth
         KhwpQ4f/HrNBYGbPGtKRYhQ6/x5tV2FeP+/LREMT+T7QLz5SteZWDl0DQIyQknVEZTVG
         XqK37+0s1ZiBVVNKSCTfgHqsIn2mknFh3B/0tsgBv0jyqXj/Vyo/96NNuhJydC8MRJ1x
         S1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbxYRCxGlOAahUO0II9Gv1UWU1girKn2umf4+x6scis=;
        b=lxmoCvMVOSUfISzrIhmwJiXTfgkIcHwIrmu+2ybtMR5dvFVLpQrqdMBMjIW8kCQ7yY
         ocmAXWNkB6y7V3q8nrRmxcbNyH3JI6hkfJ9XCYGcOPclehm013MImpruBjJuZumX2aJk
         oJN+GJNaXX1uHluc0K+GE74rO0SuGd6+XJsGhCO8r+doKoQVQwaYhyStDHQre7e1VfyI
         0pJLs8M9D/EKi9sNsgCvtIqmLFz2hzeRQA8ngxgeYSabzEsnE/FZogCy32dOzqsxkWog
         tHckv7wr04iXzGMcmjnseCNkWWsDCpC4X/yrqy+2QLYKzfs5GyQ8nWJ4wimGXoxcr3t1
         vmiQ==
X-Gm-Message-State: AOAM533rGzx6tBIU8m4lWoibaXw+DoXgmWLxkZyTkgzJnngT1j4imwIr
        0xoN0usrBDR1DDFyf13kdARaLKu2M86YS65l
X-Google-Smtp-Source: ABdhPJzyHHEo6AOZYBC/doQNYUsYXveNi6yE2xTyAZ6B0f0DQJkv5roI0gsCZ3INHWdUB7XvBNy/KQ==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr13108733wma.117.1630150060944;
        Sat, 28 Aug 2021 04:27:40 -0700 (PDT)
Received: from oci-gb-a1.vcn08061408.oraclevcn.com ([2603:c020:c001:7eff:7c7:9b76:193f:d476])
        by smtp.googlemail.com with ESMTPSA id d145sm13571021wmd.3.2021.08.28.04.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:27:40 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: NSP: Fix MX64/MX65 eeprom node name
Date:   Sat, 28 Aug 2021 11:27:02 +0000
Message-Id: <20210828112704.2283805-4-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210828112704.2283805-1-mnhagan88@gmail.com>
References: <20210828112704.2283805-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following issue by renaming the node appropriately:
at24@50: $nodename:0: 'at24@50' does not match '^eeprom@[0-9a-f]{1,2}$'

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
index bcdd38954f1d..6519b7c61af1 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
@@ -48,7 +48,7 @@ &ehci0 {
 &i2c0 {
 	status = "okay";
 
-	at24@50 {
+	eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 		pagesize = <32>;
-- 
2.27.0

