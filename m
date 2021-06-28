Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B0B3B5AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhF1IwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhF1IwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:52:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1315C061574;
        Mon, 28 Jun 2021 01:49:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c7-20020a17090ad907b029016faeeab0ccso12360273pjv.4;
        Mon, 28 Jun 2021 01:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZ1Rz1gXRWLyBZZfCueyrqEMIScQMf1t2w1D89bLOgo=;
        b=rfTw8XaKSHWcqHJxkheAzQ21uJzBLsplbqxEKwnI9qgIgVpYnSZGcYf1B3OYHGQID5
         DEi/AweUbYvOcuf6umV17HOIbgBqL1cUL0tKxcJQemqhB6FElk1IocDYd/ErG6BV6Wlr
         cZG6XSVtS3hmOMGusyRcufUgp7TD7113ElJ3C7mjMw96gmsYsR/ElwcHpEqFiIJvgVzd
         GFcAD+QAEyebHIoXodTC0JEwex282LGKpxIBDozDp0dwrbz6w26CuIR+EVRjuUMXCnfP
         sP35bKT3KL7iwCMuAWY+2VQnPMcbDU7akffhilqSkVjUw2aRnc0+M1jFtuN55iBe/Y2f
         hOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZ1Rz1gXRWLyBZZfCueyrqEMIScQMf1t2w1D89bLOgo=;
        b=qrGzkEYPBdBZSztQyR7rBoc6+VDZvH/KuFqiIG8BK+3yZLNfmle2mVdle6AvKF+Qak
         PTKgYQmFSTdvekDuNdwwcbxwGHRHnMV8iMUmvfNfg79o/WKhMCoP2Hbn5bgsq8H+LGAG
         pJK7X8MMW9wXfIvDCwp7tA0WB1v8zydBtO7kaUEsKQdPxwT4p6nthbDb6Ge17dJIxAXy
         nu0ofUTrm9fFI0luO63U5N08oI4QbG8ZKsrbB5uBvhB2moASHZC9b4wRJE+eOeTp+nno
         KEv0dLJJU1yIyJF2Of+EzquM4yI4ImaaXaHWO5bYUMBLnMTZC17kqYbOh27LqAiFWhP3
         ZTrQ==
X-Gm-Message-State: AOAM531bUXYJVHub0BQdokGi+Z3VTaVuK6Vg2eE6CwGjBOFo74W+vx7k
        GQ9utPzlJuYn5/pGgRCuAMg=
X-Google-Smtp-Source: ABdhPJzf+FJ+FM3ZjovOUDgK4fBx+vzkYpOfwxL7vC868dap89boW8lhRJKU51/MZ4vk5xge9NrzVw==
X-Received: by 2002:a17:90a:ee95:: with SMTP id i21mr6081359pjz.231.1624870186501;
        Mon, 28 Jun 2021 01:49:46 -0700 (PDT)
Received: from localhost.localdomain ([49.207.213.78])
        by smtp.gmail.com with ESMTPSA id u14sm13429397pfk.10.2021.06.28.01.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 01:49:46 -0700 (PDT)
From:   Prasanth KSR <kosigiprasanth@gmail.com>
X-Google-Original-From: Prasanth KSR <prasanth.ksr@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Prasanth KSR <prasanth.ksr@dell.com>,
        Divya Bharathi <divya.bharathi@dell.com>
Subject: [PATCH] platform/x86: dell-wmi-sysman: Change user experience when Admin/System Password is modified
Date:   Mon, 28 Jun 2021 14:19:06 +0530
Message-Id: <20210628084906.4233-1-prasanth.ksr@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever user has changed an Admin/System Password using the sysfs,
then we are automatically copying the new password to existing
password field.

Co-developed-by: Divya Bharathi <divya.bharathi@dell.com>
Signed-off-by: Divya Bharathi <divya.bharathi@dell.com>
Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>
---
 .../x86/dell/dell-wmi-sysman/passwordattr-interface.c         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c b/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
index 339a082d6c18..86ec962aace9 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
@@ -95,9 +95,9 @@ int set_new_password(const char *password_type, const char *new)
 
 	print_hex_dump_bytes("set new password data: ", DUMP_PREFIX_NONE, buffer, buffer_size);
 	ret = call_password_interface(wmi_priv.password_attr_wdev, buffer, buffer_size);
-	/* clear current_password here and use user input from wmi_priv.current_password */
+	/* on success copy the new password to current password */
 	if (!ret)
-		memset(current_password, 0, MAX_BUFF);
+		strscpy(current_password, new, MAX_BUFF);
 	/* explain to user the detailed failure reason */
 	else if (ret == -EOPNOTSUPP)
 		dev_err(&wmi_priv.password_attr_wdev->dev, "admin password must be configured\n");
-- 
2.25.1

