Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A159235FA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352692AbhDNSNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349470AbhDNSMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A61C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g17so24106599edm.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kTlqScRexjxeUZVlgvZgKV7vl/BLWE5sWlAi/z9T+Q=;
        b=UnX1dURuJBfEb8qiyjhM/mtMEpvTY17r/4dIZB6g9PjoXxxZEEJ3E/3HriGhXCGVV/
         LPlnEZknw8PnJuKX6LGQCpvU0MhNQQJUd01Mku5TewRTtKvNRC6q25eRtbkdy9nGVvAu
         K6/gUIzYxnk2/Kmdj5z4FDAI/LKUDMzaIxm0tNzPJMYdMuBWA4gfXFoOmus2ufwG3YdN
         PIDp/2arTT6BEQBSf6VA5232xLCaLf1HCeWDskwuJzA2+ZqExCcluQeGhJ9Y6H4OzQFo
         tt5l8TDPQ257xn8sZBGeyqm2I+GPjZKKff0h4UMhb0fCirTEE/Idumnxrrnzm0JunCI8
         5sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kTlqScRexjxeUZVlgvZgKV7vl/BLWE5sWlAi/z9T+Q=;
        b=GPIRGkL4oreFIVCPrNa3oX0FS761iWa7dNLT6fE4vLk5chrCAGL14WoIOVog6et4Ql
         g8evnCKPOZxB0o8cPfR6NO/TowrPCk343M/zkRvWTWXb7LNsxoirmU0iHYFe1mOn1lR5
         sBXBRv+o60eltGOZJsVgW8s6WF4z5SOiS3yqMcx7pAeHD7q3rwsSXgecsqRvooZdASzy
         pgOEQ/ERVic60KD0/mT4EgxoCoLOq4JhPHmI62K0rkdZos6Jpk/e2HMurN5BzN9ctd8I
         Eq8sUne2MdQZKirwkp0yz//1QiaCH2UYWP3B6xLjMk7R5vgmur3wLzHPm872CxPA+INB
         ZpNw==
X-Gm-Message-State: AOAM530i4n9bFCmQbDsz6Ar0YQRoiJ9+2L0YFELV7448BqLFqdzI1lhl
        tYvotoUz+918ButG3ypoZJsh7w==
X-Google-Smtp-Source: ABdhPJw0i4sbCFot3EhnDxTRytIMAMRuQMtK/zB1BawCSZq+ImOkK0sGSNzD/U1GzoF3XXiOPUff9g==
X-Received: by 2002:a05:6402:b07:: with SMTP id bm7mr207395edb.82.1618423913409;
        Wed, 14 Apr 2021 11:11:53 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 18/57] staging: octeon: ethernet-tx: Fix formatting issue in function header
Date:   Wed, 14 Apr 2021 19:10:50 +0100
Message-Id: <20210414181129.1628598-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/octeon/ethernet-tx.c:507: warning: bad line:

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/octeon/ethernet-tx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index 9c71ad5af7b98..1ad94c5060b52 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -504,7 +504,6 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
  * cvm_oct_xmit_pow - transmit a packet to the POW
  * @skb:    Packet to send
  * @dev:    Device info structure
-
  * Returns Always returns zero
  */
 int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
-- 
2.27.0

