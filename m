Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D531D8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhBQLxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:53:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:33982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232288AbhBQLtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:49:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF112B80B;
        Wed, 17 Feb 2021 11:48:29 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        wahrenst@gmx.net, mripard@kernel.org, eric@anholt.net,
        robh@kernel.org
Subject: [PATCH v3 09/15] soc: bcm: bcm2835-power: Bypass power_on/off() calls
Date:   Wed, 17 Feb 2021 12:48:04 +0100
Message-Id: <20210217114811.22069-10-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217114811.22069-1-nsaenzjulienne@suse.de>
References: <20210217114811.22069-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bypass power_on/power_off() when running on BCM2711 as they are not
needed.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v2:
 - Correct names

 drivers/soc/bcm/bcm2835-power.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index eea31f75dc64..b65a39cc2788 100644
--- a/drivers/soc/bcm/bcm2835-power.c
+++ b/drivers/soc/bcm/bcm2835-power.c
@@ -197,6 +197,10 @@ static int bcm2835_power_power_off(struct bcm2835_power_domain *pd, u32 pm_reg)
 {
 	struct bcm2835_power *power = pd->power;
 
+	/* We don't run this on BCM2711 */
+	if (power->rpivid_asb)
+		return 0;
+
 	/* Enable functional isolation */
 	PM_WRITE(pm_reg, PM_READ(pm_reg) & ~PM_ISFUNC);
 
@@ -218,6 +222,10 @@ static int bcm2835_power_power_on(struct bcm2835_power_domain *pd, u32 pm_reg)
 	int inrush;
 	bool powok;
 
+	/* We don't run this on BCM2711 */
+	if (power->rpivid_asb)
+		return 0;
+
 	/* If it was already powered on by the fw, leave it that way. */
 	if (PM_READ(pm_reg) & PM_POWUP)
 		return 0;
-- 
2.30.0

