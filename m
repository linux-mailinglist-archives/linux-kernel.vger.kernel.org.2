Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2440400AA4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351124AbhIDJkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 05:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351065AbhIDJkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 05:40:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2893C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 02:39:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so1233384pjt.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 02:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=plYva5hHszvERh5e5dbtWwplKYm4ip7TSv2p3MOtQOE=;
        b=WekawAkPIMwH9SiTHXg0fIPfJ5AA+4tzFsWmBBqY1GowcQCgEi3/pP9JbmAlfrudkj
         MHzJfaBpDPD5zZ+t8YpfTsopDfg3SoNvUGwo9fBAlokQC3VhsUPmkkxw3KbENR0NEGdV
         U2FyyVDfVLZlKt+ZMCWWbFT43nr94yDfbqM23lGY+emAUZXAdPTnrzAU/zhIflBltgYd
         kF/YwkKiSCLtKgrmwUU5qMSDhT/SUztOxzUUU+1dLjBtIY5OR57vnrAIdflQVSSPm/nC
         ucLvtsC0+SHMOzjwsCNHyMJPm9I1asW89f6eS4PhV4v6PL1Vpf4mlu/qDnV1/KxtYaj6
         LIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=plYva5hHszvERh5e5dbtWwplKYm4ip7TSv2p3MOtQOE=;
        b=WQvvqFIYKdkx9A51IO6INi2J71f3vXfptLNmMGSfyZVHTTj+lbnlM9DSx1u5hBFf6F
         dF8jQVtQkz3vvDVd6SsTvS0Yxl7cTtGGLtsKRBjygXi2LBk0OczQfGxIzfXiqBB6U6uQ
         lAfHcCBMTzGmtRyNaH5ehZOjk18R82tUWxNZvYTbwdtTygWePTM1/6JavYNqjHopdTF9
         ANhziCB5QMIbCDvwF0Au9X4HW9vdYzVGWXfCOnOWUOggSH/foifeVgiJ+BGP3X7S93VY
         EgK/mn0MPQGzEmgcPEKKk9x/lVoOS0x7wTIqxhIHK8G4773gXoljBhT1+EXCt9k9tRXy
         ydGA==
X-Gm-Message-State: AOAM533E9NipXGRSirqyq5eCuObx3JqU4sDXiO0Au2MydnI+nS9eUQ6t
        dVPm50jWa642fdR8ywZMGCI=
X-Google-Smtp-Source: ABdhPJzuW5wxNK9ghnYeDDYhnYgqDuo8ge2Jk/t+M6m5fh4W6grNKjdqI40IpAoPkGEpq3ixlvSfmA==
X-Received: by 2002:a17:90b:1d02:: with SMTP id on2mr3468540pjb.204.1630748359223;
        Sat, 04 Sep 2021 02:39:19 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id j17sm1890612pfn.148.2021.09.04.02.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 02:39:18 -0700 (PDT)
Date:   Sat, 4 Sep 2021 15:09:13 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: os_dep: simplifiy the rtw_resume function
Message-ID: <YTM+wayCk2n2CrVP@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable ret and pwrpriv.
Remove the condition with no effect (if == else) in usb_intf.c
file.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index bb85ab77fd26..673cd3001183 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -493,14 +493,8 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 {
 	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
 	struct adapter *padapter = dvobj->if1;
-	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	int ret = 0;

-	if (pwrpriv->bInternalAutoSuspend)
-		ret = rtw_resume_process(padapter);
-	else
-		ret = rtw_resume_process(padapter);
-	return ret;
+	return rtw_resume_process(padapter);
 }

 int rtw_resume_process(struct adapter *padapter)
--
2.32.0

