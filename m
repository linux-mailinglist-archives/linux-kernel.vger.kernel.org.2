Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D834F347D04
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbhCXPva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbhCXPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:50:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A89C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:50:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo1463325wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jI4V3DyYtzbeYdgtA2M2VZNwwzNsiKxsuKaAePYx0tI=;
        b=lwGqJeQkvSAMZWon1a2RGgxhia5jnv1MwaJRQTDrfZfhPOdoxd+8kxljpzUvGUOKNC
         saNNCOf+AmsVIuyEOUq9+6L0TaUKvO5PBrk12Md0DU/5Lw5TPJD79lxtlcWeJyJJ6ya3
         uIxAfBMGwhz6YnM8UEe03Md0Hj046XrchRO910C3VY9MOd8Z5jF5Ctg+JpNf0WZlASAl
         5b9xMuXCc2zT85jsdt3tu4RSkp/969pxplA/n68geIsA6M+SInFz5DzU8xfjqX+wi2rw
         9u/T4DZF80Or0Zuwi+oZ8hLHcZ3pSQ2/A1X7JdIt4c20um7dppY+OPKVY8IX3xI8EAZZ
         38Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jI4V3DyYtzbeYdgtA2M2VZNwwzNsiKxsuKaAePYx0tI=;
        b=hX1uNRNAPLjHxhCpgvSr+zgvZmaddTZtInXJnVajXULx9oizkGDrNUxD+cqJICSMJ9
         ztSUbcbFv+vq/Mb9vzrUtwjAGUoQoI3/1dpqLGp2sYNNICNTm2w+grkgUo46bBQkgd97
         XK0Vxu5xPxB0U/4pXDxfvI7t9QJRcVt1zycwDLILG8192l4T90/3AW5MDFzc4VOQKVV4
         Q4WmqeyJB5GzwVx1dXmv9G1mYbqSG7EB0QD8ef2wQbSaecLYubARVflgoeqE6NelLoz0
         e73DDU1aWTvKBj0etAs09kpXnSyuUGf4Ui71V8TmGoh52mvOtPfSsRcyNtiyf4YKHKHa
         FMVw==
X-Gm-Message-State: AOAM531OK5074DIYegkChYM2DGFYAXsgtOa5e1eD7bvvaIpEM8OxHide
        RbHLpWLeRIjKHcQcFBbbtvM=
X-Google-Smtp-Source: ABdhPJy7/rERgqmC0efLHqST9C3TgCO+KcJhvB4HvWw0FIfq+TMG7kFAqd/Vu8nh/tToUcsJhHbfHw==
X-Received: by 2002:a1c:771a:: with SMTP id t26mr3625475wmi.60.1616601053977;
        Wed, 24 Mar 2021 08:50:53 -0700 (PDT)
Received: from agape ([5.171.72.168])
        by smtp.gmail.com with ESMTPSA id 1sm6966823wmj.0.2021.03.24.08.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:50:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 3/3] staging: rtl8723bs: remove assignment in condition in os_dep/ioctl_linux.c
Date:   Wed, 24 Mar 2021 16:50:36 +0100
Message-Id: <98b58790ae7c791d091b301bccf67a70c41ec599.1616600897.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616600897.git.fabioaiuto83@gmail.com>
References: <cover.1616600897.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warning:

ERROR: do not use assignment in if condition
2607: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2607:
+	if (0 != (ret = rtw_change_ifname(padapter, new_ifname)))
--
ERROR: do not use assignment in if condition
4239: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:4239:
+	if (!(ext = vmalloc(len)))
--
ERROR: do not use assignment in if condition
4253: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:4253:
+	if (!(ext_dbg = vmalloc(len))) {

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 9909dece0b01..eac98e455413 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2604,7 +2604,8 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 		return ret;
 
 	DBG_871X("%s new_ifname:%s\n", __func__, new_ifname);
-	if (0 != (ret = rtw_change_ifname(padapter, new_ifname)))
+	ret = rtw_change_ifname(padapter, new_ifname);
+	if (ret != 0)
 		goto exit;
 
 	strncpy(rereg_priv->old_ifname, new_ifname, IFNAMSIZ);
@@ -4236,7 +4237,8 @@ static int rtw_wx_set_priv(struct net_device *dev,
 		return -EFAULT;
 
 	len = dwrq->length;
-	if (!(ext = vmalloc(len)))
+	ext = vmalloc(len);
+	if (!ext)
 		return -ENOMEM;
 
 	if (copy_from_user(ext, dwrq->pointer, len)) {
@@ -4250,7 +4252,8 @@ static int rtw_wx_set_priv(struct net_device *dev,
 	/* 	  dev->name, ext)); */
 
 	#ifdef DEBUG_RTW_WX_SET_PRIV
-	if (!(ext_dbg = vmalloc(len))) {
+	ext_dbg = vmalloc(len);
+	if (!ext_dbg) {
 		vfree(ext, len);
 		return -ENOMEM;
 	}
-- 
2.20.1

