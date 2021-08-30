Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC51B3FB5D8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhH3MQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbhH3MQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:16:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74004C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso14537714wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HirnwGNf7jyImc4ZKCsenDbRLWYzFjlPI/Sq6s9Xg8=;
        b=UFvBRBSmv4S7/WfQHzjLKHvB9xm1czJJ7wCtAi0G2eBu94+12fvx3bWNl/Y/W0GM5+
         z/gtmQ+N3UWRtSohOLkiJWPW+E4n/V92lIbQqJF2s6aadlULKpCJDAua0xV4jeD06bdO
         2VL3plu7i31ieC2VBBErzkbuMJf9GK+wb3QjcxGSsYdGoprG3YQZDZpxv05uU3a1rTRv
         xCVF+pHOoim8QRhjGohb4qRtR5oswq19D8yo5ywmAxi+Ki0mOOawgaW6+VHp3TOooj+s
         dqVquwbu/Ul1SjEV74YGoAEgbRNH2IPcqCqmdpd99TkDgrab5OfRL2gqmN0b2qO76xKR
         lkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HirnwGNf7jyImc4ZKCsenDbRLWYzFjlPI/Sq6s9Xg8=;
        b=q6M0m394MwO9CZQTiMfz7HFi1t3liHDC56LSDZZSvdbaMFgVtprwiXOjy3qy5m8i2v
         G2/H9kF6pDXE/luxcR/2EyBZK/VAJQ296426HSS04pvxfgBcEmbOgU/lBVnRzc0+mdXU
         gRDFdrh2OLLF3qLN+ef3lMgMVlTuzAbhOVyxFHOkGCLo2241NOyJdyqnlUI5wSWexIat
         xCyN6Z3sBRX5bs1gkyvt7dsaBV88TeTNy7kPWCG9QcPZOvyFvXrGVH76LyP+eevQaZse
         y+IwTTMKAUB9UxNR7NCans0eQUH9xZ924VmuexFDoonzaO48VgI1RLE8OkLtBe3/zAYk
         C5ng==
X-Gm-Message-State: AOAM5337aSKaW9caiPsrI41NF7EUCvLR6mQj/d13J9uc03JSZlbf1f0z
        4wU7VjFDMDWLx3U3AraJC0Y=
X-Google-Smtp-Source: ABdhPJyGecg1TI9i5bdRoPpRqAix6J9TFzwP+pYBLhOXDX/8ukPB+18iFtXB7gNeNTQgI4bsPf2DvQ==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr31638529wmk.172.1630325745115;
        Mon, 30 Aug 2021 05:15:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm15492116wro.83.2021.08.30.05.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:15:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/8] staging: r8188eu: use is_*_ether_addr() in rtw_macaddr_cfg()
Date:   Mon, 30 Aug 2021 14:15:04 +0200
Message-Id: <20210830121508.6411-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830121508.6411-1-straube.linux@gmail.com>
References: <20210830121508.6411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_broadcast_ether_addr() and is_zero_ether_addr() in
rtw_macaddr_cfg(). The buffer is properly aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 205798b76cf9..35a548e1c92e 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1032,10 +1032,7 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 		memcpy(mac, mac_addr, ETH_ALEN);
 	}
 
-	if (((mac[0] == 0xff) && (mac[1] == 0xff) && (mac[2] == 0xff) &&
-	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
-	    ((mac[0] == 0x0) && (mac[1] == 0x0) && (mac[2] == 0x0) &&
-	     (mac[3] == 0x0) && (mac[4] == 0x0) && (mac[5] == 0x0))) {
+	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
 		mac[0] = 0x00;
 		mac[1] = 0xe0;
 		mac[2] = 0x4c;
-- 
2.33.0

