Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244343EDE75
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhHPUL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230026AbhHPUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629144654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kVj5qK7AP8LRloafitxHpnELunfwbeT76H+IqksB9Ss=;
        b=NU71HU766f5j4XtxW7+UGUMC0kYBZIOuqsCwm0dUY5hFzyJ+MCmEazMmhz5wc+QNYMecqZ
        FofJvnUaajOzsm6uWtyvCFOWSZXpgQGx1B7W8+GKe1S0W3Q72z8DoTlx0zp8bC8U+CobXA
        Wvd+59DmcH+X8lZgiAHQEunlV/IuGKc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-8l3bCgVHNPSqpkPzFFzd7g-1; Mon, 16 Aug 2021 16:10:53 -0400
X-MC-Unique: 8l3bCgVHNPSqpkPzFFzd7g-1
Received: by mail-qt1-f197.google.com with SMTP id o22-20020ac872d60000b029029817302575so3678909qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVj5qK7AP8LRloafitxHpnELunfwbeT76H+IqksB9Ss=;
        b=k5z5ZPCESFIj56GI70CSEt+fBSRAlgv6wc7tZsx1CNFp5l1xZ5zG1G+Yz5hR4Djjmb
         aGz3OaULNmbKes9EJkV6jARz2Jo31IDunF6eET3xMuEOxnT0or6eH4OECXwSzUNftoTT
         xzUbGacr/rB4s1fEDYron4RriT1FfmSZneGrbIh9nOc9a14ARGfvDfbn5PpxlY5dAl2l
         CUbYFy5w3pceplIZjo0mfFPlLfTdQp0P9t0Q1bBX8jwH+EQu3qOJuw9tKx1r90Pk3OFd
         fDqFNht6GtX4lOwkpn/jxtDed9FufxihmnAiNxncyUvZZZfMGNatg/qCv7B+15rukg5X
         BhAw==
X-Gm-Message-State: AOAM532431Sv8fjzc35RE/ScgJ9I/EJgwt56ZLkuBH3vRF3J1iFy40d1
        jBTRPbIPUy0tWr1d63f4ZR/PGfE5C18+RORKJmdCJ9V1MbZHMzRCrENKnD2bs7BexRrW+GZ9oU1
        oYsqUO3q9Eu58xqhLfR/SaIBJ
X-Received: by 2002:a37:aa17:: with SMTP id t23mr60101qke.209.1629144653110;
        Mon, 16 Aug 2021 13:10:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiEZQdL6YlxZ5FIv8f2rts2pWkuXh1Rm60hORQ24pfTVfjKtsYif3n9Kygu6Ee4XGKFeOVvA==
X-Received: by 2002:a37:aa17:: with SMTP id t23mr60091qke.209.1629144652927;
        Mon, 16 Aug 2021 13:10:52 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k8sm124227qkk.96.2021.08.16.13.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:10:52 -0700 (PDT)
From:   trix@redhat.com
To:     hare@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: myrb: reorder status check of myrb_get_rbld_progress()
Date:   Mon, 16 Aug 2021 13:10:42 -0700
Message-Id: <20210816201042.1294196-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this representative problem
myrb.c:1909: warning: The left operand of '!=' is a garbage value
        if (rbld_buf.ldev_num != sdev->id ||
            ~~~~~~~~~~~~~~~~~ ^

myrb_get_rbld_progress() can return without setting rbld_buf.ldev_num.
Reorder the checks in the if () statement so a failure short circuits
the rbld_buf.ldev_num check.

Fixes: 081ff398c56c ("scsi: myrb: Add Mylex RAID controller (block interface)")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/myrb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index a4a88323e0209..132aec8e51e5b 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1906,8 +1906,8 @@ static ssize_t rebuild_show(struct device *dev,
 
 	status = myrb_get_rbld_progress(cb, &rbld_buf);
 
-	if (rbld_buf.ldev_num != sdev->id ||
-	    status != MYRB_STATUS_SUCCESS)
+	if (status != MYRB_STATUS_SUCCESS ||
+	    rbld_buf.ldev_num != sdev->id)
 		return snprintf(buf, 32, "not rebuilding\n");
 
 	return snprintf(buf, 32, "rebuilding block %u of %u\n",
-- 
2.26.3

