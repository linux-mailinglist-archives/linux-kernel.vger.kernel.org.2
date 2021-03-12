Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7FF338BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCLLom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhCLLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:44:36 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A370C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:44:36 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c6so3470775qtc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWg8A82KvGdxFog2ERysU51pQuJCMumjyKCQKjXfGK8=;
        b=iVIUmPTee8dNR/u7hc+xK/EUItu++ndF4G+djms03C/9dvZnb6wwMXneOIQsuGqo4f
         PUFfmARNQWOGYu3PzolB63AlAqgN1fQN60UZDx0yyPsCr4PTTTUypZaPLb4v0XfiTxay
         GTtgtP+pSQaqKokIgxw8Q383Gu/lcNU+P0Gp4iXwoE6gRZT9tFskqoR1F2jfedrqFSnL
         9rW8CtA4k5wPE3j37xevptfNq3ELB98ROJ1n+PyVXsr0esY5DvxgZZvZ0csnYzafpb11
         pHP5sFdFDW6ZnJeJbnyxgkGB1AXT8i6t3lDCXgHFjcjzIG2u9HIEV58Cg99+49f3d2Rx
         mJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWg8A82KvGdxFog2ERysU51pQuJCMumjyKCQKjXfGK8=;
        b=YvnaZWZnSjlg5LD5RZ8UTOIJBDXwXUl2/8AVCVbku+cPvr1pbXq8YHSWPBfcRQy6J8
         B/yNYTw7p8KdDcuzkwwGaBsy7syQZTt2NuQqS2HBvywn/KtnGHofdxpOPHwo9u/pajmG
         u8TmAMxjWsyebOYvxRE6je9BX+wuOMoRTo8qvnsVNgeSURi6qDsO8LPOSvBq/XpCeJXm
         uo36ev8fOUBZp1ypQ3nk+VGQA0zZTpnMD1YFkJJ0Zz1d+POE6MpICGMK+tL6zwJRstM3
         iZ6JZRVf8k/UB20qrw6uhzu0O8kw2xQtiIbbMj2FJUQvf4uTQcpIfbehETw1Mh8GLmXO
         ulbg==
X-Gm-Message-State: AOAM530kijpClS4QhaeetYY2FOmIgtm5zAAt8fDWVpdcCF6wf9XhGSaU
        N0G02UMl8CXT8sHDZvMqU6Y=
X-Google-Smtp-Source: ABdhPJyfpE7bWmA6t/13Rq22iMMV+mS45mTTpchKuGCz3b3kmzaQb/B+l62ZfbF/uVfUSzSsVGwUpA==
X-Received: by 2002:ac8:5dca:: with SMTP id e10mr10983735qtx.242.1615549475512;
        Fri, 12 Mar 2021 03:44:35 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.63])
        by smtp.gmail.com with ESMTPSA id o7sm3960756qki.63.2021.03.12.03.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:44:34 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, lee.jones@linaro.org,
        kuba@kernel.org, johannes@sipsolutions.net, unixbhaskar@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] staging: wimax: i2400m: Mundane typos fix in the file tx.c
Date:   Fri, 12 Mar 2021 17:12:07 +0530
Message-Id: <20210312114207.3624-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/exahusted/exhausted/
s/caleed/called/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/staging/wimax/i2400m/tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wimax/i2400m/tx.c b/drivers/staging/wimax/i2400m/tx.c
index e9436212fe54..2d15de653951 100644
--- a/drivers/staging/wimax/i2400m/tx.c
+++ b/drivers/staging/wimax/i2400m/tx.c
@@ -85,7 +85,7 @@
  *       can keep adding payloads to it.
  *
  *     Closed: we are not appending more payloads to this TX message
- *       (exahusted space in the queue, too many payloads or
+ *       (exhausted space in the queue, too many payloads or
  *       whichever).  We have appended padding so the whole message
  *       length is aligned to i2400m->bus_tx_block_size (as set by the
  *       bus/transport layer).
@@ -295,7 +295,7 @@ enum {
 /*
  * Calculate how much tail room is available
  *
- * Note the trick here. This path is ONLY caleed for Case A (see
+ * Note the trick here. This path is ONLY called for Case A (see
  * i2400m_tx_fifo_push() below), where we have:
  *
  *       Case A
--
2.26.2

