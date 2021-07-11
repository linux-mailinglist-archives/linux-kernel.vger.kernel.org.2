Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCB53C3C99
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhGKM5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 08:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhGKM5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 08:57:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F106A611AB;
        Sun, 11 Jul 2021 12:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626008064;
        bh=k4M8jfK77HXMpD76NZTrVYmlTw8At2S9fpKWVBhTWLU=;
        h=From:To:Cc:Subject:Date:From;
        b=ublGg91S86MGmshBCqWx3QBrt92uO//M7MQrKnvBBtULHZG6AKYAvoUsoM4Gzgsjw
         FUXsG6t1aR9p/AkhbTTqgGFeMnlP//M/LOmt0oYMXPk7g/hYFx/5Nd2PNJOpPl9x7e
         x0bGta0l35s1UIiD7Hux0dJ/drC3IEPC14eHPzeWGEN+1begzOG2Is66asI+qi0H4I
         74eOwF1rHHCPYcIWvD8y3Ogr7+9fQQOL715Y1FUCH61+SOuAYQKs7lJwtEKA/CNtfe
         RTMBE/zzetqU/cfsF53xW6xnzPRCeVc0lhHmlz46ItvflIwhPaKFv4YmEmpiu91V6o
         ZCcLd2FTg/zyg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/7] habanalabs: missing mutex_unlock in process kill procedure
Date:   Sun, 11 Jul 2021 15:54:12 +0300
Message-Id: <20210711125418.17533-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

missing mutex unlock once driver is giving up killing user processes.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 86426052a191..28fe15a28361 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -822,6 +822,7 @@ static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
 		} else {
 			dev_warn(hdev->dev,
 				"Can't get task struct for PID so giving up on killing process\n");
+			mutex_unlock(&hdev->fpriv_list_lock);
 			return -ETIME;
 		}
 	}
-- 
2.25.1

