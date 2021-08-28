Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677313FA4C4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhH1Jck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 05:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhH1Jch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:32:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0F4C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 02:31:47 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q21so5654918plq.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 02:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vRtqy8BGTAIhYSyC7XDIqe1t23R3gBc2YwajuqXH6wI=;
        b=TtuSbONuWqg9lI0GH29gZQ6PTf0mpymCLbmeH2P/RHnwjza7HCnt2yJfPui/PmWQrr
         asSqysk2u6DwyCgwMTK69Bk+ZCL7C1l1mqxim1PKtpj1Vzb5iFdmRVk6OXn6q+q/c8ea
         Magh13MuYbltvbOZjySOutGHFMLC3LrNp4YwbjONbPZuqtEOlNXmLyXN2lmG1/SJWN+S
         iVnDobKPcvBcI1rtVa5scMkyB++3BE33c8uBchMdzIsPCtafzbGpvRer1r5mA2edRUk3
         jcv6tCfUPkHWwmVB1H0O5oZa8q+Adv0KhS+AzVIe/iVL2DOtX6Q44RuAJKZ24YTAmZ/h
         FOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vRtqy8BGTAIhYSyC7XDIqe1t23R3gBc2YwajuqXH6wI=;
        b=q9BkusJVsHtgAdqQcdmvGRusX4u3aMxZF6jFXAwLSxiceNe4orig/Yljiu8KFLqkeK
         j06LjxHwxsps5ESFcUFcrPG6sLR9pmiXJK04+sNEa1JyZV7xbv3Ps5PP/1BTry+U2jyG
         QB36IQIuWn819Zertz7KbO6sV7ee9YlhHGrbRRYnKJBOuYI3yrEEZImjprUk60OIDUZm
         4rHyFG/2ccIGqiP63SNvve4+R1UbxuDKOoBODFmzk4GjdKL5kfAe891KJIxf+BAMvgSj
         01ugwa8OYmX0yrDyRs1Ot6JGX2Z54ux93zhHII5ktXPG6SCOQ+9MU+giuLONYVpUbyWp
         gAUA==
X-Gm-Message-State: AOAM531lL/TTRyrsb9AHVOlCmOInm7ljg8ayXf43AYBlneAX8AKnOu1h
        TyOa06yRinq6ln5u6PQQxN8=
X-Google-Smtp-Source: ABdhPJxcEqbJpmoRtT6Zd7CYUJUbyFfwJOdMeovxGOhUbTIw57dHZZj5SbbYPlZwiwdyfunjadVF/g==
X-Received: by 2002:a17:90a:3cc6:: with SMTP id k6mr15321469pjd.134.1630143106789;
        Sat, 28 Aug 2021 02:31:46 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id j2sm8540385pfe.201.2021.08.28.02.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 02:31:46 -0700 (PDT)
Date:   Sat, 28 Aug 2021 15:01:41 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        nathan@kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu :os_dep: remove condition with no effect
Message-ID: <YSoCfTaR66C6iJFw@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the condition with no effect (if == else) in usb_intf.c
file.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index bb85ab77fd26..849563b54727 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -496,10 +496,8 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 	int ret = 0;

-	if (pwrpriv->bInternalAutoSuspend)
-		ret = rtw_resume_process(padapter);
-	else
-		ret = rtw_resume_process(padapter);
+	ret = rtw_resume_process(padapter);
+
 	return ret;
 }

--
2.32.0

