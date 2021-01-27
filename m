Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48B33051BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhA0FIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343633AbhA0EUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:20:30 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF01BC061573;
        Tue, 26 Jan 2021 20:19:50 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r38so690699pgk.13;
        Tue, 26 Jan 2021 20:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YGrPRxNt+RP6h4OeOrtja6PVCsuV/WKXvcTlJJ9DTbk=;
        b=JLGEnAvhAwJZfHwdLlhmb0DSl4UZi3OZv3iWekFOGR3qFRUyW0DTs/gCwJjVdH9heU
         g3IgtsRjNM8IbIG0d1R3jECKK4vMQQFCYaoC8iW/hEPmLOtYz9sBuh/rnlh7x8ieQRRk
         SlvIypskATZnjm/Lvpye3dPgwr6E4tlcV8WjjUzJmDzgz0jmx8ZfAZF40RAAHTYiI2PE
         /fpvQt9yoAMz03LPgmg76lrj4omYJPVJuIhIKoj5QTwLbnkgJsZwkDSyvSWM9+UtGRbp
         LGaaekePubsHLZw3pC7kQtXYcpPAxlCbkIHqcniGQmG/7H3roHhg9QfUuKdRO5IOg6nG
         FQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YGrPRxNt+RP6h4OeOrtja6PVCsuV/WKXvcTlJJ9DTbk=;
        b=dDgzy0jBESRsnAk7JVQS2od2UFBI1bj5U7sCikZ4Px3Pz9mIOg1LKQk74iW/jotQIR
         L8nvR1tQqaIUpyf2lGXHDg7heyOW1oYmf6BKpyvv4zkYQpHW5N6jDL4y+4Frl0MAUJE7
         jmEDnLrSPwkMFk6LsRkshCx/bTnx+DECQMpNQhoRyQLgfI8IsZ8MnYJaTZ7Xc2mmoihH
         ecZ3UFxpe821lKAOFysGubFuJ5/GL5NXs21oGOTWS8VQSE8VDCBnxd7loJsCGEvuD8jM
         0JCWIiSgbR0gjS3g/idDO+Spaf6Hyq+AyO4wP7hiEbqHkyYFxAhAz3BPpjxMapF3ZJUa
         aX/w==
X-Gm-Message-State: AOAM531NC0+Khj/y4HZqliD/CX+QRCAHm4guZoS2osNP7m5Pe7wFLsLF
        bPrWQoMwm33Nv0TeatVrNjU=
X-Google-Smtp-Source: ABdhPJxvHUy9zmqIrHolYOlbR0sPQ4plZ3TiuVLdfBSVsXvKKm5tNo2PbB9tIOxKzV8McWg+Q5+WnA==
X-Received: by 2002:aa7:80c6:0:b029:1b6:92ae:a199 with SMTP id a6-20020aa780c60000b02901b692aea199mr8403118pfn.71.1611721190388;
        Tue, 26 Jan 2021 20:19:50 -0800 (PST)
Received: from lenovo.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m10sm397760pjs.25.2021.01.26.20.19.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 20:19:49 -0800 (PST)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Joe Perches <joe@perches.com>,
        Denis Efremov <efremov@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>
Subject: [PATCH] include: sysfs: Add macro to assign show for RO attributes
Date:   Wed, 27 Jan 2021 12:19:22 +0800
Message-Id: <1611721162-29982-1-git-send-email-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some circumstances, multiple __ATTR_RO attributes need to be assigned
with a single show function.

Add this macro to make life easier with simple code.

Signed-off-by: Orson Zhai <orsonzhai@gmail.com>
---
 Documentation/filesystems/sysfs.rst | 2 ++
 include/linux/sysfs.h               | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index 004d490..0e2274a 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -141,6 +141,8 @@ __ATTR_RO_MODE(name, mode):
 	         fore more restrictive RO access currently
                  only use case is the EFI System Resource Table
                  (see drivers/firmware/efi/esrt.c)
+__ATTR_RO_SHOW(name, show):
+		 assumes default mode 0444 with specified show.
 __ATTR_RW(name):
 	         assumes default name_show, name_store and setting
                  mode to 0644.
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 2caa34c..c851592 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -117,6 +117,11 @@ struct attribute_group {
 	.show	= _name##_show,						\
 }
 
+#define __ATTR_RO_SHOW(_name, _show) {					\
+	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
+	.show	= _show,						\
+}
+
 #define __ATTR_RO_MODE(_name, _mode) {					\
 	.attr	= { .name = __stringify(_name),				\
 		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
-- 
2.7.4

