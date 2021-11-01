Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED9441CAB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhKAOfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhKAOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:35:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EFAC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 07:32:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso8055885wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3fLhd/zK7hWMVh3pZLUrxWGUTbyUHhKbQ2GfpneTlww=;
        b=qNtfMwyJu8u8gcgmxYs1BxeSwmoHGHAm2d6ECgl3x8m48fEZNsy4CB3y4nLqJGwEfp
         eg2ESOqEN2cYsq4fmZ3Dj7tiUJUqwWuBBWoft2DmBFQizRzyOgjIreWQ7oYZQMMIH7+J
         yUEXwjW/xoGNCxTjChwEmsRYYgbPBfEIYlY9SMBj2o9ocibl2bZF7/iGeBgr6do4zXxX
         jZTx+jxMGkDpPe4kBaw6DA9pWdSzN3CmiAuuEtMs/y7nWzn79+m0O2JLbguOWE8W22T7
         O154M5pGKokr50eH1uPoXxRdqg32E/68wpuZPbK23LRnCGeIkYIRzcb5aHtQ0bzN9UHF
         u9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3fLhd/zK7hWMVh3pZLUrxWGUTbyUHhKbQ2GfpneTlww=;
        b=5qlJdguWOsSTkpIapoLfrPM316M0Tqu1sZkBl4vByIxnr/LeaUKbFdC3KDjX4pVlpO
         I1J4/SFWABsx4z0aMe5p+5VodOQg+8hI0yTQHcasBxktrQ9+pBc5HtXCV8nCWcN3Cgj6
         3jPW8PG6WKhKFHw3f5B5dPIKI8zdVCo+4/Oa4Hh4U/bpu5+FGTQXy8/A/WsqfQKzFFjK
         H8uA1lSaXSoZqbmjeBpet40F1BQUBnIo7ROvaOsJHC8WZP0cSFMqDK762DSeQAwEXQeV
         ApcNcAPrzlOXf0do+m5E7Ae+BF4kbvqoW3ikymh238pKo6SQ/qbT0Fsw6ow34OZZ0yRS
         b9TA==
X-Gm-Message-State: AOAM532AhuQGmPm2tNEnMPjQZcRH4r36t30dKo1bXK9sjPzX6swKQKmf
        KZrpwSJTUfRNLGda8bXdx10=
X-Google-Smtp-Source: ABdhPJzgnPCMZFXesUQ71C31nO8ZRVo3rMbSZtqojB5HuaIeWzw+ITfQGB29Sq1yOGEhZ/l+c/RMIg==
X-Received: by 2002:a05:600c:3653:: with SMTP id y19mr12233024wmq.90.1635777147247;
        Mon, 01 Nov 2021 07:32:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id l8sm17157721wry.43.2021.11.01.07.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:32:27 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 5/8] staging: vt6655: Rename `RFvWriteWakeProgSyn` function
Date:   Mon,  1 Nov 2021 14:32:03 +0000
Message-Id: <43108677b74bac35d65798e7bf502010d51c64c3.1635773680.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635773679.git.karolinadrobnik@gmail.com>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
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
index e7672da39a82..34fa54f7a92d 100644
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

