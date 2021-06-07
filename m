Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B5739D6EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFGIT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFGIT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:19:26 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07567C061766;
        Mon,  7 Jun 2021 01:17:36 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p66so15544494iod.8;
        Mon, 07 Jun 2021 01:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czqKwG1LbZCbqfUJ6Cb3XGLmd8Y0lJGxTGZrfP4Cg5s=;
        b=N3stUPjGoubypJQgu04Oyf22jW/skTo5MTOFz6+4r5D8ssVlhgcy5hYj0Az3VXwL4T
         A+m36C1QCoQljTAHR+MRofkPqkBbYfvo3grr8CNdI3EoU28Whg3prHYYVnlC+/ewOJz2
         MXqTuE5xqN5KEAsaEgIbCFVLH7tiIqhyFFinwzfUkHgmXmY3I1VuO5GhNxIt92lVB9E0
         acS1QIlCQzuQh1aORBMmbN5IiZwhSLKmaH8skDcy+9lV4YvFgwp4qIMleD5D1rx03ENf
         kSsroitGGXS5KEHs5NUBfwQVww4+QMBzmvxb0wUDih0vB9ABvty8FpYxahKB6QVaNtzr
         nT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czqKwG1LbZCbqfUJ6Cb3XGLmd8Y0lJGxTGZrfP4Cg5s=;
        b=rpU971s172CaJgtptZ7qC5xB0NDHpY2MKTJ+AeOSgBms26K8UcS2/Ach22UanTtlm+
         yz4X6CLCSm0z+n3o/ORpslRipYuVFBp12NVryVFLhp3KvgSPkF7aKROO1/U3/l7qXw3n
         clr9G/f/zzDEuZINS6xWUdIFMrY3izNl7rBQs83a25HDtHxdFNiqRarJeMap3wixsFAX
         uyAz6v9xPPnbfeidMI6oCO87eAyNfwfQq0yCCd/n3gR0cE94mnQ/rHBBxCCk1abfjt79
         MpICIvB2FJeOt7GqdQ+o+3W1+nliTTP8YyWn7Euvw4ap6Vk+WxqKCo6HF9qCJO3ItHot
         ykBQ==
X-Gm-Message-State: AOAM532QcZ19+oB2uTYbu3oJTUJrxLFxiFw6nGWpGMBQ33+ptXUZ0wfz
        PrhVRWveFpodmQFaP9FrMUY=
X-Google-Smtp-Source: ABdhPJz/1MBOkzpS7y6WmKk0MVpl+kk6nIuutlGTZhOsXT0acxa5zyI/XQl59SaKwe79Qw7azZ26kg==
X-Received: by 2002:a02:9109:: with SMTP id a9mr15389804jag.93.1623053854155;
        Mon, 07 Jun 2021 01:17:34 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id k9sm8416936ioa.13.2021.06.07.01.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 01:17:33 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Tianling Shen <cnsztl@gmail.com>,
        Marty Jones <mj8263788@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
Date:   Mon,  7 Jun 2021 16:17:27 +0800
Message-Id: <20210607081727.4723-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
stores the MAC address.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index cef4d18b599d..4a82f50a07c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -68,6 +68,15 @@
 	status = "disabled";
 };
 
+&i2c2 {
+	eeprom@51 {
+		compatible = "microchip,24c02", "atmel,24c02";
+		reg = <0x51>;
+		pagesize = <16>;
+		read-only; /* This holds our MAC */
+	};
+};
+
 &i2c4 {
 	status = "disabled";
 };
-- 
2.17.1

