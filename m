Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0DE352E66
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhDBRbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbhDBRbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:31:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80779C0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o16so5323110wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JF/B2DTWQj/w/voWt1Q8G3VMWTtinDgQ1FwmaBkjzU=;
        b=g+mGITlsuxJWzvIZseazZx95AkKh4h7A88iDYBbw4uUcuuKkuj1Y32Bu/ezehEFqjL
         MvhiSTopgpz3Ltqi4Xq959DsNBXZhBHNoKjME9f6hSYTeAZC66RMBLfmW5LJqlchE2+/
         H1kIQ1/I0K3xjgNae9car4C7Uyire7dtshFMDFzyJRlX+omqQhWrXq13HDDvAZwIBAm6
         H1qAgKjNvenEsI9c7vc7s1EvRM/jb0Pew4GHIX5CzJHugTJSeflJrC3Si37EnKDQPCCo
         T5is2eCiX7Mfc1/ZbYIomjtDiAsevBiQZEs59kFzdh0yfDHNEJxGAZsUEudIZmw0y23i
         fLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JF/B2DTWQj/w/voWt1Q8G3VMWTtinDgQ1FwmaBkjzU=;
        b=LfrYf4mTs9sFaf9f8OvKx1Zygfv6IWw1SSz642moHtJy/SP/0GM0HQTk30eJceU7My
         2Osb/XPVh7DWZgl/8bG54jT1tjT7yiI5Mq0M8azqYO72vZH7HyagxLb7Ut1OPfVnB0km
         vFjUQ3fWSrVfAs/9NQfzom2HsSUL5Df8LIZmkkPfkBza1gQXXYHrSSqlYdbYAQ+UGOeA
         E3D8Wxizq0/kyqWWm89NdbswJO0Z9ny8IVGqvEguRjM6aE6/zR902eJMlP/GHsd+Aq96
         19KGmt31A0HwcNkS9fg9CZw8u/42b6Q+QkjjiD5/QgFvwHf/71Spq3WG1w6yb/4ArU7I
         /BeQ==
X-Gm-Message-State: AOAM532Ge3aPRoEyMEaNfvBZSu1oT35cbXWg9jKlioXbDRCGWp8yJoUR
        bnG3sLguZq4DjH8xunOTzzg=
X-Google-Smtp-Source: ABdhPJyiQ6nmGJAs26YXtGngvZSYwlHeMmAlUngQsGQqV8Ub/lRCgNZ7ZoOdgWlkbeJPqwk7gM46uQ==
X-Received: by 2002:a5d:58fc:: with SMTP id f28mr15774072wrd.180.1617384656305;
        Fri, 02 Apr 2021 10:30:56 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id m2sm3372258wmq.6.2021.04.02.10.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 24/30] staging: rtl8723bs: remove commented RT_TRACE call in core/rtw_ioctl_set.c
Date:   Fri,  2 Apr 2021 19:30:06 +0200
Message-Id: <82b9fa684553a3b98d42481761787bc2dc10e544.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
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

