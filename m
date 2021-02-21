Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05BB320A9E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBUNlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhBUNlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:41:44 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B578AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 05:41:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z9so7013001pjl.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 05:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYPWdfQDErM49hDyDe8HZEC/S9QGDrMuKNGM0lXXWH8=;
        b=Lf0ILpNmVGQ1kwXwnOF64u30UufNZRlFj1c7loSM3+NAx2vUV1hdZGkYkl6M+pLWGN
         TJsp+xQPvjbCys+SN9kNQ21zLT/2kyKpwCgv7WfV1na4YjWzwKXJ1szywyHxXudlBXdo
         lf/iupzRWgWTU8p3DQHXhMNbC4V/CFhz0h7gNULQwT+/8e5iDcBYS42WV4bGZQkNumQ6
         c6Z/GQOs1joVicArF74k/QpX23chfxgqE3FR0um49GgaRM51IVW59lfG8VRdGLpig8Qe
         N5YDkAwazjsHLvMQH2yoRfkNc9F5zVELiDHe5QUNul0sOdU4AyfCZqdNxo43RX7bW7BZ
         8AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYPWdfQDErM49hDyDe8HZEC/S9QGDrMuKNGM0lXXWH8=;
        b=oruF5WXbI9d3T+SAcBvE4cvTVYaSuRDjhMhdCTAbgKNvKP4iiIQMwKtQqi2k+IxV8R
         qirO/WVQHPOAF4VEVU+U3gwAIEquXc6gsjTZqm+ATf6ZiMxzs03IICA6dLEp2X4IDftl
         Af90GUkw7ZYxgasX4DkV1DySAe6u01qMcLCdq+0LhiS9v+W4rj1ld1+4HgMa0kht9LMK
         TacALyJstEjbi49iCfxTEcmBnWLjIhhP3BxPOdnbzUqzThTkDTL6lAW0hlmRwQMTRhcq
         g8Fz1dwi87U5luA8Jg4q21L7Gj4Nsib2rZFu8nMxxGdLN05rvNslh4sTKbkVge+yslH+
         LNTw==
X-Gm-Message-State: AOAM532VjZn8/rW3uvZfDddCbAbp5o6x1BXvlnLmknnaUEUaBGv0f/81
        BK42oswgAaKWfwMxV2DUuC4=
X-Google-Smtp-Source: ABdhPJxhQWbxltNb93GnJoFZbBVPCzJSO/5yxELzBDYYwXvkAejsfhQPzZ2V8NK4l5aWLkMBF8BwQw==
X-Received: by 2002:a17:902:b941:b029:e3:1628:97b7 with SMTP id h1-20020a170902b941b02900e3162897b7mr17660892pls.60.1613914863197;
        Sun, 21 Feb 2021 05:41:03 -0800 (PST)
Received: from localhost ([103.106.200.55])
        by smtp.gmail.com with ESMTPSA id w1sm14440356pjq.38.2021.02.21.05.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 05:41:02 -0800 (PST)
From:   Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
To:     gregkh@linuxfoundation.org, lee.jones@linaro.org, kuba@kernel.org,
        johannes@sipsolutions.net, memxor@gmail.com, arnd@arndb.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
Subject: [PATCH v3] staging: wimax: i2400m: add space before open parenthesis
Date:   Sun, 21 Feb 2021 05:39:51 -0800
Message-Id: <20210221133951.21234-1-sssraj.sssraj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220134652.16127-1-sssraj.sssraj@gmail.com>
References: <20210220134652.16127-1-sssraj.sssraj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixing ERROR: space required before the open parenthesis '('

Signed-off-by: Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
---
Changes in v3:
	- Fixed commit message (removed filename).
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

