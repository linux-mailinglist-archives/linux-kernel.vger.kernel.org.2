Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33F235E102
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhDMOLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhDMOLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:11:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C30C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:10:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c15so7669918wro.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vH99A1fpuY8PmP3SpQC4JZoT0N6aqKLVm35tssstBY=;
        b=YyeJkG/wviaq9AXZn5iPJ2pxSoBnDP7b3oGypT2AOj0I1I5/6JBkckXNpvyK8tLtoA
         a+caxOgoPnKgmh0N89rwqt0CnMXF2iCGzm4yFets7UJeggn50+lxo68uVXw+i+Sz3NOX
         K683TGIXcTxUY0gVaQEzODVTX7cQc6zsfVUFEfmW+kUvDXPm61XeX+ew4cN3WZt7K82I
         ykSy71vgxBK+fs1FEeWUhfPta/5CA1A20mElqAEvTwR27czg9gyt17AFG7rTN9q0WOKj
         yoYwGnpank+RDJTj8GN/jyDwXECfKhiPbP3Jpb4knGkWA5f7BBRlzDA2UBvb7yqNS7VB
         9qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vH99A1fpuY8PmP3SpQC4JZoT0N6aqKLVm35tssstBY=;
        b=sS6ah61yMpnROkMxEk+iyhzaZvrCiDJfAJblwXYjccGjo3XGieWLS3HZ6od5P3PKDn
         9ZJS4qrmGZeKuoTxCVjjym0xOkyXGfG9Cndo2tMm6sBK2Grf4pWIcoTiA+QcN3MEb719
         XmnFy3OpeS906VdOd6WD08/wiihajE0rNMWFFsV0rg/wvNvpsivngr//z+/ptr5VlwtJ
         gH0ijjJpnSHtDo1nfIIatyH3bCr2zcalMuwXcplZHt7+G98B1vP/EbcOBFSy68/vNIJ8
         OoS+nvikef1+D3n9H6jPaiS+d4iKHuyJSQX7jXPyjyms4JF2FSCVmSMl5yTQ8R7l+xIj
         HhzA==
X-Gm-Message-State: AOAM531I3HUKHJK17eO/CK+KxgWoN//RVoeUWWM/RouygfCRqo6wVF/X
        UcpcAkI8Dg9ZOAxl4bPmzYVPV5EQX/jGtA==
X-Google-Smtp-Source: ABdhPJx1zFyzztrVNNrVNW9vLsorNK6xLTat/RMZw06mPIcS3fqsjJ9lquGTIohLKgujqG12NznsrA==
X-Received: by 2002:a5d:4a48:: with SMTP id v8mr13339054wrs.204.1618323046572;
        Tue, 13 Apr 2021 07:10:46 -0700 (PDT)
Received: from agape ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id h63sm2557871wmh.13.2021.04.13.07.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:10:46 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] staging: rtl8723bs: replace dump_drv_version usage with netdev_*
Date:   Tue, 13 Apr 2021 16:10:36 +0200
Message-Id: <463d327e54e903b65f4700f966f0faae3c88d806.1618322367.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618322367.git.fabioaiuto83@gmail.com>
References: <cover.1618322367.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace dump_drv_version() usage with netdev_dbg().

The string printed is the same contained in DBG_871X_SEL_NL macro
called inside dump_drv_version().

This is just preparation before bulk DBG_871X_SEL_NL macro
replacement by coccinelle.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 332855103b14..98c9eb399ba7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2590,7 +2590,7 @@ static int rtw_dbg_port(struct net_device *dev,
 					break;
 
 				case 0x10:/*  driver version display */
-					dump_drv_version(RTW_DBGDUMP);
+					netdev_dbg(dev, "%s %s\n", "rtl8723bs", DRIVERVERSION);
 					break;
 				case 0x11:/* dump linked status */
 					{
-- 
2.20.1

