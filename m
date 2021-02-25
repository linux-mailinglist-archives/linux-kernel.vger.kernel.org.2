Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB48C3250A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhBYNj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:39:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhBYNjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:39:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E52864F0A;
        Thu, 25 Feb 2021 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614260323;
        bh=qucQ4ui+9Q3+/MBGogHwuEeihRjiYzYamvASBd7qPCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=FfaOqrVlGUOxrvasGuwfRQpbLkW03bzs1iVjMSKEaZ7idHcVYVYSAtaOlVSibxT5W
         E4Y4B6kioofJ8KwjpyA2woDfAt/zpZkMDaRdv/LO1HhBLrp1xg6iVfBCdp95/wtC+o
         2OJEnUVFH+CNbObaGyWPyUYSqMpwB/UmsuO9JfSlgXgav7cLtP2dxbH1ewKUmi38fP
         7VpvaRjTbD1Dh4CqaQxAZx8IAXvp6PQTPrIgFWYxSvoJ2PUreaCzPlLQWg8ybSfsi9
         Q1kmtFqydwROph2+k6/TfUaTw6UytzKz+AIe97lAJjbX1iUobPm0nBPhozmenQcAUt
         MnGLNqa+EqYTw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Shuo Liu <shuo.a.liu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Zhi Wang <zhi.a.wang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virt: acrn: add hotplug_cpu dependency
Date:   Thu, 25 Feb 2021 14:38:30 +0100
Message-Id: <20210225133838.2196965-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without CPU hotplug, acrn fails to build:

drivers/virt/acrn/hsm.c:389:3: error: implicit declaration of function 'remove_cpu' [-Werror,-Wimplicit-function-declaration]
                remove_cpu(cpu);
                ^
drivers/virt/acrn/hsm.c:402:2: error: implicit declaration of function 'add_cpu' [-Werror,-Wimplicit-function-declaration]
        add_cpu(cpu);
        ^

Enforce the dependency through Kconfig to avoid the build failure.

Fixes: 666834c47d3b ("virt: acrn: Introduce ACRN HSM basic driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/virt/acrn/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virt/acrn/Kconfig b/drivers/virt/acrn/Kconfig
index 3e1a61c9d8d8..fbb0e3234aaf 100644
--- a/drivers/virt/acrn/Kconfig
+++ b/drivers/virt/acrn/Kconfig
@@ -2,6 +2,7 @@
 config ACRN_HSM
 	tristate "ACRN Hypervisor Service Module"
 	depends on ACRN_GUEST
+	depends on HOTPLUG_CPU
 	select EVENTFD
 	help
 	  ACRN Hypervisor Service Module (HSM) is a kernel module which
-- 
2.29.2

