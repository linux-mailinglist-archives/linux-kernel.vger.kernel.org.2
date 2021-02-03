Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C346830E030
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhBCQyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhBCQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:53:28 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710ABC06178C;
        Wed,  3 Feb 2021 08:52:48 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r22so344010edo.11;
        Wed, 03 Feb 2021 08:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PMs0NDSuf1zcUrhFtkHc3rUKSCkURTHcknmuZn+qw+Y=;
        b=geo41BrGzKU4OH40sIUY27Y+Xsbx+6t3yM73U+tZTOLHdvnj8CwZgKZEGd6uOjnBse
         hAH4OGul+2rrYOhXI7AmBMtRN1Rb4pyDDa1Ej+orYWa2Q+5naJzTlevELZGzZzmhMbbo
         +XE3UbKggw6K4cOjTEItCBXiOi6z25mtJRPc4av12jDbsdPnA1E9f90y0XeB7A9a6EsC
         Cr/XYdGiXZhetMrmBAjgGTTdkMvTk37EHjmy8SYhh0pb394jXeMal5gbw83aIplVlu/E
         pPhnAUD3bQ3PHcLBKvq1wBLlxixLAK7c6s/3Cqk5Ns7o3nHGAIO68eli3q53cM41CD+i
         5yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PMs0NDSuf1zcUrhFtkHc3rUKSCkURTHcknmuZn+qw+Y=;
        b=j0bcvkpqVQEXYt0gpyg1C0i3nY0z5M/XcXTOLv8a71s7bCu+2CWOcfUsluV6jmOhfx
         iL5rt75aCG+/JgaAQ4CXmMRnmAWB4WwC3zSTVL7DWQOxFth+Qn8VWZRSjluZW3htvvDi
         R+J0ClcTXqAIj0DL3rLljgbetp+EwK15deIgStvMKy1CKp1Bg2sNa2L+i+I0nyxW7PGL
         kU2IURbISL86rlNzooyQKD8CbR+2RFBMvDUk3NauXeOsgeA2tT140ss6d75RPeYtPX7e
         h2VksRDG+GlyHXd+IEKKjvJxsRD7u9wx0j8KevLits6D5E9z/1JyA0IDoQQWrIXWaUBx
         otnQ==
X-Gm-Message-State: AOAM530a4LWqD44sN3Be62izsII8EnpPHQI8s/E3pv/SMmZHTkSaX/Ba
        osNo3M01t/qLtQO0X0HD07U=
X-Google-Smtp-Source: ABdhPJwSKL2/RABPjQr6OIwdlGCvg4cQWkDOExMBDUqjjU3Sl65Zz7+TwMx1lj3vzItxNZDBk8F3Sw==
X-Received: by 2002:a50:acc1:: with SMTP id x59mr3898959edc.43.1612371167242;
        Wed, 03 Feb 2021 08:52:47 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a25sm1135471eds.48.2021.02.03.08.52.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 08:52:46 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] dts64: rockchip: enable dwc3 usb for A95X Z2
Date:   Wed,  3 Feb 2021 17:52:33 +0100
Message-Id: <20210203165233.22177-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210203165233.22177-1-jbx6244@gmail.com>
References: <20210203165233.22177-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable dwc3 usb for A95X Z2.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
index 30c73ef25..e71870768 100644
--- a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -357,6 +357,11 @@
 	status = "okay";
 };
 
+&usbdrd3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.11.0

