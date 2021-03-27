Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52AD34B8E5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 19:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhC0S3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 14:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhC0S22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 14:28:28 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA06C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 11:28:28 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p133so8776121qka.17
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X45eDZbZ1G5E6KWs205oaawTbgGY1el7OrtpH5YicfE=;
        b=ugBxdy+F95hbZdPyYjmqGeP8SzM+DpBjPRJZcPWXytAsY1k+nz3/8EKi34dAH9WOBg
         23hoCetgwrEkMDIboJ+4+Z4mrYhyyYZxlXvpgKT54j1EKY1sDk9/smndOFswRCIFpTY+
         SZ6ct7ocSEBXCaOmqM/wxEgSvOliAgLLwVdQK+qBOlQSdnyD6ibZc/1S4RuhA8cc5bMV
         vLh+a1vqhaDn+kpaEJ6Zyr/ewdJtTfy4Rq2wvX7CS9kkek4x7jv/NWYNWB0XLm/cQkeW
         G2jQYOOV4sirkaBvtBstS9mrZXpBteQV9Xlra+qmxPsUOIBbuc8ImsV/YTIYhQ1/ZgC9
         czlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X45eDZbZ1G5E6KWs205oaawTbgGY1el7OrtpH5YicfE=;
        b=RJr5V7P8YBpm+SH2+hkWR2bjq/MnGqkfvYHPzV4OIqJwm/o16u8ToZgoNV5iFI4b8W
         CVtwebH8NkxxUY6Oj9r4yF8B+m8MjplHWRcHX/RtTgMc1KYlkRuJYx5jgkZdA3/sW7fY
         oZQtemuNShHcfGJ67zl3OX7DQAsdHf2+x9VRfW+79sLtVUyvQGU3unmFCnE42eAgP/D/
         6v7sh604IAyxPUt1Qo3RIzvEjULlOzRYI9eQbhhoq407U55TrIyWxUOsuY7wXKrAIBCd
         padf8bVOEC+CecMkQTyfpPeGLwHzYnXPXXNIaouwBMARYsdtxZrzbTzjfy/7eMPtuKFE
         XGYQ==
X-Gm-Message-State: AOAM533YobZhK97RAuZxpQ3kSqGKDUetQ9NahhdYbSfvCo/4hxyYXMHf
        GaNlo7peheVZ+2KSxHI6vq1sDTuExMo=
X-Google-Smtp-Source: ABdhPJzFbYU/AO5bbpshyBr3fNe2qpIRy0A3unQtF6tfkrKAfdwwJE+s0kUa34JdIl7oU+m1+xqLYG86Ams=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:493c:e5b:69c:54cb])
 (user=raychi job=sendgmr) by 2002:a05:6214:18d2:: with SMTP id
 cy18mr18945606qvb.50.1616869707507; Sat, 27 Mar 2021 11:28:27 -0700 (PDT)
Date:   Sun, 28 Mar 2021 02:28:09 +0800
In-Reply-To: <20210327182809.1814480-1-raychi@google.com>
Message-Id: <20210327182809.1814480-3-raychi@google.com>
Mime-Version: 1.0
References: <20210327182809.1814480-1-raychi@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 2/2] power: supply: Fix build error when CONFIG_POWER_SUPPLY
 is not enabled.
From:   Ray Chi <raychi@google.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kyletso@google.com, badhri@google.com, Ray Chi <raychi@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build error happens when CONFIG_POWER_SUPPLY is not enabled.

h8300-linux-ld: drivers/usb/dwc3/gadget.o: in function `.L59':
>> gadget.c:(.text+0x655): undefined reference to `power_supply_set_property'

Fixes: 99288de36020 ("usb: dwc3: add an alternate path in vbus_draw callback")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ray Chi <raychi@google.com>
---
 include/linux/power_supply.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 81a55e974feb..b495b4374cd0 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -426,9 +426,16 @@ static inline int power_supply_is_system_supplied(void) { return -ENOSYS; }
 extern int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val);
+#if IS_ENABLED(CONFIG_POWER_SUPPLY)
 extern int power_supply_set_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    const union power_supply_propval *val);
+#else
+static inline int power_supply_set_property(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    const union power_supply_propval *val)
+{ return 0; }
+#endif
 extern int power_supply_property_is_writeable(struct power_supply *psy,
 					enum power_supply_property psp);
 extern void power_supply_external_power_changed(struct power_supply *psy);
-- 
2.31.0.291.g576ba9dcdaf-goog

