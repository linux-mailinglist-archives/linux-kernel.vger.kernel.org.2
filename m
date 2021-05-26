Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A133921AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhEZUyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:54:38 -0400
Received: from foss.arm.com ([217.140.110.172]:49830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233669AbhEZUyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:54:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D1F511D4;
        Wed, 26 May 2021 13:43:23 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED4A23F73B;
        Wed, 26 May 2021 13:43:02 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] coresight: Propagate symlink failure
Date:   Wed, 26 May 2021 15:40:42 -0500
Message-Id: <20210526204042.2681700-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the symlink is unable to be created, the driver goes
ahead and continues device creation. Instead lets propagate
the failure, and fail the probe.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 6c68d34d956e..2dc4b0110442 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1392,7 +1392,7 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int coresight_remove_match(struct device *dev, void *data)
-- 
2.31.1

