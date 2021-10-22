Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D52B4374E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhJVJkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhJVJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:40:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C91C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:37:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d198-20020a1c1dcf000000b00322f53b9b89so2007814wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eui2f6xiYAJe7Go/+jIeHmtQh5FPkhPyZFMuoXCPPAU=;
        b=lYEH8PNC1nNFdMr0lNdlph0+qzNXFQwEWemaPl5UigmQIFzn/r2jABQ2kya4fs5HQ7
         YiDg7kQOxylBUkJqzrTXNlO4buLcsc5SNZZnQMRfVfeIc8IwaYGpE37OE4CjVGS+/qLG
         hQNdmdtkwwMu0CpSYofCCqa1xW1Z6nbgND0Keu/ylT5mvU8cDD60EkyNkYYJUWVYzXvu
         IIUUfyoUFavVK/lMy9WaizLr8MN63NWxTF8YGD/7ZrfCLPRQYWOVFCf2zE9+Z3fAZFlm
         QbTI6C5V2HvKFnGmmBpBjV5CaEqaxiXDcyBQyRFIJrz2W20VEJEXsSS7he9Ytc6A9CQ+
         vzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eui2f6xiYAJe7Go/+jIeHmtQh5FPkhPyZFMuoXCPPAU=;
        b=RnofMefr7Bsk1+Fq21NEe9AydMySxQcyUVPwROWxAs82L0dFtFU/n2g5BrmA/MEmJw
         LeC1H+Zx/YqFgh4ot1gNe0Srl2ytElYj6abOFB20NM4jRMTUS9ins8+NuCyMkTlCeJmj
         /hp9gom9fXXohYnNSZiiIDrix5RCtKvBbnIsbdG9pdmMguYUrtjlJ+62Mg5unJOjvVLG
         apGgWVNfwIYzK2hy28KUo3/lPeDe7H2lsv2eonpd1Yc4z9XWTvKofNnZSX3ZENWk+uoc
         b28ozaoHL4wIJAJzqxtG3ijNPmmAZeQcwUtjtnY28f5ziu+4+IgOiQRsTd6DqfzsWtpj
         VN5w==
X-Gm-Message-State: AOAM533F0qjDclAq0N45HNPd4CJM80XSKX2JyUVuZmFYhnt34IZuIt2a
        /rQXLWAKQLXr+Ei4myYhSpc=
X-Google-Smtp-Source: ABdhPJyKDRC+PEhSoUitlfKsltRa8lT737H0DlQHF6xtZLpwdaz0tVTUhU2ITlrqEqQcwyvX1eFcNw==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr12589021wmi.69.1634895474182;
        Fri, 22 Oct 2021 02:37:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id r15sm1643602wru.9.2021.10.22.02.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:37:53 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 4/5] staging: vt6655: Rename `uChannel` variable
Date:   Fri, 22 Oct 2021 10:37:17 +0100
Message-Id: <09881aacf6b399e3bce2de658133553c78c5b1ab.1634826774.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1634826774.git.karolinadrobnik@gmail.com>
References: <cover.1634826774.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop Hungarian notation in `uChannel` variable in
`RFvWriteWakeProgSyn` function. Change it to use snake case.

Fix issue detected by checkpatch.pl:
  CHECK: Avoid CamelCase: <uChannel>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 18 +++++++++---------
 drivers/staging/vt6655/rf.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index a30ffacf720a..0dd91b0433f6 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -670,14 +670,14 @@ bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType,
  * Parameters:
  *  In:
  *      iobase      - I/O base address
- *      uChannel    - channel number
+ *      channel     - channel number
  *      bySleepCnt  - SleepProgSyn count
  *
  * Return Value: None.
  *
  */
 bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
-			 u16 uChannel)
+			 u16 channel)
 {
 	void __iomem *iobase = priv->port_offset;
 	int i;
@@ -689,7 +689,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 	case RF_AIROHA:
 	case RF_AL2230S:
 
-		if (uChannel > CB_MAX_CHANNEL_24G)
+		if (channel > CB_MAX_CHANNEL_24G)
 			return false;
 
 		 /* Init Reg + Channel Reg (2) */
@@ -701,9 +701,9 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
 			MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al2230_init_table[i]);
 
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL2230ChannelTable0[uChannel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL2230ChannelTable0[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL2230ChannelTable1[uChannel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL2230ChannelTable1[channel - 1]);
 		break;
 
 		/* Need to check, PLLON need to be low for channel setting */
@@ -714,7 +714,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
 			return false;
 
-		if (uChannel <= CB_MAX_CHANNEL_24G) {
+		if (channel <= CB_MAX_CHANNEL_24G) {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
 				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230InitTable[i]);
 		} else {
@@ -722,11 +722,11 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230InitTableAMode[i]);
 		}
 
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable0[uChannel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable0[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable1[uChannel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable1[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable2[uChannel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable2[channel - 1]);
 		break;
 
 	case RF_NOTHING:
diff --git a/drivers/staging/vt6655/rf.h b/drivers/staging/vt6655/rf.h
index d499aed45c9f..d3f2b8dd6afc 100644
--- a/drivers/staging/vt6655/rf.h
+++ b/drivers/staging/vt6655/rf.h
@@ -60,7 +60,7 @@
 bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData);
 bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType, u16 byChannel);
 bool RFbInit(struct vnt_private *priv);
-bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType, u16 uChannel);
+bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType, u16 channel);
 bool RFbSetPower(struct vnt_private *priv, unsigned int rate, u16 uCH);
 bool RFbRawSetPower(struct vnt_private *priv, unsigned char byPwr,
 		    unsigned int rate);
-- 
2.30.2

