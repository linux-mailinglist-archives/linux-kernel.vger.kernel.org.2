Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35E3396AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhCLSeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbhCLSda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:33:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:33:30 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g8so4376151wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=99Si3ZeTVQRmaMijDuv1ZpadtC/J5+lXBe0guhvxNRc=;
        b=J6WvtRB095p/dNCwYDp8loUtF5t/qWNsDX3ilqp9hpdvqQJ6VMlIjkLjWUQxZBWC89
         lsQFoCCE03x3ybJVS/1HOa9J4JhFpywMLU1b/aSO27L0xmVk87ff4PnMatpyIGs5RPI8
         0OPIylETGHcgDOouX/pPYyXm4bl3KFtecsemynkV4w1R93wrGPHul3IqAzIOazQ9G9ES
         STMmzL0a1N78MxALdgSLNzVR6oYQZsFbY2G19u8qVhEFvH7TTowVUUIqtiL8A42UEY2o
         JymWJAuJwi9w46iaNSen/Pq9upPopvZLtXiQpKuqX1G4106twv1NKc/ERDMRSzKmDBGV
         bmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=99Si3ZeTVQRmaMijDuv1ZpadtC/J5+lXBe0guhvxNRc=;
        b=tIoHL01YYizO/TtpA3ZVJa7B8EMZYd9kewVL4KuG5+uDL5fOJUJX3TLDqmEgn9S8Hl
         +Xts/IDY90VxvKubIS9fDKOZZRoANRry5RFLXCrHSHzDcGFuQ9pJoCiAEYq9OLM4S6ld
         GVsNX7kxLbsZU1kTq37kQZn893uRSZlLzBDA/vxEpPX+PE/9FBIs4Q7xttYvx5fMZOFs
         2VVfsRiO/t0qfWV2O9N3BkQBBBBZ7vdyQOVKyta8mEPXPzci4b+an2YoMT0q4h2bYVCz
         qUSegahoRaosRzu+AVbwuHH6M0sUWhA3kOx3FOnyIP8DHq7NYw5p9FB2QwgoO9Ki3snT
         SYyg==
X-Gm-Message-State: AOAM530v0Oh/dPGER8ljWK8C2OrDQHc4jEcqGUr6aTElAmAOWEAuCHhy
        eg6kdSykCiQoZ/OZrmhXzsU=
X-Google-Smtp-Source: ABdhPJzYVYO64oHb03idx/Qa7hX1KosLLZRFIPprtu8flcBDdVtb/Es5w3akof3Ab0VhfFEqKtbwoA==
X-Received: by 2002:a1c:771a:: with SMTP id t26mr14476280wmi.60.1615574008829;
        Fri, 12 Mar 2021 10:33:28 -0800 (PST)
Received: from agape.jhs ([151.57.163.80])
        by smtp.gmail.com with ESMTPSA id v18sm9761728wrf.41.2021.03.12.10.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 10:33:28 -0800 (PST)
Date:   Fri, 12 Mar 2021 19:33:26 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_PNO_SET_DEBUG
Message-ID: <1a2eaead1b848c26892497fe34841b29e5eaeec2.1615572985.git.fabioaiuto83@gmail.com>
References: <cover.1615572985.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615572985.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove conditional code block checked by unused CONFIG_PNO_SET_DEBUG

Cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 48 --------------------
 drivers/staging/rtl8723bs/hal/sdio_halinit.c |  5 --
 2 files changed, 53 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 0480e32701f0..479623d6eb79 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -1668,18 +1668,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 			rtl8723b_fill_fake_txdesc(padapter,
 				&ReservedPagePacket[BufIndex-TxDescLen],
 				ProbeReqLength, false, false, false);
