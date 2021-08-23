Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FA13F4D33
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhHWPSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:18:33 -0400
Received: from [138.197.143.207] ([138.197.143.207]:48918 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhHWPSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:18:32 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: [PATCH] maintainers: Add Alyssa Rosenzweig as M1 reviewer
Date:   Mon, 23 Aug 2021 11:17:38 -0400
Message-Id: <20210823151738.6273-1-alyssa@rosenzweig.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a reviewer for Asahi Linux (Apple M1) patches.

I would like to be CC'ed on Asahi Linux patches for review and testing.
I am also collecting Asahi Linux patches downstream, rebasing on
linux-next periodically, and would like to be notified of what to
cherry-pick from lists.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Hector Martin <marcan@marcan.st>
Cc: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b63403793c81..399e536bf629 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1264,6 +1264,7 @@ F:	drivers/input/mouse/bcm5974.c
 
 APPLE DART IOMMU DRIVER
 M:	Sven Peter <sven@svenpeter.dev>
+R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
 L:	iommu@lists.linux-foundation.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -1693,6 +1694,7 @@ F:	drivers/*/*alpine*
 
 ARM/APPLE MACHINE SUPPORT
 M:	Hector Martin <marcan@marcan.st>
+R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	https://asahilinux.org
-- 
2.30.2

