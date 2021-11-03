Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0BE443A82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 01:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhKCAkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 20:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhKCAkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 20:40:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F11C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 17:37:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so197414pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 17:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wa3NOHCf3U1aur5kRZW335EJTyvo20m6TWpz6Ee93z4=;
        b=qeoNPWCDisFMYbqOExPhP7lwmk3zdmH9O9ZQGvHISlNSlwEAPnqKhXn/cMhVPZv7SV
         51R1D3RjVIXTO/57fsGpBvCUmLuPBbULkyG71KLy2CleqM4T8XPEhx250bxSYw8QrCt9
         qhJ5qrJlqe9V9InnPzX6BYEkXf+ulE2An33dO5RNbczxNQKGnV0pqjxLWz7lhR5WSXXd
         yD3olysYAUME5VL93e2LdmrW4Q/arnkLUaJS8y5cDM54e9h10oAdDnTHOfdwa4FYYnqA
         DHcRRksc5SkYc7CJfMAsrM+CHSWUXglTBw42ZIqcVxwfoe5rKD7hnBWIesSjtDoLWyf7
         bdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wa3NOHCf3U1aur5kRZW335EJTyvo20m6TWpz6Ee93z4=;
        b=C3mmXB8CasDhQ8EbgTPRcI54p/z4UFbIYZk57n/Kv3a1VAmxTTpaMx8iA65z7ufVDS
         UFk6bAyHyOEjjbfZplsixRX1lucYn/shnlg59FiHj2EBm/P7/MxIyW/RrX2rO4GJgyZM
         Q9Vx+uE4+nyISoCn/CCxN9uKeuUGqOt8dgpak30IzVts0Db/mBHoK5X/vXDVtQBk8R6V
         ylD05pnRpXoOxIDK+n/S4t6I7UGNK+uppBcyPD6yXCFxFLvHszvwlberU7yzemDtTB6M
         JpwNJS5uxlWbgK1j7kIsWNTDofHIruFF5oSxEYAOkFcnCnNDKXybOWvR5a3VEkock0y8
         pZ+A==
X-Gm-Message-State: AOAM531/OgKxikNYJ6gqGA+UT0afxhKVcMYVOzGTlPOOJXVx+FKmro7V
        +ZNopIWosOlNn/gk7wA6PA2cyg==
X-Google-Smtp-Source: ABdhPJzkyqxuxEaanIPZ4V895U+b0wUB+nkMnRg4hv4eTHxChiPPXzjJShuyAcaJ+IPNzQtXka8kkw==
X-Received: by 2002:a17:90a:de0d:: with SMTP id m13mr10970746pjv.85.1635899866162;
        Tue, 02 Nov 2021 17:37:46 -0700 (PDT)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id n20sm219159pgc.10.2021.11.02.17.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 17:37:45 -0700 (PDT)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     linux-scsi@vger.kernel.org
Cc:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/2] scsi: scsi_ioctl: Validate command size
Date:   Tue,  2 Nov 2021 17:37:18 -0700
Message-Id: <20211103003719.1041490-1-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to make sure the command size before copying the
command from user.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: James E.J. Bottomley <jejb@linux.ibm.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: <linux-scsi@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <stable@vger.kernel.org> # 5.15, 5.14, 5.10
Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
---
 drivers/scsi/scsi_ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 6ff2207bd45a..58c1f62aca68 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -347,6 +347,8 @@ static int scsi_fill_sghdr_rq(struct scsi_device *sdev, struct request *rq,
 {
 	struct scsi_request *req = scsi_req(rq);
 
+	if (hdr->cmd_len < 6 || hdr->cmd_len > sizeof(req->__cmd))
+		return -EMSGSIZE;
 	if (copy_from_user(req->cmd, hdr->cmdp, hdr->cmd_len))
 		return -EFAULT;
 	if (!scsi_cmd_allowed(req->cmd, mode))
-- 
2.31.1

