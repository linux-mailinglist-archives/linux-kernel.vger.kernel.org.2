Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAB3314FC7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhBING4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:06:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:48564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhBINC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:02:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C13F6B11A;
        Tue,  9 Feb 2021 13:00:52 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        wahrenst@gmx.net, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        eric@anholt.net, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Russell King <linux@armlinux.org.uk>
Subject: [RFC/PATCH v2 15/16] ARM: configs: Enable DRM_V3D
Date:   Tue,  9 Feb 2021 13:59:11 +0100
Message-Id: <20210209125912.3398-16-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209125912.3398-1-nsaenzjulienne@suse.de>
References: <20210209125912.3398-1-nsaenzjulienne@suse.de>
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

