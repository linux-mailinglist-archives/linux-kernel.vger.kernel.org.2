Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC0E3A72DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhFOASV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhFOASV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:18:21 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AF9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:16:07 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id if15so10615933qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJQtqjTXQnGdHs9kZE7OUYlBMJLNxudd4m7R2tkcZzY=;
        b=DaDyYut0R3HYxNfPxezGH6YONhxmpNkkLbMJ3/Gv9Slez4nU46Hsu65mKRunVwbzht
         ipa9d+uyUVJga10iQVNJnWk6QndJawNqyLxYbHJADCXNDD+r438XpTJdGBlMi1JkLnpa
         wKBphFMPnTU7M1v+y30WQ6KVtCADbzpiP2wBMfBnOvJvU6Nb6wzZ8hKH5dGEov0SRsuB
         1Kdw2fLjDMzRFGcewxlmMNh9M5bpH0X+HA88W99slWYHa5RhK21HUY3khAtndRonxP2t
         6D1c/0Ul+MttNEdx3+0W/+tP1E8tNlotWdz699YJxzV+ydtygsYgYUfR7dBcvUlMVKWq
         VJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJQtqjTXQnGdHs9kZE7OUYlBMJLNxudd4m7R2tkcZzY=;
        b=DYg9c8RiICiWAnmhh1eDMz90rJZ56jOOr8YfkegbS8XkK9Ly62N4x94iLBq6O7ICjK
         Z1QHora5ItWynioPfY9HJmXvuY6pp7r2mWI+ehhzrpH8BMAqqUhicM9tJkeajh0d781Q
         DVJ6KuDFzYU5g63R9Na+Wu/Beub/GKqDjS/RnZ8YaMXURklZ0FYOnjaJ9jCGNbAbVHB9
         CVSJYOajxTSfdQQA3/UCDN2Nio4AE35m4AeAuykbE8+CtJO/RTvgmDchh6nLqgT2y3mP
         l01aXCBhjtKPeOHLOqUULC/w7/q9G8mZQhaBw4PfzASXV84ySeoEQTQC03oZJiqWGdUf
         /SIQ==
X-Gm-Message-State: AOAM5339a2YDd8aR8mg5JfYvdbZXZ6EeU9LbmrtMdI6r0JIXRyusjtri
        TehTuHy0btGZKQlNzFb27dMlhA==
X-Google-Smtp-Source: ABdhPJxpBbI/D7gkShY1OA4K1TQqFoFg8i3t+XEMqXuR2NlR05Su6yFqI7RK45uo80aJ9Ny8mWiX6w==
X-Received: by 2002:ad4:5426:: with SMTP id g6mr1418723qvt.47.1623716166847;
        Mon, 14 Jun 2021 17:16:06 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:16:06 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 14/28] staging: rtl8188eu: remove all DBG_88E calls from os_dep/mlme_linux.c
Date:   Tue, 15 Jun 2021 01:14:53 +0100
Message-Id: <20210615001507.1171-15-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from os_dep/mlme_linux.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index df53b7d52618..8af58e847afb 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -144,8 +144,6 @@ void rtw_indicate_sta_assoc_event(struct adapter *padapter, struct sta_info *pst
 
 	memcpy(wrqu.addr.sa_data, psta->hwaddr, ETH_ALEN);
 
-	DBG_88E("+%s\n", __func__);
-
 	wireless_send_event(padapter->pnetdev, IWEVREGISTERED, &wrqu, NULL);
 }
 
@@ -167,8 +165,6 @@ void rtw_indicate_sta_disassoc_event(struct adapter *padapter, struct sta_info *
 
 	memcpy(wrqu.addr.sa_data, psta->hwaddr, ETH_ALEN);
 
-	DBG_88E("+%s\n", __func__);
-
 	wireless_send_event(padapter->pnetdev, IWEVEXPIRED, &wrqu, NULL);
 }
 
-- 
2.30.2

