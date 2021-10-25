Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1344398AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhJYOe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhJYOer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:34:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A8EC061348
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v127so10892028wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CN1bzN5gAX0mR9pVVX4XrUmk+ae17sN/41d9NohOKlo=;
        b=H/9Cig8TOUsoag0xHxHxcJ/HsWnggINCOtje/+QkLhac5dV66z44hGoxQnqHUF8AGl
         w7jtIXbazQqtQ2AgdJUfyzNvSWKmTSONasOuqgbg6BcEWnFUB7jRTrR73H4sFEs6FIU4
         P6Nhk/+0B6kmAvbk9/MygP7msalRWELE0s2mM8Gck2Gg/4npsyNM+kYwFJB7dKBqWEpC
         SX0Xgvy7EH/dxbIeEaU8Qg06F33xOrd34INByymtnXHRjU5cGr56y0Yv/YBLQ5OXn6Z/
         QtFMJoVQsDBhDOjh+rtjBP60pZome3FJsJxxeIJOnenDywmDX+0LKDWMymCqiGXAZPWc
         P9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CN1bzN5gAX0mR9pVVX4XrUmk+ae17sN/41d9NohOKlo=;
        b=hmyCdzDRuiSArz+syf+IqAoI2V1XIg0tjvX9BaVAVg9TpCa2e+66KRbyBhR5D/og3S
         U9rVNeyzbhTbIym7/Hj1WiWgt/2pzJI485Fw5RO6rO5UqSJyi2ln8d5k7XEtfA1VDKa9
         WJ+xCXOrHuqy9JE9CfxcvC1NuDICpBjJrGDnJcWWsJ2EOBf/jZdN8jT4ratufE0XpSeU
         e2dZVvrk/Fmf/NEGqjBFa1KZy6xIpmpu+/+eksup0Vh3rgFUcanuXCeJialLeLl1GAtM
         nPrOT1TcK/vDjhIt3w590DjBEAMfu04+9bB4hIqKbYCMyDqa+S87ki9l94BV2TwDE+lH
         Ls5w==
X-Gm-Message-State: AOAM530BL5ZfYEdjLMoJwngKJI0RJ9PqGx9dZb3vM6EjpT1+nNYAmCcn
        lS9wX+xCJDgG/3O18PJtwaE=
X-Google-Smtp-Source: ABdhPJygyqKtnaXeDlxyVcg1MB+e1ms+aU7jU7tx7KOZEI6kEpoFJWE7TuDwpRzzTad7yhAyrMTl+g==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr19798568wmq.54.1635172343529;
        Mon, 25 Oct 2021 07:32:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id x8sm13011500wrr.53.2021.10.25.07.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:32:23 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 6/8] staging: vt6655: Rename `dwAL7230InitTableAMode` array
Date:   Mon, 25 Oct 2021 15:31:32 +0100
Message-Id: <bd97b801861fac2168625c3e4ea1f97b9960e962.1635171519.git.karolinadrobnik@gmail.com>
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
  CHECK: Avoid CamelCase: <dwAL7230InitTableAMode>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index a5c8dc5875eb..d132a21faf24 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -176,7 +176,7 @@ static const unsigned long dwAL7230InitTable[CB_AL7230_INIT_SEQ] = {
 	0x1ABA8F00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW  /* Need modify for 11a: 12BACF */
 };
 
-static const unsigned long dwAL7230InitTableAMode[CB_AL7230_INIT_SEQ] = {
+static const unsigned long al7230_init_table_a_mode[CB_AL7230_INIT_SEQ] = {
 	0x0FF52000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Channel184 // Need modify for 11b/g */
 	0x00000100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Channel184 // Need modify for 11b/g */
 	0x451FE200 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11b/g */
@@ -719,7 +719,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230InitTable[i]);
 		} else {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230InitTableAMode[i]);
+				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_init_table_a_mode[i]);
 		}
 
 		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_channel_table0[channel - 1]);
@@ -923,13 +923,13 @@ bool RFbAL7230SelectChannelPostProcess(struct vnt_private *priv,
 	 */
 	if ((byOldChannel <= CB_MAX_CHANNEL_24G) && (byNewChannel > CB_MAX_CHANNEL_24G)) {
 		/* Change from 2.4G to 5G [Reg] */
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[2]);
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[3]);
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[5]);
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[7]);
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[10]);
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[12]);
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTableAMode[15]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[2]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[3]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[5]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[7]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[10]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[12]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[15]);
 	} else if ((byOldChannel > CB_MAX_CHANNEL_24G) && (byNewChannel <= CB_MAX_CHANNEL_24G)) {
 		/* Change from 5G to 2.4G [Reg] */
 		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[2]);
-- 
2.30.2

