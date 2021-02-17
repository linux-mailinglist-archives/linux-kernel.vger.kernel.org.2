Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE8431D8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhBQMA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:00:56 -0500
Received: from foss.arm.com ([217.140.110.172]:57482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232459AbhBQMAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:00:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94B2C1042;
        Wed, 17 Feb 2021 03:59:20 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.61.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99F863F694;
        Wed, 17 Feb 2021 03:59:18 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        daniel.lezcano@linaro.org
Cc:     viresh.kumar@linaro.org, thara.gopinath@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com
Subject: [RESEND PATCH] MAINTAINERS: update thermal CPU cooling section
Date:   Wed, 17 Feb 2021 11:59:08 +0000
Message-Id: <20210217115908.22547-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update maintainers responsible for CPU cooling on Arm side.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi Daniel,

Please ignore the previous email and that this change with 'R'.
Javi will ack it later.

Regards,
Lukasz

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f32ebcff37d2..fe34f56acb0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17774,7 +17774,7 @@ THERMAL/CPU_COOLING
 M:	Amit Daniel Kachhap <amit.kachhap@gmail.com>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
-M:	Javi Merino <javi.merino@kernel.org>
+R:	Lukasz Luba <lukasz.luba@arm.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
-- 
2.17.1

