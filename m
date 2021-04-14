Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D601035FA67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhDNSMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhDNSL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:11:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89204C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mh2so11251827ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnExdzfO9je6lLNL7qtvdytBrdvZAdV+P/MA6dcwm/Y=;
        b=LFCnxo/ON6AR8hqk6TYHju9T6QsGLojj9S66l0FpBe1yOYFDfYAEdmRpFZfOz1G9md
         yrBMvBz+XAgb9jcDDWX8Q/kbLrP6jNqiQfqIwBRCkEZ92bMknaf+XIeePDX69SokWijx
         YgLuT2ylOBoS3uAVMreT4LkpvQgCMJvG/ClwaR39l1EYvDd/H9Q6/tZs+wErlKEfgxl1
         j1edSJiutNNNHAMml0362bfMJc6LwWmmGzBSIciLlLqJHPWIaqo/6ea151AeJDZ2X/5j
         gnzotl1RUgEMvnaXOJd7RPeXb3fdhOf1k+aFurpLFxbDffO/AIvqG9wJuz56bByhoWg3
         VP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnExdzfO9je6lLNL7qtvdytBrdvZAdV+P/MA6dcwm/Y=;
        b=WJgXafA856TSP/OdcQnuXqFpRRUZiE8f426ezzxzgdXc6TxL+vlYoBZFn9mEn20LKX
         cZQilygjpWwf0vhUP/Y83aqG4Sm99c97/0nUENW1ItcfWeiatbkJOmV7GNm/Qgmo+EBm
         ynsmTip9kSEbO5/uCDzQa4QS232X33NtUCA0HU5I2CTmuus48iPu0YFcrfbWtfpl16+Z
         3Lb3F9dv2vSpEVCj1HfYqk62pqRcPTkbFhNZQArQPqgiFJdCudN3JWrtF0WEqCLI1Pr2
         j28w9qnpCL8tHw+JdoRy+90tVsyfp8wmkmw00yD1I+tiGKXNUAOn/gQa9i4YYZyDLeC3
         I0Ng==
X-Gm-Message-State: AOAM531O6mheWkCIsRGDFMcmhvPF6VBT0Uvv/Ks0Vsjhm9tJ9bQnWF76
        pLIkkOtkEdqzgB+2g2w5V0o/ZQ==
X-Google-Smtp-Source: ABdhPJztchaXZGy4TYvWXRBUOA/K9lvgspXhAfnCq5NTnCE6kXdkNGxm0ItI1LLoSbdSkmpwXPK4oQ==
X-Received: by 2002:a17:906:3455:: with SMTP id d21mr144104ejb.11.1618423895284;
        Wed, 14 Apr 2021 11:11:35 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Merello <andrea.merello@gmail.com>,
        Jerry chuang <wlanfae@realtek.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 01/57] staging: r8192U_core: Remove unused variable 'ret' and demote kernel-doc abuse
Date:   Wed, 14 Apr 2021 19:10:33 +0100
Message-Id: <20210414181129.1628598-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8192u/r8192U_core.c: In function ‘rtl8192_hard_data_xmit’:
 drivers/staging/rtl8192u/r8192U_core.c:905:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrea Merello <andrea.merello@gmail.com>
Cc: Jerry chuang <wlanfae@realtek.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8192u/r8192U_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index f48186a89fa14..643769e32e433 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -902,7 +902,6 @@ static void rtl8192_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 				   int rate)
 {
 	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
-	int ret;
 	unsigned long flags;
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
 	u8 queue_index = tcb_desc->queue_index;
@@ -915,7 +914,7 @@ static void rtl8192_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 	*(struct net_device **)(skb->cb) = dev;
 	tcb_desc->bTxEnableFwCalcDur = 1;
 	skb_push(skb, priv->ieee80211->tx_headroom);
-	ret = rtl8192_tx(dev, skb);
+	rtl8192_tx(dev, skb);
 
 	spin_unlock_irqrestore(&priv->tx_lock, flags);
 }
@@ -2972,12 +2971,10 @@ static RESET_TYPE RxCheckStuck(struct net_device *dev)
 	return RESET_TYPE_NORESET;
 }
 
-/**
+/*
  * This function is called by Checkforhang to check whether we should
  * ask OS to reset driver
  *
- * \param pAdapter	The adapter context for this miniport
- *
  * Note:NIC with USB interface sholud not call this function because we
  * cannot scan descriptor to judge whether there is tx stuck.
  * Note: This function may be required to be rewrite for Vista OS.
-- 
2.27.0

