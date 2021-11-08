Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DB3447E52
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhKHK6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbhKHK6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:58:33 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B91C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:55:49 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c8so43957285ede.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 02:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KNfZ6uMilvryu7GOeBols/pZXZY1MA2eNPOG6Jq/4aE=;
        b=U6/HA5p3cWuErRNeCPFky87n13xC42GPv4nrDR0gbY2gmrn+ebDtFFI2KFSqRVA8w9
         sOvpJUlzvyFaqyAHLWTG0d1jO1ESIuUOsmI7Yr0xTa/igyFZyMRi9xzpp6tKBaln5hr1
         +ieS+RiQVx5e4zERv7D2tkbG3bW16i7yinhi/tTZMJmgRNfQmLB4grolMp3/mpgOP59e
         +RL9WS/kJcBUrdGGeN2Fglgh26MUnGI2D56JPKdsxflxQRLjV1Nkcm2QTAUgEXoy4JiT
         T/LLw+EX2OxCQ7jWfmz6P1Itg4cI+DvI5KmtJiWYcxncPb0bAI6aLGma18pyYJ6Kg3Wi
         5omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KNfZ6uMilvryu7GOeBols/pZXZY1MA2eNPOG6Jq/4aE=;
        b=WZcf19qnhKiB5t9CyUVrSVJ32S8kKdWH2wDpcofp6KOUz3LuLH7S0yqXPM0OfMvCXz
         Lg2Ag1BGu6AGafRdM+vJS+i2kXb02LgorcRkrUhK7VF619XIM2eBbuyZOIYrxmIk42aD
         WZtZVZPpFNXsf80zl1L0Wn9VrdnnDsY/G5jIQK33v5N4siTI+Vs4wKT+k/SzoSGRNfhO
         HI+/D1R6tm5Mvs8vj5dWeSs16qxjOPx54D6iLdt/feqW1wC6+535Kde+7iMJnEnHheSd
         9jrctTn0XHRrjmAEeq2eZ3HyoQDl5dH12+Jca05uuDySLixBaYR+XJFQ8O/bbSyhzgUj
         Ydwg==
X-Gm-Message-State: AOAM532xL0j4PdSDsRG2PJT0FeV3UIU4dfj7F/JvJkoesi4o7qZeF80p
        9IWP53/QfsH7LgtY7qLOL9wum1v6GR4=
X-Google-Smtp-Source: ABdhPJw45JqAdv9ir6/uvLoZyLi0420BmFuUQmuzlpYjj5tfePpXzhhGGK88crc5ORPybLmIPd0E1Q==
X-Received: by 2002:a05:6402:10cd:: with SMTP id p13mr106801534edu.111.1636368948149;
        Mon, 08 Nov 2021 02:55:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::38bf])
        by smtp.gmail.com with ESMTPSA id b19sm7747051ejc.107.2021.11.08.02.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 02:55:47 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: use GFP_ATOMIC under spinlock
Date:   Mon,  8 Nov 2021 11:55:37 +0100
Message-Id: <20211108105537.31655-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rtw_report_sec_ie() kzalloc() is called under a spinlock,
so the allocation have to be atomic.

Call tree:

-> rtw_select_and_join_from_scanned_queue() <- takes a spinlock
   -> rtw_joinbss_cmd()
      -> rtw_restruct_sec_ie()
         -> rtw_report_sec_ie()

Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/mlme_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index a9b6ffdbf31a..f7ce724ebf87 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -112,7 +112,7 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 
 	buff = NULL;
 	if (authmode == _WPA_IE_ID_) {
-		buff = kzalloc(IW_CUSTOM_MAX, GFP_KERNEL);
+		buff = kzalloc(IW_CUSTOM_MAX, GFP_ATOMIC);
 		if (!buff)
 			return;
 		p = buff;
-- 
2.33.1

