Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1911F43DF07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhJ1Kik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhJ1Kib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:38:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563A3C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:36:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id p14so9262871wrd.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QgAukz7mdLKe7ngRgDotUJonIepfmE0m8F5gQ9CbNhY=;
        b=chBgsfcdjKwZclH5mJf+O52LmQev5S4OPB8RJam/M+za+Wb8MjJxaUI8CGUGPzR5qC
         uIbYu59gxT9jVkwAEN6rAuFXF+1xxg+wxvv9LySoK9gur/l21leKm9SsbJYNeMd4lILT
         IeTsAfsIjcVsHUtLA9+eYaCWFx7ZZ/nhdSIF31KGMjHMmxSj3qETzHCe/NzpFuBa1GkA
         SrSA6Ze6i70RZ7RKSJ0asPZEBgDaoG/QC2f1pDln6cEhrYvAIswFv2BBOXiPrineq+q7
         OrGIR1yTKWF/Ox9IvYggubYuuUdPp7fNxywpkHubsttp48yYxG3LVw89VF9JHQeD1IsZ
         c0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgAukz7mdLKe7ngRgDotUJonIepfmE0m8F5gQ9CbNhY=;
        b=EWW3tJueDtUkdU27uHqD/4VKFpLoHIYM2U0ezT6iKMi+d+oBjTPs3Ph8nTrorqA9EI
         2Gdl0Bo2Jbo+uJ+ZV/K74qmr1l4IHAiQKZ1E+Q/vxhMPfnIVE3EEoQ7USjJHV5/YMvNr
         Sgh29PXwT368rID/gEpKo3KtOrOTQdLOysnhW2gAA1UYDv0XLK/f22GksZ4fcrmQw3OK
         J873u2gXF74qx+37+JGyzD/E3gq5HcXKANnGzsk1oB6kpIjCAtrFcQdC7Ck3dla+wyWz
         ueQn4S8p9A5HEv0gtdv04ZL9uMtYiaJKZ5PS/XzmSX8b2BnVCnNVxd5xe6JiAD0iJldw
         gMBw==
X-Gm-Message-State: AOAM532qmJZ1r2ZrhlNChYZ0VVAAtakekefHlespeCP7lHbxLAutbhwk
        EsJfM2QCd1d0prvM2K8LAd4=
X-Google-Smtp-Source: ABdhPJwaqGXKFMLxHk+MvQZWZsLKEx52jaUig0P0fGq/jzqaXx07c6JEKEX4Lnkiizx39vd7hqcBTA==
X-Received: by 2002:adf:fccc:: with SMTP id f12mr4437635wrs.64.1635417363015;
        Thu, 28 Oct 2021 03:36:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id 13sm3768083wrz.38.2021.10.28.03.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:36:02 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 6/7] staging: vt6655: Rename `RFvWriteWakeProgSyn` function
Date:   Thu, 28 Oct 2021 11:35:36 +0100
Message-Id: <04e7c6a432016e247f9c3f6abd74231bbf4a20da.1635415820.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635415820.git.karolinadrobnik@gmail.com>
References: <cover.1635415820.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To align with the kernel coding style, remove the type from
the function name and do not use CamelCase.

Fix issue detected by checkpatch.pl:
  CHECK: Avoid CamelCase: <RFvWriteWakeProgSyn>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/channel.c | 2 +-
 drivers/staging/vt6655/rf.c      | 4 ++--
 drivers/staging/vt6655/rf.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index b550a1a0844e..e37c8e35a45b 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -189,7 +189,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 
 	/* Init Synthesizer Table */
 	if (priv->bEnablePSMode)
-		RFvWriteWakeProgSyn(priv, priv->byRFType, ch->hw_value);
+		rf_write_wake_prog_syn(priv, priv->byRFType, ch->hw_value);
 
 	bb_software_reset(priv);
 
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index af4eb7eb8e7d..7caac1b44a68 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -676,8 +676,8 @@ bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType,
  * Return Value: None.
  *
  */
-bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
-			 u16 channel)
+bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type,
+			    u16 channel)
 {
 	void __iomem *iobase = priv->port_offset;
 	int i;
diff --git a/drivers/staging/vt6655/rf.h b/drivers/staging/vt6655/rf.h
index 0939937d47a8..9fef81846a9f 100644
--- a/drivers/staging/vt6655/rf.h
+++ b/drivers/staging/vt6655/rf.h
@@ -60,7 +60,7 @@
 bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData);
 bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType, u16 byChannel);
 bool RFbInit(struct vnt_private *priv);
-bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type, u16 channel);
+bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type, u16 channel);
 bool RFbSetPower(struct vnt_private *priv, unsigned int rate, u16 uCH);
 bool RFbRawSetPower(struct vnt_private *priv, unsigned char byPwr,
 		    unsigned int rate);
-- 
2.30.2

