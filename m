Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF119353EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbhDEJHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 05:07:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1907 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238505AbhDEJFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 05:05:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FDPql1BWXz9txQl;
        Mon,  5 Apr 2021 11:04:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id j-oF-vx1_R-g; Mon,  5 Apr 2021 11:04:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FDPql06Mbz9txQk;
        Mon,  5 Apr 2021 11:04:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A5CBA8B790;
        Mon,  5 Apr 2021 11:04:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FUEdEzIjFpS8; Mon,  5 Apr 2021 11:04:55 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4116C8B75B;
        Mon,  5 Apr 2021 11:04:55 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc: iommu: fix build when neither PCI or IBMVIO
 is set
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>,
        Anton Blanchard <anton@samba.org>
References: <20210404192623.10697-1-rdunlap@infradead.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <135d33bc-5520-d49b-dd1c-582c7d8e3bac@csgroup.eu>
Date:   Mon, 5 Apr 2021 11:04:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210404192623.10697-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 04/04/2021 à 21:26, Randy Dunlap a écrit :
> When neither CONFIG_PCI nor CONFIG_IBMVIO is set/enabled, iommu.c has a
> build error. The fault injection code is not useful in that kernel config,
> so make the FAIL_IOMMU option depend on PCI || IBMVIO.
> 
> Prevents this build error (warning escalated to error):
> ../arch/powerpc/kernel/iommu.c:178:30: error: 'fail_iommu_bus_notifier' defined but not used [-Werror=unused-variable]
>    178 | static struct notifier_block fail_iommu_bus_notifier = {
> 
> Fixes: d6b9a81b2a45 ("powerpc: IOMMU fault injection")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Anton Blanchard <anton@samba.org>
> ---
> I was supposed to update this about one month ago, but then I lost
> some email and also took a break for a few weeks, then I remembered,
> so here it is.
> 
>   arch/powerpc/Kconfig.debug |    1 +
>   1 file changed, 1 insertion(+)

Wouldn't it be cleaner to get rid of those two horid #ifdefs ?
Of course we can do both.

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 216871414434..d691afa8acf8 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -180,12 +180,10 @@ static struct notifier_block fail_iommu_bus_notifier = {

  static int __init fail_iommu_setup(void)
  {
-#ifdef CONFIG_PCI
-	bus_register_notifier(&pci_bus_type, &fail_iommu_bus_notifier);
-#endif
-#ifdef CONFIG_IBMVIO
-	bus_register_notifier(&vio_bus_type, &fail_iommu_bus_notifier);
-#endif
+	if (IS_ENABLED(CONFIG_PCI))
+		bus_register_notifier(&pci_bus_type, &fail_iommu_bus_notifier);
+	if (IS_ENABLED(CONFIG_IBMVIO))
+		bus_register_notifier(&vio_bus_type, &fail_iommu_bus_notifier);

  	return 0;
  }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..361f4f255911 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -964,6 +964,8 @@ enum {
  #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
  #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */

+extern struct bus_type pci_bus_type;
+
  /* These external functions are only available when PCI support is enabled */
  #ifdef CONFIG_PCI

@@ -986,8 +988,6 @@ enum pcie_bus_config_types {

  extern enum pcie_bus_config_types pcie_bus_config;

-extern struct bus_type pci_bus_type;
-
  /* Do NOT directly access these two variables, unless you are arch-specific PCI
   * code, or PCI core code. */
  extern struct list_head pci_root_buses;	/* List of all known PCI buses */
