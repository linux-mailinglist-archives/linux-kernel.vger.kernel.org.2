Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F04241507B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhIVTbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233678AbhIVTbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:31:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4587960FE8;
        Wed, 22 Sep 2021 19:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632339007;
        bh=Qj1Av/b1GJoDvAQnrqzwIbHI14OhoMTW7cGHOjkPsTc=;
        h=From:To:Cc:Subject:Date:From;
        b=R2IvAEAGTGoTdyLF1nMx497bfyy2qUdhsYzG69eLmJWSOTJlu7AprkNHrsaQIZBhp
         nKoPZIEJwpgqsUv3ss64tKU2OJ0vRiFehTQttNe7p1KR6m/eSo3dPyG34EnMHC8guJ
         lhX/bIQuCK/taIEzFv+SEpjtlVY7oCpYPuVFdeJNmdh58f1eumg5rSkWbqkeps/Ui9
         2vS1WW+Ktq4KdmL2s+apvz+YTpo8O+HsLwgYSCYQaZ8gCYgY0pDPnY25FwcxgO/Cy1
         pILrl+jzidZKl4T5Tf5DyEiiN4L9yZJnFJ3DgptGl75Ine8EOO8Y5SiZXFSEbRMS7S
         p6W3h5emnMMpA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH] MAINTAINERS: update entry for NIOS2
Date:   Wed, 22 Sep 2021 14:30:01 -0500
Message-Id: <20210922193001.2334311-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ley Foon has left Intel and will no longer be able to maintain NIOS2.
Update the MAINTAINER's entry to Dinh Nguyen.

Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca6d6fde85cf..09a938614bf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13255,9 +13255,9 @@ F:	Documentation/scsi/NinjaSCSI.rst
 F:	drivers/scsi/nsp32*
 
 NIOS2 ARCHITECTURE
-M:	Ley Foon Tan <ley.foon.tan@intel.com>
+M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
 F:	arch/nios2/
 
 NITRO ENCLAVES (NE)
-- 
2.25.1

