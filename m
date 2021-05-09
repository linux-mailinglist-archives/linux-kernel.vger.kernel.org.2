Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49824377719
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 17:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhEIPCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 11:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhEIPCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 11:02:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD62CC061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 08:01:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h20so7915097plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YWggVXdnRquifL9/XQ7A1rwSATVVaZDpBuuzR8KgOIA=;
        b=QyPVlGeznb4Timxlcr3NnZoGOeZsHAk5KhNKlmoslgY+Llmm0GywfkSAxqZAH16aZX
         FROK4h1pm3XJH5AHleAIo5OTVmvEsMWToYsTDIe7oOSWkXzptivogxoHoe/15qnLkE4b
         R/kS7ZCQSeXbNJr1wapSA4T+wBBKMLSmrNwvB0ocXqbxMbJJGkwvEdmMST6K5OZZA5yy
         036tbjurJRIxbj+mSnSHg4VV9KHORIcs3HJwrbVI6NWGdFS4BvoXcenCm6scvxF4BQn0
         RTxDfzG7v/lsjhe1x8omZhXPJG7VTsOBV7Qow0B85WEH6NkdCa6v59thlZCohDHshKjL
         yVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YWggVXdnRquifL9/XQ7A1rwSATVVaZDpBuuzR8KgOIA=;
        b=UpXtULzC1oqSmk+V0pFtVDH758VjMenA31MRgWoMx9MyOVccZ4WpwBEDVaXXgTHjU0
         kwowldnnX6LksmQ0zBw26hLKkCMkFjD2lmhMoreDjWeLKW0h8T8VhaMrWVVKxhEgmXSs
         isIo53SwwIS0lk7su/py1QA84K+czeP7y2LXAI00U7+UvTXifKqMqNJboe91u674adVj
         PUy2+StUZoXcAukwL3ZMumppZBzva50WuB8C3XqxUu0F60T3x9T1JM5lpfu7uEm4aEGv
         kJzjiXd1tGeSfG2IAqDQBvAYlpChKOiJNHi8fny81K6QVwOmw3H/hkp8Xl9jJZBoNb0W
         fCJg==
X-Gm-Message-State: AOAM532PDFZqdJFPoxTu+T3BWNfKGYffSowAjYwsuFbdXRIV2YZyT/HK
        c+0dQ1UD7NTv0/URisLfnUj5DbNxM9Avi8up6vE=
X-Google-Smtp-Source: ABdhPJyQB+aOSYqUog7CKxqOhnUBq8QNYbbYVPBkwY/On1NIFLZgFZVOY9W2205bADdwGieVZdMFXw==
X-Received: by 2002:a17:902:fe94:b029:ee:ba90:a27a with SMTP id x20-20020a170902fe94b02900eeba90a27amr20079450plm.53.1620572462019;
        Sun, 09 May 2021 08:01:02 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id y64sm9201718pfy.204.2021.05.09.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 08:01:01 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] scsi: libsas: Use fallthrough pseudo-keyword
Date:   Sun,  9 May 2021 23:00:52 +0800
Message-Id: <20210509150052.15828-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace /* Fall through */ comment with pseudo-keyword macro fallthrough[1]

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/scsi/libsas/sas_discover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index 9f5068f3bcfb..dd205414e505 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -461,7 +461,7 @@ static void sas_discover_domain(struct work_struct *work)
 		break;
 #else
 		pr_notice("ATA device seen but CONFIG_SCSI_SAS_ATA=N so cannot attach\n");
-		/* Fall through */
+		fallthrough;
 #endif
 		/* Fall through - only for the #else condition above. */
 	default:
-- 
2.25.1

