Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A6C3454AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhCWBJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhCWBIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:08:52 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213A4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:08:52 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 7so12773044qka.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uVmhqGnsjGsJrmduRvggndhRWp4nQB/gucWOwGEWlgY=;
        b=RaJzkIiK+kyv2JKxuECtZ7H+a1zFXXmKcTbamFIDba3UKrjAUmD7zsQiQYbTAKTyK1
         EDSTiT2hyT1Mepa++PgoyD7kotVFmhy823Nh2eJuvudBxwvlsZi2yZ/XnuITcTFONUMw
         6CDH0+d5rJoLiRZLPSjZlvu+awRmSsL/mjH9ST9MT13bN3eFeB3g3wNInVsuYgbWXLlV
         HLdidqq8LDr6rWM7bymmtm4v5OVlGReA0ALkdVzxxl7bq6pVbhdlHDrKSWp5y/X/jSs4
         FCtwRuPHYQe//VPQlDldWlONua6eseP2mi4bl2tRU93uEolBJKrAiZRQQwrm7NbuCare
         UH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uVmhqGnsjGsJrmduRvggndhRWp4nQB/gucWOwGEWlgY=;
        b=YCqpkxvxRJ1PWxrw2d9c/vzndNH95yOupt/MAFLM6rWpZ7TioBZXrSuiwPpAeURsC1
         uM+lL7Qaa/6GGDhLVEivwoX7/SzMFn6ZZUqahTKRvkA9y7EclSFLOOgipR6HSvUhUQ4d
         g/Itvz7V9UEUCtS6/o5jWJVGtKdI/iCthJ5L9w8zJbQFC8PS3ebO//NCdto6ZNk445aS
         U3d5iWpYPciDC5Ta0RBh8P2HPVhp/hBPE4GKu1OMoz+ClCqZydXGo7K/0DC1Hxaqrna5
         mRQDfHMC8Rv8roiicUYU6MA+9aLC3q81d/4A24yKv9Cbn5jr8qjmEMZOGuE/DKR5B/mI
         2WcQ==
X-Gm-Message-State: AOAM530Pfs5t7jpps2zySZSut+OiWrGCFtYX1b15cWU2Cr8s46HQk4t4
        11VFCsp9AvQBWnvIcOWB4bC1tTbJ9/1jvCs2
X-Google-Smtp-Source: ABdhPJyDbo8xmxYwhGFChaGdt7aO1URHQUC3yWhshdHzxrH8NJQaB1QFTZyXxmeDaQUa3wZI4SfCEg==
X-Received: by 2002:a37:a10a:: with SMTP id k10mr2978573qke.171.1616461731424;
        Mon, 22 Mar 2021 18:08:51 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.117])
        by smtp.gmail.com with ESMTPSA id j13sm3943745qth.57.2021.03.22.18.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 18:08:50 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        yanaijie@huawei.com, matthew.v.deangelis@gmail.com,
        amarjargal16@gmail.com, izabela.bakollari@gmail.com,
        unixbhaskar@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] staging: rtl8723bs: Trivial typo fix
Date:   Tue, 23 Mar 2021 06:38:35 +0530
Message-Id: <20210323010835.4061779-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/netowrk/network/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 2c9425e2a1e9..3888d3984ec0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -599,7 +599,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 		}

 		if (rtw_roam_flags(adapter)) {
-			/* TODO: don't  select netowrk in the same ess as oldest if it's new enough*/
+			/* TODO: don't  select network in the same ess as oldest if it's new enough*/
 		}

 		if (oldest == NULL || time_after(oldest->last_scanned, pnetwork->last_scanned))
--
2.31.0

