Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038ED35386D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhDDOLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhDDOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A414EC06178C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q26so3086462wrz.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kcJCSOmYpxcf+ptWmUJmH8IOVjOvLmxAelD1jsprrwA=;
        b=gBvwJYaTt2zvSgsPzz76Tz+Ew4kbmCTLkq6UnLfZN8DXnV/t5smNq9mGoiPyCPAjOq
         FjnwYdAGAR0itXn5dMVqU0QKsiT1/AsGSrg8iigQDnhRfigTpvRJCsEsxShDH8oCqR/w
         2wLm/WOEqmjVPzb2n1ang5bnaecYauB1rK0kvuKnS5bTot2ybNYWTShuyJI3sQnXqs6i
         3IdMMeCPn/YdgyLET3qo1WkRlAJBqDJB9FO2OEm9K5nnC5EmLAIsF1XQX18vh3cHcUUe
         JPFJ+Kob3qW0RqAAme1FmVlYCcxo+HeMsMAQ8TnRUQeHA80AW6hDe178hzYC/I0GgTU8
         Wy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kcJCSOmYpxcf+ptWmUJmH8IOVjOvLmxAelD1jsprrwA=;
        b=iFMlF907Ye+nPsQeEIZO6wVFI7I1n+9uQ1qE+JTxgRLv1Gq0fF6h9qTuNBgfx3zuF1
         dF218kPNosQ7BXmG0wLxSstm6rNZeISjwQGELzpQWXIMfIL/w2HYcfAL2+SEjQB6jAYX
         DDhQiDmpA9ognFM3chSuOtwYbDv1EIrGzheM9tkyVVSxzY1YaNp5V9VCA8kXMy3XAgW8
         TsUm6VhFpGFJz2O3QJrjoFq0JChUz2tZT8+It6PrkZBIAPQmu14/DqVqJN+XzekJQjeD
         uUPctrxP0fYPPVpbAhNEwdSmoISHrxBr3HuxNaUHCCVNdSRyTm1Yk/vX7+B01f5rz5Jt
         MplQ==
X-Gm-Message-State: AOAM533tGZ+vDCZAZD1YVy+DHJk/FHkA3aIIOqvAMkrwKl71gWCWzw14
        zjGNV/pzjXpLaEQIrH6Epz0=
X-Google-Smtp-Source: ABdhPJzzuJPTOufJ7JDA3PtMEWVU2CQ8IqzuGm+9c+nN/MX85b1WfLEKx170oy4gSq9gXWLn68QUng==
X-Received: by 2002:adf:f852:: with SMTP id d18mr25339907wrq.210.1617545433440;
        Sun, 04 Apr 2021 07:10:33 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id s8sm22959559wrn.97.2021.04.04.07.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:33 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 26/30] staging: rtl8723bs: place constant on the right side of the test in core/rtw_ioctl_set.c
Date:   Sun,  4 Apr 2021 16:09:42 +0200
Message-Id: <3c701cacd71a6bb0f59242fc3a987f72dabb93e2.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix posst-commit hook checkpatch issues:

WARNING: Comparisons should place the constant on the right
side of the test
40: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:71:
+			if (_SUCCESS != ret)

WARNING: Comparisons should place the constant on the right
side of the test
69: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:122:
+					if (_SUCCESS != ret)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index d4920d7d2452..f8c7dcb7ab7d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -68,7 +68,7 @@ u8 rtw_do_join(struct adapter *padapter)
 		) {
 			/*  submit site_survey_cmd */
 			ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
-			if (_SUCCESS != ret)
+			if (ret != _SUCCESS)
 				pmlmepriv->to_join = false;
 
 		} else {
@@ -119,7 +119,7 @@ u8 rtw_do_join(struct adapter *padapter)
 				) {
 					/* DBG_871X("rtw_do_join() when   no desired bss in scanning queue\n"); */
 					ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
-					if (_SUCCESS != ret)
+					if (ret != _SUCCESS)
 						pmlmepriv->to_join = false;
 
 				} else {
-- 
2.20.1