-#ifdef CONFIG_PNO_SET_DEBUG
-	{
-			int gj;
-			printk("probe req pkt =>\n");
-			for (gj = 0; gj < ProbeReqLength+TxDescLen; gj++) {
-				printk(" %02x ", ReservedPagePacket[BufIndex-TxDescLen+gj]);
-				if ((gj+1)%8 == 0)
-					printk("\n");
-			}
-			printk(" <=end\n");
-	}
-#endif
 			CurtPktPageNum =
 				(u8)PageNum_128(TxDescLen + ProbeReqLength);
 
@@ -1690,18 +1678,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 			/* PNO INFO Page */
 			RsvdPageLoc.LocPNOInfo = TotalPageNum;
 			ConstructPnoInfo(padapter, &ReservedPagePacket[BufIndex-TxDescLen], &PNOLength);
-#ifdef CONFIG_PNO_SET_DEBUG
-	{
-			int gj;
-			printk("PNO pkt =>\n");
-			for (gj = 0; gj < PNOLength; gj++) {
-				printk(" %02x ", ReservedPagePacket[BufIndex-TxDescLen+gj]);
-				if ((gj + 1)%8 == 0)
-					printk("\n");
-			}
-			printk(" <=end\n");
-	}
-#endif
 
 			CurtPktPageNum = (u8)PageNum_128(PNOLength);
 			TotalPageNum += CurtPktPageNum;
@@ -1710,18 +1686,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 			/* SSID List Page */
 			RsvdPageLoc.LocSSIDInfo = TotalPageNum;
 			ConstructSSIDList(padapter, &ReservedPagePacket[BufIndex-TxDescLen], &SSIDLegnth);
-#ifdef CONFIG_PNO_SET_DEBUG
-	{
-			int gj;
-			printk("SSID list pkt =>\n");
-			for (gj = 0; gj < SSIDLegnth; gj++) {
-				printk(" %02x ", ReservedPagePacket[BufIndex-TxDescLen+gj]);
-				if ((gj + 1)%8 == 0)
-					printk("\n");
-			}
-			printk(" <=end\n");
-	}
-#endif
 			CurtPktPageNum = (u8)PageNum_128(SSIDLegnth);
 			TotalPageNum += CurtPktPageNum;
 			BufIndex += (CurtPktPageNum*PageSize);
@@ -1729,18 +1693,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 			/* Scan Info Page */
 			RsvdPageLoc.LocScanInfo = TotalPageNum;
 			ConstructScanInfo(padapter, &ReservedPagePacket[BufIndex-TxDescLen], &ScanInfoLength);
-#ifdef CONFIG_PNO_SET_DEBUG
-	{
-			int gj;
-			printk("Scan info pkt =>\n");
-			for (gj = 0; gj < ScanInfoLength; gj++) {
-				printk(" %02x ", ReservedPagePacket[BufIndex-TxDescLen+gj]);
-				if ((gj + 1)%8 == 0)
-					printk("\n");
-			}
-			printk(" <=end\n");
-	}
-#endif
 			CurtPktPageNum = (u8)PageNum_128(ScanInfoLength);
 			TotalPageNum += CurtPktPageNum;
 			BufIndex += (CurtPktPageNum*PageSize);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 9dd3f3249e01..3266839031f8 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1476,11 +1476,6 @@ static void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
 				rtw_read32(padapter, 0x2fc),
 				rtw_read32(padapter, 0x8c)
 			);
-#ifdef CONFIG_PNO_SET_DEBUG
-			DBG_871X("0x1b9: 0x%02x, 0x632: 0x%02x\n", rtw_read8(padapter, 0x1b9), rtw_read8(padapter, 0x632));
-			DBG_871X("0x4fc: 0x%02x, 0x4fd: 0x%02x\n", rtw_read8(padapter, 0x4fc), rtw_read8(padapter, 0x4fd));
-			DBG_871X("TXDMA STATUS: 0x%08x\n", rtw_read32(padapter, REG_TXDMA_STATUS));
-#endif
 
 			{
 				/*  2.  Set Disable WOWLAN H2C command. */
-- 
2.20.1

