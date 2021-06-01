Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033BD38FF36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhEYKdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhEYKcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:32:13 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA8FC061358
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:30:15 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id f15-20020a17090aa78fb029015c411f061bso15921063pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y6YaFo9xMSyv5si5BVZOxww4rwo4OSsWWh5xilxnc1g=;
        b=QmCvf6vxSJmUaWr07r2Af0WtkWFbXQSxFR51Ok5fioSUZgOmtzctE/dZ7X8q1KdRmJ
         ATu1C+hF2yXKUKBt0hzYNfKcKXYe5tT8tQFX625um6lPYW/+RxboQHA5Sy4M8II2ElNV
         v+fb16/ZN+sfsFGwRFz8X+wuiB+StUq9rOCpIKsZx8KZhG2+PeVZ9zANkwPFgQYrT5Co
         r9bce3xqn9NO/4lvWH0cJeMk838LS0IrRP34srMl1/m3LXCIqGpUx6A3H1n0fXVUmP/h
         s/FhWd/dhQPYQ133A/FkRhe6DfN5A0uQEsITpsadLBpVc5XV06PywhqSkrrrkZDvxQ5z
         JgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y6YaFo9xMSyv5si5BVZOxww4rwo4OSsWWh5xilxnc1g=;
        b=hdO6F2t1yY9pUZIcgbUH/hwqSDaVMaEKGr+FJx7e58lrYcukROwZ6guCv+Xq8tQTGy
         oZC3zApdeObG2Ye8EN2sql4M/Ioov/2I8BIUiV++tS1/7sg21BZiiGBRkrW0alA6rEBV
         JKjdM+CV+X/81hLg6a3KH3siJ2TvSyZDrZ3yZruIWMprFB+S2bq+/Q0IoGFn8IyEINbd
         SRFm4I6P+mPA+TMVvAkSbKPgfZlpOCjbAkzR2fuCZUfx/OKyXaGeh+P1C0q3iPtT4988
         utugzSprppQ3BtDG+LGIfkRd/1JXjmVZ+LmZWExcQGiDmxEX8gd8ltrFWlNN+5eYHupm
         FnBA==
X-Gm-Message-State: AOAM533fkaJVTRFMgP6vd11a3bOBQZiGX/WYnR2slCRtOWRp82qFAORN
        DbcsTqNNBz+g9plJM9VHammxV+otZJK6
X-Google-Smtp-Source: ABdhPJxAvsMZeTF3Sxy/Sq7R2QI1AMCtxljQX5HNv8dIrJeXEru+uiJB2OkZ0Uw2basdV7EtW/cu1q+pzdRv
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:8806:6b98:8ae6:8824])
 (user=apusaka job=sendgmr) by 2002:a17:90b:90c:: with SMTP id
 bo12mr30044645pjb.10.1621938614725; Tue, 25 May 2021 03:30:14 -0700 (PDT)
Date:   Tue, 25 May 2021 18:29:35 +0800
In-Reply-To: <20210525102941.3958649-1-apusaka@google.com>
Message-Id: <20210525182900.6.Id35872ce1572f18e0792e6f4d70721132e97a480@changeid>
Mime-Version: 1.0
References: <20210525102941.3958649-1-apusaka@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 06/12] Bluetooth: use inclusive language in RFCOMM
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Use "central" and "peripheral".

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

 include/net/bluetooth/rfcomm.h | 2 +-
 net/bluetooth/rfcomm/sock.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 99d26879b02a..6472ec0053b9 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -290,7 +290,7 @@ struct rfcomm_conninfo {
 };
 
 #define RFCOMM_LM	0x03
-#define RFCOMM_LM_MASTER	0x0001
+#define RFCOMM_LM_CENTRAL	0x0001
 #define RFCOMM_LM_AUTH		0x0002
 #define RFCOMM_LM_ENCRYPT	0x0004
 #define RFCOMM_LM_TRUSTED	0x0008
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index ae6f80730561..b02d0e8a7030 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -674,7 +674,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 		if (opt & RFCOMM_LM_SECURE)
 			rfcomm_pi(sk)->sec_level = BT_SECURITY_HIGH;
 
-		rfcomm_pi(sk)->role_switch = (opt & RFCOMM_LM_MASTER);
+		rfcomm_pi(sk)->role_switch = (opt & RFCOMM_LM_CENTRAL);
 		break;
 
 	default:
@@ -794,7 +794,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 		}
 
 		if (rfcomm_pi(sk)->role_switch)
-			opt |= RFCOMM_LM_MASTER;
+			opt |= RFCOMM_LM_CENTRAL;
 
 		if (put_user(opt, (u32 __user *) optval))
 			err = -EFAULT;
-- 
2.31.1.818.g46aad6cb9e-goog

