Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A836BE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 06:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhD0EnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 00:43:16 -0400
Received: from mail-m121145.qiye.163.com ([115.236.121.145]:11316 "EHLO
        mail-m121145.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhD0EnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:43:16 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 99AA58001ED;
        Tue, 27 Apr 2021 12:42:31 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] hwmon: Remove unneeded semicolons
Date:   Tue, 27 Apr 2021 12:42:19 +0800
Message-Id: <20210427044219.7799-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQxhMSlZCHh4YQx0dGEkdTElVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQg6URw4KT8XKFZDDD8LKj0e
        OhdPCU9VSlVKTUpCT0JDTk5JSk5CVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQ0lINwY+
X-HM-Tid: 0a7911a2c9e1b03akuuu99aa58001ed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/hwmon/corsair-psu.c:379:2-3: Unneeded semicolon

Remove unneeded semicolons.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/hwmon/corsair-psu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 3a5807e4a2ef..02298b86b57b 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -355,7 +355,7 @@ static umode_t corsairpsu_hwmon_power_is_visible(const struct corsairpsu_data *p
 		return 0444;
 	default:
 		return 0;
-	};
+	}
 }
 
 static umode_t corsairpsu_hwmon_in_is_visible(const struct corsairpsu_data *priv, u32 attr,
@@ -376,7 +376,7 @@ static umode_t corsairpsu_hwmon_in_is_visible(const struct corsairpsu_data *priv
 		break;
 	default:
 		break;
-	};
+	}
 
 	return res;
 }
-- 
2.25.1

