Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB599441C9A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhKAOaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAOaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:30:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0609AC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 07:27:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z20so65332671edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uPf+iT4fwzI/SoUUxDbRDAYvExd9vocMw0cUgy57Zcc=;
        b=Wp8btRtmJM41T7dOmTx8He6zSn3nMOtBeF3JbWpmcL42yQw/swcdCgwidUoGPdHpe7
         uKR6AvYQI3w0ovKn0yGrzy/8UFn6TVtxnISkktWKB73KTQjsZLYmjUUpFjNvQR0qIwXR
         a8wVwu2Pow7/t0bFDdfTAzjd5Xz9icOYGcnccE7tSfGua2sp9CvwE2qpo9rRPglur53Z
         3S9Oh4O6P4DAlw0gZvrIaJvvBajkCRkFcHmZz8SFWLg5HAffR6gfWs4xbaeMC9Z6W3Wg
         RZqqztClYP6uIPJfKMI9WrOwPhPvAtbIuoZkUpYnQGM6XI90HPIn/PuzEfb60TWxEOpP
         u+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uPf+iT4fwzI/SoUUxDbRDAYvExd9vocMw0cUgy57Zcc=;
        b=CBnuuM30tAu1lRkCsi8fRiPvav9ccSZaaxBTJMHxPkIWlGC8JHYu+d1BBx6/qJYsSs
         lnOxRLc+ndqzWsw2t/rCaDCEhcRvi8iEZtRe9HT6RNT73TjFTEBnrOkUYqYzp7goBO9x
         ITk2uB3Vsr/Q078AQ7huZ7GX9zeA3CgPdHxhFrdoPAtuACN0Q3sNI012RDXqrscgzTBP
         1pul2QTMwGdReNO6Z4TGYGwpl5H8ozhVUu3/VH8fz4/kmyb3GpXZhl/n+/NtLbF8N5gO
         XYArwl3GRsSwQa+hwCoJfC2wx1v1LSSnhVAvv2YPahm5UQtgtEDMxCwaiquxlKZ3rYxX
         ICYg==
X-Gm-Message-State: AOAM532X5gQVEXPaevYsjsyQs+UvD3tZ3dP5RBhwa2o7sQgAG444ubud
        lLk0E0lwlVktYRm8AR0GAq0=
X-Google-Smtp-Source: ABdhPJxgGsMjLYNHKTuzcpEvtW+OHHT5HqunzXh7mRoLUv4Il0LoTlbmmcQU7TDdKh4/N+lJmYo7ag==
X-Received: by 2002:a17:906:a84a:: with SMTP id dx10mr17697421ejb.569.1635776863508;
        Mon, 01 Nov 2021 07:27:43 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-54-101.retail.telecomitalia.it. [79.56.54.101])
        by smtp.gmail.com with ESMTPSA id d3sm4133836edr.0.2021.11.01.07.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:27:43 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in  atomic context
Date:   Mon,  1 Nov 2021 15:27:32 +0100
Message-Id: <20211101142732.5638-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
report_del_sta_event(). This function is called while holding spinlocks,
therefore it is not allowed to sleep. With the GFP_ATOMIC type flag, the
allocation is high priority and must not sleep.

This issue is detected by Smatch which emits the following warning:
"drivers/staging/r8188eu/core/rtw_mlme_ext.c:6848 report_del_sta_event()
warn: sleeping in atomic context".

After the change, the post-commit hook output the following message:
"CHECK: Prefer kzalloc(sizeof(*pcmd_obj)...) over
kzalloc(sizeof(struct cmd_obj)...)".

According to the above "CHECK", use the preferred style in the first
kzalloc().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Fix an overlooked error due to an incorrect copy-paste
	of the sizeof() operator.

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 55c3d4a6faeb..315902682292 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6845,12 +6845,12 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
-	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+	pcmd_obj = kzalloc(sizeof(*pcmd_obj), GFP_ATOMIC);
 	if (!pcmd_obj)
 		return;
 
 	cmdsz = (sizeof(struct stadel_event) + sizeof(struct C2HEvent_Header));
-	pevtcmd = kzalloc(cmdsz, GFP_KERNEL);
+	pevtcmd = kzalloc(cmdsz, GFP_ATOMIC);
 	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
-- 
2.33.1

