Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE9F3FA56D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhH1L2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhH1L23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:28:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDCFC061756;
        Sat, 28 Aug 2021 04:27:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z4so14527673wrr.6;
        Sat, 28 Aug 2021 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IhBJd4EZ+wP+RveI9xXJL+AfUJG+bXvlwD9Cl5uDPLQ=;
        b=kQkdpSB7jvDnqvT8hPAd5EZLmobA79UzKk852cLXtipmsoV//WJ+zNK3zmYprYpbvz
         7vwhDyQQsEznrFYj+akPWo4hTglv9HyQ9RZYWYGJmu2mLDVF+TXUdnxhYSY6aDiaoc6i
         dIvl5Xc3PNr/q0ShX5Q296UR9rwC7AjuYA2FX1v0+Jud8T4jfj4BhFfzP+xF9x1zaIm7
         9OFh0m7ztxCHLM1RlXCKEiz6WnLREC3qltDH5pi/I1npiOQqMtYy6k5X9BsPxky7H9es
         fknZZcrwroCJYjWwxJiDRkMjV2sJU8F/5G7Psjur5C/4rQR2MwHfPsNxx0eTpaJBQdsA
         cZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IhBJd4EZ+wP+RveI9xXJL+AfUJG+bXvlwD9Cl5uDPLQ=;
        b=WyK/W4IbZqfGWDKnwSoSSUFD2jzwjz+EDyDgOsCsUENMJmdfoF32NRiY7M7L6NbMrl
         jUZkfsEILenEhMquJHIKBToylnEMIxRtjC/HCpXtPWupCPUOYB58KcCHMX0cprWJ1fPQ
         6G6gfvclLnFH23YkDSwCpfDctH6P/m/MthZK/lyM7bE3MfWoFnwVhiZyPsDThvBmAYRX
         /lz6rGTYV99ePskze1Fg8Ouyq0n3f31fLXuTT/w+CsqMJfk4CaTk6wvD4KePSCnRPfBZ
         v9JTkQqAf6obnuR8aEpV6PotHdBt6JvSeOH/EN2Zb/Kwir6aPlQhrSMlWCsafSyHEVvk
         HL4g==
X-Gm-Message-State: AOAM532H5nUEgMJ/BE/5K2kyJn/J3x+beR4M8I6/WvRRVRRyUoOwmx7v
        9TxPm9E7zGqoUiy8naqCkHEss298/Rz/bAnN
X-Google-Smtp-Source: ABdhPJxMEPePqg8at+PLu4/unpZILEzO87Q0sYZVwhOoEnf3oi4TBtYziQoFQRqPA0hshVvRZ6RDPA==
X-Received: by 2002:adf:804a:: with SMTP id 68mr15743552wrk.236.1630150058129;
        Sat, 28 Aug 2021 04:27:38 -0700 (PDT)
Received: from oci-gb-a1.vcn08061408.oraclevcn.com ([2603:c020:c001:7eff:7c7:9b76:193f:d476])
        by smtp.googlemail.com with ESMTPSA id d145sm13571021wmd.3.2021.08.28.04.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:27:37 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ARM: dts: NSP: Add bcm958623hr board name to dts
Date:   Sat, 28 Aug 2021 11:26:59 +0000
Message-Id: <20210828112704.2283805-1-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board was added to
Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml. This patch
corrects bcm958623hr.dts by adding the board name to the compatible.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm958623hr.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index 80556882951f..c06871915a1c 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -37,7 +37,7 @@
 
 / {
 	model = "NorthStar Plus SVK (BCM958623HR)";
-	compatible = "brcm,bcm58623", "brcm,nsp";
+	compatible = "brcm,bcm958623hr", "brcm,bcm58623", "brcm,nsp";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
-- 
2.27.0

