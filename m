Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEBA35B658
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhDKRmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 13:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDKRmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 13:42:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A26C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 10:41:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g5so9774743ejx.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9+q96TK9VMf/Mx9e4OxGt+pQceSuNr0TnGIlmL4TBw=;
        b=SLXnMCA6lSvQ/t3X22xC8QjMk3XgUQWveaJOgAHqeosdtLKAT3sEAh+qTDI4eCw0UP
         EFXK8S0qwufXkGzUOFxzEfrtvrO0Y7C3qWuGIHamFVGHw6PlWtZpKjdcE4y7K+oPC4C3
         7pfvay3HYuNPlTcpq3+2LiJoRbyHKOAvzGI587fTFJT7hq/ctBNrUFMX5qhBmToMlg3R
         hbRUKENMA6wp2SWlPc7ja/OoXKI0LQbctAwyp8DFzPYECNJfhFwWsgy/ytDOS6GtFmBb
         7WxkHhcP1zP6EDArdo/v9DBWUNd2HPWCVrfTQ0Q/MV8IBwKnIzCvdBRjbKFhmCIkEri0
         XYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9+q96TK9VMf/Mx9e4OxGt+pQceSuNr0TnGIlmL4TBw=;
        b=HGVF2FmqEOxaiL09d61OTNMzRhOfplCGl0e/qOvWL5HAnMZlcl17B7D9vvxPcqdlYk
         dwpE/8vUmkCn9RUPv6i2lXWA0VSDlCrfq2UCBkN4Mt8JmMqDMs0BMOzufxD5mHob1JkL
         aKpKOaMT7Kru/JH+9S684xcjUW+LutQU1ZSj+rbx09cygIRRWzqxlo55VUnVXUZelIZg
         R4VCPHBCvH7XlSvCotcIyVEDNIuYLu8JJZqQxQamuCeFybJTlgPMHuBPKf4SX9GhFbPM
         BPZZYi8Ds8iGL96mLDw4gTmKD9Vx0IOfZ5uPMcBpWh47e4w/btG4uVvKkiwJuYHvmYOM
         PAnQ==
X-Gm-Message-State: AOAM533w6vIxtdHn0OHpzmk4SmZdmEfTkgNs0pDy8b/ndErg735aB6Pg
        w7csTTl69FCmhS+/XAuSbUY=
X-Google-Smtp-Source: ABdhPJyz7A2KWzHZwRd8VqW33YQDNERox46F1va+xJ366Hnux8Krn57JQmxEuwEr2r0FPhJjdb5TSg==
X-Received: by 2002:a17:906:c0c8:: with SMTP id bn8mr23728409ejb.445.1618162907860;
        Sun, 11 Apr 2021 10:41:47 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id cy5sm5166359edb.46.2021.04.11.10.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 10:41:47 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] staging: rtl8192u: Remove variable set but not used
Date:   Sun, 11 Apr 2021 19:41:43 +0200
Message-Id: <20210411174143.31618-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable "int ret" which is instantiated but not used.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index f48186a89fa1..30055de66239 100644
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
-- 
2.31.1

