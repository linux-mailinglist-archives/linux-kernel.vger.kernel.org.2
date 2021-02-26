Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB8F3261D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhBZLNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230153AbhBZLN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:13:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C2C164DDA;
        Fri, 26 Feb 2021 11:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614337968;
        bh=yI1EWY46ibA8KnKsAOavYvHFytGyojJsQ8TnGh70IZ8=;
        h=From:To:Cc:Subject:Date:From;
        b=nKAVaOKkzVtc0ccyAOC2I0u4Bg6/vNk6/u2p/PvIZCrvez7uusl4vDwqWO+5G5hgd
         RKg382v+3A1A1jCdfP4LoN9ftijqORLL2IuGwlBQ4xiCM9XzmDgSwsh5BDD2S4lPEk
         N1JZMfRIDYJix8CYbAfcsnEsKuR9aa1e3Z/vFUVWq2YY1H/ER7UktfQBOYBOmOf5B+
         GIooaXk84gwAK8zZlGDPmN0zsDnABWfz8AvZDGbIMFiFIPCcKwGrcpGKr+Z65PmtyI
         cz2BTziIgUSTg74qJl3rCdZJjgkYVlf0Yk/q7O1mL+1EK/5FGLbIXWXqBXcFClS1yY
         kparzeAfJ3F+g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add linux-phy list and patchwork
Date:   Fri, 26 Feb 2021 16:42:33 +0530
Message-Id: <20210226111233.2601369-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-phy subsystem gained mailing list and a patchwork instance. Add the
details to MAINTAINERS file

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

Greg, Linus: Can we merge this patch for -rc1?

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66428c9..d53754790d38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7448,8 +7448,9 @@ F:	include/uapi/asm-generic/
 GENERIC PHY FRAMEWORK
 M:	Kishon Vijay Abraham I <kishon@ti.com>
 M:	Vinod Koul <vkoul@kernel.org>
-L:	linux-kernel@vger.kernel.org
+L:	linux-phy@lists.infradead.org
 S:	Supported
+Q:	https://patchwork.kernel.org/project/linux-phy/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
 F:	Documentation/devicetree/bindings/phy/
 F:	drivers/phy/
-- 
2.26.2

