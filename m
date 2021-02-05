Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3A310D6A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 16:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhBEOMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:12:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:59200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhBEN4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:56:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0879AF13;
        Fri,  5 Feb 2021 13:53:05 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     phil@raspberrypi.com, wahrenst@gmx.net,
        Russell King <linux@armlinux.org.uk>
Subject: [RFC/PATCH 10/11] ARM: configs: Enable DRM_V3D
Date:   Fri,  5 Feb 2021 14:52:46 +0100
Message-Id: <20210205135249.2924-11-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205135249.2924-1-nsaenzjulienne@suse.de>
References: <20210205135249.2924-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM2711, the SoC used on the Raspberry Pi 4 has a different GPU than its
predecessors. Enable it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3823da605430..0ad4ffe4e6f6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -713,6 +713,7 @@ CONFIG_DRM_TOSHIBA_TC358764=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_DRM_STI=m
+CONFIG_DRM_V3D=m
 CONFIG_DRM_VC4=m
 CONFIG_DRM_ETNAVIV=m
 CONFIG_DRM_MXSFB=m
-- 
2.30.0

