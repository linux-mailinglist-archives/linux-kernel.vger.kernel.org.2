Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15AE32BF08
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577216AbhCCRsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhCCOwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:52:42 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0990C0610D3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:45 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k66so6597427wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U92/RQ3hpLZuYnPJtsOpX25Ju+xsfO8zWOU6k76xGHs=;
        b=rNsskH/w5bS8B3UXyXbYeb3x7TdttXqfSrFaKyJlnbBo1iMvOfaWCQkN4RiP4tsGty
         /7poK+nS0jVRPENWhBrjf0utc734Ad17uNRMG4/DmK3dNspWCkP/BFkegAQdcUG/LJmg
         cBCHzxDaohMBfzaR9MjbVuSF9T8ExP+jj22uuGWrg6VMUHMhvR9ExgZHk8XK2yeHlfEa
         /EVJ9pgupROEK05kfYBn67Z83PZFGEG52eJvDNc7bufAEFVgdnKIxR093iKcA1iOijPz
         AjGb3qxQh1oLKCevw2Duftgx+kDg1GePvYUqGHh9X2QDluwVFkkpN0xTYK71ex45kpSR
         QFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U92/RQ3hpLZuYnPJtsOpX25Ju+xsfO8zWOU6k76xGHs=;
        b=dpdcwJ4NhDj0bnUHEUv+BVZFUsZuyOOrrZgs437dQKNtuwP3QyAf9VZvnBh/LAQirS
         4lMRuDItMLrWkj2Iggb0I+4VuTRviZqN9U7nxJQHy9F93xXRVF9V/sefjhSwipHDIT/y
         wwZHiwscxha1w7rVFLyxF5mZ7MMErrXs96MG6k9mYFNv7+BCa2xRjYyX8ac9s1UVCx8+
         0xaczxZrUbbbV4lIVCHlh9KJAiT+hWFCCkW4tnzFh4/J5bVK3yeARXPVAAwP7c2Xviq9
         Rt/oWOi3EbRXtiGk4FL2dTvZ+sLD80OdTSbAKhELcSQxjbPwM4BosGPWAd4ZuQPeCsAn
         fQ2Q==
X-Gm-Message-State: AOAM531teBv9L7+jBgtNsjHZbZ6nWl7dglYQg95ukrJTSMigcj3TO/Pf
        Ej8qbla85JNp0LQg4/FkdnVzAw==
X-Google-Smtp-Source: ABdhPJyE6wgr9mNM1wEy0PMtTFZ9XEX7/Vl2VTHLplVq+KbhEEYuWhfAvSSaU02WJTkn1TEh6UY1Xw==
X-Received: by 2002:a05:600c:1550:: with SMTP id f16mr5448736wmg.97.1614782864204;
        Wed, 03 Mar 2021 06:47:44 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 26/30] scsi: libfc: fc_lport: Fix some possible copy/paste issues
Date:   Wed,  3 Mar 2021 14:46:27 +0000
Message-Id: <20210303144631.3175331-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/libfc/fc_lport.c:710: warning: expecting prototype for fc_rport_enter_ready(). Prototype was for fc_lport_enter_ready() instead
 drivers/scsi/libfc/fc_lport.c:759: warning: expecting prototype for fc_lport_set_port_id(). Prototype was for fc_lport_set_local_id() instead
 drivers/scsi/libfc/fc_lport.c:1400: warning: expecting prototype for fc_rport_enter_dns(). Prototype was for fc_lport_enter_dns() instead
 drivers/scsi/libfc/fc_lport.c:1516: warning: expecting prototype for fc_rport_enter_fdmi(). Prototype was for fc_lport_enter_fdmi() instead
 drivers/scsi/libfc/fc_lport.c:1647: warning: expecting prototype for fc_rport_enter_logo(). Prototype was for fc_lport_enter_logo() instead
 drivers/scsi/libfc/fc_lport.c:1789: warning: expecting prototype for fc_rport_enter_flogi(). Prototype was for fc_lport_enter_flogi() instead

Cc: Hannes Reinecke <hare@suse.de>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/libfc/fc_lport.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index 22826544da7e7..78bd317f0553b 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -703,7 +703,7 @@ static void fc_lport_disc_callback(struct fc_lport *lport,
 }
 
 /**
- * fc_rport_enter_ready() - Enter the ready state and start discovery
+ * fc_lport_enter_ready() - Enter the ready state and start discovery
  * @lport: The local port that is ready
  */
 static void fc_lport_enter_ready(struct fc_lport *lport)
@@ -747,7 +747,7 @@ static void fc_lport_set_port_id(struct fc_lport *lport, u32 port_id,
 }
 
 /**
- * fc_lport_set_port_id() - set the local port Port ID for point-to-multipoint
+ * fc_lport_set_local_id() - set the local port Port ID for point-to-multipoint
  * @lport: The local port which will have its Port ID set.
  * @port_id: The new port ID.
  *
@@ -1393,7 +1393,7 @@ static struct fc_rport_operations fc_lport_rport_ops = {
 };
 
 /**
- * fc_rport_enter_dns() - Create a fc_rport for the name server
+ * fc_lport_enter_dns() - Create a fc_rport for the name server
  * @lport: The local port requesting a remote port for the name server
  */
 static void fc_lport_enter_dns(struct fc_lport *lport)
@@ -1509,7 +1509,7 @@ static void fc_lport_enter_ms(struct fc_lport *lport, enum fc_lport_state state)
 }
 
 /**
- * fc_rport_enter_fdmi() - Create a fc_rport for the management server
+ * fc_lport_enter_fdmi() - Create a fc_rport for the management server
  * @lport: The local port requesting a remote port for the management server
  */
 static void fc_lport_enter_fdmi(struct fc_lport *lport)
@@ -1640,7 +1640,7 @@ void fc_lport_logo_resp(struct fc_seq *sp, struct fc_frame *fp,
 EXPORT_SYMBOL(fc_lport_logo_resp);
 
 /**
- * fc_rport_enter_logo() - Logout of the fabric
+ * fc_lport_enter_logo() - Logout of the fabric
  * @lport: The local port to be logged out
  */
 static void fc_lport_enter_logo(struct fc_lport *lport)
@@ -1782,7 +1782,7 @@ void fc_lport_flogi_resp(struct fc_seq *sp, struct fc_frame *fp,
 EXPORT_SYMBOL(fc_lport_flogi_resp);
 
 /**
- * fc_rport_enter_flogi() - Send a FLOGI request to the fabric manager
+ * fc_lport_enter_flogi() - Send a FLOGI request to the fabric manager
  * @lport: Fibre Channel local port to be logged in to the fabric
  */
 static void fc_lport_enter_flogi(struct fc_lport *lport)
-- 
2.27.0

