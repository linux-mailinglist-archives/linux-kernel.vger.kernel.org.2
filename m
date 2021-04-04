Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C1135397A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 21:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhDDT0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 15:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhDDT0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 15:26:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4E4C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3pF1jOma3Z1mWr7uQzP/TbmpInXypLLHfdO7biubeG0=; b=KcAI/2B7QYcwQmHemGdmiqb/22
        WcJqCV7Xvce5EAv/H5X8WlaIg3QuzN8y25lrJlQ/3d7qzRAkEpo0nJAJa/q178R8IHwFZn2d2aINk
        z6o4zqaMPeQ+UTz4GSEjTpER76QhKd7vwVWN2tSHg9tWAbFQAsNfUCy+7bncfgWhE9vOK2MW8rdd3
        gRRzCLG3vE49nX3BRLL6U0ZQ84ywIvtED6rKb0R4AYItT8Dj4aRkCFMVoHSZPiDVen2vkgs5ODVM1
        fAaxeHMgu0F9kV3cxJu0iQX5buaI/KzlLXApVlOEJfpidLMJ7K9VpL//l9b+GDeupHcN6ubY5LdP+
        zTYq3qBQ==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lT8OB-00ATM1-M4; Sun, 04 Apr 2021 19:26:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: [PATCH v2] powerpc: iommu: fix build when neither PCI or IBMVIO is set
Date:   Sun,  4 Apr 2021 12:26:23 -0700
Message-Id: <20210404192623.10697-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When neither CONFIG_PCI nor CONFIG_IBMVIO is set/enabled, iommu.c has a
build error. The fault injection code is not useful in that kernel config,
so make the FAIL_IOMMU option depend on PCI || IBMVIO.

Prevents this build error (warning escalated to error):
../arch/powerpc/kernel/iommu.c:178:30: error: 'fail_iommu_bus_notifier' defined but not used [-Werror=unused-variable]
  178 | static struct notifier_block fail_iommu_bus_notifier = {

Fixes: d6b9a81b2a45 ("powerpc: IOMMU fault injection")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@samba.org>
---
I was supposed to update this about one month ago, but then I lost
some email and also took a break for a few weeks, then I remembered,
so here it is.

 arch/powerpc/Kconfig.debug |    1 +
 1 file changed, 1 insertion(+)

--- lnx-512-rc1.orig/arch/powerpc/Kconfig.debug
+++ lnx-512-rc1/arch/powerpc/Kconfig.debug
@@ -353,6 +353,7 @@ config PPC_EARLY_DEBUG_CPM_ADDR
 config FAIL_IOMMU
 	bool "Fault-injection capability for IOMMU"
 	depends on FAULT_INJECTION
+	depends on PCI || IBMVIO
 	help
 	  Provide fault-injection capability for IOMMU. Each device can
 	  be selectively enabled via the fail_iommu property.
