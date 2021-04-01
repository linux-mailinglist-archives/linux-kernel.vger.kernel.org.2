Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BBB3511F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhDAJWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhDAJV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAC6C06178A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y6so1170792eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZ5b7ao/ZXBfmZah2BX66hKezYl8HfGL05msSmUSV60=;
        b=JqYE6dexvnr0vWlIntrmoTG46FCTPQGmnER32LiN7Qzxla7syATeYrJCY8EKGy89fB
         Q9IsJE/i3TJb79BOGAFhUe55dcjEh3EoKzl7mUEJlbc8U0wgiRIiGRl8xCOchEu/V7Fp
         dpgnl6qMk9KmUhb7h78z/ZYGjJDEA1r8yVWyjeZERoZBKDroqkvbzQPQ9CmRmOWmiEUV
         xPl/0AoZ6qqeXKdY9aSCVYkOGssUGPbLk6kUZK7YfQDa24NKDfBVrXWtUg8OEtleH8SU
         uV9Qn3IQ18IaTvamWdZ/vo0EE0mJixeOMWP7exdmj9mHTXGeTY+BGqcQEmPYVFpa6H+5
         UAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZ5b7ao/ZXBfmZah2BX66hKezYl8HfGL05msSmUSV60=;
        b=PvYxAuAcYP14RypeV37u5wZCpAQSVDFy38+yMUzahWDWSD1YhIh0Jr0gRmhMF8gFf9
         sXSlsTkw/9NbbeudFBIUIceh7+vcRtxNhQFnzq0gYx8DAzl56T2wbIJ1rGrweWzHbgUi
         KOx72CKTQw7/3fFMylHX566/pzL/10DnsRkgwRxCWutQ+bx/55XPCTLdlDJpX1nsB137
         1UItGjqdgOVN9U38Xg9KSVAQLYlYKu9JIJuGBEN0C9OsM7VhC2MHFsydyUX3+u3tBLLI
         pVufdo+ZQmPiyoSGl6BIX0tc0jG9KdHyzv+TgP0SIwfL+KwrrTZrme+kC2buojYxyiaB
         dPSg==
X-Gm-Message-State: AOAM533pv0CXKNtCfTkUO4VX4/Ayyt4TMivV8166qQv8szWjuWAdGTQh
        d/uplWsM/9xCyJBfaXuInhE=
X-Google-Smtp-Source: ABdhPJxd8EFptUjoHx4I1U+bLj/s/lYI3U/iTgYCHn8xcImA3hFdEGNdH65lUT+IfVQ1ALqBZDsuNQ==
X-Received: by 2002:a05:6402:32a:: with SMTP id q10mr8692185edw.15.1617268915994;
        Thu, 01 Apr 2021 02:21:55 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id lu5sm2442044ejb.97.2021.04.01.02.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:55 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 20/49] staging: rtl8723bs: remove empty if-block in core/rtw_ioctl_set.c
Date:   Thu,  1 Apr 2021 11:20:50 +0200
Message-Id: <2eb03134008d273b89907dd67757d02c556131cd.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty if-block

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 44bead8cb6f4..080d548fe269 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -457,9 +457,6 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 		/*  Scan or linking is in progress, do nothing. */
 		res = true;
 
-		if (check_fwstate(pmlmepriv, (_FW_UNDER_SURVEY|_FW_UNDER_LINKING)) == true)
-			;
-
 	} else {
 		if (rtw_is_scan_deny(padapter)) {
 			DBG_871X(FUNC_ADPT_FMT": scan deny\n", FUNC_ADPT_ARG(padapter));
-- 
2.20.1

