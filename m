Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22853D2298
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 13:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhGVKgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 06:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhGVKgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:36:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5781361289;
        Thu, 22 Jul 2021 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626952611;
        bh=ReoyftaE1SLyCrY4bYkuCvD9C5ca+EWArmNR4HbuuMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4tylMaQOFxnDvzqjt9oNlKoTyGsr8xqvTSb5+r0E+TpXQm1hezRghtrKKkLg+4D7
         b+5OSWWwaJV/yJJC3WK7neB2SKC7lXYeiewb9dHPWY2SvCarN4MBzihfO2geILJ3UY
         l2bPQUmBpJjGbDZwPKJ23eiqBdVHPAN3/03vpCsuSYEVrEMawmJ4zhrLkoW0qjjKU0
         Y2Lb/T6vV6c83jX05JTThJSp7VVwKNNyjlGIbG8NU0exEjRwQmp6kaOHO2SLbUpkzQ
         wIORvN1h1Z1uKVxfJbnzmtS5dn6BONfYi4lU8Ep+vCFhRfG0ddj5tQfeFQ3bGmK7YO
         WHAPXcdQL/89A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/3] habanalabs: add validity check for event ID received from F/W
Date:   Thu, 22 Jul 2021 14:16:43 +0300
Message-Id: <20210722111643.17568-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722111643.17568-1-ogabbay@kernel.org>
References: <20210722111643.17568-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Currently there is no validity check for event ID received from F/W,
Thus exposing driver to memory overrun.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 6 ++++++
 drivers/misc/habanalabs/goya/goya.c   | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 0cb21440b5ff..655278e98618 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7962,6 +7962,12 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	u8 cause;
 	int rc;
 
+	if (event_type >= GAUDI_EVENT_SIZE) {
+		dev_err(hdev->dev, "Event type %u exceeds maximum of %u",
+				event_type, GAUDI_EVENT_SIZE - 1);
+		return;
+	}
+
 	gaudi->events_stat[event_type]++;
 	gaudi->events_stat_aggregate[event_type]++;
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 9d66bdda8789..d54c700c31cd 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4805,6 +4805,12 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 				>> EQ_CTL_EVENT_TYPE_SHIFT);
 	struct goya_device *goya = hdev->asic_specific;
 
+	if (event_type >= GOYA_ASYNC_EVENT_ID_SIZE) {
+		dev_err(hdev->dev, "Event type %u exceeds maximum of %u",
+				event_type, GOYA_ASYNC_EVENT_ID_SIZE - 1);
+		return;
+	}
+
 	goya->events_stat[event_type]++;
 	goya->events_stat_aggregate[event_type]++;
 
-- 
2.25.1

