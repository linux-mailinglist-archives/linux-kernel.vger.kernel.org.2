Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C9C352945
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhDBKCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbhDBKCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:02:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8ADC06178A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 03:02:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h10so4920376edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 03:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JF/B2DTWQj/w/voWt1Q8G3VMWTtinDgQ1FwmaBkjzU=;
        b=VOZjXsKNDs/43HC/yzuSI2IhkHsNbgagKnNvPhzvZMXHyU7ax1sAfuzjwhFyY98MMw
         dLkRqxBtgnB8Hynl5XsCDMQLZuHiW0H1Kj2Gy1+FxwTYHP177prSt6eSCpm8JaX3vNsY
         AdtdpdWH4SU/Z8CACyG35bDnJi/KhWXfaFyXzRQ2Jyr3RGSZzscm3lL9jcqqorzetfsV
         28auFWPYLBh3Q796Qr+N53OeqSNNST+4PXusQY9aYVy5vP40JP13eB8b3t3Z2oTjg0VK
         kuM4NEZCM40JFvpH8Y8swjqwtnCt47hyK9Xtmg7oS+t/jCxBFwVt5iWCP53JjiUm35Of
         P8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JF/B2DTWQj/w/voWt1Q8G3VMWTtinDgQ1FwmaBkjzU=;
        b=r4nPfTqzUOST610kjbHjPuHXoI93R3DGLzodbl5BINbCwIeLBU9ODTYQe55I+IWMls
         qQW33vfTMclM3K2KmYwFk1FW4ZOo9XM5xyAvpGbSxv4Gez1QD8f74i/CLJwldDnEQQfY
         oCA86xK1DOxPCa88MfDZZLReWa3j0zgDkSOHE4IHsrjVzUWFEPSwspABbXzmoJO+7mov
         KJ3vRqpWBDJLVgpFKQxFCIXh3bVk16+74SJbeMk69i63RpmoB5tAWLSE7NIF+TFY52Fs
         CJ26NAujTATegcU+ezo2xQhKMgJFOWo1r1UVYJUxLvdMk78HlcAs0KKmhrO3pr5KYZTG
         l5nw==
X-Gm-Message-State: AOAM531xOskKWEXhUUBLxvTo8kOT2ldP9KCyVPcIjyQpaXiXhnyBSaIF
        9olMVwwySK7ma0WMFZrlqfE=
X-Google-Smtp-Source: ABdhPJxjdOT7EkL/Ri5zpv67Ha91FlYLy7Yfw/wWnWNdSbV7UfahWlzEu/lbhM+P2s/2+h32tju3NQ==
X-Received: by 2002:a05:6402:1d33:: with SMTP id dh19mr14555728edb.362.1617357727372;
        Fri, 02 Apr 2021 03:02:07 -0700 (PDT)
Received: from agape ([5.171.72.128])
        by smtp.gmail.com with ESMTPSA id k26sm3952485ejx.81.2021.04.02.03.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 03:02:07 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 12/16] staging: rtl8723bs: remove commented RT_TRACE call in core/rtw_ioctl_set.c
Date:   Fri,  2 Apr 2021 12:01:32 +0200
Message-Id: <65df341f90e3d62e00681a97997ae3112218189e.1617356821.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617356821.git.fabioaiuto83@gmail.com>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented RT_TRACE call in core/rtw_ioctl_set.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 7d858cae2395..14eb01df69b0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -451,9 +451,6 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 
 		/* SecClearAllKeys(adapter); */
 
-		/* RT_TRACE(COMP_OID_SET, DBG_LOUD, ("set_infrastructure: fw_state:%x after changing mode\n", */
-		/* 									get_fwstate(pmlmepriv))); */
-
 		spin_unlock_bh(&pmlmepriv->lock);
 	}
 	return true;
-- 
2.20.1

