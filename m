Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4DC35385D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhDDOKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhDDOKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C7C06178C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f6so2687972wrv.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+xwuMQ9miiJI3ZL7Gy8Q2GKln0XoUkaK0hGIQWaMFY=;
        b=QZpPuiorUwMQmgA9H90IworX86fxlDm0wbAStOXnIQO3FO25obfMIQwT+Np0NAL1xD
         FqYZlkFZ97uElLVY0Hty+mTz007LNjPHp7DeR0qpq7OmnQJPpAzMlr5c80Sx5iwghz+h
         xAz1k33eBR9SWvkowzbCsIVC/GjxwXBHbS4aVxJPJviGupW3k69xle4rE4NW7/rjQ+5t
         vzm1tBInye+mAsNyvj+IvTokL1q5lYVel8iJX9SV3P44+JKiSnpD/9ZHiKM7kslwBgDp
         viNUFUg87ZDcOxHBXDmXtk+7Hu0rqiLnRh7HN/QxLuGeX9DrgSpQguICYyUL9juttaw9
         wpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+xwuMQ9miiJI3ZL7Gy8Q2GKln0XoUkaK0hGIQWaMFY=;
        b=grLIfxNXb8X2DqUorA91sTFiaZZesf18Y089k6nHQ2pprPrJh4jo00wR02ameWDsFt
         slCSqD7Zz+RyFYS2rxbnuUMR3OuDh2HiIMXgqp/XZf8JJd9e3Ot9om3dRPC9z/pTPy1h
         1MdtGu+4AuLsBtJG2L5tyaMdF7YGLwzL2G5ZqCarf04qw0s6Mx6biB+sdcGOlj8le1sk
         R3gGT8nLYWpy+YHiyZAXS2qvy/Huwee3xmbPl6qEs79XX3bWNUjr8yPX1JVnMEwxCPg0
         K+PcDtxtjvksnE1B2getvHiV6EhE80gDCwiRANjDj783kZioO7WSlQuR7jGtxnJn0ly3
         kenQ==
X-Gm-Message-State: AOAM533mnmQctILmJHagsHTb5E2ZpsAz8b8Cc/6O8Thoev9yor3GaokB
        /YQnScFyMBq5SF5bc9DswpJPnZTwk+kzDw==
X-Google-Smtp-Source: ABdhPJyKrvQtSAca4y4RMJB4XeSHq5MGSqxC0GAQ6xcIlPx5JaNxxnCwTUZQK2msM2NEC0y/Mr4pfw==
X-Received: by 2002:adf:e90e:: with SMTP id f14mr1440645wrm.75.1617545407179;
        Sun, 04 Apr 2021 07:10:07 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id o15sm24460423wra.93.2021.04.04.07.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:06 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 10/30] staging: rtl8723bs: remove unnecessary parentheses in if-condition in core/rtw_pwrctrl.c
Date:   Sun,  4 Apr 2021 16:09:26 +0200
Message-Id: <d4d1d256586cbdfc55157b0b384b28d53a61c2b8.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkpatch issues:

CHECK: Unnecessary parentheses around 'pwrpriv->rpwm == pslv'
26: FILE: drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:269:
+		if ((pwrpriv->rpwm == pslv) ||
+		    ((pwrpriv->rpwm >= PS_STATE_S2)
	&& (pslv >= PS_STATE_S2)))

CHECK: Unnecessary parentheses around 'pwrpriv->rpwm >= PS_STATE_S2'
26: FILE: drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:269:
+		if ((pwrpriv->rpwm == pslv) ||
+		    ((pwrpriv->rpwm >= PS_STATE_S2)
	&& (pslv >= PS_STATE_S2)))

CHECK: Unnecessary parentheses around 'pslv >= PS_STATE_S2'
26: FILE: drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:269:
+		if ((pwrpriv->rpwm == pslv) ||
+		    ((pwrpriv->rpwm >= PS_STATE_S2)
	&& (pslv >= PS_STATE_S2)))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index fa06144337ce..09bf25940e92 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -266,8 +266,8 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 	if (pwrpriv->brpwmtimeout) {
 		DBG_871X("%s: RPWM timeout, force to set RPWM(0x%02X) again!\n", __func__, pslv);
 	} else {
-		if ((pwrpriv->rpwm == pslv) ||
-		    ((pwrpriv->rpwm >= PS_STATE_S2) && (pslv >= PS_STATE_S2)))
+		if (pwrpriv->rpwm == pslv ||
+		    (pwrpriv->rpwm >= PS_STATE_S2 && pslv >= PS_STATE_S2))
 			return;
 
 	}
-- 
2.20.1

