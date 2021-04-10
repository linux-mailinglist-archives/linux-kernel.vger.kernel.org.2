Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870D435AF4F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 19:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhDJRd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 13:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhDJRd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 13:33:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A66C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 10:33:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m18so2033036plc.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mPRVe+dtqmO2CcciwnI9bQjdkM3bNfy3dPHUSjpkio0=;
        b=Or6FpkmW6TxCMa3OmWBKZP6PbJ149nI6bqjqQtHrLPEsY1abnGi1Cxv3Nc7+KCT8nm
         39XT2KO082uMXtCnmBCTzUR8IMgPo6oxTnBpU3IrJn8mprANKiXByiX4d5KDKqcgCG6F
         MMVXUulMJCVdiSnJQi6SdLbQyJ8rIqACCnf7QNLM7glh1vQ56aqJAVNJiYVp3FcA6Cj7
         neJXQRylQ4IYwzwdaAvb3MSTDvQD6WLNdQBV+3PFdYvnPuBdWHnAkH3xpZt0u1SGCnSV
         2vEnwxQjjpQF/IOvKXylhWb3Lx40v7A29L9JkrLS5U30I/HyjPgCcaRGMYV5nLf+Uv03
         dLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mPRVe+dtqmO2CcciwnI9bQjdkM3bNfy3dPHUSjpkio0=;
        b=tQZ6tM8BRtipyLK6cJSxb+YkhKzhSNRGAKJVwwRxhT2JCr/huuB6Mq+Ra3dgYpKsAQ
         wpYy+m6Qg5pWjVO6IJ1Jk9pAr4flBlESZkf9pawlnmcBqJdkPvI6o2sXo0+7PD0jA0RQ
         5QQu/RVj+Dtih3AzttPk/fAwX1zDVXQhQgdXY0KNSt2LSby0s9AUXRPyJRhZXWJetbbB
         HLdJRAZyE33QFv7FJevAsKbW6uPAxD8m6x/aVy+/5KW2wMe67/YTRiBHWTUz0/Liu3IP
         uYAFwlst9iY/WUVMcmSQhH49vlvDUiywe5QqNDpwQ2MOdQgUGDixu01paMF3NC1iQwjj
         8g0w==
X-Gm-Message-State: AOAM532yMDYTta5D0kFrbDiRM/akKfQkuWwrgCNOjQVgyi5lizQNXzzI
        //Lux+yYE5dAp1+Nn6Pe0TU=
X-Google-Smtp-Source: ABdhPJz5VX7Gq0ep7DhbH4m7k4xatK5kOnSk1q6Pg7RmFrFTJnl/w8yDq0OAeDCIVE10fb7zC75/zQ==
X-Received: by 2002:a17:90a:8907:: with SMTP id u7mr19621197pjn.114.1618076021193;
        Sat, 10 Apr 2021 10:33:41 -0700 (PDT)
Received: from z640-arch.lan ([2602:61:7344:f100::678])
        by smtp.gmail.com with ESMTPSA id b67sm3062135pfb.37.2021.04.10.10.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 10:33:40 -0700 (PDT)
From:   Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Siddhant Gupta <siddhantgupta416@gmail.com>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Selvakumar Elangovan <selvakumar16197@gmail.com>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-pci: stop using of_pci_range_to_resource
Date:   Sat, 10 Apr 2021 10:33:31 -0700
Message-Id: <20210410173331.57949-1-ilya.lipnitskiy@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic here was already overriding the erroneous IO addresses
returned from of_pci_range_to_resource, which is the bulk of the logic.

So stop using it altogether and initialize the fields explicitly, as
done in aeba3731b150 ("powerpc/pci: Fix IO space breakage after
of_pci_range_to_resource() change").

Signed-off-by: Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 1781c1dcf5b4..115250115f10 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -301,18 +301,19 @@ static int mt7621_pci_parse_request_of_pci_ranges(struct pci_host_bridge *host)
 
 	/*
 	 * IO_SPACE_LIMIT for MIPS is 0xffff but this platform uses IO at
-	 * upper address 0x001e160000 so we have to get the resource from
-	 * the DT because when it has been requested it failed and has been
-	 * removed from bridge->dma_ranges and bridge->windows. So parse it
-	 * and remap it manually to make things work.
+	 * upper address 0x001e160000. of_pci_range_to_resource does not work
+	 * well for MIPS platforms that don't define PCI_IOBASE, so set the IO
+	 * resource manually instead.
 	 */
+	pcie->io.name = node->full_name;
+	pcie->io.parent = pcie->io.child = pcie->io.sibling = NULL;
 	for_each_of_pci_range(&parser, &range) {
 		switch (range.flags & IORESOURCE_TYPE_BITS) {
 		case IORESOURCE_IO:
 			pcie->io_map_base =
 				(unsigned long)ioremap(range.cpu_addr,
 						       range.size);
-			of_pci_range_to_resource(&range, node, &pcie->io);
+			pcie->io.flags = range.flags;
 			pcie->io.start = range.cpu_addr;
 			pcie->io.end = range.cpu_addr + range.size - 1;
 			set_io_port_base(pcie->io_map_base);
-- 
2.31.1

