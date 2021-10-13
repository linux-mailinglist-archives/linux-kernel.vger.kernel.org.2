Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB67C42B3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbhJMDnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhJMDnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:43:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55326604DC;
        Wed, 13 Oct 2021 03:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634096460;
        bh=AIdAHNFHuai/d02DcDs5zpN1aDYqcsFZdyW+f3Cp69s=;
        h=From:To:Cc:Subject:Date:From;
        b=ZNDlX9DzKPnrjzSc28e7TV6UMZCiEbdqYIgJf8UemugainF+EVktPgHBJEl0R/mas
         f/QOobraGrzgEzRv036samM99RwUtzURQgFuxiHT4GoUZ4KWqwlVKfFxJJYhHismTm
         bUuE4UByR+VN1LoKuypdyd3VtSMOy29drTiZHUmdUjyzQ0LGmpXhBFRp8EaPbbmM3k
         vUNyEwWvLHSfx6TfX09TEuKUald8btL4a0akenkdgio33QxtgYevSp19ry6p/9hbAy
         NtrBjJISYyW6Sd1vZ012BLKCmLWhhcDFn+eOu0/oKblrnYOwte/EdK7yWodQbE7fou
         nXMMiUB8XSYNw==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update entry for the Stratix10 firmware
Date:   Tue, 12 Oct 2021 22:40:56 -0500
Message-Id: <20211013034056.1560020-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gong is no longer at Intel, so update the MAINTAINER's entry for
the Stratix10 firmware drivers.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0bca0de0df7..6b6f98483deb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9629,7 +9629,7 @@ F:	include/uapi/linux/isst_if.h
 F:	tools/power/x86/intel-speed-select/
 
 INTEL STRATIX10 FIRMWARE DRIVERS
-M:	Richard Gong <richard.gong@linux.intel.com>
+M:	Dinh Nguyen <dinguyen@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
-- 
2.25.1

