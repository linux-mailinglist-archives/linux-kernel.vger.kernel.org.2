Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FCD3EDA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbhHPQAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbhHPQAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1663C061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so282926wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iI9Of+nrqdFYRQxURrSca1NN7aev7XNUSsZZAhcpiA4=;
        b=YJBkHvdyYcxV3bzbXTrDm2Na56juDdxf2MWdiTimb8hidhVxvWnr/635fRkmViiKF5
         Z5xks7EV7N035hDXmX5wkXadHXb2cLArIsKRpxzaZ7mfYNjBf6BymavPvaejxylRB38D
         UJFpLTcV8cPesPuGIMxNH0AQSZ8zwuIG6NC/GqZ2q59QC77sZwiA9NqoONA8wAxXOCU1
         EmHcVU5E5lMwp2KMK5zQkmdw9FOhIqrVuIdKLeQphG4yDd5essH9JzULqLtVAqGHhpWH
         Bk3wp+ZQOsvkyMNIKLHENPzHnucEXC3mDHX9iJOs+diG3gHE3fhwm5qZk5wcKkL2SuSt
         e6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iI9Of+nrqdFYRQxURrSca1NN7aev7XNUSsZZAhcpiA4=;
        b=sEG+SqwqY0Q4r1mMQ+cOurybbXNswhug/XbFAwx4rlekm4prD8+iLLiwIhSnyo7/eW
         7RRIiusUeEj7cvt6ADnh2UFbpNwXTG/DDhjkeCHLg+lhvgPJbKSz49bjaw33Xf6NhoL3
         A/OiBTOT2XHe74xsSP6nzj7SmKKNXcQSE4+5G3UXUCT1CvJ3Wc8ne0zdoxbF6yS6Xn7U
         e1H9nWuVSDw47HWS7zkhsqyRH0459T95h1YVz2r3cqpHXf2FdEdQZaqlsETw5XlT+ts5
         iZW/ksQ+10ZfqzW5gpxGqjeHx1InYvPJrpCrM3f8CVeh+UGMQcw0k9ObL6NAUcoRXYE1
         JTrQ==
X-Gm-Message-State: AOAM533Pof+cWu4yinV8zf6oxXewji6Kj2GsAmRfVbNP12UyrhVYlCv9
        TyjOF4JmcIw18dySjWkFpOA=
X-Google-Smtp-Source: ABdhPJx5iu/aYOqIl46Y9AEknTmkEyK0TxSRKNAxIppWK05pLN67xn3clwkJxGvkQY28qL9lQupw/Q==
X-Received: by 2002:a1c:a743:: with SMTP id q64mr15752423wme.74.1629129585362;
        Mon, 16 Aug 2021 08:59:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 22/23] staging: r8188eu: clean up spacing style issues in core/rtw_sta_mgt.c
Date:   Mon, 16 Aug 2021 17:58:17 +0200
Message-Id: <20210816155818.24005-23-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_sta_mgt.c reported by
checkpatch.

WARNING: space prohibited between function name and open parenthesis '('
CHECK: spaces preferred around that '/' (ctx:VxV)
WARNING: space prohibited before semicolon

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index b4568ec1c48a..9628d095a487 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -13,7 +13,7 @@
 static void _rtw_init_stainfo(struct sta_info *psta)
 {
 
-	memset((u8 *)psta, 0, sizeof (struct sta_info));
+	memset((u8 *)psta, 0, sizeof(struct sta_info));
 
 	spin_lock_init(&psta->lock);
 	INIT_LIST_HEAD(&psta->list);
@@ -111,7 +111,7 @@ u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
 
 inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
 {
-	int offset = (((u8 *)sta) - stapriv->pstainfo_buf)/sizeof(struct sta_info);
+	int offset = (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
 
 	if (!stainfo_offset_valid(offset))
 		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
@@ -196,7 +196,7 @@ struct	sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 
 		list_add_tail(&psta->hash_list, phash_list);
 
-		pstapriv->asoc_sta_count++ ;
+		pstapriv->asoc_sta_count++;
 
 		spin_unlock_bh(&pstapriv->sta_hash_lock);
 
-- 
2.32.0

