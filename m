Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15F3A131B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbhFILrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFILrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:47:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8FBC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:45:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d184so3850822wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEDmcXw1Vb0a19AjvwRij7MjXqXCoObE8zeLieziyHk=;
        b=kKGqttYupE3iAnWWcj2Z/5S/M9a++Vowp7tLhYCysZ5ycoUMSJhJ5pj5brD1sUEmyi
         Ozr4OFfsbSV8EqJz/U/YRe5NVT/WvePyC4/4vVIdtjh0O0XhRi6Ny3gvWNsKCmGrkd5Q
         kMIlbz3cPWF6QcpHq5Rj1Q+azERtcIi9E0hzTxD4vavVlgjj2M9vxQ8dCcuNJR0ZBu4s
         JbvNh8qyZVq5M6VknyuYHsUwuRH4ep2ylfheCD1On3cHp6hJ7enWSYLbneWMYvIXYVYv
         aGZv64qRAhI2oavIwckktxBwo/ZW4ruXDHpHlEKx8gKLRTf38fMGy0MU5S67+I+Uy40G
         K/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kEDmcXw1Vb0a19AjvwRij7MjXqXCoObE8zeLieziyHk=;
        b=lHZEuN7F9VanbIRudzVKIAhlVAj9yEiRF6dKuzRsQ47xQ+fNn9qNezhCLv7PcxenDv
         U4gAbsp4CdniNz6Gx5c7AwM5dHIZZnrW7JwCp9OXrqIu+wz4iY+RHfXocdgztpFgoW0o
         2XIxW7g07r8Tl+2DNtT0uCC4Y7gefNLcZqzJX4Vk0ZaMbp8kenvEZAHHiF6U+ojuf6ui
         Pvtc+zp6JWFyYAiqxeBxRZqbeyOqU2p3iBL0daqnHB12U+TxONsxjRMJgF+0WooTgPlq
         4jopSO0LojRmAeJ0nDd4dRO2Cbxd9E8IBWeUVOYRVfwXgEAmxuR7Jh94ep4HRJ2WW9B/
         GUjQ==
X-Gm-Message-State: AOAM5317HF5Tljaf4lPbhncr0dy+cpb0nkLT4dJR9RdcAtPy8uk+TXZG
        Fw0edlo/bStlDNa9js7rIQtCnUX0cab0ITWa
X-Google-Smtp-Source: ABdhPJx/gF/i/+f3rHQ5uRMfSpqn975b21+2ucb/F8nsogWOh6nBJ3ghohhqCBek0mAcbMtAQQqwrg==
X-Received: by 2002:a1c:2015:: with SMTP id g21mr9400708wmg.87.1623239124315;
        Wed, 09 Jun 2021 04:45:24 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id o18sm13601475wrx.59.2021.06.09.04.45.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:24 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/31] arm64: zynqmp: Do not duplicate flash partition label property
Date:   Wed,  9 Jun 2021 13:44:38 +0200
Message-Id: <6c4b9b9232b93d9e316a63c086540fd5bf6b8687.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>

In kernel 5.4, support has been added for reading MTD devices via the nvmem
API.
For this the mtd devices are registered as read-only NVMEM providers under
sysfs with the same name as the flash partition label property.

So if flash partition label property of multiple flash devices are
identical then the second mtd device fails to get registered as a NVMEM
provider.

This patch fixes the issue by having different label property for different
flashes.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index 4a86efa32d68..f7124e15f0ff 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -131,7 +131,7 @@ spi0_flash0: flash@0 {
 		reg = <0>;
 
 		partition@0 {
-			label = "data";
+			label = "spi0-data";
 			reg = <0x0 0x100000>;
 		};
 	};
@@ -149,7 +149,7 @@ spi1_flash0: flash@0 {
 		reg = <0>;
 
 		partition@0 {
-			label = "data";
+			label = "spi1-data";
 			reg = <0x0 0x84000>;
 		};
 	};
-- 
2.31.1

