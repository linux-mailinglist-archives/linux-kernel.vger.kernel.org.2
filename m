Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDE43A8BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFOWia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhFOWiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:38:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FF8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:36:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b205so57833wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tNq1hkaBq71fJWtllv0ekTPqyTFUx2WNRfW/B4flVec=;
        b=cRpfli8rafsnR+XOZiK4XGetJvdhfh385XH/doGVE8g7bjz1KP+ZopCKOUs0X2RZ8j
         06fh5m67bgT97DYuajoTfRAr0zsohDeYEBhzUGSZKqxirl8Bu0HnZO0d9TfIxpeHsMUR
         zj1y2/KLbZz9XWCZBAucNsNM3LwjABJGprJ2Li3wSillVsu5gqjNnmW8OnrzsXJTd5EJ
         Lt0ZGuecn1sjz3WldloVu4T6kOB7YckEUlGhitsO17En1Xw8w5jexGEEqu/kTU3GGoBy
         f4gSp5snoL3AEbk6wP1VSiTrZFhy8YclKTm/IMYsqFgZ09DMUFvxzkwUZX3rlixCOIJC
         bGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tNq1hkaBq71fJWtllv0ekTPqyTFUx2WNRfW/B4flVec=;
        b=N/jeqEIyMVT9O9MeDLovBaEkF1S9+k0/B1br/DU99whnRZO2vAGNBkmxLszaRKL/Mi
         r1FKWWNqdM8LAu3mVNrfW4v8PoxI39cORLWPdmi9aAiU13BuStf2/ohAacJhC4FFHDLK
         paMY/ulKGvykB0xj+WCcc+SUAVDMWYLbICTMmVOuDLtj/2vEmdj8E/JMoNLJBmkay9RX
         fWU8JRKLBbJr+I8Dxd0uUG+1+FIMcgSsMUqnbRselFqHCkTBFOTVJzStbMiUvjwasN42
         cTGfUx8IPg8TEVh5RuXK/OgQvucye9yGUrry13sV26k+VlfRmmI/5LTfHnsOiJpjXMVj
         K52A==
X-Gm-Message-State: AOAM531YHQgkS7PuVzC/ZABVqo45CEwSsv6POvSfWFLsJrqjDeHbFjfQ
        RfP6JhGcDCROdwHQq6ylLVwzpg==
X-Google-Smtp-Source: ABdhPJyed4RT4BFqwWEhS7jfnGc5DNI2kZ/Jexdao47MBEf0CtgdKiOOtySZArYUWEYTuEMbGKKZjg==
X-Received: by 2002:a1c:770b:: with SMTP id t11mr7869410wmi.79.1623796576728;
        Tue, 15 Jun 2021 15:36:16 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id m23sm3934791wml.27.2021.06.15.15.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:36:16 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 5/7] staging: rtl8188eu: remove unused variable from os_dep/ioctl_linux.c
Date:   Tue, 15 Jun 2021 23:36:05 +0100
Message-Id: <20210615223607.13863-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615223607.13863-1-phil@philpotter.co.uk>
References: <20210615223607.13863-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unused variable 'reason' from within the file
os_dep/ioctl_linux.c in the function rtw_wx_set_mlme, as it is
triggering a kernel test robot warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 12f845c17aa5..3b8386245017 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -978,15 +978,12 @@ static int rtw_wx_set_mlme(struct net_device *dev,
 			   union iwreq_data *wrqu, char *extra)
 {
 	int ret = 0;
-	u16 reason;
 	struct adapter *padapter = netdev_priv(dev);
 	struct iw_mlme *mlme = (struct iw_mlme *)extra;
 
 	if (!mlme)
 		return -1;
 
-	reason = mlme->reason_code;
-
 	switch (mlme->cmd) {
 	case IW_MLME_DEAUTH:
 		if (!rtw_set_802_11_disassociate(padapter))
-- 
2.30.2

