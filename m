Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3364435385C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhDDOKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhDDOKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FF2C0613E6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i18so5317146wrm.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJRj1n/cuhJAwDRjHiH4R8KD3m6yCHecaRSvaH7YYy4=;
        b=WJ78iTKhfMaahPc9Z/k2wDQYtzVIYNNGY9ixBq7QH3vX7zWAwYfl4QqFLHwOyyevj0
         ABHEr8AY31DfZCYr/o0zE/2HsY5cS3S6TL+/4v2DxEDtkXU8GaZhEASSbWH35j1H4/TG
         bIXHw7fOMPsBQtv5jAcZQsyaGcCLQvEnlPxT06jArH1i8ldfnyyqUzjVfT67iHS4VlLv
         JMVm1y5UvY2V6WSyltYhkLnBVb6gWUptnh+ixjUTxW79uz4q2N+b/DPVZSpsnQc69+K7
         iCS0CsJFdCsLHC13nucmo7GyAlPEoQDSYy8pt8bIPEvlx640Uofp0239dMr+lHdSSPFC
         kqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJRj1n/cuhJAwDRjHiH4R8KD3m6yCHecaRSvaH7YYy4=;
        b=ddtaKJE6PhMYwrynLeuOLq0ak7knLz65usSR7ZQFAM1m1wXKR4CsqzRyB/n4N/MU5Y
         N/phE1rJQJjjhQsGaKVTVbOM9HPVZUap9BDqZ3cDtBCFuDjGuKg7UDkP3vGvKItR5k2y
         jLq2q6PdJv2yW6XYCAMkum2gXPX/XPdIz2zlF1bHxHvHHYWuUWNn1XrjVJbnPnPI2TP0
         OYa95PkFHPUyAn85KK28lXOZGNFCTbsejXii929RRUupQ0X4iW2i8snw0ouGkldjGmji
         Nl8hQ8U59Q7wRiDwy/F7vxJ5ipDv6ZIRHoY1MsrtDDSofCzd4OPvZuSNnxtgVUrl7H6c
         zLTg==
X-Gm-Message-State: AOAM533Fevi6qimkwrvpN6vmY2NOI8mM+dj5rjFhvPj3CB9Cd2wpe0yr
        DYB36gKpLAAQl3k1UOt9RlE=
X-Google-Smtp-Source: ABdhPJx3AmUpjkYciXT8sFswJpO8jkqb1oZyEtL2z+A9NcplRilpL4QoPPCtEvYODLLZtxmP3rPh7A==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr6750814wrv.142.1617545405535;
        Sun, 04 Apr 2021 07:10:05 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id r16sm22348349wrx.75.2021.04.04.07.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:05 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 09/30] staging: rtl8723bs: fix logical continuation issue in core/rtw_pwrctrl.c
Date:   Sun,  4 Apr 2021 16:09:25 +0200
Message-Id: <ecbd557c645e280a801c34d235559d2d138ec67f.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkpatch issue:

CHECK: Logical continuations should be on the previous line
22: FILE: drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:270:
 		if ((pwrpriv->rpwm == pslv)
+			|| ((pwrpriv->rpwm >= PS_STATE_S2)
		 && (pslv >= PS_STATE_S2)))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index cc1b0d1a5a7b..fa06144337ce 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -266,8 +266,8 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 	if (pwrpriv->brpwmtimeout) {
 		DBG_871X("%s: RPWM timeout, force to set RPWM(0x%02X) again!\n", __func__, pslv);
 	} else {
-		if ((pwrpriv->rpwm == pslv)
-			|| ((pwrpriv->rpwm >= PS_STATE_S2) && (pslv >= PS_STATE_S2)))
+		if ((pwrpriv->rpwm == pslv) ||
+		    ((pwrpriv->rpwm >= PS_STATE_S2) && (pslv >= PS_STATE_S2)))
 			return;
 
 	}
-- 
2.20.1

