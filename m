Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DF1308478
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 05:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhA2EJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 23:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhA2EJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 23:09:39 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED9DC061574;
        Thu, 28 Jan 2021 20:08:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a14so9082473edu.7;
        Thu, 28 Jan 2021 20:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OZ7PniycqC1RtILMk9WI7xj65U10DcWXv360uL6AeTQ=;
        b=n4HiATxnobZ29zCQVzIZ55f963r/lEssTtXJXv75iOozu2Wb5hmrSnX+TJdvr39P4E
         +WGOrInJeSDpKouSMiisNNhk0bkB3W20/w4RAGQOiPSkbVxiddg7f+8WGfdCdvOwYKUo
         Poa/E29ovMLrUFam5zZqcSokatskxfW2MjrzTmKg8Pidj/xX+vn1dd7obWIr2dEkC5wd
         qwQueiVd3hC6OWWPoNzEWr1G98fEvzPo09XXSRglwgb3Hyrn2QhSwaEt1b6n1ev54Vp2
         09bBNMenlzvdyCnRbhkut/O8b0DlF7cp1Q2FWYVc/moz1rN4JvbkdySLBLy+aIc50N6J
         mH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OZ7PniycqC1RtILMk9WI7xj65U10DcWXv360uL6AeTQ=;
        b=G780u7aUhr32GiMrSvYrKHQYDqxqjSIAAEiCW1WiQWi6sk2sznyXdve/6b5DM39BHU
         gZ5Pi+Z7IKhTESMIkz2fy4ZWSz4Iq2skv7/ArNCgWgX1sCguQoKOq/Pc3IDIGTIXBatY
         c+q4HWFF5e3m13luRr9F4fE/jXhHJEwz6hxWuj5Q+m2tIpOtFYge8EAkywQdMYP83TMJ
         3L/6czuQ2xluzB8U0CJH0nZRvH/E5XbS/+seNyzh2unSGLsqH3sB7KKD6o5y5dVuzy2t
         WvvKYrLCEoaF31G2Zl4g+ZmnHZuS7x0KSPCsWdFw250jt+TDWsjLtVFSZLo7r2IGEjp6
         DiPw==
X-Gm-Message-State: AOAM531D9qn5cR9Fn7ZniwRnmcr9r4EXWkL5Y9sdT2+9EtgBpYK4TqRC
        /vtgGlVnMQKgtgvBWNlYt2g=
X-Google-Smtp-Source: ABdhPJz9OdksQfUHSsaicRgt8qhekpX2Ah4ZzkSCFixcXUzHp22t/f0tEjdrvs0mamy5UNf1gSJmOQ==
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr3036790edd.100.1611893338182;
        Thu, 28 Jan 2021 20:08:58 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d91:2600:859e:aee:ff42:2cc6])
        by smtp.gmail.com with ESMTPSA id bm9sm3218828ejb.14.2021.01.28.20.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 20:08:57 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Nitin Joshi <njoshi1@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: rectify length of title underline
Date:   Fri, 29 Jan 2021 05:08:49 +0100
Message-Id: <20210129040849.26740-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d7cbe2773aed ("platform/x86: thinkpad_acpi: set keyboard language")
adds information on keyboard setting to the thinkpad documentation, but
made the subsection title underline too short.

Hence, make htmldocs warns:

  Documentation/admin-guide/laptops/thinkpad-acpi.rst:1472: \
    WARNING: Title underline too short.

Rectify length of subsection title underline.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210128

Nitin, please ack.

Hans, please pick this minor fixup for your platform/x86 -next tree.

 Documentation/admin-guide/laptops/thinkpad-acpi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
index b1188f05a99a..0e4c5bb7fb70 100644
--- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
+++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
@@ -1469,7 +1469,7 @@ Sysfs notes
 
 
 Setting keyboard language
--------------------
+-------------------------
 
 sysfs: keyboard_lang
 
-- 
2.17.1

