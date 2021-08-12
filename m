Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3CC3EABEE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbhHLUlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237717AbhHLUlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:41:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A2AB610A3;
        Thu, 12 Aug 2021 20:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628800850;
        bh=BecshPOdhG2cf8MYoE4wgDf8dzfOwrTr4mgRevgNqRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uUJfM4YRnitV0Whn/81HD8HhyICBJtB235tOm5qWDr/YaNnxigSOB3PCCYjNKu88g
         GUOLeN2DQtbdDihSCOMkKs05PmwAW5PNRKHT7PQ9+zRyXidqGmM3kDhpU0+mZm/Pj8
         8KO/VqFzHofUa2VYH3uwgfeiWcmrVest+kn4s/k6vdFpym2rwQgq74iEMBYsRrPtOm
         x6wwAD3MkHqOMWu/pYBtNiKGj886Tryr2zWHep34E/SwpiwIxpIuxHJJmaiokX0hpc
         Rc9nC/vjp8ZfxBnMfnSRlfkaXmn6GJX7fIXk5AQt5+bCCudD7Gh1UDg+kjhuq0sWsW
         rli0+XOPDbdiQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 3/3] staging: r8188eu: Reorganize error handling in rtw_drv_init()
Date:   Thu, 12 Aug 2021 13:40:27 -0700
Message-Id: <20210812204027.338872-4-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2
In-Reply-To: <20210812204027.338872-1-nathan@kernel.org>
References: <20210812204027.338872-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 987219ad34a6 ("staging: r8188eu: remove lines from Makefile
that silence build warnings"), clang warns:

drivers/staging/r8188eu/os_dep/usb_intf.c:726:6: warning: variable
'status' is used uninitialized whenever 'if' condition is true
[-Wsometimes-uninitialized]
        if (!if1) {
            ^~~~
drivers/staging/r8188eu/os_dep/usb_intf.c:741:6: note: uninitialized use
occurs here
        if (status != _SUCCESS)
            ^~~~~~
drivers/staging/r8188eu/os_dep/usb_intf.c:726:2: note: remove the 'if'
if its condition is always false
        if (!if1) {
        ^~~~~~~~~~~
drivers/staging/r8188eu/os_dep/usb_intf.c:714:12: note: initialize the
variable 'status' to silence this warning
        int status;
                  ^
                   = 0
1 warning generated.

status is not initialized if the call to usb_dvobj_init() or
rtw_usb_if1_init() fails.

Looking at the error function as a whole, the error handling is odd
compared to the rest of the kernel, which prefers to set error codes on
goto paths, rather than a global "status" variable which determines the
error code at the end of the function and function calls in the case of
error.

Rearrange the error handling of this function to bring it more inline
with how the kernel does it in most cases, which helps readability.

The call to rtw_usb_if1_deinit() is eliminated because it is not
possible to ever hit it; if rtw_usb_if1_init() fails, the goto call
jumps over the call to rtw_usb_if1_deinit() and in the success case,
status is set to _SUCCESS.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index a462cb6f3005..667f41125a87 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -704,20 +704,23 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
 static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device_id *pdid)
 {
 	struct adapter *if1 = NULL;
-	int status;
 	struct dvobj_priv *dvobj;
+	int ret;
 
 	/* step 0. */
 	process_spec_devid(pdid);
 
 	/* Initialize dvobj_priv */
 	dvobj = usb_dvobj_init(pusb_intf);
-	if (!dvobj)
-		goto exit;
+	if (!dvobj) {
+		ret = -ENODEV;
+		goto err;
+	}
 
 	if1 = rtw_usb_if1_init(dvobj, pusb_intf);
 	if (!if1) {
 		DBG_88E("rtw_init_primarystruct adapter Failed!\n");
+		ret = -ENODEV;
 		goto free_dvobj;
 	}
 
@@ -726,15 +729,12 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
 		rtw_signal_process(ui_pid[1], SIGUSR2);
 	}
 
-	status = _SUCCESS;
+	return 0;
 
-	if (status != _SUCCESS && if1)
-		rtw_usb_if1_deinit(if1);
 free_dvobj:
-	if (status != _SUCCESS)
-		usb_dvobj_deinit(pusb_intf);
-exit:
-	return status == _SUCCESS ? 0 : -ENODEV;
+	usb_dvobj_deinit(pusb_intf);
+err:
+	return ret;
 }
 
 /*
-- 
2.33.0.rc2

