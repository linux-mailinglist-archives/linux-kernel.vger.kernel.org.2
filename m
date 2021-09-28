Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9053341B4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbhI1RLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 13:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241958AbhI1RLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:11:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46891C061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:09:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dn26so8971694edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MOkJiFFV+D+y/7iBdkppsbCFqP93nQiAS8IIYiy8lX0=;
        b=ysvN9ddniGUrClxsHS1LmwTVKXK56UiClKP4e5jte2z5dCv8tP/UkjV/c5OKQ1MauZ
         pPHhaIy8s2Ibs48CgwbBd6rZ547y3UdXlN3nM4+NMJoV6x+RCL7idHdno0ZmJBEvRveV
         nX43+4/VG0ryjwCxCIAolz1nTByixXYUcyleuu+2+PLZ1Ac9f16c3bAVGrsRqpr2NVoB
         c+QluS9RmGAhORtml9T+tiZgmTbQ9en4me1UHsQvEUwuwhK51yM28LM9pT0zF5aSXf60
         KKRDljNVePGmWvfDDzC4BJlK/1LszqLQsLIcOex+i9UqM/p+4g80u/mas6C5S+G6D6Qo
         yDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MOkJiFFV+D+y/7iBdkppsbCFqP93nQiAS8IIYiy8lX0=;
        b=OMM49LdPdNs8EZzhylaO6X7jLtOht2+4GXwFfr4ewHJhY/sTU59IGS45gFMRQBLbrN
         p7Mjd4RrbzslJPIuRFzMmS9+IfBlceZVA37ykmZ3wJRcBtxmLH+BWbWHuWgyNR8mPGkU
         2eoh3DAgEqkOj7WHCQ4CzBTBlMWfuFTImkKuBI58RPXUcLERsE6Cnp78+3TOzuJyOLec
         g23UaRBajFatgRJrb3PVfBS3JEeJJeiOMAYY6BsbScC+sNsVrbQ64J3mBkHDq6zJ4SmH
         mvo4HihI35E7nhrcJPL7bPstCYbbvShocwDWa9prbrRsoW6NPv5d9osp8ScnFb0RFeH/
         wgzg==
X-Gm-Message-State: AOAM531S1/bz/RycIgpSXLlXgS0O3CfbcTjH8xqbIwjFKKisA02KYpQP
        7W9UDzfpdB8vdsKZKVQzdXUfiIOvqVFhWQ==
X-Google-Smtp-Source: ABdhPJz4Y72BDlbKQ4LAeyOESF53Jg+2BscvxE5OZUe993IRCBuexeXHB/U7OXkgMxMULZYLv6F8qg==
X-Received: by 2002:a17:906:c7d0:: with SMTP id dc16mr8158507ejb.555.1632848965759;
        Tue, 28 Sep 2021 10:09:25 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-144-231-cbl.xnet.hr. [94.253.144.231])
        by smtp.googlemail.com with ESMTPSA id bj21sm10806129ejb.42.2021.09.28.10.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 10:09:25 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pali@kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 2/3] arm64: dts: marvell: espressobin-ultra: add PHY and switch reset pins
Date:   Tue, 28 Sep 2021 19:09:18 +0200
Message-Id: <20210928170919.691845-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928170919.691845-1-robert.marko@sartura.hr>
References: <20210928170919.691845-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the Topaz switch and 88E1512 PHY have their reset and interrupts
connected to the SoC.

So, define the Topaz and 88E1512 reset pins in the DTS.

Defining the interrupt pins wont work as both the 88E1512 and the
Topaz switch uses active LOW IRQ signals but the A37xx GPIO controller
only supports edge triggers.
88E1512 would require special setup anyway as its INT pin is shared with
the LED2 and you first need to configure it as INT.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index 610ff6f385c7..7c786d218f1b 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -114,12 +114,16 @@ &usb3 {
 &mdio {
 	extphy: ethernet-phy@1 {
 		reg = <1>;
+
+		reset-gpios = <&gpionb 2 GPIO_ACTIVE_LOW>;
 	};
 };
 
 &switch0 {
 	reg = <3>;
 
+	reset-gpios = <&gpiosb 23 GPIO_ACTIVE_LOW>;
+
 	ports {
 		switch0port1: port@1 {
 			reg = <1>;
-- 
2.31.1

