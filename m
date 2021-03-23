Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A285C346AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhCWVCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbhCWVBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:01:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6994EC061574;
        Tue, 23 Mar 2021 14:01:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso106220wmi.0;
        Tue, 23 Mar 2021 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dl26BKNx8DNxpiYwsjFKzS/TV8T1jYq2tKrn4c6d7Vc=;
        b=vHc0a+1N0Wb045wyuX2p9V5HaKFx7awbvWb6be/RKSpvJWUvNcab+dTN/cx4ZB6K5I
         TVwKzHHDk1CT5EV2R+F+Kr7e/WY57f6emxb5R1ZTsmA/nfxMSxWP8+kZOjBYPjPpLJos
         QYmgYQKvD8p20uWodiIGbnNRxrE7C2bsVDAVtUbJt6GrPfRbZlNOVOdZgHVb6gEPwYn5
         B/miDENkPhedGpOJ2T7xn2iEviejrvISqsgbFmrQPNiUTNyRD2Nizj+yPUsZ+xlJKJst
         XCMgQCBBYNRIK4gfkP5Csp0cqlZot7DtS5DsDP2lgnDQjXomBowJMGLcfDt/LNH9+VWB
         k/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dl26BKNx8DNxpiYwsjFKzS/TV8T1jYq2tKrn4c6d7Vc=;
        b=haYBdCfVDK4nylvzd39iOFh3t4F2hioApBI2iAxqG5/UESlOfTliqHyr/h7qgYbGs0
         oW+fpUAPcL9rTlSmQJ4hQJpxdPEuh9QrEjgax+fa7KLtQsfb552wnb/RS4OJ/O5SuRIG
         eBzxtoyz5y6i/ntLRpoJYm/ccz0Y6FbFl6ksSp+vxW6YmjCjvs5JbOUMYAKLZ7/lRD/U
         tCEJydtU7B1UwyMutO+yFgBjfWut9gZyqwddn+uHDta1bTEQdXTxDec1J19XFaHajlf9
         +lpe1c1EZCWVuCAXtRva94sqqGDOPOVj+xlha6MtlqEmLi87l5o9A6gv9vxzRwc/7eJ5
         994g==
X-Gm-Message-State: AOAM53343u0WNz9bnH9uJOBej3ZTu1L+q8weFxKIQvP35CCI1Ixe9Xph
        Cg369Wz3+oth+JxDrLDxqF0=
X-Google-Smtp-Source: ABdhPJwMjaAPC9k+4+ITAn2yGmPbQI7Dx448+GLZE0st2l4iOesfyxceh+Mg4muGv4viQH1qoh5FOA==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr5069251wma.10.1616533288113;
        Tue, 23 Mar 2021 14:01:28 -0700 (PDT)
Received: from luca020400-laptop-arch.lan ([2001:b07:5d33:19f:ea1f:2342:ea78:219a])
        by smtp.googlemail.com with ESMTPSA id p18sm176637wro.18.2021.03.23.14.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 14:01:27 -0700 (PDT)
From:   Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] platform/x86: asus-wmi: Add param to turn fn-lock mode on by default
Date:   Tue, 23 Mar 2021 22:01:26 +0100
Message-Id: <20210323210126.145286-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210323202505.141496-1-luca.stefani.ge1@gmail.com>
References: <20210323202505.141496-1-luca.stefani.ge1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* On recent ZenBooks the fn-lock is disabled
  by default on boot while running Windows.

* Add a module param ( fnlock_default ) that allows
  changing the default at probe time

Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9ca15f724343..ebaeb7bb80f5 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -47,6 +47,9 @@ MODULE_AUTHOR("Corentin Chary <corentin.chary@gmail.com>, "
 MODULE_DESCRIPTION("Asus Generic WMI Driver");
 MODULE_LICENSE("GPL");
 
+static bool fnlock_default = true;
+module_param(fnlock_default, bool, 0444);
+
 #define to_asus_wmi_driver(pdrv)					\
 	(container_of((pdrv), struct asus_wmi_driver, platform_driver))
 
@@ -2673,7 +2676,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
 
 	if (asus_wmi_has_fnlock_key(asus)) {
-		asus->fnlock_locked = true;
+		asus->fnlock_locked = fnlock_default;
 		asus_wmi_fnlock_update(asus);
 	}
 
-- 
2.31.0

