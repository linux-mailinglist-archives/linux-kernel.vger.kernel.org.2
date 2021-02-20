Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167D7320595
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 14:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhBTNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 08:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhBTNrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 08:47:40 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 05:46:59 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e9so4963535plh.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 05:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuncKa8C7Gvbsww59N/7E5WQogHVX0cQD50aQgpuM4s=;
        b=lhC00UCfipfGQhYiAb6ePsNuvNobif3fZc3QnfdM6cNy3RCSaGXxHVHyp90EsTcxqy
         APiApES0eh1q12T4f8bp6A3H20uMM5q96nsBBv0uv+m964uJh/0ZZx/vNOsg3Jps46IR
         Jml1zrjd8a1rMgWskPRaYgkaOJQ6ATBQ61AtF9n6pv/p38WUgCBhHDlLjlA84V0HOCEK
         ie0oItrFq5U+NgKaaWpj5JeJHWc3NjImy16qD0KmPCLPZJn+Lm++r5zNg38x4ofb3tL2
         ZlK+nkmtY1oE/InEz/uaQw3w6+/LqYbhHq+HfmlagprKzfInAUHZ304vFkr35/GldPma
         65dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuncKa8C7Gvbsww59N/7E5WQogHVX0cQD50aQgpuM4s=;
        b=KZRd1g7ngacidISzu6ar/Qg1N9c2DFWSKyqjpvPKxjCJWhU6aofRKiQz/oQn40vBpr
         oV0sKKJyZglC1glCOqB2b51wGdlOhpKLC5YE+iPCL8lcVD02zHdaXJTjMFf1JV9sB/ic
         q11R5hHY7BMy5nJn9c5rwUh+O9X1jxHEmTxlLMsSMqjDCUNRitYSyWJcpkTrTzuhQb7o
         IYeUfqfuPGZ+Cc21FRYrjKA7u0ATq7AU+nW4vqhY/KY/NGqQQN20HLmygO/EXaE1DpX0
         uoyzmg0AvFK4dr8HIzfEjXKRuvjkuGkbbCN8ulAygwL6ka917HGsxUaJn5i4jUq5un2m
         Dwow==
X-Gm-Message-State: AOAM530mwH5jroyDGVQ1w2OTUFoLImk6wzcm2QrvrwKroZ/hVFtFORYZ
        TmCh4hMgqIwUtDo8jz0O1zI=
X-Google-Smtp-Source: ABdhPJzTKUmKdoiUvNJ25OfQwFhi1G7FDq8tDvEdBcvzCfdwDBrjef+hJzlod9NiU7ca4ads0kaq0A==
X-Received: by 2002:a17:90a:12c5:: with SMTP id b5mr14260985pjg.89.1613828819059;
        Sat, 20 Feb 2021 05:46:59 -0800 (PST)
Received: from localhost ([103.106.200.56])
        by smtp.gmail.com with ESMTPSA id d19sm7216921pjz.0.2021.02.20.05.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 05:46:58 -0800 (PST)
From:   Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
To:     gregkh@linuxfoundation.org, sfr@canb.auug.org.au
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
Subject: [PATCH v2] staging: wimax: i2400m: add space before open parenthesis
Date:   Sat, 20 Feb 2021 05:46:52 -0800
Message-Id: <20210220134652.16127-1-sssraj.sssraj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220104816.13263-1-sssraj.sssraj@gmail.com>
References: <20210220104816.13263-1-sssraj.sssraj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

netdev.c

fixing style ERROR: space required before the open parenthesis '('

Signed-off-by: Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
---
Changes in v2:
	- Removed filename from commit message.

 drivers/staging/wimax/i2400m/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wimax/i2400m/netdev.c b/drivers/staging/wimax/i2400m/netdev.c
index cd06eaf75e8b..5b53e59084c8 100644
--- a/drivers/staging/wimax/i2400m/netdev.c
+++ b/drivers/staging/wimax/i2400m/netdev.c
@@ -523,7 +523,7 @@ void i2400m_net_erx(struct i2400m *i2400m, struct sk_buff *skb,
 
 	d_fnstart(2, dev, "(i2400m %p skb %p [%u] cs %d)\n",
 		  i2400m, skb, skb->len, cs);
-	switch(cs) {
+	switch (cs) {
 	case I2400M_CS_IPV4_0:
 	case I2400M_CS_IPV4:
 		i2400m_rx_fake_eth_header(i2400m->wimax_dev.net_dev,
-- 
2.25.1

