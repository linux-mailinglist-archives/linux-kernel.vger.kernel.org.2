Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC0346E74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhCXBEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbhCXBEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:04:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8924C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:04:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q11so7042710pld.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOFzQ2jCakOgU1pwAYyIIEpEFP9m6Nt53S4tZwFxe7s=;
        b=egZM3rXGWFC4HFLhXb5KdcFzUaaq1rUskREM9ziQJuX5c26cL3x8aLBtbVIm3Suc/H
         AsSKzUkFDLvvC+ScPNldH+lf8i551ZLIeomM4SAw5GZNewzJM76I2VJeLvWhl+2K4tzt
         wmzQwRL/RvyAn22ULNdiP8X0wCdh4OG+Q5fug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOFzQ2jCakOgU1pwAYyIIEpEFP9m6Nt53S4tZwFxe7s=;
        b=YHFi9JCVCxibwcT/jSIXtBMSlBiNdgBYZDiqI92ThhhVM5IcEjOQUbLkIlVl4Aj5qt
         hb1vlyTEuwx7j7H+XhcRqaPFzZ3TEDDbqqLxHDY9LmBLxJozQSZACKcEB5K0MdEMOFmZ
         +xsq+oZGjPtaWdhv/hs8Vh8liO2JrXBXfxPXGMlu8Df2KA0WCQ447XpntScSMYXtHxTE
         HLrWJag4QoNQUia98qjVVC8XK4zNOS+A+qv9Q5UdrUlxsii/YI3BiXYOzGpLVkAcVb5H
         3R7avhzIRU3IonMu0JXXwYiKZhszToMG0n6TJqlpK8oZfhOOuf0WMJyTSYXZ5pWQD1ir
         dLOg==
X-Gm-Message-State: AOAM530i3pgv3+5gGZQSogtiOsge3nd0IVxfIX5spJjRH3QD1V7FITdD
        gFoBSjq7PqqCQpGKMrEDqYYpHg==
X-Google-Smtp-Source: ABdhPJwKSSYOOg2WMJ9Ov+4FIPkCVtwmcB3n1NL0u8y7XvB6KA4b/ELp3Mww4J+tZXeSPtYY0sj5Tg==
X-Received: by 2002:a17:90a:987:: with SMTP id 7mr751037pjo.61.1616547864216;
        Tue, 23 Mar 2021 18:04:24 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:cc81:ff03:bd16:9643])
        by smtp.gmail.com with ESMTPSA id j20sm4167217pji.3.2021.03.23.18.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:04:23 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: [PATCH] dt-bindings: ddr: Add optional manufacturer and revision ID to LPDDR3
Date:   Tue, 23 Mar 2021 18:04:05 -0700
Message-Id: <20210324010405.1917577-1-jwerner@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, DDR parts are multi-sourced and the exact part number
used is not know to either kernel or firmware at build time. Firmware
can read identifying information from DDR mode registers at boot time
but needs a way to communicate this information to kernel and/or
userspace. This patch adds optional properties for this information to
the existing "jedec,lpddr3" device tree binding to be used for that
purpose.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 Documentation/devicetree/bindings/ddr/lpddr3.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/ddr/lpddr3.txt b/Documentation/devicetree/bindings/ddr/lpddr3.txt
index a0eda35a86eef9..b221e653d3845e 100644
--- a/Documentation/devicetree/bindings/ddr/lpddr3.txt
+++ b/Documentation/devicetree/bindings/ddr/lpddr3.txt
@@ -12,6 +12,9 @@ Required properties:
 
 Optional properties:
 
+- manufacturer-id : <u32>     Manufacturer ID value read from Mode Register 5
+- revision-id     : <u32 u32> Revision IDs read from Mode Registers 6 and 7
+
 The following optional properties represent the minimum value of some AC
 timing parameters of the DDR device in terms of number of clock cycles.
 These values shall be obtained from the device data-sheet.
@@ -49,6 +52,8 @@ samsung_K3QF2F20DB: lpddr3 {
 	compatible	= "samsung,K3QF2F20DB", "jedec,lpddr3";
 	density		= <16384>;
 	io-width	= <32>;
+	manufacturer-id = <1>;
+	revision-id     = <123 234>;
 	#address-cells	= <1>;
 	#size-cells	= <0>;
 
-- 
2.29.2

