Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1829130B08E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhBATm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhBATmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:42:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E8AC0613ED;
        Mon,  1 Feb 2021 11:41:21 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s3so6564397edi.7;
        Mon, 01 Feb 2021 11:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mllDDoFqrKsaQ7KlxScyjYXTToCMmRRcsUF13aNpIwo=;
        b=lOq2v9Lwl5m1ENUAEOwokF4SpIw39mkXEtSS3xvZQt9PTK8ta89rTe4PBQbsZ+1K2d
         DA7GGQISOUJMllrvPP5H5VbogNvgccK2OMJsUzr4NCgoNg3pNM8k0SGe+HRI8ttTVNRH
         LZlK6nRYuj/Bk8mvyaqPEduEYzgv9Vdfy8Seta5HjZXOydQEStn68fVG/QVtRhjVRmL0
         sqN8AB4o0ndeL5qczfEq5827rQTijdZmfblpnV3iCm+pJg+dHMNx2ML7unBR7fHa4Ebb
         YpCoO5mtYRvneAXajWTTNuBt3UETAsXfqkWKszKElZKvLbSSrFmixl3+izQzyswgNXn+
         xbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mllDDoFqrKsaQ7KlxScyjYXTToCMmRRcsUF13aNpIwo=;
        b=kxPI93HECn4z7X5dDF1B5YhE4hFSgTYoJ3DJY4D/hREtljYiZIpSZjExC9sMjclefn
         sR9gFM7WbDj0W7BR8xUX+7NKLHcw4Gjc7z4SqaHfTOZG9KUPA1ULtjr33OoiJuYunuBP
         aWnRG8WcZG57d0lx9nNnywXJ7hrBmS9rJYcZQNdwwCLXKNN3infyKVDqohF9Db7vbJHR
         G659cFFrsbfmaHP4uLx4ATE5xv1P9XvRM0uYn0Ci2pUBlyUcyBGBYnqR8I2ugin3/dO3
         RNabyZOt6EI4VglKEHHOoCIiDAbEL77GTYZBtSt7QR+CCeChzhXaJ30tMgpt0oe//WLT
         a8Cw==
X-Gm-Message-State: AOAM5329kXgKEpw5IH6trMBYlH4RYDyocOycxhbJwv4QiJ4ZX/qge+Ec
        HGpc/99nGjcPY9s7NmFchMY=
X-Google-Smtp-Source: ABdhPJzflGvb9KJYZGMytp1I8l3QpW1wrHny5906kgyPSsIc4FpU96o1x39WcYNA3eK15Jfh5c97ZQ==
X-Received: by 2002:a05:6402:11d3:: with SMTP id j19mr20525720edw.314.1612208480752;
        Mon, 01 Feb 2021 11:41:20 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id du6sm6702799ejc.78.2021.02.01.11.41.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:41:20 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] dts64: rockchip: enable dwc3 usb for A95X Z2
Date:   Mon,  1 Feb 2021 20:41:05 +0100
Message-Id: <20210201194105.32673-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210201194105.32673-1-jbx6244@gmail.com>
References: <20210201194105.32673-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable dwc3 usb for A95X Z2.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
index 30c73ef25..b26c653c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -357,6 +357,15 @@
 	status = "okay";
 };
 
+&usbdrd3 {
+	status = "okay";
+};
+
+&usbdrd_dwc3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.11.0

