Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C803C15CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhGHPWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 11:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhGHPWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:22:06 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A816C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 08:19:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g12so5096233qtb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufAgsiTnQ9eBYetRBihzfvakFKHz/gmIJgDx64cE/zo=;
        b=N8GMDxfajBeXlItImWVWvMHSRBNN0vryfP47MuYaEvkBE+oJcaitNzqY2PqYlCUoZW
         nfAqcRzkuwDPEgD9d2+SUZwq6zcq2mLeOgUD+QR0AhJdc2Ljdz8Lo3MnrnyW90ZAghOK
         FZ6i5dvr7gf8G31fmIvVIFqTm2mr5STba6zwqu+pzVHOn/M62aFFexNvz+cjGbdq8yCt
         f+oLqv5/eTlFrup6K7WHGrd5nwenqWWxErH87YlI3CpgyZZqGjpcRhbzlvXVrQIa9ez6
         lz8scQ3+wdL8xb3hq0LqHByJxefy8lZuGTGN+VR8SHAfQrkSErMdAGtvToJOGT9KfDlD
         e1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ufAgsiTnQ9eBYetRBihzfvakFKHz/gmIJgDx64cE/zo=;
        b=PzP+1ad4xNrBkGbBQJZOZ0AiJ+OuGcktG24OmmM3yO6te1ijzRGbb5tqrdlVMt2Xwf
         NDv31IFtyvUyIXbMGBLDvNBAqVPc6137BR8CaVNHOTGRrcZsRtQdwE0Js+T/E4WdAoaJ
         GQAz6xHXKtwBiuZGOr3ymgIVtZEvF/764BoxBXTfrzAUxIKeV67MLl5GhftDY2m1xiOX
         4Ge9pbWH2lhcCksa4Atjsf/vbTuYFtol8TqJZydLgQ/+wE81GiO575dLpLCZ74TL4ZLj
         oSvLJes7DBk/ZZ1I8INv2WROefe3TGOXPdm/F0m2jrhwAW6X+WPCpD+7uXNitd0oSCxO
         1BUA==
X-Gm-Message-State: AOAM530VvtPQNP37Gu5ZO1OnrKfpwZ6AwWGik/5OvoPzPxwLxYeYEL9g
        dgnxY6XSeZW5JkBVS9YjIbTgpg==
X-Google-Smtp-Source: ABdhPJyvOMCTieFag9rIrbItRv1I5VQ954BDSC0I9miiKXFAwJcOD4dO4RmSJdgPGPKgacQRc3yC9w==
X-Received: by 2002:a05:622a:1745:: with SMTP id l5mr20134010qtk.153.1625757561104;
        Thu, 08 Jul 2021 08:19:21 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id m187sm1071304qkd.131.2021.07.08.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 08:19:20 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch
