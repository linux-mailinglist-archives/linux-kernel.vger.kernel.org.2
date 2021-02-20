Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E673C3204EE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 12:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhBTKtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 05:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTKtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 05:49:04 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 02:48:23 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c11so3545566pfp.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 02:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=27sxJ01JG4xpWs2LBAyPY5QwB2Gx3zDdlzLfkDIVGhU=;
        b=dc+usyKj/aUWIjprXvqwf8GvnAWdOgoAMkpyDKeGaawQebPS5dwGERuoNu7Cw3zfAr
         08DhZXlCfdcbiWDPgn7l/N0P/nxoSjDw5HLzepqxP8W4tH52nHT9IFtuJP1CxMgp4jFg
         SgNV+/9Dlc9of5Nh3qD7PE+1NpyNPj6Zx+faYKcRssuRQHwokYnNt8gIg+7r+5Wb4V/O
         UgyYWpJcmTuFeHn0Q/fpnSJ0tGfys2DIW2CyQ+/Hn0v7ggbUPRDhPn3AYVamn6si9VXD
         r7888l5nuo9f4OoxOwx+talXAGfBzbJlvWL0tSsSq9r1SlCYq/9TfpwJddfJTFfZMaLb
         nmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=27sxJ01JG4xpWs2LBAyPY5QwB2Gx3zDdlzLfkDIVGhU=;
        b=Tw6oshik3RSlKBqYUKAoEacjMbQo4Nl3cvLdlRRcqfShS8wPdAugcGHXQ5FdMLj0Dj
         XrXAFvSTDVe592i4hjSn6AeKthf06jOmHZ4vBpHTKFgtkTINykDkJdNKeSGjeXESWDfo
         0lC51fhBpcYb90rRWuqhk82m/KrtFOU38O4dvVmEdsJ/5bHXd9hVdihtQznHs5IGpyaZ
         LT5tx7prztsGOx5LubTQDH3cBJ9YgP7bUkwLCrpoQa2w2bk2fQvHiO+4DumjT4BiAvEM
         5vNjtGND2XdfF5nNcXGE4h3zIwdG9RYCvWCoX+RUrCGxFEI7TP1CH+W0WlFqQZwT0RrA
         lGLw==
X-Gm-Message-State: AOAM53031xDlmn93mVhc2gVdm8EX5+A4W0IYidqi7mVYiPJBziYvsf1y
        wlmyJ8xhX/uX9mnkuJ5RcUI=
X-Google-Smtp-Source: ABdhPJzIsOeuKDoXE0qwQxclfn7exL0CZHFCtYWuZFm55Kk3xM6PyDwUOuBQfdhH1yNjg1liDzwS+w==
X-Received: by 2002:a62:e315:0:b029:1e6:2f2e:a5e7 with SMTP id g21-20020a62e3150000b02901e62f2ea5e7mr13501341pfh.81.1613818103152;
        Sat, 20 Feb 2021 02:48:23 -0800 (PST)
Received: from localhost ([103.106.200.55])
        by smtp.gmail.com with ESMTPSA id q18sm13857136pfg.72.2021.02.20.02.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 02:48:22 -0800 (PST)
From:   Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
To:     gregkh@linuxfoundation.org, sfr@canb.auug.org.au
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
Subject: [PATCH] staging: wimax: i2400m: add space before open parenthesis
Date:   Sat, 20 Feb 2021 02:48:16 -0800
Message-Id: <20210220104816.13263-1-sssraj.sssraj@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

netdev.c

fixing style ERROR: space required before the open parenthesis '('

Signed-off-by: Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
---
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

