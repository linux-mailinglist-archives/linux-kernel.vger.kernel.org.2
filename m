Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1C231F2FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhBRXXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:23:32 -0500
Received: from mout01.posteo.de ([185.67.36.65]:50079 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBRXXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:23:30 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 6D3ED16005F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 00:22:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1613690553; bh=yEXRlc/sSYKM3VIaDtPwOZa/sbjN+qoXAvWzOZjB3BU=;
        h=From:To:Cc:Subject:Date:From;
        b=TiJxdOXdaAEHQ5TQX/VJevysFpmWwOdZR2DJYfhq2igdClm1TtBRY3UTysruv2wRl
         apFZcDB5FsZy4MuBoQnz3na2A3fpzH2ZPq/t3NzMQk7WZun1h6DIb6MmBTBei+t/jM
         iPqMhrKt4KSyzsD8XyBhomhQI407Bcqt4tN8KQwAkVmJM/lMjEyxX6aiTGpS31miSc
         kIPlvIcSHyiunT/9qKwzlBZY8o8MQ96OOPNVLoHpDkCIenEhbGvR9BpXShxWzygIng
         3l4xxajTLvlKlbhF8iIqaiUD8VuabQg2mpQ/nKk94ZRlx4vVQzC9stHwxSC6jf3FXK
         cK/zQoG4wo2DA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DhW2c072nz6tm9;
        Fri, 19 Feb 2021 00:22:31 +0100 (CET)
From:   Florian Ziegler <florian.ziegler@posteo.de>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     Florian Ziegler <florian.ziegler@posteo.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Fix alignment of function args
Date:   Fri, 19 Feb 2021 00:22:15 +0100
Message-Id: <20210218232215.17508-1-florian.ziegler@posteo.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align function arguments to fix checkpatch.pl CHECK message and rewrap
to match the file's style.

Signed-off-by: Florian Ziegler <florian.ziegler@posteo.de>
---
 drivers/staging/vt6656/card.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 10f3dfda83b5..396736eee690 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -375,7 +375,8 @@ int vnt_radio_power_off(struct vnt_private *priv)
 	case RF_VT3226D0:
 	case RF_VT3342A0:
 		ret = vnt_mac_reg_bits_off(priv, MAC_REG_SOFTPWRCTL,
-					(SOFTPWRCTL_SWPE2 | SOFTPWRCTL_SWPE3));
+					   (SOFTPWRCTL_SWPE2 |
+					    SOFTPWRCTL_SWPE3));
 		break;
 	}
 
-- 
2.30.1

