Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECB13BC238
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhGERXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhGERXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:23:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D1BC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 10:21:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id he13so11263587ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m85dyNpl8mqHsOPCFURrUsHBDPNhbY1YJhD2/1+cLLc=;
        b=CzyuUPUOhaXCmGkQTGKwssC5jCunixl35NfFC8QZErKYdUlEdFXFnruhYMiMmidV9U
         YLHilwKvqcbGAnRV88G8rg05EItCtmCNHWlWteUaXFYXI6ZFHR+WVYWXjEmy2sRp3frg
         AehvLe2t4KXZ+WEX+MFRsBZ4PsoxSbq6JI6p3rDrWzP0asLJKVBdUqiu6TK0CmT4j2/U
         XZzZzBpo9Suu0kBxHi7r/HxCoLh+VNXkV2OA/J7xEdqdEeU8P5EPmYFrYvz+e5LVfmoQ
         owmBynh/Y7rEKYZpG9D+rkjNUxaazHQRdDTu1bx5psBcc3VhXZ9FqaGTm/E0zffk2wrq
         eBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m85dyNpl8mqHsOPCFURrUsHBDPNhbY1YJhD2/1+cLLc=;
        b=XbN7o7uz2bh1rawyWeH1Nq2R5j7L71Xz2uPbwl3o68jQgp3Qoi4Nrql8TVVxBXXM4N
         wGXTyzKKjJMw7mV7BdeA+1N4BBW1YcnUR73sKeEmCrPzrS6YhGcLf+fggr/Fg6oLaYsb
         h/Z0KS0e+OcVSDgFpFWlhHZowZhs/Ke8MsJT1Vf4Mj8DzCZS+nAfEOv1GR0zK5tiaEa6
         vgtXyQbEehi2Ll4hBI9THtONKTkYcF3IoVYu8FtbtNvpuY2DQHrGCrgrp+vW2PIlzbgH
         fyIpcJ4ysVrCwMMojee/EaV7MY+DHobIqhKQQXOEd2f6j6NKZnt8rBMwTTvSMP5IlwBl
         x8hQ==
X-Gm-Message-State: AOAM532B2FLgO/RNnaMdITNPnTNzHjuB+09yAV/ts4cU2OGo1wDtjwrv
        x7swBjgG8xaxbdK9SufebuY=
X-Google-Smtp-Source: ABdhPJwvE8VU7IVwvU7V27WFSZFnaZci/VgS/qcitx44GxQ0s7HYrPS1QWvtsiefdY/cbDnm4bGM7Q==
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr12352046ejc.233.1625505671714;
        Mon, 05 Jul 2021 10:21:11 -0700 (PDT)
Received: from uhost.fritz.box (p508df717.dip0.t-ipconnect.de. [80.141.247.23])
        by smtp.gmail.com with ESMTPSA id h19sm5917392edt.87.2021.07.05.10.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 10:21:11 -0700 (PDT)
From:   Jan Gruber <j4n6ru@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jan Gruber <j4n6ru@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unnecessary logging
Date:   Mon,  5 Jul 2021 19:21:01 +0200
Message-Id: <20210705172101.239899-1-j4n6ru@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
158: FILE: drivers/staging/rtl8188eu/os_dep/usb_intf.c:158:
+               pr_debug("===> %s\n", __func__);
---
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
177: FILE: drivers/staging/rtl8188eu/os_dep/usb_intf.c:177:
+       pr_debug("<=== %s\n", __func__);

and removes another line of unnecessary logging, which was not
identified by checkpatch.pl in an automated manner.

Signed-off-by: Jan Gruber <j4n6ru@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index b7e2692c35f3..fe8101c46808 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -155,7 +155,6 @@ void usb_intf_stop(struct adapter *padapter)
 static void rtw_dev_unload(struct adapter *padapter)
 {
 	if (padapter->bup) {
-		pr_debug("===> %s\n", __func__);
 		padapter->bDriverStopped = true;
 		if (padapter->xmitpriv.ack_tx)
 			rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_DRV_STOP);
@@ -173,8 +172,6 @@ static void rtw_dev_unload(struct adapter *padapter)
 
 		padapter->bup = false;
 	}
-
-	pr_debug("<=== %s\n", __func__);
 }
 
 static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
@@ -455,8 +452,6 @@ static void rtw_dev_remove(struct usb_interface *pusb_intf)
 	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
 	struct adapter *padapter = dvobj->if1;
 
-	pr_debug("+%s\n", __func__);
-
 	if (!pusb_intf->unregistering)
 		padapter->bSurpriseRemoved = true;
 
-- 
2.25.1

