Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130A33C1817
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhGHRaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGHRaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:30:23 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DF4C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 10:27:41 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c9so1370890qte.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFz8c/A6ZV4W6xpWvsnoUBn7gb2Lgxtcr7wPVBycdds=;
        b=U/I/UJrslUxJMnLfBpgw/eLvphVVnj88tSSF7zwmXEgcXF6SFvM+LbUO2iu4qEPjc5
         QJY6iYb/ZgBT3uosGbbNJvtISgA1tO/9LS9VIZJ05hBMM2J9BcUDNlTi8aNcQdLa6uEm
         6BxsGXOuMIyLNuB0hSO/Rua2Ujg/2wRHV68E4Aw00+7YfAfCRgN9+xBXmmr9KlGL8VuF
         ODUt5zCSvlTYFM0YhSRpgp2GXAFzlaaAUB+o6xdtVMLv0xZpGCChX2KqfL0krnDQJ4gU
         l53VU00Xrfk8tE9aNIBjgbfMFHZMbhzxMDyLF1mmd8VsX8gmFIoPuMH2X8Xllp2nbhk6
         KbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wFz8c/A6ZV4W6xpWvsnoUBn7gb2Lgxtcr7wPVBycdds=;
        b=fu2JWpXBf8TlO8FQWEildoIW1QyjYdJDoKDUTJa6VPXGR2wD5HrIsYZ9DUd0ys1GSp
         Sxc6p0RiGmXzTd/W5DcXyJ4pTWfptOkht32HjR6fVxZt1JJ/CrfiKA36huCriYpjxlj4
         a2Ugy9fKpccU0hiLQi/rmkiqIH7KKxYQjPh8IDUP67x8KxxKpOhtgNBMI7tHA2D4ZXsE
         goDB51piJjz3bUS7yAs+EdNdkqyfYSAqLrKQcae7qFajKW9ERIbKuqrhfmWjQGq0J2Ma
         EYIXp2XrFxyiti9cYKg/jqQ0jKbbg9pwER1BymSJQzVZprlKLvbLGATuvhMbfK43Z0Y4
         t4uQ==
X-Gm-Message-State: AOAM533W3P6ffvnBKL34dvPb54YanUgmC6yvvxfrlEw9fJTzH4uTMkho
        NxaWpH4qRSs99pns0V30QxtfaQ==
X-Google-Smtp-Source: ABdhPJwU8EqAvdKhadpTz0xUXUZKjI9Yiin+trV5lSIMG+lj1nYN5jdRrkqKpMuJ+Lk7ivTvj7oJrg==
X-Received: by 2002:ac8:5f0d:: with SMTP id x13mr29348066qta.69.1625765260790;
        Thu, 08 Jul 2021 10:27:40 -0700 (PDT)
Received: from iron-maiden.localnet (50-200-151-121-static.hfc.comcastbusiness.net. [50.200.151.121])
        by smtp.gmail.com with ESMTPSA id b6sm1202197qtg.1.2021.07.08.10.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 10:27:40 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] drivers: atm: Follow the indentation coding standard on printks
Date:   Thu, 08 Jul 2021 13:27:39 -0400
Message-ID: <108389762.nniJfEyVGO@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <YOceNJYQJiPh3qhc@lunn.ch>
References: <2784471.e9J7NaK4W3@iron-maiden> <5630870.MhkbZ0Pkbq@iron-maiden> <YOceNJYQJiPh3qhc@lunn.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation of printks that start at the beginning of the line. Change this 
for the right number of space characters, or tabs if the file uses them. Also
directly remove the printks inside #if 0.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
Changelog: 
- Replaced printk for DPRINTK on suni.c
- Directly removed the #if 0 printks.
---
 drivers/atm/eni.c    | 23 -----------------------
 drivers/atm/iphase.c |  4 ++--
 drivers/atm/suni.c   |  4 ----
 drivers/atm/zatm.c   | 22 +---------------------
 4 files changed, 3 insertions(+), 50 deletions(-)

diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index 422753d52244..d766500e91a2 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -1448,25 +1448,6 @@ static int start_tx(struct atm_dev *dev)
 	return 0;
 }
 
