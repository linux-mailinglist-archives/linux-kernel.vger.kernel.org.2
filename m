Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57236346E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbhCXBBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229836AbhCXBAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616547632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mXD4jkd7wlqRcumQPssXGkKrnP2LYdiCNnEzRMWZEdA=;
        b=iS4JRtSh1g14D7XSS4canEpuUheCUGAisUEkBZpssMnowlGHfsoi0uDLBIZ/ddGRlR2dOj
        WqJuejEut+cjCxXdp2hjMxYWnkgwxOLSOp0vKq9o5WqLtSSqHZIl3PKFfdPrid9xTRLaRg
        uH9ISKESFEEWVMG0cmHE503dildwFLs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-10TDPinhPJG-s9ruo0NwvA-1; Tue, 23 Mar 2021 21:00:30 -0400
X-MC-Unique: 10TDPinhPJG-s9ruo0NwvA-1
Received: by mail-pl1-f199.google.com with SMTP id w10so40296plc.20
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXD4jkd7wlqRcumQPssXGkKrnP2LYdiCNnEzRMWZEdA=;
        b=bKqSc7jznrMaPbk8vxI7tq4QrFxPgh2KgNKDDnweYUA+/ZQPORf0lp8pd8q9V59NrH
         FycAuPMu3HluDoX6+9vczy4BvF6qqPRmQRkjO4L+9eN7VZo+xbvISjAI+3A3JhPLD5h3
         wuMnnh50BR0QCOfcu/12y8np70jYX5Q6Z308Kbl9mLoWL3RLjKMmIt13zyecFcpGED1V
         Y31YQ83ujHC2TUP0GCgZZv6s8ILfZPZlXyGa3VctMOleAMFxOK6iivSURvh5oRBDDOYx
         Ys6TeQxUGfNX7sEEXO38BETuU0ofwpcPr77ath2U+3N49JT68oL/u0WTbXPxDOnBTAoj
         POfg==
X-Gm-Message-State: AOAM531sGtgx/PbYqA8f3ajs+S1z4mb1qB+efPbhh28G/42osVoqRUKT
        Uq3wdlrX74H5jsl1xZJLym+94EjVmCksGwICO5VhvKdmvuSbbeHzfYcnF5qGiKJrMewnd5ni22P
        gPKhOGapaIYUVSakKvndYkJnS
X-Received: by 2002:a65:4288:: with SMTP id j8mr777134pgp.231.1616547629237;
        Tue, 23 Mar 2021 18:00:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWirEo8pQH7hqV/baJawI7VwpC/dAAShVAbbWa8tVTu1Ema0frBwQddALOqOwrEz0+SFjcig==
X-Received: by 2002:a65:4288:: with SMTP id j8mr777116pgp.231.1616547628926;
        Tue, 23 Mar 2021 18:00:28 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x1sm321456pje.40.2021.03.23.18.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:00:28 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     linux-staging@lists.linux.dev
Cc:     Coiby Xu <coiby.xu@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com (supporter:QLOGIC QLGE 10Gb ETHERNET
        DRIVER), Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org (open list:QLOGIC QLGE 10Gb ETHERNET DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] staging: qlge: deal with the case that devlink_health_reporter_create fails
Date:   Wed, 24 Mar 2021 09:00:01 +0800
Message-Id: <20210324010002.109846-1-coxu@redhat.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coiby Xu <coiby.xu@gmail.com>

devlink_health_reporter_create may fail. In that case, do the cleanup
work.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/staging/qlge/qlge_devlink.c | 10 +++++++---
 drivers/staging/qlge/qlge_devlink.h |  2 +-
 drivers/staging/qlge/qlge_main.c    |  8 +++++++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/qlge/qlge_devlink.c b/drivers/staging/qlge/qlge_devlink.c
index 86834d96cebf..0ab02d6d3817 100644
--- a/drivers/staging/qlge/qlge_devlink.c
+++ b/drivers/staging/qlge/qlge_devlink.c
@@ -148,16 +148,20 @@ static const struct devlink_health_reporter_ops qlge_reporter_ops = {
 	.dump = qlge_reporter_coredump,
 };
 
-void qlge_health_create_reporters(struct qlge_adapter *priv)
+long qlge_health_create_reporters(struct qlge_adapter *priv)
 {
 	struct devlink *devlink;
+	long err = 0;
 
 	devlink = priv_to_devlink(priv);
 	priv->reporter =
 		devlink_health_reporter_create(devlink, &qlge_reporter_ops,
 					       0, priv);
-	if (IS_ERR(priv->reporter))
+	if (IS_ERR(priv->reporter)) {
+		err = PTR_ERR(priv->reporter);
 		netdev_warn(priv->ndev,
 			    "Failed to create reporter, err = %ld\n",
-			    PTR_ERR(priv->reporter));
+			    err);
+	}
+	return err;
 }
diff --git a/drivers/staging/qlge/qlge_devlink.h b/drivers/staging/qlge/qlge_devlink.h
index 19078e1ac694..94538e923f2f 100644
--- a/drivers/staging/qlge/qlge_devlink.h
+++ b/drivers/staging/qlge/qlge_devlink.h
@@ -4,6 +4,6 @@
 
 #include <net/devlink.h>
 
-void qlge_health_create_reporters(struct qlge_adapter *priv);
+long qlge_health_create_reporters(struct qlge_adapter *priv);
 
 #endif /* QLGE_DEVLINK_H */
diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index 5516be3af898..59d1ec580696 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -4620,7 +4620,11 @@ static int qlge_probe(struct pci_dev *pdev,
 	if (err)
 		goto netdev_free;
 
-	qlge_health_create_reporters(qdev);
+	err = qlge_health_create_reporters(qdev);
+
+	if (err)
+		goto devlink_unregister;
+
 	/* Start up the timer to trigger EEH if
 	 * the bus goes dead
 	 */
@@ -4632,6 +4636,8 @@ static int qlge_probe(struct pci_dev *pdev,
 	cards_found++;
 	return 0;
 
+devlink_unregister:
+	devlink_unregister(devlink);
 netdev_free:
 	free_netdev(ndev);
 devlink_free:
-- 
2.31.0

