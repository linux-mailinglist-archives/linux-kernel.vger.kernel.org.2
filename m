Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3DD33EC56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCQJMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhCQJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:11:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3F3C061760
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso2949410wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdNAYGEf3HErZd1qMy9Fio2Q6mTHXUXt55dWtvm2uqs=;
        b=KoI4pQgLlCN8e9y0ULjwArxZGVHgE65tgmu+pIBdoAfjkPAL3ETIwM5PA8C8HqEj5i
         OmAmH+Cja8knY9rm+oohq/XjrAyFZ+P1xuNAvAvSKdzq5v+J3O8q0+oj5wxMb1/vtC52
         b7p4uHR6Ba3P7Kg9KGScByrPQh/Hph7zja8aQvLMGzs5ddXwZ2deqKiHCrOGPd/m/6Fp
         KfS1/9KbSe9sH7DaL7l64Vsbx0vsrKX01XDy5vT0eHLLwUPGYI/2wRPHxPehm8RF4l5R
         15LzwLhmvGUw3qQ+FV7JDEJUhJQnfbupA2HA+ivw8zt4lFm83z45Kdw/nrCliL/iMTX2
         6tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdNAYGEf3HErZd1qMy9Fio2Q6mTHXUXt55dWtvm2uqs=;
        b=hal07JJcqPGfvBgZJSByvFor9hIAs4HHG7PgUdnEOpGJaYs4upwwj/tZzgPTOLS4sa
         GTGTc+wmNO6TwttEY5XQJxW4ZrRS9vHwSIPJ7CVvMtFFi8VHDqtP3m6l+z0RsGcrr6d/
         ouToVlJ7Hm/k1fwwn7q0GclkqLEFCGrQ/enNSXJk529Nc12uWb9FMjWsASxFV2F2+02r
         lievakJz/5zFt2z7uSddlIlR+Q6fur/2vleboBYyyJJIJMy0gzu70T3kVeq6ZyVDPLKy
         XURQFVlc6k89Q0B3BlDwqhdkgGdSMjpqQspTCd4plVu1lsE1Yvx4OeVKZ9SyFbGtxjlA
         SJrg==
X-Gm-Message-State: AOAM531/qF4XRzMTtoFfzj92hLsNQoEVzeNYhNE66Cc1ofLWSdqEWLQQ
        pWAOJx/qmrhQNRjZjhgmPme8FQ==
X-Google-Smtp-Source: ABdhPJwKnx+JQa5kLVp55k1jrbwyMuKQk8QBlnUzaKW+0g0lPwZTWljk9O1RUtO4MIuVoV3n8ds4KA==
X-Received: by 2002:a05:600c:3546:: with SMTP id i6mr2682279wmq.104.1615972296229;
        Wed, 17 Mar 2021 02:11:36 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id s83sm1709279wms.16.2021.03.17.02.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:11:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, GOTO Masanori <gotom@debian.or.jp>,
        YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        gotom@debian.org, linux-scsi@vger.kernel.org
Subject: [PATCH 8/8] scsi: nsp32: Correct expected types in debug print formatting
Date:   Wed, 17 Mar 2021 09:11:25 +0000
Message-Id: <20210317091125.2910058-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091125.2910058-1-lee.jones@linaro.org>
References: <20210317091125.2910058-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/nsp32.c: In function ‘nsp32_setup_sg_table’:
 drivers/scsi/nsp32.c:879:6: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘unsigned int’ [-Wformat=]
 drivers/scsi/nsp32.c:280:69: note: in definition of macro ‘nsp32_msg’
 drivers/scsi/nsp32.c:879:52: note: format string is defined here
 drivers/scsi/nsp32.c: In function ‘nsp32_detect’:
 drivers/scsi/nsp32.c:2719:6: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘int’ [-Wformat=]
 drivers/scsi/nsp32.c:280:69: note: in definition of macro ‘nsp32_msg’
 drivers/scsi/nsp32.c:2719:22: note: format string is defined here
 drivers/scsi/nsp32.c:2719:6: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 6 has type ‘int’ [-Wformat=]
 drivers/scsi/nsp32.c:280:69: note: in definition of macro ‘nsp32_msg’
 drivers/scsi/nsp32.c:2719:28: note: format string is defined here
 drivers/scsi/nsp32.c: In function ‘nsp32_suspend’:
 drivers/scsi/nsp32.c:3267:23: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 6 has type ‘pm_message_t’ {aka ‘struct pm_message’} [-Wformat=]
 drivers/scsi/nsp32.c:280:69: note: in definition of macro ‘nsp32_msg’
 drivers/scsi/nsp32.c:3267:56: note: format string is defined here

Cc: GOTO Masanori <gotom@debian.or.jp>
Cc: YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: gotom@debian.org
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/nsp32.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
index 54abda4d07c64..134bbd2d8b667 100644
--- a/drivers/scsi/nsp32.c
+++ b/drivers/scsi/nsp32.c
@@ -876,7 +876,7 @@ static int nsp32_setup_sg_table(struct scsi_cmnd *SCpnt)
 
 			if (le32_to_cpu(sgt[i].len) > 0x10000) {
 				nsp32_msg(KERN_ERR,
-					"can't transfer over 64KB at a time, size=0x%lx", le32_to_cpu(sgt[i].len));
+					"can't transfer over 64KB at a time, size=0x%x", le32_to_cpu(sgt[i].len));
 				return FALSE;
 			}
 			nsp32_dbg(NSP32_DEBUG_SGLIST,
@@ -2716,7 +2716,7 @@ static int nsp32_detect(struct pci_dev *pdev)
 	res = request_region(host->io_port, host->n_io_port, "nsp32");
 	if (res == NULL) {
 		nsp32_msg(KERN_ERR, 
-			  "I/O region 0x%lx+0x%lx is already used",
+			  "I/O region 0x%x+0x%x is already used",
 			  data->BaseAddress, data->NumAddress);
 		goto free_irq;
         }
@@ -3264,7 +3264,8 @@ static int nsp32_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct Scsi_Host *host = pci_get_drvdata(pdev);
 
-	nsp32_msg(KERN_INFO, "pci-suspend: pdev=0x%p, state=%ld, slot=%s, host=0x%p", pdev, state, pci_name(pdev), host);
+	nsp32_msg(KERN_INFO, "pci-suspend: pdev=0x%p, state.event=%x, slot=%s, host=0x%p",
+		  pdev, state.event, pci_name(pdev), host);
 
 	pci_save_state     (pdev);
 	pci_disable_device (pdev);
-- 
2.27.0

