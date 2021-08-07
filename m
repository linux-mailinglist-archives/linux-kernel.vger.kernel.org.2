Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8643E34BB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhHGKYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhHGKYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:24:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B30C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:23:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mt6so20487718pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X4chUMTcwJeUS2XAVjNjj8/Qn6QKA6HkZgiWU19u+xY=;
        b=W6YwIdwkmVKPQ1BOq/s6Bz3AHrrErWwKYBvGfTpmbrKTk+ZGVQ1saL0ZXVMMJFltu4
         3QBouqBMoJB+KL0TZ597OR8AeDbyqBL07vRFCBIR+4Nmv/lwVin40jI6HaCJ8L+s4oMC
         ZuX96eeRdo/Nx/fRsrgBxLGKoDq1HblbNTq7R0w/8txCloNhL05fJgf3YyWJcCkAW5F4
         NOtrgFbdfJHSCUOakQcDcWBfMnU5X6t0uGWdWKBFrzDT4RN7A5DkWsErL3s7Kowtu26g
         abE1MBtmctOCxnVSUAAo+Asc8iyFdRAaeDIHYUvUEcDs0hK2sPJnsU2QKSUkzKfRsSY9
         hgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4chUMTcwJeUS2XAVjNjj8/Qn6QKA6HkZgiWU19u+xY=;
        b=d+OfyBCMr7P3FjyXwbHu/qRXyBPB+1dCTOMr2XspXtFmwvkteVzfnOFEWrwrJTBN/y
         lPC+Vh189F4re5fhlmGX3zRKiyn+C/xCTl+jl2Q6WOXW25GOyHzOkMntavQGpqtRbhCn
         yqxZWkmLS23caszMx3CDS534UkbKnG/4tv17daFyKQnwwlhojI9cb5j+unz9ENzIgv2y
         nXs6pjx2vEbQ36kfugPqN5iP4z2nBEYYX+8ou10sPtZeol+rMONgY1Rk6JGRAbUpLyYa
         qBKDBYdUQfAvsuM7jYGYSDdRVIxU2XSTJlHdpDqu1b3697REA/l4AjyEMcfTVITmBVzw
         7IMw==
X-Gm-Message-State: AOAM532OkpqsPIsrO1zbYvz6z1cmIDWYs2wyQrI+nmyxXjmNpPx5z6hB
        gW5N7BjY869+vc/73/3h+mI=
X-Google-Smtp-Source: ABdhPJzugLLxupJ/QfUhT7pvb2Y8+ayjMxIEWOnLgvggKuhvh9NhVHvy0EizzCyy4rKNNWEszeVEQw==
X-Received: by 2002:a17:90a:d3d2:: with SMTP id d18mr25884388pjw.102.1628331826200;
        Sat, 07 Aug 2021 03:23:46 -0700 (PDT)
Received: from user.. ([106.212.234.168])
        by smtp.gmail.com with ESMTPSA id d17sm13290717pfn.110.2021.08.07.03.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:23:45 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        saurav.girepunje@gmail.com, insafonov@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, will+git@drnd.me,
        dan.carpenter@oracle.com, apais@linux.microsoft.com,
        yashsri421@gmail.com, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: rtl8188eu: os_dep: Remove unused variable
Date:   Sat,  7 Aug 2021 15:52:29 +0530
Message-Id: <20210807102232.6674-2-saurav.girepunje@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210807102232.6674-1-saurav.girepunje@gmail.com>
References: <20210807102232.6674-1-saurav.girepunje@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable data and data_len from mon_recv_decrypted() in mon.c

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/mon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mon.c b/drivers/staging/rtl8188eu/os_dep/mon.c
index 73b9599fe0dc..7c7cb29ee005 100644
--- a/drivers/staging/rtl8188eu/os_dep/mon.c
+++ b/drivers/staging/rtl8188eu/os_dep/mon.c
@@ -58,8 +58,7 @@ static void mon_recv_decrypted(struct net_device *dev, const u8 *data,
 	netif_rx(skb);
 }
 
-static void mon_recv_encrypted(struct net_device *dev, const u8 *data,
-			       int data_len)
+static void mon_recv_encrypted(struct net_device *dev)
 {
 	if (net_ratelimit())
 		netdev_info(dev, "Encrypted packets are not supported");
@@ -93,7 +92,7 @@ void rtl88eu_mon_recv_hook(struct net_device *dev, struct recv_frame *frame)
 	if (attr->bdecrypted)
 		mon_recv_decrypted(dev, data, data_len, iv_len, icv_len);
 	else
-		mon_recv_encrypted(dev, data, data_len);
+		mon_recv_encrypted(dev);
 }
 
 /**
-- 
2.30.2

