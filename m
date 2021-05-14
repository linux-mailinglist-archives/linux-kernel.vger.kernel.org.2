Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0475C3808AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhENLki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhENLkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:40:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:39:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p6so213007plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfi+Lj87o7ESgL1WTUrnNcPq88+DNAoSToKuflqJeFE=;
        b=Wi7HxsyjXgzutTwWnty6ybZk/I20s+j8QBf4AEJi2NfX825nRn2vo11bGrgCUPWN9L
         IltKalvvlOannafnyCCDoxwwkNRxCoc/+4WLTw/Y11bAY2I4HcY2+i3wHsE8UriaLefW
         8SYBEs9+XfSCJw+DOidb43caYy0OIC7T9vGWIQ6eao0bZZST/g0GU4k423VzGiDue0BZ
         o2cUe9dKGxuJxHgjMB3peW2kOrDUNo9bK+NA9ren/7KjwB/rDZea0OwgVBBmOInATWVQ
         OsBELmryv7xLRvHgqpDn6yO6c2bjBhNCPVfsbYs7Dd1FBkhZu3BtaAv9VmCamRnVoWI+
         rtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfi+Lj87o7ESgL1WTUrnNcPq88+DNAoSToKuflqJeFE=;
        b=JPmdszeqcsETrilxajsbqm7b+ZG6pw8tUqxbO9ucKW2YBkmCnTcQxEWG/Gy5NcSIfi
         8AuLXNyIZSoe7tFQWHwbLUFbfb86mFHWTphniS9NsS3o1Fc29YvlATnESvzXeZ0OEr/W
         NYeQiysdmqrEFc4zeEBGkiWXQUwz8ZymAYAv5C29KLxG70QSxteBheHqq/rl+SFa7NDC
         Tq34thBuRgotY0Ra5eQ3uZhaPw0V7qwif54PGJzGpsSVhvsZSpXQqSkQcaC8hD7hYrAi
         70RocjkmzAdpOEFQ/ooL/1HCnFl5/fcT4shQqd25X/nZe616j7HIaMYP1ZAjquWCpANj
         sT+g==
X-Gm-Message-State: AOAM53338+bfW++ynzLNyOVdcuVfNKqFBTsmU6g3oZ3gvlXajQRvgONy
        dHkOcBMn6jpxUdDi6NTMz0GlAocm9RpOyA==
X-Google-Smtp-Source: ABdhPJwWtYHt+MlJ2HtcrEBIsxH6MdvgEUtING4oQCRdSl35BCSrZVYv92fLRApOQawC0Aec9SE72w==
X-Received: by 2002:a17:902:d903:b029:ef:abd0:d8fa with SMTP id c3-20020a170902d903b02900efabd0d8famr5170706plz.49.1620992364053;
        Fri, 14 May 2021 04:39:24 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id w23sm4213376pfn.63.2021.05.14.04.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:39:23 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Morris Ku <saumah@gmail.com>
Subject: [PATCH] 8250: Add SUNIX SDC series uart driver
Date:   Fri, 14 May 2021 19:39:08 +0800
Message-Id: <20210514113908.5121-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add SUNIX SDC series uart driver

Signed-off-by: Morris Ku <saumah@gmail.com>
---
 Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Kconfig b/Kconfig
index 7ef60f8..3a68ef4 100644
--- a/Kconfig
+++ b/Kconfig
@@ -217,6 +217,12 @@ config SERIAL_8250_MANY_PORTS
 	  say N here to save some memory. You can also say Y if you have an
 	  "intelligent" multiport card such as Cyclades, Digiboards, etc.
 
+config SERIAL_8250_SDC
+	tristate "SUNIX SDC serial port support"
+	depends on SERIAL_8250 && MFD_SUNIX_SDC
+	help
+	  Support for SUNIX SDC serial port.
+
 #
 # Multi-port serial cards
 #
-- 
2.20.1

