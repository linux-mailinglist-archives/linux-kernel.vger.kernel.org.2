Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFBE3430E3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 05:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCUEg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 00:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhCUEgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 00:36:47 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5417C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 21:36:46 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id cx5so7087753qvb.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 21:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cgjAg1npPwTI8+HwC0MGr8ZbYybNytKphsGDAOhPsLY=;
        b=lwHRgJHdI6PktQQz+JEk7ibvwGgLSHWbswwbhRcQtaWhd1D4wiYoI/VUQ0xImq30sE
         Emkoh8JenvMIL6SQ0PRKXCz2ImFsqBfT+ud3SqaKfF1ZWyUlCVG6U15ocldNqYp2cnbK
         FLBQ5RIS3tp8kh21ibc1+6kj92XD3nzZOV+j79j05u+yKLwJQtV5fgxy5+iiDRCYprZl
         qx/QlkOUS27EIdYVS999uEBUQRssRjQl4QQQPEr5TZ1FzGZ/BKef2fPyioHfPM1RHRoc
         uLS9bGQQWA++uTdTRCp7MMbrApuSYXOYLfElyc+JNbPjBKQOFzazVm8HI0CZTMXisee8
         8HBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cgjAg1npPwTI8+HwC0MGr8ZbYybNytKphsGDAOhPsLY=;
        b=SLezZXA+fx42YwJteiPoP2t+Q4tpzQT/XJRX8qyarMgePcy7GZopg8CQdUDtTLyGNh
         3ifh+qKBC98pypEvI2MFPvu0aLWmNdLS9vIoY/Z0rrAKiA1tvF8a5yh28gVnDa3Mz3Zc
         QBsOtCba2SYbZkfyxdUhRCxie7SHhaRoH5kvjS08ywkC7RBGHVLgtckT8DSBVK7hDniM
         E+TlvwuL8Ng+TrU5SwePtp7a5rK6c3pCIg3DgpNJvq/OdarnCD9o6l3PqwaA2IdmCWlL
         t2AaXUx6DSKLGN5qcpAHSsc9nro4rnbLxp5FcNb12LrbfaR/4h3VKtM3ljJG99Exvh8d
         ZhgQ==
X-Gm-Message-State: AOAM532DWS3hdNZJTbT+cnLBkJ4Btv+z1O1dTMLoDusvJlznsDc9YvR0
        CnjZ8B8I+FlyGiA/54/iHuw=
X-Google-Smtp-Source: ABdhPJwxQQTq0TQ2vHLqc8iL7D4hvrPZfup+rA2DXEXO0JzU0c5JzdZxhK0ebgZ/ZoOT1R5RsPLsYg==
X-Received: by 2002:ad4:4d92:: with SMTP id cv18mr15892707qvb.5.1616301405966;
        Sat, 20 Mar 2021 21:36:45 -0700 (PDT)
Received: from localhost.localdomain ([138.199.13.177])
        by smtp.gmail.com with ESMTPSA id o125sm8006024qkf.87.2021.03.20.21.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 21:36:45 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     nsaenzjulienne@suse.de, gregkh@linuxfoundation.org,
        jacopo@jmondi.org, dave.stevenson@raspberrypi.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] staging: vchiq: Typo fixes
Date:   Sun, 21 Mar 2021 10:06:29 +0530
Message-Id: <20210321043629.585758-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/sepecific/specific/
s/comonent/component/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 9097bcbd67d8..06bca7be5203 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -432,7 +432,7 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 	m.u.buffer_from_host.buffer_header.pts = MMAL_TIME_UNKNOWN;
 	m.u.buffer_from_host.buffer_header.dts = MMAL_TIME_UNKNOWN;

-	/* clear buffer type sepecific data */
+	/* clear buffer type specific data */
 	memset(&m.u.buffer_from_host.buffer_header_type_specific, 0,
 	       sizeof(m.u.buffer_from_host.buffer_header_type_specific));

@@ -927,7 +927,7 @@ static int port_info_get(struct vchiq_mmal_instance *instance,
 	return ret;
 }

-/* create comonent on vc */
+/* create component on vc */
 static int create_component(struct vchiq_mmal_instance *instance,
 			    struct vchiq_mmal_component *component,
 			    const char *name)
--
2.31.0