-
-/*--------------------------------- common ----------------------------------*/
-
-
-#if 0 /* may become useful again when tuning things */
-
-static void foo(void)
-{
-printk(KERN_INFO
-  "tx_complete=%d,dma_complete=%d,queued=%d,requeued=%d,sub=%d,\n"
-  "backlogged=%d,rx_enqueued=%d,rx_dequeued=%d,putting=%d,pushed=%d\n",
-  tx_complete,dma_complete,queued,requeued,submitted,backlogged,
-  rx_enqueued,rx_dequeued,putting,pushed);
-if (eni_boards) printk(KERN_INFO "loss: %ld\n",ENI_DEV(eni_boards)->lost);
-}
-
-#endif
-
-
 static void bug_int(struct atm_dev *dev,unsigned long reason)
 {
 	DPRINTK(">bug_int\n");
@@ -1509,9 +1490,6 @@ static irqreturn_t eni_int(int irq,void *dev_id)
 	if (reason & MID_SUNI_INT) {
 		EVENT("SUNI int\n",0,0);
 		dev->phy->interrupt(dev);
-#if 0
-		foo();
-#endif
 	}
 	spin_lock(&eni_dev->lock);
 	eni_dev->events |= reason;
@@ -1901,7 +1879,6 @@ static void eni_close(struct atm_vcc *vcc)
 	kfree(ENI_VCC(vcc));
 	vcc->dev_data = NULL;
 	clear_bit(ATM_VF_ADDR,&vcc->flags);
-	/*foo();*/
 }
 
 
diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index bc8e8d9f176b..8a3ee51e6c9f 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -1246,8 +1246,8 @@ static void rx_intr(struct atm_dev *dev)
                ((iadev->rx_pkt_cnt - iadev->rx_tmp_cnt) == 0)) {
         for (i = 1; i <= iadev->num_rx_desc; i++)
                free_desc(dev, i);
-printk("Test logic RUN!!!!\n");
-        writew( ~(RX_FREEQ_EMPT|RX_EXCP_RCVD),iadev->reass_reg+REASS_MASK_REG);
+        printk("Test logic RUN!!!!\n");
+ 	writew( ~(RX_FREEQ_EMPT|RX_EXCP_RCVD),iadev->reass_reg+REASS_MASK_REG);
         iadev->rxing = 1;
      }
      IF_EVENT(printk("Rx intr status: RX_FREEQ_EMPT %08x\n", status);)  
diff --git a/drivers/atm/suni.c b/drivers/atm/suni.c
index 21e5acc766b8..eaafcfc3b229 100644
--- a/drivers/atm/suni.c
+++ b/drivers/atm/suni.c
@@ -327,10 +327,6 @@ static int suni_start(struct atm_dev *dev)
 	if (first) {
 		timer_setup(&poll_timer, suni_hz, 0);
 		poll_timer.expires = jiffies+HZ;
-#if 0
-printk(KERN_DEBUG "[u] p=0x%lx,n=0x%lx\n",(unsigned long) poll_timer.list.prev,
-    (unsigned long) poll_timer.list.next);
-#endif
 		add_timer(&poll_timer);
 	}
 	return 0;
diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index cf5fffcf98a1..a487fcb9282d 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -379,18 +379,6 @@ static void poll_rx(struct atm_dev *dev,int mbx)
 		if (((pos += 16) & 0xffff) == zatm_dev->mbx_end[mbx])
 			pos = zatm_dev->mbx_start[mbx];
 		cells = here[0] & uPD98401_AAL5_SIZE;
-#if 0
-printk("RX IND: 0x%x, 0x%x, 0x%x, 0x%x\n",here[0],here[1],here[2],here[3]);
-{
-unsigned long *x;
-		printk("POOL: 0x%08x, 0x%08x\n",zpeekl(zatm_dev,
-		      zatm_dev->pool_base),
-		      zpeekl(zatm_dev,zatm_dev->pool_base+1));
-		x = (unsigned long *) here[2];
-		printk("[0..3] = 0x%08lx, 0x%08lx, 0x%08lx, 0x%08lx\n",
-		    x[0],x[1],x[2],x[3]);
-}
-#endif
 		error = 0;
 		if (here[3] & uPD98401_AAL5_ERR) {
 			error = (here[3] & uPD98401_AAL5_ES) >>
@@ -402,16 +390,8 @@ EVENT("error code 0x%x/0x%x\n",(here[3] & uPD98401_AAL5_ES) >>
   uPD98401_AAL5_ES_SHIFT,error);
 		skb = ((struct rx_buffer_head *) bus_to_virt(here[2]))->skb;
 		__net_timestamp(skb);
-#if 0
-printk("[-3..0] 0x%08lx 0x%08lx 0x%08lx 0x%08lx\n",((unsigned *) skb->data)[-3],
-  ((unsigned *) skb->data)[-2],((unsigned *) skb->data)[-1],
-  ((unsigned *) skb->data)[0]);
-#endif
 		EVENT("skb 0x%lx, here 0x%lx\n",(unsigned long) skb,
 		    (unsigned long) here);
-#if 0
-printk("dummy: 0x%08lx, 0x%08lx\n",dummy[0],dummy[1]);
-#endif
 		size = error ? 0 : ntohs(((__be16 *) skb->data)[cells*
 		    ATM_CELL_PAYLOAD/sizeof(u16)-3]);
 		EVENT("got skb 0x%lx, size %d\n",(unsigned long) skb,size);
@@ -664,7 +644,7 @@ static int do_tx(struct sk_buff *skb)
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




