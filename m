Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E62934475A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCVOdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhCVOcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:32:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D4AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e7so19554725edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXtAafHdRgTuu2ScDrS6HUwwTfEuC/19w3Nfd18OE70=;
        b=r7oEeFgTthfv+A3y3mTeOVUHyBwGwY389wSrOoCzC6PmF+hnhNRLss4NrHdaW64eE9
         ewKQ+3dELDs4Lm6IXepvKr6TVxoGTSMSCo0kC+u9DwiLpsye8YrB38L9l8CwPj13AVOF
         eUvTjRJTvbDTdY9Vn+b6nsxvoxS9M+QzrOiIpwSGu+7eNwuqBMH4cXZjtlEJbXuMy/o3
         em6UgqfF75EnOk7m6x/gWpGYUXOKiEGFMwEUK7LHNJHZxrlM4cgFpomr+fu2AiuWxE2M
         9dZBbsiTbBrpSV4a8Zrfs/rXQAmobQT32izjlOBoh4pojznZMQ/yEKHmIG9RwwtdFyTJ
         Ckdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXtAafHdRgTuu2ScDrS6HUwwTfEuC/19w3Nfd18OE70=;
        b=UK/48rK9Yi/nJkrVjxnRxa00h56B8fXxVpOPwef21ivA9UtsHKfy3Vjm3bpOSwC+A2
         HRR6Htr4KR5cbNGtmRDdKIhohKF6pRCNDwBaz/qJX2OEeH9KI1ZlGq96vIb9UMPJn7fF
         NqeeMAqssnKMNktU/QhFSBqAwJRSN6D8+0xVjrJOlHvyOV3jJAwlwa/IACslYjF2mG/P
         wWNb28NLfHwtn/Dz1H9Njz6oe8l9TAOyFft+3GCgJ7ozzFqYfY5QaniYAdafv0iXGihL
         J7rXvYzJ3I/X4ceccLge0JiPTQolQ8leP50TYdgLel1d8JeoZ35p0jMaIZ219H+aEHeS
         vwhQ==
X-Gm-Message-State: AOAM533zJjF7+bGBlRLQ4bcUKq+JKLjtQ5GO20PpitBPF+uNMWo9a5I9
        WgpusP7bqZ4fesaLvcmUEjaPo4ZrMH/0CA==
X-Google-Smtp-Source: ABdhPJxFo6f9hY4ew06xeOxJ+G7Dm1E8o+cHKsguqdv+0dFE90ma2RqIO6hP8dVZtOWoP0Bo6aAJJA==
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr25733143edv.44.1616423557975;
        Mon, 22 Mar 2021 07:32:37 -0700 (PDT)
Received: from agape ([151.57.176.11])
        by smtp.gmail.com with ESMTPSA id hd8sm9578707ejc.92.2021.03.22.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:32:37 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 11/11] staging: rtl8723bs: remove unnecessary extern in os_dep/sdio_intf.c
Date:   Mon, 22 Mar 2021 15:31:49 +0100
Message-Id: <be21175bd3ce666110e507a3e577e1a053700a9c.1616422773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616422773.git.fabioaiuto83@gmail.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary extern.

The function is defined static in os_dep/os_intfs.c and used only once
in the same file

remove also a blank line

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c  | 1 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 3713c62a477c..321f7c45ed95 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1027,7 +1027,6 @@ void rtw_ips_dev_unload(struct adapter *padapter)
 		rtw_hal_deinit(padapter);
 }
 
-
 static int pm_netdev_open(struct net_device *pnetdev, u8 bnormal)
 {
 	int status = -1;
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 185919b6963f..156ad91d33ee 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -482,8 +482,6 @@ static void rtw_dev_remove(struct sdio_func *func)
 	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("-rtw_dev_remove\n"));
 }
 
-extern int pm_netdev_open(struct net_device *pnetdev, u8 bnormal);
-
 static int rtw_sdio_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
-- 
2.20.1

