Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81443F88FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242673AbhHZNa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbhHZNav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:30:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9D7C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:30:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so6593800pjw.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGevsc/jyJ74lEaSwdV/APsb0ImTFRxwqrKLjXKSBgo=;
        b=NjZDFd/8qpUbZcpyiNwRynlrWO6fTiYgBnlL6tkSnbAgyBSDIOWnt+simjDktIg5ww
         P6i1lp+WlvbgStVLOJi/KotykOktwOZ1zV5wqcLtW/w1sXGv6dtSQ0qN9QV46AMyjXBR
         CCRb5pAF4Eg9gXo+dvyXpKPDVVW3IgBoHm8VKFeDPjA8Qo3WWu50Wj2Ce5pc47uLFcL8
         dNahGuQlfbnMKmjkGkcYAXkE8LdFeBGBTDIAbHJyIh7MpfIb/js2sRA5ahQVKyisx/FH
         hEWp36m1q8TZvNOdJbe/491rCfceHJWYRsU5RKT17D/RZOp0y+QTK4CVydPOgjCQ4oM5
         O/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EGevsc/jyJ74lEaSwdV/APsb0ImTFRxwqrKLjXKSBgo=;
        b=diuU83xxYfgKG8ymjxUFQyGrvUWWe/uEliJk0JUWbQysSDtkXY5EhjVmaNTSRMV2H1
         UbyzqLMrYWoyDh1lVKKqrlvgI50OrVMWH8gYGos7wmrD+VDJdOQngBoAKUMmlSzd6v3P
         TeY+Ea4e0uwpV6Boz2xhioP1V9tRqdUKtuW3TnjuqXXEA8mq22pAIzSur76i6Eyr/Vf1
         pTQfwVd4pFwjmsnxU+eyi3XVR7TEISSlKhj3sdMhd7c4N8CcmfJKJe+ioedB/4l7gQoD
         HtuhqaluRboFBqB/nKFuuGql7NnLpglz7YS3TLBXmd1+ywaTLMjLAy7U2O4/Co3qpTmS
         sMQA==
X-Gm-Message-State: AOAM530Lj8ZJy/BFKLosRZQVU7hzutUcuku8PwsUwZ7aqUkqdvqxuFhR
        MLcGQ4ZEf8aHiteWX/adIhbN7YjPOTM=
X-Google-Smtp-Source: ABdhPJxvQ7kbhcuLjB4I8EdREWj4nIdGC+r42Y/Ok4cfnkGHswNqhK2h+7sr42gEQSzroslfZSfP8g==
X-Received: by 2002:a17:903:32ce:b0:138:7c09:1178 with SMTP id i14-20020a17090332ce00b001387c091178mr3597011plr.60.1629984603296;
        Thu, 26 Aug 2021 06:30:03 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id w186sm3359693pfw.78.2021.08.26.06.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:30:02 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Stafford Horne <shorne@gmail.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] openrisc/litex: Update defconfig
Date:   Thu, 26 Aug 2021 22:59:46 +0930
Message-Id: <20210826132946.3324593-4-joel@jms.id.au>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826132946.3324593-1-joel@jms.id.au>
References: <20210826132946.3324593-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the liteeth network device and basic network options, and update the
options by doing a savedefconfig.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/openrisc/configs/or1klitex_defconfig | 26 ++++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
index 3c2c70d3d740..d695879a4d26 100644
--- a/arch/openrisc/configs/or1klitex_defconfig
+++ b/arch/openrisc/configs/or1klitex_defconfig
@@ -1,18 +1,24 @@
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
-CONFIG_BUG_ON_DATA_CORRUPTION=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_EMBEDDED=y
+CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
 CONFIG_HZ_100=y
-CONFIG_INITRAMFS_SOURCE="openrisc-rootfs.cpio.gz"
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_OF_OVERLAY=y
-CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
-CONFIG_PANIC_ON_OOPS=y
-CONFIG_PRINTK_TIME=y
-CONFIG_LITEX_SOC_CONTROLLER=y
+CONFIG_NETDEVICES=y
+CONFIG_LITEX_LITEETH=y
 CONFIG_SERIAL_LITEUART=y
 CONFIG_SERIAL_LITEUART_CONSOLE=y
-CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_TTY_PRINTK=y
+CONFIG_LITEX_SOC_CONTROLLER=y
+CONFIG_TMPFS=y
+CONFIG_PRINTK_TIME=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BUG_ON_DATA_CORRUPTION=y
-- 
2.33.0

