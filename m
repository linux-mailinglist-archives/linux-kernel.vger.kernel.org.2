Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6753D8553
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 03:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhG1B2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 21:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbhG1B2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 21:28:54 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA332C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:28:53 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id gg10-20020a056214252ab02902f3a4c41d77so977341qvb.18
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=u18JPqezBuNnCoS9PFQiyHRGpr77MWfIAMC88dhsA70=;
        b=XA/bMzmpJv1aZioF0UgFDElW1oenUyZKbOW5vPa//F0t987N3CN0EOvslHkvH5FptR
         OrUq5E7+2w5riexOS3CMUjCTO8JInrsl5XUxShn623JPAawQJ8OX9AUNve/BLGvBShOR
         9Gw3wJBCutVoSTIx9VZmc49vPfi9bNm3F390QGEwNPhrDCIZaYZ+rCZusATkmhh1PJI5
         fyeE65N4hAS5cJO/O0BPOtDp/7UTO6496KJCQnSQ5gS+Nvv5pcFsejlWZe4ueZhjtLs/
         tvm4Cgs5XW2RnsbiRNFB5tksSGjeXERjV5crXXxsoPfbw2yXIKICB6TVAynhLltCpmEh
         /CjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=u18JPqezBuNnCoS9PFQiyHRGpr77MWfIAMC88dhsA70=;
        b=kL62agCcB5yYlWYYho3ioIMiIyN/I+6Ffag9XB6+hHoJCt1Xte9GhFmdB3zbfmC0ap
         UQLlzdSTXuH1Ugn/EDIsAK7Hd6FTsDEyro5lQ3T7eD3YCRycYgl9PrqH158E+eZ2WspB
         V8hP3FE+Nlppc7vVuOtXPchOyEjYcbiX4KPxcN24QKTfpyDhKa6YthNNwLn0rTptSzqI
         /qPuRpSrvUsb8RbelFbcTkptn8JGWSxF1O/A+7CKeKGb62R6E2S8vTr3Qr0Xcdrd4zVZ
         3YoxDAeIAvfusKBLWZRiDk+L8mwzCjyhK4V/FVmzvLDRwhesmq0BHrc8OkmQ4hGSHUTG
         2moQ==
X-Gm-Message-State: AOAM532Z3pGdOgs7BrPF9Pmnav8Fst8plimm4ZZ58++tvny0WmY3ibcS
        3vRfKBMR1fukBdRI7SET43+U1qsYcqf+pVfUuxaa2Vre/MmFLxxglOYlGSh7FSacKGu72TSSeMZ
        1bV0cWc9on+7ZAaMrGFLpAcz7m863cYgISq1hvX6WaMM5WLTGqvlLONFxOMhtdyoy3KJG1V7x
X-Google-Smtp-Source: ABdhPJzqYH4lNsgQEofBqfJiBYrF4Z233J0dQBMPyZniOgW1YuRo0hZY0OzAqBLU5MovcbytOjsdXCBof3oB
X-Received: from lighttop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2fcb])
 (user=paillon job=sendgmr) by 2002:a05:6214:529e:: with SMTP id
 kj30mr25896914qvb.32.1627435732820; Tue, 27 Jul 2021 18:28:52 -0700 (PDT)
Date:   Tue, 27 Jul 2021 18:27:43 -0700
Message-Id: <20210728012743.1063928-1-paillon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] scsi: ufs: Allow async suspend/resume callbacks
From:   Vincent Palomares <paillon@google.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Vincent Palomares <paillon@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow UFS suspend/resume callbacks to run in parallel with other
suspend/resume callbacks. This can recoup dozens of milliseconds on the
resume path if UFS hardware needs to be powered back on.

Suspending and resuming asynchronously is safe to do so long as the driver
callbacks only depend on resources made available by either a) parent
devices or b) devices explicitly marked as suppliers with device_link_add.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Stanley Chu <stanley.chu@mediatek.com>
Cc: Can Guo <cang@codeaurora.org>
Cc: Asutosh Das <asutoshd@codeaurora.org>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Vincent Palomares <paillon@google.com>
---

Are there any suspend/resume dependencies for UFS drivers not tracked by
the device parent relationship?

drivers/scsi/ufs/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index b87ff68aa9aa..9ec5c308a0ea 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -9625,6 +9625,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	async_schedule(ufshcd_async_scan, hba);
 	ufs_sysfs_add_nodes(hba->dev);
 
+	device_enable_async_suspend(dev);
 	return 0;
 
 free_tmf_queue:
-- 
2.32.0.432.gabb21c7263-goog

