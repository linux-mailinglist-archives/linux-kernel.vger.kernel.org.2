Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC25144BF6E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhKJLCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:02:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:35066 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhKJLCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:02:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232891455"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="232891455"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 02:59:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="452260777"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 10 Nov 2021 02:59:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B755A155; Wed, 10 Nov 2021 12:59:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>
Subject: [PATCH v2 2/3] soc: fsl: Correct MAINTAINERS database (SOC)
Date:   Wed, 10 Nov 2021 12:59:51 +0200
Message-Id: <20211110105952.62013-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211110105952.62013-1-andriy.shevchenko@linux.intel.com>
References: <20211110105952.62013-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS lacks of proper coverage for FSL headers. Fix it accordingly.

Fixes: 1b48706f027c ("MAINTAINERS: add entry for Freescale SoC drivers")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a35e4d9e52b8..8748328fdc63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7689,6 +7689,7 @@ F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
 F:	Documentation/devicetree/bindings/soc/fsl/
 F:	drivers/soc/fsl/
 F:	include/linux/fsl/
+F:	include/soc/fsl/
 
 FREESCALE SOC FS_ENET DRIVER
 M:	Pantelis Antoniou <pantelis.antoniou@gmail.com>
-- 
2.33.0

