Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7745B351223
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhDAJX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhDAJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7AC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h10so1129494edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAFBVnxf7LYJNJ2cEtCwdZzp2LZTVZ57HRGj4i0Yfv0=;
        b=H4MRrnzDqU3fQV2tI+vF6k16CJHD8FF0/74qbrP6zydfMR1/PUG07IFbkQUo8xNfDB
         2l+d2KexSMPNKVypK3STC8YyP+SdEZPQKTV5ZTS1AdHhq3AY4gSM6KBAayLStAklVtYF
         yH5BS+msk9ixefkqZ3jcBsTqURYKDl3KSuKQxMoLTgHoSVsHDpZ+TsLkVEMZdmj498qq
         CSDVWuCv2gvzsI35aS+B8z5xsbgWpsRfGshF+q/pujNT36XzWSxqW4MzxxkNYVMzwtGg
         0vTRcM03Z29Y6ovvGm2ATFdbMQnBktfBLmW5SwYci+CQbiDOQ/6oXg9jGeNQtvoSD/GB
         dfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAFBVnxf7LYJNJ2cEtCwdZzp2LZTVZ57HRGj4i0Yfv0=;
        b=R5NosxOnlI+4KP1RAMQrch9Nc/Sr/+hNPSEBYjhr7hhF12WBgDWxEu+2hb3vtZmYVi
         PZM25Z2yzyjL/UEFtZoI8xtgc+znDylq/cm1VFwFuUIKu7LE7rS0s1i1HU6CegwrqHhx
         9jlFIjcpt/nf7lQ/vi7guXxhvugdBKZs3cj5WcWnYW7uuluokHHfzH1TG5x7Vb5RmRGI
         8D2wlo++UWB8c8uS+a/V7GeC4QWQAhxO1HpVudyTZthqOb0mQwMmUwdovkrGONG13uMu
         bF2f6rxBAVER5ZjQxthVyEtFSf8/1XySeXawyf3QFic2XL85fy7Q5dxgNJ4pe3Oq70z0
         HJBw==
X-Gm-Message-State: AOAM532aEgdJT6xnz25Tn57KHsT+oUyX6+A7ExRliQ+ddErEPVFSWSpL
        cCet6WRZTpqvYh2mH+YF/cs=
X-Google-Smtp-Source: ABdhPJxmdTbecwBRCCzKhbZq3vVCYrS5ds2xB6I2Vbqdn0cJrvOLKGhg3EcvpenWujwrzXcjA7DJiw==
X-Received: by 2002:a05:6402:350f:: with SMTP id b15mr8706183edd.6.1617268959655;
        Thu, 01 Apr 2021 02:22:39 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id n6sm2498169eji.37.2021.04.01.02.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 47/49] staging: rtl8723bs: remove RT_TRACE logs in os_dep/osdep_service.c
Date:   Thu,  1 Apr 2021 11:21:17 +0200
Message-Id: <44f37521ea6486b4d95b86fc7acf7391bcf13e51.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 843003b91ea2..7b2aad346d20 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -161,7 +161,6 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
 		ret = register_netdevice(pnetdev);
 
 	if (ret != 0) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("register_netdev() failed\n"));
 		goto error;
 	}
 
-- 
2.20.1

