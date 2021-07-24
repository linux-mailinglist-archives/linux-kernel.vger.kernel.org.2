Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EEC3D43B9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 02:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhGWXbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 19:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbhGWXal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 19:30:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56000C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:11:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so1609627wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJmJe0Btm66YtZpv5ep8XSIjEMC6uvZWpwP1fR08nIU=;
        b=HfSDuehpfa1encWBwxNWHVRgSFt3LVQUcrkdss8CHcDf/m9nv5wIbLVnkrssZrI1Cp
         j9Hj4N5+yajKDtTYRLE87kJHpEzZPhECDJbW0AduXSHxg2SG2hKsYXMIWHJMt/1g7TE6
         +nETCrIUZRRyHGAxb8zsWnCMYaa+V4LUPTloorYnJhgwbBXZU73ZsIhW28ImEPEtQ5CP
         2figZSr6/TWd9zElzI6z2IABQnT8eHaxCVvsirZ0MhwQGKLNBbHNL0QeJCH3czlPVB3T
         CF0h6A+mIqUzaI0qnP8w52OEvYV12qIk3ZrNCrmMXzFEAb+e1SOSMsyPq7Ap0wGcg+iT
         y0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJmJe0Btm66YtZpv5ep8XSIjEMC6uvZWpwP1fR08nIU=;
        b=l4pZZdhleaRyc133m/XWFFGY8O6ySJHMxQifVo3kxzxTpNxzF7ievfWIZxgmOqU9sg
         +RJlrGyFWgFStqpskVi0y30KyU/hb5E527zW4a3PSgRXrggZ+5g/nF7rz/tjq6Yj8Chh
         qZ6Y8cz5/a+2HNXzqyAqTB2wZ3ntGQ4wGtTtL0eIABjHISdFuZROHzuWUxdwxN5RsFZT
         OXCt8AfpRpSO9B+3xgg9WEs6rppOX5Y+SjT3ApupfKL3ipYBV0eYhsxjl6IA7iCTTbrP
         h+Q88qcTPKnEXrk3zLjwLUUzm/C4gFaUKPch4WsGTBUhNOu++eDTblkZ9Zz57smVomPY
         d79w==
X-Gm-Message-State: AOAM532SEjq05MeMQ6lRy0SjMtQKYZl0/KA0IM6Z3kOrSfqV3QNlYWEQ
        iyp6G3Cr+jAhWgyKe6Sia6w4hA==
X-Google-Smtp-Source: ABdhPJx7RSQXiaJjpJ3REtNVetq+o3Ff5G1f4DDzkfj/TSScRz+Tx2LShSxU1wcaC6vBHZWyZGmZ7w==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr16544003wmq.31.1627085472988;
        Fri, 23 Jul 2021 17:11:12 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id k24sm35491305wrh.30.2021.07.23.17.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 17:11:12 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com
Subject: [PATCH v3 7/7] staging: r8188eu: attach newly imported driver to build system
Date:   Sat, 24 Jul 2021 01:10:55 +0100
Message-Id: <20210724001055.1613840-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210724001055.1613840-1-phil@philpotter.co.uk>
References: <20210724001055.1613840-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify Kconfig and Makefile to import new r8188eu driver into build
system.

Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/Kconfig  | 2 ++
 drivers/staging/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index f958f612829f..e03627ad4460 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -36,6 +36,8 @@ source "drivers/staging/rtl8723bs/Kconfig"
 
 source "drivers/staging/rtl8712/Kconfig"
 
+source "drivers/staging/r8188eu/Kconfig"
+
 source "drivers/staging/rts5208/Kconfig"
 
 source "drivers/staging/octeon/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 810afc8e63a6..c7f8d8d8dd11 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_RTL8192U)		+= rtl8192u/
 obj-$(CONFIG_RTL8192E)		+= rtl8192e/
 obj-$(CONFIG_RTL8723BS)		+= rtl8723bs/
 obj-$(CONFIG_R8712U)		+= rtl8712/
+obj-$(CONFIG_R8188EU)		+= r8188eu/
 obj-$(CONFIG_RTS5208)		+= rts5208/
 obj-$(CONFIG_NETLOGIC_XLR_NET)	+= netlogic/
 obj-$(CONFIG_OCTEON_ETHERNET)	+= octeon/
-- 
2.31.1

