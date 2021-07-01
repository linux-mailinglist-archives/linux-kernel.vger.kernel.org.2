Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541EA3B8C71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 04:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbhGAC5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 22:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhGAC5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 22:57:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C463EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 19:54:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e20so4841892pgg.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 19:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FreGcpfuTNUkLNbp61xzFG1QIlw6BMxT4r9xTYebUUg=;
        b=ZqCs0/GFoYhCk0xwnWnLhfOAsVOV41ZdnRz9OWTSTSEC4X0AF2np/AmpDK1kFn30ow
         Cs3/MJtj02o2QaRYpG8nUSz/Dq+ZGYhs1aAX90zjBdkXeRicncCrfdrex33uZ7DwXkDI
         jWo5kYZk+rymXlcvz7xpKQaAiyOoV5E/S4XcHRTr0eKo/pSulU00Rp0qrFQ/WiVe1Nxp
         RsI8gSA78Tz1qBqgI4g+lbivj6heWBD/dFFEuirNgc4kDYyXKmBfMacDEQA41873UbRg
         5imFK16p0+eO8uREiuyX6CTEPbudySvNIAEj1HuP78tzvV9ERVq/0MqUqk6WWifrZU0I
         XPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FreGcpfuTNUkLNbp61xzFG1QIlw6BMxT4r9xTYebUUg=;
        b=B/eMJVqx+qCPq3MW17WumsdCqf6saIeGya5zal4jbVjC//09OSxI2m/OC9qvj127he
         z4j4OTGIEjdVCngs4KhSbLXlnWB6H8iQIO5T1R1WdCSVPYFbF2ivKehyxZ6+1/GB+vgB
         2RLbq1zW2XHMrTDvRaIMydFSHIjFAt9SMnf1twQ6L8w/8gtadfPHCA6Wzn6b03bWZuRw
         Ya6zMR0D4s/KyLJHqKj13drfdz5N4MFj5bl2hslPbPfmJBj4rb/zwdBqAh+GPtdIxSVW
         Zsed5kNY+F4o42s1XiAeF+EKE5nEcigzJxrSe8u5ERSiJeJjZHwg/ubQdwdfJU1h8Akq
         FrAw==
X-Gm-Message-State: AOAM530JrigSc8Z/n8LNr8spxH/qC8AL6jpZSLUpsmm98UpVqSKL7Y+C
        /5e/1lPAsWgHkuQxUJCyVhM=
X-Google-Smtp-Source: ABdhPJxwdk1rO8kK6ssAAU1sOXiEZnVgdZA4IopX1NwDHC4nUpI9iotkj06IxenVr/EB+3j2Mv0d/w==
X-Received: by 2002:a05:6a00:bdb:b029:30f:94e8:6108 with SMTP id x27-20020a056a000bdbb029030f94e86108mr7575533pfu.57.1625108089240;
        Wed, 30 Jun 2021 19:54:49 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 75sm756707pfx.71.2021.06.30.19.54.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jun 2021 19:54:48 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: n_gsm: delete SABM command frame as requester
Date:   Thu,  1 Jul 2021 10:54:38 +0800
Message-Id: <1625108078-16491-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

as initiator,it need to send SABM conmmand ,as requester,there is
no need to send the SABM control frame,it will cause redundant data.

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5fea02c..e66418b 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3005,8 +3005,9 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 	/* We could in theory open and close before we wait - eg if we get
 	   a DM straight back. This is ok as that will have caused a hangup */
 	tty_port_set_initialized(port, 1);
-	/* Start sending off SABM messages */
-	gsm_dlci_begin_open(dlci);
+	/* Start sending off SABM messages for initiator */
+	if (gsm->initiator)
+		gsm_dlci_begin_open(dlci);
 	/* And wait for virtual carrier */
 	return tty_port_block_til_ready(port, tty, filp);
 }
-- 
1.9.1

