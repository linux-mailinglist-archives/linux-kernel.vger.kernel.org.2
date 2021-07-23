Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0193D30FF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhGWADC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhGWACJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:02:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E43C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:42:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l11-20020a7bc34b0000b029021f84fcaf75so2556322wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VM6rjy1k2Y/qSvUlDobugVK975Hy7Un538yc0+q4TZ8=;
        b=e6Si8DsxxOMG689N1nQV3P6MflMkRiQvOe0CE3DNbha/Y9t0MIRelIjvEu/SnYMhY3
         kOKmbhJfw0EnTzUaDPDMvvkXyVmp+QABu1Z6iEpdgvVqv6soUJgMTSLnWkPVZgd+mutx
         /1QQBgd1AyhbLRCTVruI5cLalJgCZMgabLKzPp2AvFTbMq/8Fu7TbAKyoTtueqy56TXR
         lKaabuAugO+FDuxM0dKJlZn+/m2DM/q7oH0Lp46YyDt1IU7PPkEPpXa14MdMNugQ5H1t
         J0CH5JJoTAB90LOHjzP2Z9xzNcxB9XxYx0dxoUE+2uFbEJ2LyMaaJvEM9sBMWj+ab3NW
         mA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VM6rjy1k2Y/qSvUlDobugVK975Hy7Un538yc0+q4TZ8=;
        b=X3h1B7qgidZQcpqH19DkJDzG64y8ZbteH4EfA7C6lDrH07ZPvmWJg4fcG7Po8uoKdz
         GVDEjasvg09RFNu/Qw7aKns9yQV7kgqqg7TmOo4Y69Ufm6W7Q+Gair0QhNMre8KrOHX+
         bDYHAQlAH66Qc+b2zd2D8mTOdQquik99jglgyltdyUNLqkfmHTrlrhY6VBD3MBZIFU6J
         Y+Z1beHGOyV6QnnzQf/OJx0gf2XEzsHGgjVqhetY9nU/4vjud95kgGeS5PWQIX2lZORl
         rqjHALDycbsM7wzRUoHqY+uAPd+Cv1hvoY8Mah6z2ipi/ODndcTChniUETHuw2erD9D7
         f5dw==
X-Gm-Message-State: AOAM530SpSL54/W3S0f8msow2kAKAGbrUN4nqSH9UhA4KXH/Q2R4af+u
        TTYPioYU4kVe2Yj9JwsTNEy2Aw==
X-Google-Smtp-Source: ABdhPJynJFkLCnmKK5+Bf7i2B1Q5zbVTr41zDw8uLgHlyrybKXQgeTAfj+5kL5vzacoDQSqGSHnx/A==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr11672168wmi.187.1627000959063;
        Thu, 22 Jul 2021 17:42:39 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id m4sm31630498wrs.14.2021.07.22.17.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 17:42:38 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com
Subject: [PATCH 7/7] staging: rtl8188eu: attach newly imported driver to build system
Date:   Fri, 23 Jul 2021 01:42:14 +0100
Message-Id: <20210723004214.912295-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723004214.912295-1-phil@philpotter.co.uk>
References: <20210723004214.912295-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify Kconfig and Makefile to import new rtl8188eu driver into build
system.

Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/Kconfig  | 2 ++
 drivers/staging/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 7ece46a6423d..5d04f479fe79 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -28,6 +28,8 @@ source "drivers/staging/wlan-ng/Kconfig"
 
 source "drivers/staging/olpc_dcon/Kconfig"
 
+source "drivers/staging/rtl8188eu/Kconfig"
+
 source "drivers/staging/rtl8192u/Kconfig"
 
 source "drivers/staging/rtl8192e/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 581c25c47d1a..065dbd7958ff 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -4,6 +4,7 @@
 obj-y				+= media/
 obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
 obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
+obj-$(CONFIG_R8188EU)		+= rtl8188eu/
 obj-$(CONFIG_RTL8192U)		+= rtl8192u/
 obj-$(CONFIG_RTL8192E)		+= rtl8192e/
 obj-$(CONFIG_RTL8723BS)		+= rtl8723bs/
-- 
2.31.1

