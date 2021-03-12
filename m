Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5660833891D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhCLJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhCLJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E057C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l19so3399623wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cAgrlXd2l1LJdhAbUiQiEGzy9+X15djTsbIgtd+mY2I=;
        b=lVMCHULUc5/aA9eGRFFQrjna7vIsiRzLtnqSsoC0NJMHqsv/u8vvcgXmV6Cqq8tRDa
         MHdCbm9U1qbzrGZJhJL3k1zKbbjt/SwoVE91G4peiMCu0bQzrQN0/lzOu7g9leTDUEi5
         a8X/Y3TwSYRE6y1WsHvze5bFHmLgPq5tgSumBnDRe5iSEWaLyjPjhwWld48S/Ddp5iwG
         pBgnAxqhCyeoZB9+R8q2++w0gN2CP8I0ulVZNlJvcoecnG0LoGlV80vFU2P4v9Ped6+4
         ash1+yOFmYD0afs62CoH6VLeKAXPSpbH9+pK54Vyi/SNC08nB+xGwthDnf0hqgNIQMee
         BJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cAgrlXd2l1LJdhAbUiQiEGzy9+X15djTsbIgtd+mY2I=;
        b=P/TmQneeUCh3VYDritW2AB37D2l/z3MBr0esBLWfNkc6dCM3TSXX2qVILhZHuOsgy0
         sipzMG4yi+ovY/nK6naCzE2XsqRX/f7tKvH0pIo95uUKRr7/p/taquEC6u+/KX9ewjzm
         hKNwcJddc3iHxF5/d9fh0YknV7adk7YhGNvhroPO2bXQjg8+lMZJddIKe803PGLO+Ob+
         j94PFuuOAONnSD5CBlRMiVaODRWgGNTTkHL/T5Hv/aBnHT8RtmwYuLaOebdOiWMOZCdB
         MOSwDBlvnqHyYfmx/XqO/eq9avsk5L79ZFez1YRLesaRvgArJYuYWV+EMzIo+gzMDbvy
         W6Sw==
X-Gm-Message-State: AOAM530QSjTht+6goM8YyrLKhaFKyrz8jvp8EXHKf9AMs+M96UUssJHG
        MsxSCuhN++ETMUWhLfmdFRuhy6rFd0lTAQ==
X-Google-Smtp-Source: ABdhPJxtxs+yAdlG3bLdXNsyC/3JEqEfDxibDtPZ2HJjVgqSmtWHsn8Q0+9JVZCgM1P++N0ANZzplg==
X-Received: by 2002:a1c:5416:: with SMTP id i22mr12228165wmb.146.1615542486634;
        Fri, 12 Mar 2021 01:48:06 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Karen Xie <kxie@chelsio.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dimitris Michailidis <dm@chelsio.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 17/30] scsi: cxgbi: cxgb3i: cxgb3i: Fix misnaming of ddp_setup_conn_digest()
Date:   Fri, 12 Mar 2021 09:47:25 +0000
Message-Id: <20210312094738.2207817-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c:1189: warning: expecting prototype for cxgb3i_setup_conn_digest(). Prototype was for ddp_setup_conn_digest() instead

Cc: Karen Xie <kxie@chelsio.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Dimitris Michailidis <dm@chelsio.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
index 37d99357120fa..203f938fca7e5 100644
--- a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
+++ b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
@@ -1177,7 +1177,7 @@ static int ddp_setup_conn_pgidx(struct cxgbi_sock *csk,
 }
 
 /**
- * cxgb3i_setup_conn_digest - setup conn. digest setting
+ * ddp_setup_conn_digest - setup conn. digest setting
  * @csk: cxgb tcp socket
  * @tid: connection id
  * @hcrc: header digest enabled
-- 
2.27.0