Subject: [PATCH] drivers: atm: Follow the indentation coding standard on printks
Date:   Thu, 08 Jul 2021 11:19:19 -0400
Message-ID: <5630870.MhkbZ0Pkbq@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <YOcOWDqlONm69zwo@kroah.com>
References: <2784471.e9J7NaK4W3@iron-maiden> <YOcOWDqlONm69zwo@kroah.com>
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
Changelog: Replaced printk for DPRINTK on suni.c
---
 drivers/atm/eni.c                      | 2 +-
 drivers/atm/iphase.c                   | 2 +-
 drivers/atm/suni.c                     | 4 ++--
 drivers/atm/zatm.c                     | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index 422753d52244..6d10fd62ba7e 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -1456,7 +1456,7 @@ static int start_tx(struct atm_dev *dev)
 
 static void foo(void)
 {
-printk(KERN_INFO
+  printk(KERN_INFO
   "tx_complete=%d,dma_complete=%d,queued=%d,requeued=%d,sub=%d,\n"
   "backlogged=%d,rx_enqueued=%d,rx_dequeued=%d,putting=%d,pushed=%d\n",
   tx_complete,dma_complete,queued,requeued,submitted,backlogged,
diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index bc8e8d9f176b..65bb700cd5af 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -1246,7 +1246,7 @@ static void rx_intr(struct atm_dev *dev)
                ((iadev->rx_pkt_cnt - iadev->rx_tmp_cnt) == 0)) {
         for (i = 1; i <= iadev->num_rx_desc; i++)
                free_desc(dev, i);
-printk("Test logic RUN!!!!\n");
+        printk("Test logic RUN!!!!\n");
         writew( ~(RX_FREEQ_EMPT|RX_EXCP_RCVD),iadev->reass_reg+REASS_MASK_REG);
         iadev->rxing = 1;
      }
diff --git a/drivers/atm/suni.c b/drivers/atm/suni.c
index 21e5acc766b8..149605cdb859 100644
--- a/drivers/atm/suni.c
+++ b/drivers/atm/suni.c
@@ -328,8 +328,8 @@ static int suni_start(struct atm_dev *dev)
 		timer_setup(&poll_timer, suni_hz, 0);
 		poll_timer.expires = jiffies+HZ;
 #if 0
-printk(KERN_DEBUG "[u] p=0x%lx,n=0x%lx\n",(unsigned long) poll_timer.list.prev,
-    (unsigned long) poll_timer.list.next);
+	DPRINTK("[u] p=0x%lx,n=0x%lx\n",(unsigned long) poll_timer.list.prev,
+	    (unsigned long) poll_timer.list.next);
 #endif
 		add_timer(&poll_timer);
 	}
diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index cf5fffcf98a1..4fb89ed47311 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -380,7 +380,7 @@ static void poll_rx(struct atm_dev *dev,int mbx)
 			pos = zatm_dev->mbx_start[mbx];
 		cells = here[0] & uPD98401_AAL5_SIZE;
 #if 0
-printk("RX IND: 0x%x, 0x%x, 0x%x, 0x%x\n",here[0],here[1],here[2],here[3]);
+		printk("RX IND: 0x%x, 0x%x, 0x%x, 0x%x\n",here[0],here[1],here[2],here[3]);
 {
 unsigned long *x;
 		printk("POOL: 0x%08x, 0x%08x\n",zpeekl(zatm_dev,
@@ -403,14 +403,14 @@ EVENT("error code 0x%x/0x%x\n",(here[3] & uPD98401_AAL5_ES) >>
 		skb = ((struct rx_buffer_head *) bus_to_virt(here[2]))->skb;
 		__net_timestamp(skb);
 #if 0
-printk("[-3..0] 0x%08lx 0x%08lx 0x%08lx 0x%08lx\n",((unsigned *) skb->data)[-3],
+		printk("[-3..0] 0x%08lx 0x%08lx 0x%08lx 0x%08lx\n",((unsigned *) skb->data)[-3],
   ((unsigned *) skb->data)[-2],((unsigned *) skb->data)[-1],
   ((unsigned *) skb->data)[0]);
 #endif
 		EVENT("skb 0x%lx, here 0x%lx\n",(unsigned long) skb,
 		    (unsigned long) here);
 #if 0
-printk("dummy: 0x%08lx, 0x%08lx\n",dummy[0],dummy[1]);
+		printk("dummy: 0x%08lx, 0x%08lx\n",dummy[0],dummy[1]);
 #endif
 		size = error ? 0 : ntohs(((__be16 *) skb->data)[cells*
 		    ATM_CELL_PAYLOAD/sizeof(u16)-3]);
@@ -664,7 +664,7 @@ static int do_tx(struct sk_buff *skb)
 		EVENT("dsc (0x%lx)\n",(unsigned long) dsc,0);
 	}
 	else {
-printk("NONONONOO!!!!\n");
+		printk("NONONONOO!!!!\n");
 		dsc = NULL;
 #if 0
 		u32 *put;
-- 
2.25.1



