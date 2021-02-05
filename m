Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E47310B4A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhBEMp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhBEMms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:42:48 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEEEC0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 04:42:08 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h16so4771817qth.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 04:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPdHT5qVHokClqjxnwYMrxKV50moL7VSDU0O/jdeoaM=;
        b=Ee4TP4KLDZtCOIEMr7sg+xigoPSBTMO8gdcbWQaPa/4sXRQLdyWbeAa7U8rm859lql
         ghD7WI1nbWZ1rE88ZgKUamr7g408Uhpn9Rmeb4hKq0r0Lk6s8i30g3I8spN/cq+1e2Ii
         +OrJ1nil3LkoFC+ceNPQOoYxCAfn4kCMlW8etKOgscUIQkgurNQ1Aabbgy/b/gSuPw4E
         kVgbb4Lf2Eszg3psct6P4D8oZVOVwQcnn5Y+mCmzP/u2DN66YGVDpN/yKATXvPHMnABM
         qnVscY/td9dfN8TOmNeDOfae2iNqfEq57j/4NMZjQFvGnKkRkX2MXHc9JOuZlkp9fKpZ
         7Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPdHT5qVHokClqjxnwYMrxKV50moL7VSDU0O/jdeoaM=;
        b=Z0QEwmRMd61SVYt/Xs9yzagA2Ma365ytjBewHd93b/3jrItMFzsmVgqA0UuWYoLVsq
         r9hOdQpc5sRwCpuJ9dtvlIPb4HUB9Asxb9V9LeZIWhg6f11Yw1zSWB2fWOvYaqz3DlMd
         eocPuu/16CY89vcuqX9/NsmDETvrGq36ky42Dg49iSAEX232IYsZMQrLbEZqGUrp05Rj
         jKXqSVqUCZMJM17jcDBUFCf5G06bXsfN+WDO4RK8uWDoBHFBbgx5fwij31oZdDBirqs9
         caRm/4dw3dFQQoJ9SrcZPxnGdRUjw8kcn9QJKd+Rampyo9Y531RDZt4+YFTrSH0dCpZ2
         yr3A==
X-Gm-Message-State: AOAM530oB9870VAKx3JoqddqFbfz64oUp7aFrTF2sIrptYiVyQTuB6rz
        LUWrCMmE1b3QSo5pqhxAuTQ=
X-Google-Smtp-Source: ABdhPJzz+lA92PzR/BQJBWs1XArV7VCGbWoxtkaMAi0Y15HQWmKCcBZdL4w2fKOmuJYjFvbsZS9/6w==
X-Received: by 2002:a05:622a:20c:: with SMTP id b12mr4095432qtx.208.1612528927867;
        Fri, 05 Feb 2021 04:42:07 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id y68sm8385707qkb.132.2021.02.05.04.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 04:42:07 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: mtd: Better word replace a not so good word in the file mtd_blkdevs.c
Date:   Fri,  5 Feb 2021 18:11:51 +0530
Message-Id: <20210205124151.1386271-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



s/fucking/invite/


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/mtd/mtd_blkdevs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index fb8e12d590a1..756a0995e474 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -523,7 +523,7 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
 	int ret;

 	/* Register the notifier if/when the first device type is
-	   registered, to prevent the link/init ordering from fucking
+	   registered, to prevent the link/init ordering from invite
 	   us over. */
 	if (!blktrans_notifier.list.next)
 		register_mtd_user(&blktrans_notifier);
--
2.30.0

