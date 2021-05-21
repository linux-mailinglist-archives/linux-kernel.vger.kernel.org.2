Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A80A38CA4F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhEUPmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhEUPmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:42:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16837C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:40:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c12so3593291pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UA6xPv5LeF6SOpRV6Qraytl+bpMd+qdk0hK3e5B3Cgk=;
        b=DJ1JKnVAIZLi4G4kVfvqb4K6CKLVprfGDIWjF0zBF2KsJY2vYlobcUmk7Vp4PX3Oe3
         4mHVgvKSCMx5626xGz+G8SyseUh5WaeP7dT/uVz9jJYBFJNDEAeOyPAx+Lgmm+zzC+3c
         jaOPulK4ux2t4KW5XAuI9Aop0W39QllbV3ZIFZMda5/Kl7N86CLyAW0jNAj3DtF4SB4I
         98BohEy4zn69DXpG4vTofAGZtTUVRTwL54lHUqd6fS8QR54+zXcMUCJDXhJfcNrUNA3k
         bodQqpHekIRTtyzLUknQjot6nk7qbNzqK9d8ghVvZn0FUqLKtTBgAdauVwH2Mp/0AGNb
         o9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UA6xPv5LeF6SOpRV6Qraytl+bpMd+qdk0hK3e5B3Cgk=;
        b=iS4GFT9hPNcmf6t+OB7Hv3GiGRUCAkkDWr8gJx6m8IRSnmZippCZvbOY7S98JpHTSx
         5zSlNT/6uwiuTQ9to0L+RFjgoAMZpuoT6mH0MjtukZK2gKAOOnRcLiQ0g6hRl4WW6XkN
         6ooMXQHWioBOYBwQ4RJmwCNwSUhhXq4uWtIK0r+/r/7hbG77VjCeKi/WkZq0Es2UbkhM
         xZ5+xoVr6W+XWhH1i09XJeD0rZkb3IcVMz1SzGuUpno3aqTyG4a/eT3PypQB4XQiXR9b
         EihrD/Yuf0cbPqeLppwdKX8Ej5yEl7axWvCDA1tcbUnsU4GV3cnoEuhz6uNeMO+E6H4J
         y4Ng==
X-Gm-Message-State: AOAM533EJf6uS/oRKqiDbL4swMOCVSSghR36SbBwqGGT7g8DYFC1kb+M
        wRBqKWDEDyIl4NmYoEIiOmfEa8M/mmLx/qZU
X-Google-Smtp-Source: ABdhPJxRwUy54XtclIe/o3gLoWcXF0/Cg63DARPEjjF+8/keJHdx7jOIP1L62Lq8Xp/TKS0HBFwZ9g==
X-Received: by 2002:a62:3106:0:b029:25c:cd66:3be1 with SMTP id x6-20020a6231060000b029025ccd663be1mr10619026pfx.29.1621611636503;
        Fri, 21 May 2021 08:40:36 -0700 (PDT)
Received: from ubuntu.localdomain ([103.196.78.23])
        by smtp.googlemail.com with ESMTPSA id u7sm4627212pfi.104.2021.05.21.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:40:35 -0700 (PDT)
From:   Hriday Hegde <hridayhegde1999@gmail.com>
Cc:     hridayhegde1999@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Romain Perier <romain.perier@gmail.com>,
        Pascal Terjan <pterjan@google.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: Removed unnecessary blank lines
Date:   Fri, 21 May 2021 08:39:16 -0700
Message-Id: <20210521153924.22843-1-hridayhegde1999@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following lines were fixed as dictated by running checkpatch

CHECK: Please don't use multiple blank lines
65: FILE: drivers/staging/rtl8712/xmit_linux.c:65:
+

CHECK: Blank lines aren't necessary after an open brace '{'
39: FILE: drivers/staging/rtl8712/usb_intf.c:39:
+static const struct usb_device_id rtl871x_usb_id_tbl[] = {

CHECK: Blank lines aren't necessary after an open brace '{'
849: FILE: drivers/staging/rtl8712/rtl871x_xmit.c:849:
+{

CHECK: Please don't use multiple blank lines
260: FILE: drivers/staging/rtl8712/rtl871x_sta_mgt.c:260:
+

Signed-off-by: Hriday Hegde <hridayhegde1999@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_sta_mgt.c | 1 -
 drivers/staging/rtl8712/rtl871x_xmit.c    | 1 -
 drivers/staging/rtl8712/usb_intf.c        | 1 -
 drivers/staging/rtl8712/xmit_linux.c      | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_sta_mgt.c b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
index 706e9db0fc5b..2c806a0105bf 100644
--- a/drivers/staging/rtl8712/rtl871x_sta_mgt.c
+++ b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
@@ -257,7 +257,6 @@ struct sta_info *r8712_get_bcmc_stainfo(struct _adapter *padapter)
 	return r8712_get_stainfo(pstapriv, bc_addr);
 }
 
-
 u8 r8712_access_ctrl(struct wlan_acl_pool *pacl_list, u8 *mac_addr)
 {
 	return true;
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index bb4de927fb02..090345bad223 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -846,7 +846,6 @@ static inline struct tx_servq *get_sta_pending(struct _adapter *padapter,
 					       struct  __queue **ppstapending,
 					       struct sta_info *psta, sint up)
 {
-
 	struct tx_servq *ptxservq;
 	struct hw_xmit *phwxmits =  padapter->xmitpriv.hwxmits;
 
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index dc21e7743349..64ddbd483a23 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -36,7 +36,6 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 static void r871xu_dev_remove(struct usb_interface *pusb_intf);
 
 static const struct usb_device_id rtl871x_usb_id_tbl[] = {
-
 /* RTL8188SU */
 	/* Realtek */
 	{USB_DEVICE(0x0BDA, 0x8171)},
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 1f67d86c606f..90d34cf9d2ff 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -62,7 +62,6 @@ sint r8712_endofpktfile(struct pkt_file *pfile)
 	return (pfile->pkt_len == 0);
 }
 
-
 void r8712_set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
 {
 	struct ethhdr etherhdr;
-- 
2.25.1

