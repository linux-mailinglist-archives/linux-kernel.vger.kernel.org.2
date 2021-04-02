Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4144035267C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 08:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhDBGNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 02:13:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15466 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhDBGNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 02:13:47 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FBV7G1w5QzwRJn;
        Fri,  2 Apr 2021 14:11:38 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 14:13:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <vaibhavgupta40@gmail.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ide: Remove unused inline function ide_dma_verbose()
Date:   Fri, 2 Apr 2021 14:13:35 +0800
Message-ID: <20210402061335.19512-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 3ab7efe8e2cb ("ide: DMA reporting and validity checking fixes (take 3)")
left behind this, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/ide.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index 6bc6ba57b505..0242a66158fb 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1455,7 +1455,6 @@ static inline u8 ide_max_dma_mode(ide_drive_t *drive) { return 0; }
 static inline void ide_dma_off_quietly(ide_drive_t *drive) { ; }
 static inline void ide_dma_off(ide_drive_t *drive) { ; }
 static inline void ide_dma_on(ide_drive_t *drive) { ; }
-static inline void ide_dma_verbose(ide_drive_t *drive) { ; }
 static inline int ide_set_dma(ide_drive_t *drive) { return 1; }
 static inline void ide_check_dma_crc(ide_drive_t *drive) { ; }
 static inline ide_startstop_t ide_dma_intr(ide_drive_t *drive) { return ide_stopped; }
-- 
2.17.1

