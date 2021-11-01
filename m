Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90535441AC4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhKALoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhKALoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:44:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8ADC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 04:41:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g10so63104623edj.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1vzz5M91BX0QvpSEDHAoinm2QbwS4lcXb3VFQF+9RUY=;
        b=lFkt+KqdE/clax4K3AsmkijFisYtgScpWdkDzsKkOFtZFkeVvQg5QhyzCtH/wdmaO0
         ZKydlxi+xO2p/Crwgg/YwkYOrVZAg9ffs7f258I9yciN4hJR91VKVrESvf/lht3br0wj
         KXtRYgky6+ODhojVKc72dST5VFDEuWKGqS2IFDX8wiXc653+2oBFek9+Bnd4P0UoOTcN
         tCZxF/iIbnEfnqs7odnHK5UIUceNELRYuHWd2O9gLYPJcTxQj0c2dJBHRFZzk55+VZL+
         sTjQI5CxyBxferELZliMGwgZJSkXJbgdys5bobFZ0wzKdFR6wK4rOK3HhXlPatHC0JWg
         qf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1vzz5M91BX0QvpSEDHAoinm2QbwS4lcXb3VFQF+9RUY=;
        b=JB5IoeFNDKpaIGfAVmf3zsOX1bsIiB/MPdt6rJj/lvm7AcqKlQJuzjo8MvkqdiljUQ
         afqveOinFe4GfPgH/CZ+XNUy7+vn6YreF/wM+6b83e8nu8DriIjVq4wwk3pvZ1PBpuYz
         495zdrlWdJ0uEUrxeR4LWjZ7oii7fWdlWLcKXhoSIqs5uQvK6ZM3AmQivkxcw1uDNbVL
         +igZa3m+KcBZRwF3JJfBZe85EEWeNTyZf3nqjRIZ6E2r04FyOYXb4/gJ13sUIqUEeiJp
         rF31sXPwExYrG/X4VHm7kyBL5jFD69CneTR6TMkZHbUUERCvlC+Lq+z4xWCUlA4DcBgl
         Xe1g==
X-Gm-Message-State: AOAM532A76iKLzK6UgHfFibyqdOBszMObeDx3x16DBygXKuWnOoMwfvZ
        8HdDqgMxFcfnPYYxnzwVR91R84KeJPg=
X-Google-Smtp-Source: ABdhPJw/pBFq99I4VZndRkQeU/UpbiIeOOsB/wkbT0ai/j7TOxgrSBq2/QgIqwMBnD578+Vz/t8Amg==
X-Received: by 2002:a05:6402:4387:: with SMTP id o7mr40257618edc.77.1635766886328;
        Mon, 01 Nov 2021 04:41:26 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-54-101.retail.telecomitalia.it. [79.56.54.101])
        by smtp.gmail.com with ESMTPSA id nb4sm1057600ejc.74.2021.11.01.04.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 04:41:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
Date:   Mon,  1 Nov 2021 12:41:21 +0100
Message-Id: <20211101114121.23865-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the GFP_ATOMIC type flag of kzalloc() with two memory allocation in
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
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 55c3d4a6faeb..3367ec40679d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6845,12 +6845,12 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
-	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+	pcmd_obj = kzalloc(*cmd_obj, GFP_ATOMIC);
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

