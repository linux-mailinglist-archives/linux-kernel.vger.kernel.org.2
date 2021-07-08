Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE343C15E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 17:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhGHP0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 11:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhGHP00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:26:26 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07A6C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 08:23:43 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c9so1039980qte.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:mime-version
         :content-transfer-encoding;
        bh=+YN55qVJT6wyC2rtDdpkRhVOqaoHkRAE4/LgamoXOuY=;
        b=GL38T1LqGKZ3ZHwIez67t3J3i336LrAK6A70RsakIVVAIHGIX2vhOyfY1moMZ6VgB/
         rKVn1d7bUvZ0TjaVcdFyjkpfyPmXIK78Ko9q5Y7/trVXwrzbt4U3Ee8yRU+Np/SUF8Fc
         U9NLuea2epXaRI02H6epKBE5wyVAACFpMm6TAdmuEqb/jZA9aT0YsSFL1Kpw0v3TPRYp
         kkUubx0Q7PdBSVsPnVLCd1WAW0mPsVPFWMcslAaDfMEhM4JE0izWHRrlWji8QicUld0e
         cSAhEDkYfsN/v8QVwF1ObMMfXPu0L8qhu2SvYsajphnXYg5SQGnO1hC4fH32FNcguNtr
         mMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=+YN55qVJT6wyC2rtDdpkRhVOqaoHkRAE4/LgamoXOuY=;
        b=IJR/OP4IDxrlCv5DOtPRBIKTozWJ1snBBJdY/QyZEl9MQO76wYz9SEDdzJQF4eOjVm
         cFdha7rezfMLNIBaE8m23VGccNLhc6/XN9Q3713SeYHhO+Y/LvWPNr5G7RovgEu3rV95
         14K2pvDTnGnkpi6HyQGePXD7YP74jIWSd5+ARCp06wjoFchwEKa65P9S/5CLnJSjqPR+
         1UhDihWv/LbwdnMo7Nd7dWiV0KWDDH51GQfT91scaywaK084UhI+WpyrfhTJWDhTD59O
         k9jlNF6tJR9jj9XNTeB7tEVY2ugKQH9mUypY2ocqKkwUmbye1xjWVgZx1CgOI/VJNqeS
         P0DA==
X-Gm-Message-State: AOAM531hB6ATOsd4xax0M8JB0W7FlGMKlZXlrPD63YBwY23JyjNIBjTi
        09RDvs9kK+DJ728nslJLrOLcTQ==
X-Google-Smtp-Source: ABdhPJyoHqkFNIolSZv4+J+JG/HNwhwGEYBadtGOyri4ALLuNSj0/YY6m0VmS1fNECiTBIjazFHbnQ==
X-Received: by 2002:ac8:5f86:: with SMTP id j6mr9022194qta.227.1625757823041;
        Thu, 08 Jul 2021 08:23:43 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id x9sm1072514qtf.76.2021.07.08.08.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 08:23:42 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     davem@davemloft.net
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        gregkh@linuxfoundation.org
Subject: [PATCH] drivers: net: Follow the indentation coding standard on printks
Date:   Thu, 08 Jul 2021 11:23:41 -0400
Message-ID: <1884900.usQuhbGJ8B@iron-maiden>
Organization: Virginia Tech
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation of printks that start at the beginning of the line. Change this 
for the right number of space characters, or tabs if the file uses them. 

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
 drivers/net/ethernet/dec/tulip/de4x5.c | 2 +-
 drivers/net/sb1000.c                   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
index b125d7faefdf..155cfe8800cd 100644
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -3169,7 +3169,7 @@ dc2114x_autoconf(struct net_device *dev)
 
     default:
 	lp->tcount++;
-printk("Huh?: media:%02x\n", lp->media);
+	printk("Huh?: media:%02x\n", lp->media);
 	lp->media = INIT;
 	break;
     }
diff --git a/drivers/net/sb1000.c b/drivers/net/sb1000.c
index e88af978f63c..54a7c7613434 100644
--- a/drivers/net/sb1000.c
+++ b/drivers/net/sb1000.c
@@ -760,7 +760,7 @@ sb1000_rx(struct net_device *dev)
 
 	insw(ioaddr, (unsigned short*) st, 1);
 #ifdef XXXDEBUG
-printk("cm0: received: %02x %02x\n", st[0], st[1]);
+	printk("cm0: received: %02x %02x\n", st[0], st[1]);
 #endif /* XXXDEBUG */
 	lp->rx_frames++;
 
@@ -805,7 +805,7 @@ printk("cm0: received: %02x %02x\n", st[0], st[1]);
 		/* get data length */
 		insw(ioaddr, buffer, NewDatagramHeaderSize / 2);
 #ifdef XXXDEBUG
-printk("cm0: IP identification: %02x%02x  fragment offset: %02x%02x\n", buffer[30], buffer[31], buffer[32], buffer[33]);
+		printk("cm0: IP identification: %02x%02x  fragment offset: %02x%02x\n", buffer[30], buffer[31], buffer[32], buffer[33]);
 #endif /* XXXDEBUG */
 		if (buffer[0] != NewDatagramHeaderSkip) {
 			if (sb1000_debug > 1)
-- 
2.25.1



