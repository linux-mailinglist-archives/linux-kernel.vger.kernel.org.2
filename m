Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CB934FD2B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhCaJlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbhCaJke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b16so21518134eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JF/B2DTWQj/w/voWt1Q8G3VMWTtinDgQ1FwmaBkjzU=;
        b=Xchwqom267MoYT/kxUcurJ2fxRasvFUK4ZiUaB3GhuPMqxJ76SBQEYvyGnc1mOWYWz
         M5KXmPDuTgHWOzjlWhyHQoFDJYLyQ9CD49YPHzqbyym1REvMay1xaHutSDtQY/boP/lc
         yD4V748eYQTrhHaydBViY5JnLUxZfZIk7xJ+TqZndkIciPoFGH5lUT5P482TkO4P7Ml5
         vyUkrl0zCjj5y/po22B+/7VXPY+mHSi+8aPltwNpTmHFopdzcDnnMqalt3sgX9nroxXw
         gXih9OH3s23pi/Kwx9JLbbybB60jVac61sWu8NEWNAFJGD+4TC+zrbnVfpE+UDJzqgAK
         G2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JF/B2DTWQj/w/voWt1Q8G3VMWTtinDgQ1FwmaBkjzU=;
        b=tfWNEqL+7u4CZk0wrubVycTfu/voLdokwvOtELgpnGj2uG4EzTanygxQduBuuXwM+m
         h2j1oXdRWrUDYDEZYi7i0IAzAOkfxm8G490lhJlccvJn6ArwO3e8UqVuIuY6YBANzer1
         j1i1jCifCCRrQDg+qju8EYwGMgIzvYqFmv/iEhOR7fXv1pkVxoRAA18DPJuHbl+FQuQU
         T8a1VnQrsEXoLhy40RQv8LEuVOrflvPO8hzmepv1XAFfOPk4SadDO9B6PuaRaetslJ5Y
         V1bwN522gSC5LaCiIjz5gIs+CqhdoU46msk0alCFFGp+BaRPhnttWj0v+FYYdJ2cKPx8
         msPg==
X-Gm-Message-State: AOAM53271rZk6yImmnhS9QaZVl/ypn13UcDLuHqV8QjhuIXRyBxsgTnO
        gR9AuUQRHiuaEE7a9MxRer7hrmiB+q/NVw==
X-Google-Smtp-Source: ABdhPJzO8ZLbrtJXXI0WJntQYM6nbtdbUh6ttzd2nf3+P++hizNok3aA+t+jT5hCHjYMx4ERrdyhqQ==
X-Received: by 2002:aa7:da48:: with SMTP id w8mr2496933eds.81.1617183632812;
        Wed, 31 Mar 2021 02:40:32 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id q16sm849465ejd.15.2021.03.31.02.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 11/40] staging: rtl8723bs: remove commented RT_TRACE call in core/rtw_ioctl_set.c
Date:   Wed, 31 Mar 2021 11:39:39 +0200
Message-Id: <9f86621a574ce979e907384f0fc94425b7b63123.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
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

