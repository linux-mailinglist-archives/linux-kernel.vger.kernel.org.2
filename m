Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427533EBD2A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 22:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhHMUPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 16:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234079AbhHMUPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:15:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D2BD6109E;
        Fri, 13 Aug 2021 20:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628885673;
        bh=oHqr9gf6iJE6sAUL+WaaVHLwy6uNjlOmXgVB7pQvDag=;
        h=From:To:Cc:Subject:Date:From;
        b=aeN6dhhH/cdXVWFowFxc2MAfPoKZIZl78+2FcNIYAKibg8GDD5I2dPjg6UTKK1AOq
         rpNXph0ZMfsgx4ZVi0TqPfs0LeZK+Lw97REu3XwAoPEDArqtZb2QF5eZsbS4bJEcKu
         ayCMVmbJNHzz+sCBy5+l5hbnaWR5lgFO9STi2p9ZLvCleelTaYtcyr2UVTc1QPsYyQ
         BdaxCpLDSjUesat/50b0VlAW1NH//2aZcN56e0fifgIzeE8JtW68+EBdZqgAZF5dW0
         7YFy2XcyeIgT76mwoYI2rmiNyTxsJJXXhY/hjcqd+vr8BHbiqdm+l0INUutJ/qWY3l
         zlrREjTpSWV2Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Remove unnecessary ret variable in rtw_drv_init()
Date:   Fri, 13 Aug 2021 13:14:18 -0700
Message-Id: <20210813201418.4018631-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret is unnecessary as both error paths set the same error code so just
return that directly.

Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 667f41125a87..3e5f4b5eb0fc 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -705,22 +705,18 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
 {
 	struct adapter *if1 = NULL;
 	struct dvobj_priv *dvobj;
-	int ret;
 
 	/* step 0. */
 	process_spec_devid(pdid);
 
 	/* Initialize dvobj_priv */
 	dvobj = usb_dvobj_init(pusb_intf);
-	if (!dvobj) {
-		ret = -ENODEV;
+	if (!dvobj)
 		goto err;
-	}
 
 	if1 = rtw_usb_if1_init(dvobj, pusb_intf);
 	if (!if1) {
 		DBG_88E("rtw_init_primarystruct adapter Failed!\n");
-		ret = -ENODEV;
 		goto free_dvobj;
 	}
 
@@ -734,7 +730,7 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
 free_dvobj:
 	usb_dvobj_deinit(pusb_intf);
 err:
-	return ret;
+	return -ENODEV;
 }
 
 /*

base-commit: 0bd35146642bdc56f1b87d75f047b1c92bd2bd39
-- 
2.33.0.rc2

