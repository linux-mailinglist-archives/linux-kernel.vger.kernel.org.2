Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65EA35332F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhDCJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDCJOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4CBC061788
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 12so3451524wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+xwuMQ9miiJI3ZL7Gy8Q2GKln0XoUkaK0hGIQWaMFY=;
        b=jXR9PoaQ5fuqg2K1PISHtU7EW/6mprl8LtwthdIpPxbiI0AVj3qqjbwCsiiKbPeM3W
         U1vX2Eb4K1I+MkuYeWgQWGCHUNhJwM3gL1/HRincTVh4/RssskOyI3oDDdP4qWVPpCq6
         ZmWA0s8kt7g8i80SzdNPZ3N0J/fBNC+lFqLwXv5q6Ck64HWqB9IplSxSV6SxZXjE0zFO
         6rBfmRVRgjctITvlzSnKEVcEb9ZTHBfp0nti8mooMbvqd2/2eLE06/uGJFBVlqdTboMk
         2/7awuGvMr/TpKIYWGenS8iQba89Kn76d/Yld/M7jhxiBMjbCc4Z6cBrh+o9t9LN5OAN
         d4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+xwuMQ9miiJI3ZL7Gy8Q2GKln0XoUkaK0hGIQWaMFY=;
        b=V98Ugh+WKS1SOV66b0glldibcHIkBUp8MWIm1TMULvSS2wrEbenMbP05+TJzQVI1bd
         0z4U2b9m4ebnwtxOK0UqVhiyHm4I8Bx67O6aDwF/p7Ve4Tf/0SyI6wqsI7Lqi/us9ktm
         HORrECwauDj7AAksY7YwXTk8m4rXF/2laRGdzxM6Izd16SgDaGtceVMg0A3MM9ikV/Kg
         1ZFPLcOgdibq0Fi/aII/8tXg1Vb4rvLPA7R7oc9vtvilGqtWP6vtuKc6Brp3ANJnLvNi
         ao8go9SywJIJ6VNDKRIQ32lUt4FmdbAQ/rxEvnsqn+9jfhoOoLxD9ZXX1xjJwlkMU0Ln
         b51A==
X-Gm-Message-State: AOAM533a2JOqH9/7P2yqA5LmijGmYyELYOloyvVkS7HeR8/+KO/ghBb0
        I6jjHeuhTkVR4LkBK7Ij5Mw=
X-Google-Smtp-Source: ABdhPJymoLM8xMQgsXMwQcb728dHLZgUPfeQF+Jd47gAHdBivNEolbI3mqVdnbAJ+Q++blT6y9TRVA==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr15942405wma.141.1617441270184;
        Sat, 03 Apr 2021 02:14:30 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id q9sm17286733wrp.79.2021.04.03.02.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:29 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 10/30] staging: rtl8723bs: remove unnecessary parentheses in if-condition in core/rtw_pwrctrl.c
Date:   Sat,  3 Apr 2021 11:13:32 +0200
Message-Id: <d4d1d256586cbdfc55157b0b384b28d53a61c2b8.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
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

