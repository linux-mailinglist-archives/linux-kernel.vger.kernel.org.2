Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C869A37F446
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhEMIlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:41:08 -0400
Received: from bgl-iport-4.cisco.com ([72.163.197.28]:40264 "EHLO
        bgl-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhEMIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:41:00 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2021 04:40:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1328; q=dns/txt; s=iport;
  t=1620895191; x=1622104791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GILvIbVCmcaVxwex9QMjQ6XJulnDFvDcHk5uBggKEUY=;
  b=jQGs2IFbSWs07l42/G9Cy0qV7Kp5q8OV2bYcTJLYiyr9PUgQSt+L9U3m
   zu7W8/gxn+d/y/ZZ13QTY7f4LiXKGMuMoBklSoAeKgSce44pHfWDzXmcc
   Up0QKEs/MI+FUwXrhQDC63OQNXY9BBKUPT4I5E0o1M5OXNVNsAvWv9xdJ
   w=;
X-IronPort-AV: E=Sophos;i="5.82,296,1613433600"; 
   d="scan'208";a="184709319"
Received: from vla196-nat.cisco.com (HELO bgl-core-4.cisco.com) ([72.163.197.24])
  by bgl-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 13 May 2021 08:32:26 +0000
Received: from bgl-ads-2459.cisco.com (bgl-ads-2459.cisco.com [173.39.54.102])
        by bgl-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id 14D8WPKr022518;
        Thu, 13 May 2021 08:32:25 GMT
From:   Gopalakrishnan Santhanam <gsanthan@cisco.com>
To:     stern@rowland.harvard.edu
Cc:     danielwa@cisco.com, hramdasi@cisco.com, gsanthan@cisco.com,
        christian.engelmayer@frequentis.com, xe-linux-external@cisco.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fsl-usb: add need_oc_pp_cycle flag for 85xx also
Date:   Thu, 13 May 2021 14:02:25 +0530
Message-Id: <20210513083225.68912-1-gsanthan@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <20210507172300.3075939-1-danielwa@cisco.com>
References: <20210507172300.3075939-1-danielwa@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 173.39.54.102, bgl-ads-2459.cisco.com
X-Outbound-Node: bgl-core-4.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e6604a7fd71f9 ("EHCI: Quirk flag for port power handling
on overcurrent.") activated the quirks handling (flag need_oc_pp_cycle)
for Freescale 83xx based boards.
Activate same for 85xx based boards as well.

Cc: xe-linux-external@cisco.com
Signed-off-by: Gopalakrishnan Santhanam <gsanthan@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 drivers/usb/host/ehci-fsl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 6f7bd6641694..385be30baad3 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -387,11 +387,11 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
 	/* EHCI registers start at offset 0x100 */
 	ehci->caps = hcd->regs + 0x100;
 
-#ifdef CONFIG_PPC_83xx
+#if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_85xx)
 	/*
-	 * Deal with MPC834X that need port power to be cycled after the power
-	 * fault condition is removed. Otherwise the state machine does not
-	 * reflect PORTSC[CSC] correctly.
+	 * Deal with MPC834X/85XX that need port power to be cycled
+	 * after the power fault condition is removed. Otherwise the
+	 * state machine does not reflect PORTSC[CSC] correctly.
 	 */
 	ehci->need_oc_pp_cycle = 1;
 #endif
-- 
2.26.2.Cisco

