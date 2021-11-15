Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520DC4502F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbhKOLCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhKOK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:59:33 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2364EC061208
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so12037596wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u31AxQ7wkDGai2idA8j+UwnpueHVlzsR7IvVcZ1VJbY=;
        b=G+zD7xYhhVWiZ57K/UVe8JKlegvdbnfMUcZD5ALSHHbnLRWd6J0QQfjINPnN4uNYB0
         fHJhPPUpclLAZ7vlxtSqq783fkFQwIIiq0XTI2+g3CvX7+uhstwCvO+Ccfq8KuP4uRKh
         dNuGgW7PK3lJUf7ADjoCrnZJ56eMGoILPENOFZXcfuOS0Zc6wg53ljhyYxLQ/ZJQkpD1
         tQh9dXf5Qfv3o01Kfpbsr9ivV+n+rV+X7e5L5kv3iWGsnMfNuZHsD+3pV5le7YbIi/Ey
         H6HcqEreZ6jAeX7L4JidgAKeculk28zzsZfZyZyFR61YJlWVeQgQfqEhFAHeCHnNtw08
         OFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u31AxQ7wkDGai2idA8j+UwnpueHVlzsR7IvVcZ1VJbY=;
        b=omMeqxE8myZt0+WDWYsopkh9/lXgm8X/C7BZbOeZrtOGRkFZaW0FI1Xvub/r9rqFPl
         2IDJLNWo1/P7SgR1B0Mrlm4hlHKvZnqTNeiRT0fBsrpBbuqho0YuB1175J5VZzJMP8nz
         Uc7MfRgK8aJMV14af9rQazsP9yTgMNzxkkqjh+TxkYCm476e4AU+Zhj5ZLmvbDq5J8p5
         SASG/cRoxxWfmPWAmztoKbeL4duAjqYOPqOU5hfz8exMBHOKbX1hG3FO/GuoxKB5A5iw
         wz6GS7R9X5gm+Y+ppDjYnxdP0tbEnDIB+UELdmgE/eWVYmAggiJl0a1EqbC5cZOtrgdY
         5mDQ==
X-Gm-Message-State: AOAM532O0eX/QzyG7mvmhuxUaQ+ZxKti3JWcLFBUPFn8mPv7+2lZUhzQ
        MJlca/GCI+3arn1p0TQao5Q=
X-Google-Smtp-Source: ABdhPJwo54sc6iKiv1AA+2PdI4g2zpkjzuCeHcLKUgZM/+H7eBuYxSUSUtjfE31HShFGDqbAE4Or1w==
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr41305881wmj.83.1636973788809;
        Mon, 15 Nov 2021 02:56:28 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id d1sm13516532wrz.92.2021.11.15.02.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:56:28 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v3 5/8] staging: vt6655: Rename `RFvWriteWakeProgSyn` function
Date:   Mon, 15 Nov 2021 10:55:46 +0000
Message-Id: <29899f738b4f381a2b3f01fd0748e9b96f835239.1636729147.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1636729147.git.karolinadrobnik@gmail.com>
References: <cover.1636729147.git.karolinadrobnik@gmail.com>
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
index 5246ba211ffb..569b430dd9ae 100644
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

