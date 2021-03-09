Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A8F33288C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhCIO00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhCIOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:25:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1397FC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:25:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso2838574pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aCxMTT4chOlmnZ2LoZCszcaK4fN4jjyi9EzefP1rzW8=;
        b=YlZUGxEUx5XSJAPnzSpR/LsttTG3jRuDhGrXT2dlU+EhSIf5rcfO2tJ4eu7TnyDa95
         moFgzbSr+PZivJVGEOJ5X5Iljv/mjnveL4YDbpQak8o82d80SgjcgAtgDFvVQjfiiWRl
         6UyeiN4bNw8j1EqB8oZBNFtpmbnXJ9eZbVRu2cD88XH4VI/Cyb9tFF3+D0qljqkjdjtz
         YlUKqQYm1Z/cXSWATxKrRHyBbWXKvxEZMXcP817QxqONW5wlijyMpNTBKXfkvZM6iacZ
         EtVJejYfiGVWdNPpTVLXxIbf1oju9A3Vi2RIS+Qzv4ynxT/EmnN/rvf3/7jw+FPEsxg/
         tfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aCxMTT4chOlmnZ2LoZCszcaK4fN4jjyi9EzefP1rzW8=;
        b=bBw4fdwhrOl+j+bP/OFwpdG3UYnj3OpZCscoEWxSQFyYUzdjsdgO29oc2z1OalpRpb
         AWL5ZdwpUDYDUC3U+xWbL8IpvurDR/QDOuCWWzPrTb46mj9gOS1beKnGp5BbjRgmrH/1
         lyCjLQrltjPhlUrh+ZDqNU3vrhG7mv0iO63xq0Tvh1KYTFYqj/IUbbEhp1d8NF+hU7U4
         YpVepKrDLz6gOeba9+opDJp04LXqCCF3P2HnO2LIIDFkg1fcyBge2/hzzTCwwAr1H6hx
         Ahco627hCyh774DJMxyazpeB3KQ6TQtMaLnVY4YFvioRJEkNomK2DCCB1pKZKHjCgvIX
         Ki0Q==
X-Gm-Message-State: AOAM5336h+XkoG9StfF/lfoN9dmtS+Nbdx5RiqtcBr3vjpjjvCwmkPpU
        K6g1PycdNUQUk3F4XD6MaiU=
X-Google-Smtp-Source: ABdhPJxVtbJzhq09uTZN1UZbOKBzvkEY8DMMWG14426nWl4oHwSNqe/Agi+9IFZ3ELVZEV2q504uWA==
X-Received: by 2002:a17:90a:6089:: with SMTP id z9mr5043669pji.211.1615299951512;
        Tue, 09 Mar 2021 06:25:51 -0800 (PST)
Received: from localhost.localdomain ([116.73.168.170])
        by smtp.gmail.com with ESMTPSA id j4sm13371831pfa.131.2021.03.09.06.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 06:25:51 -0800 (PST)
From:   Selvakumar Elangovan <selvakumar16197@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: fixed no space coding style issue
Date:   Tue,  9 Mar 2021 19:55:47 +0530
Message-Id: <20210309142547.16974-1-selvakumar16197@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added space around the binary operator for readability in
rtl8712_xmit.h file

Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_xmit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.h b/drivers/staging/rtl8712/rtl8712_xmit.h
index e4c0a4bf8388..5cd651a0de75 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.h
+++ b/drivers/staging/rtl8712/rtl8712_xmit.h
@@ -89,7 +89,7 @@ struct tx_desc {
 
 union txdesc {
 	struct tx_desc txdesc;
-	unsigned int value[TXDESC_SIZE>>2];
+	unsigned int value[TXDESC_SIZE >> 2];
 };
 
 int r8712_xmitframe_complete(struct _adapter *padapter,
-- 
2.17.1

