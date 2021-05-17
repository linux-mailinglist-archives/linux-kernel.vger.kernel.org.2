Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05E938292A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhEQKAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:00:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34599 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbhEQJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:59:59 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia1K-0002TP-86
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 09:58:42 +0000
Received: by mail-ed1-f72.google.com with SMTP id d8-20020a0564020008b0290387d38e3ce0so3615475edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2mpH5FVMrjvjH8WEdGmN2JnMyMXBzqsrskS5jwEFjyI=;
        b=jbNqpDAjBRLSofSV0FXyyckUXe7Z9kKwLBVpJKVtSGxFuaSef4YetGsgC42U61pGBI
         CJfTIfcrEQwy1w8+KNWfaImOpIV6Y7eic/4RuXKi0BhEJ1wTelkViYW3dvGRPu2wFZxZ
         c16JwkWzl1XsNsrjmuOKPXkVf4Hq9lFz1UQnX17tJfKnNtXmfz7BLQWkyG1WtJDCFPZo
         JBK5nBpFrtIWDcYo6Yk4yfE25J24GOYZMhnSaHVj9/jqJtWDxIuCPM9GwA3atY3AiFau
         M2n1FT1ksAXTF7bWhncZU7qfUczOYUCRKTvwQWMpS1JJN4JSKlyRB3SmqEUk01atI/hN
         AzrA==
X-Gm-Message-State: AOAM533c5LI1bIR3k0cD6umSov1Za8XcW6UoAZymI0u+wYLFD2GduG71
        k1ZL/zr3x72z5nPpOobH/Eon7saCgAKHP+6eU9xxvtIqIJ75b/3vlKS9+CTgPtXGpa/BmKcrxC0
        laCWkPPqRl8hGIJgtnTyuz+wmAJu/fDmeypRYSlDVbg==
X-Received: by 2002:a17:906:8478:: with SMTP id hx24mr4112957ejc.490.1621245521963;
        Mon, 17 May 2021 02:58:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFRG/l/G2rg1zX50CxuoToOo+lAsM6sV5pKwmdKQGRrZLr8YNgrn4AfOtYJKORD+xj1Qs8MA==
X-Received: by 2002:a17:906:8478:: with SMTP id hx24mr4112949ejc.490.1621245521826;
        Mon, 17 May 2021 02:58:41 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id i20sm4883813edr.94.2021.05.17.02.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:41 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] backlight: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:39 +0200
Message-Id: <20210517095839.81833-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find drivers/video/backlight -name 'Kconfig*' | \
    xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 drivers/video/backlight/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index d83c87b902c1..a967974f6cd6 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -129,11 +129,11 @@ config LCD_HX8357
 	  driver.
 
   config LCD_OTM3225A
-  	tristate "ORISE Technology OTM3225A support"
-  	depends on SPI
-  	help
-  	  If you have a panel based on the OTM3225A controller
-  	  chip then say y to include a driver for it.
+	tristate "ORISE Technology OTM3225A support"
+	depends on SPI
+	help
+	  If you have a panel based on the OTM3225A controller
+	  chip then say y to include a driver for it.
 
 endif # LCD_CLASS_DEVICE
 
-- 
2.27.0

