Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157A24398A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhJYOew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhJYOen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:34:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC65C061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y78so5653240wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGtxyy1pN4unr3M65/WvnaFnyZFrXOocHdC+iYb/z6A=;
        b=ag3x72nA4X0o/9gwNUHbCN5j8c3ZYNXAvesojnLHExkVbhtg7fzOLwWEfmSzu0T4s5
         tbl1l55Yax40MhQ+lSOJAEjJOQYMQwSMeRa18BKT2vbHCy1WTACH2AmF07Ut7wGc9IVt
         QAZavIWJ/VWIXG+dUWJrx2grUMERV+coV7G/G5swYNczt+Q+Wwa+bRXVzHzN2FUAZ7o5
         OCaPXgF8nQeHyhDqlYELQ0/ME2sjHasl3F7KD+dBifooUfGRGOsrxgFWROOoURNjjdj2
         7mDeF4p4pks8KR/L+vyXliut7e5+TWBhWzbXNg1gKO66wrQT7nQLXZ6vW/CyT6JKQm5D
         +wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGtxyy1pN4unr3M65/WvnaFnyZFrXOocHdC+iYb/z6A=;
        b=YTLoopKxGZmu3pTr4oQHbJgI6yrsVkH/wkur9vWwKja9jPNKm8cPZ6tOWg5WLlBFQP
         SXwW8vrtaj7r84ZvcTHxNOKRIqvbkIMGC34S87DAzp2zHRBGrcHewa/bXaE6z7MVTLOl
         QjVoiQW71JcyOKemlV3+EDQ92cHvVnQnA0QvYgi23k1dsPLJ8fEP+VIf1kSmRnds7LB6
         3ehy7cpEOcOVDn7xs/rsButuhgfPgDf/Vad9hqWWcWxcTnhnoXm/ldi8slmgkcTj/meS
         0YjAvgjyETBY5J3ocoLV7AV84+puUFNS/wWrsOju0GC3fJxcbks5RVgc4CFf40BrJlHT
         vsrA==
X-Gm-Message-State: AOAM532VhP6+NQFvDL34wDGAgiqFygWaqPWGl0khLcWadwHMU/bTwQDQ
        DP1uEJFSGedl3CT226RisWE=
X-Google-Smtp-Source: ABdhPJyohR8buuc0G0cXcQ6Ukn01SnqQdptZZWTeWKCong3XCecio/xEXTRfBn75UExtsrN7+RgeEg==
X-Received: by 2002:a1c:8002:: with SMTP id b2mr2687618wmd.124.1635172339495;
        Mon, 25 Oct 2021 07:32:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id x8sm13011500wrr.53.2021.10.25.07.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:32:19 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 4/8] staging: vt6655: Rename `dwAL7230ChannelTable1` array
Date:   Mon, 25 Oct 2021 15:31:30 +0100
Message-Id: <bd3e987e975add4a4c1ce6f679d2b0c2b8ff05d9.1635171519.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635171518.git.karolinadrobnik@gmail.com>
References: <cover.1635171518.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To align with the kernel coding style, remove the type from
the variable name and do not use CamelCase.

Fix issue detected by checkpatch.pl:
  CHECK: Avoid CamelCase: <dwAL7230ChannelTable1>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 3235585a67bd..4dac3ad1abbe 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -262,7 +262,7 @@ static const unsigned long al7230_channel_table0[CB_MAX_CHANNEL] = {
 	0x0FF61000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW  /* channel = 165, Tf = 5825MHz (56) */
 };
 
-static const unsigned long dwAL7230ChannelTable1[CB_MAX_CHANNEL] = {
+static const unsigned long al7230_channel_table1[CB_MAX_CHANNEL] = {
 	0x13333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  1, Tf = 2412MHz */
 	0x1B333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  2, Tf = 2417MHz */
 	0x03333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  3, Tf = 2422MHz */
@@ -464,7 +464,7 @@ static bool s_bAL7230SelectChannel(struct vnt_private *priv, unsigned char byCha
 	MACvWordRegBitsOff(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPE3);
 
 	ret &= IFRFbWriteEmbedded(priv, al7230_channel_table0[byChannel - 1]);
-	ret &= IFRFbWriteEmbedded(priv, dwAL7230ChannelTable1[byChannel - 1]);
+	ret &= IFRFbWriteEmbedded(priv, al7230_channel_table1[byChannel - 1]);
 	ret &= IFRFbWriteEmbedded(priv, dwAL7230ChannelTable2[byChannel - 1]);
 
 	/* PLLOn On */
@@ -724,7 +724,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 
 		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_channel_table0[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable1[channel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_channel_table1[channel - 1]);
 		i++;
 		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable2[channel - 1]);
 		break;
-- 
2.30.2

