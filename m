Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13573E4186
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhHIIZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhHIIZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:25:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2413AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 01:24:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so10898050wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 01:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8M4d0Uxz/0+0kMFPkk4zFO2m4csYlGTmBy9HzP7nwc4=;
        b=NwUHzMjoQ5R5F5nGSCfQy+CR6Mbh323wn9co/8+otLrt9OyssZ2/yCQQ3BjkrC5KeX
         7Ok8+86VSe9mw15Q7adCt3V7xIB6wD3xm7Z7CdUCEAiZgYdHQKJYPiuASKhEzcb4GJyI
         EdpJkfIj7ATYUJSjCdbkArd3V9PZilgW6Fn9AMhwDqK8UBmernuxwus+HDPK3Y4LtBJU
         WpyDA6Q8egGhl+M5Vx6T9uKNvk/tclwvVdqyoWXOcaP/WG72g5FtalkT0N6YMAPsXC1Z
         e6mpJ45V2D1rdOmoVQb5Ayc48mgJQSgwPAy5YYXk+eYnhAaejfYC2/KxEcEfVMP1MmCb
         yGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8M4d0Uxz/0+0kMFPkk4zFO2m4csYlGTmBy9HzP7nwc4=;
        b=JYkZSkRRFw8lg0wkQKgd+MhUmLSHJRdzqkhzb3fbvLZo7+gYjWdf2auZy1NhdP711S
         ExJ6A62EtKYPkJD8PNWU7cWi2zae+jgvL9kuEgls5IfTd9FGnsgC0fGmf2qtr/PcasZh
         USB7JqVcYzHaWK001bnln1kWat7iZsNJa9C8V69X3n2EuqjAHzeuF5E0KeP3k5N8b/7p
         lo3B2YSLMk5sekCwq6rsEnZxHCMWxcBdzYdJUJ02Trx8UTW62M3q7booiKoJ2TD1r2VG
         abjNg83hfSUXOUKqSrKXBlaQlX7cwaGCOFMGw89vDAjolGAlam0eXPCy7xQh5137OJys
         ZLZQ==
X-Gm-Message-State: AOAM531Non5Wipw4KLefxPQ233XkGN6OTDHyicmtg+P2T2c4XHc9EnOH
        qIPAWC5Z5JFUQW4TOb4Ta7I+Ug==
X-Google-Smtp-Source: ABdhPJygLJ9rfKmu6JFLWSn90gDdBwp6px0wKMsk/PIlpH8+5DEJxt5ldVd8vgB+ubiXpzETQbhSJg==
X-Received: by 2002:a05:600c:2306:: with SMTP id 6mr15684677wmo.115.1628497480815;
        Mon, 09 Aug 2021 01:24:40 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t15sm18036371wrw.48.2021.08.09.01.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 01:24:40 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        stable@vger.kernel.org
Subject: [RESEND PATCH 1/4] slimbus: messaging: start transaction ids from 1 instead of zero
Date:   Mon,  9 Aug 2021 09:24:25 +0100
Message-Id: <20210809082428.11236-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210809082428.11236-1-srinivas.kandagatla@linaro.org>
References: <20210809082428.11236-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As tid is unsigned its hard to figure out if the tid is valid or
invalid. So Start the transaction ids from 1 instead of zero
so that we could differentiate between a valid tid and invalid tids

This is useful in cases where controller would add a tid for controller
specific transfers.

Fixes: d3062a210930 ("slimbus: messaging: add slim_alloc/free_txn_tid()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index f2b5d347d227..6097ddc43a35 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -66,7 +66,7 @@ int slim_alloc_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	int ret = 0;
 
 	spin_lock_irqsave(&ctrl->txn_lock, flags);
-	ret = idr_alloc_cyclic(&ctrl->tid_idr, txn, 0,
+	ret = idr_alloc_cyclic(&ctrl->tid_idr, txn, 1,
 				SLIM_MAX_TIDS, GFP_ATOMIC);
 	if (ret < 0) {
 		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
-- 
2.21.0

