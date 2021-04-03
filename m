Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BFA35333F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbhDCJPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbhDCJPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:15:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA8EC0613AA
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso5260875wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kcJCSOmYpxcf+ptWmUJmH8IOVjOvLmxAelD1jsprrwA=;
        b=NsCOfCdAPOYFI5rF/k94JrQH0iP0jY1f6Ki2X4GRhUGsLV3uaOPbVn7LTlnElfHZrJ
         S6zRwf9CqtwSFhrDq5+EPKqOXeEeHJRj7GhRLB4ra9kfhkspjO6+UlVERb93nll1gbMD
         T+zTC1Gx5Y1QucMIf2fD3SMQV3lcHKdMtmtFAdDOc+fAIYv5RDu6J018BH/cowNFNAa8
         X5t93LpB4C5m2gTOSxy4N8+qV/fc2MJ+MIwaTLrxEHxCUS2ysNl+j9+BeZjdnIyfuTZ0
         +k6rU4Jj+6y4FTeTVJ7I14ZWbyQ/9zG7Fcg3nP+ZAgyV6n+qCvYu+FrddCNpiKQ0bkAc
         gadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kcJCSOmYpxcf+ptWmUJmH8IOVjOvLmxAelD1jsprrwA=;
        b=jJh54RLLz8pj5uMFlWHah6ag21K0ZS04Boh38Ye9TkRSonj8rFG7aZbjmdGa6+Bk97
         I0a9OZGex0t8RQfKw6xdwahSi5ljfhbEqg6OHvzrnRY9bTxlzLOXQDlkIWgR9C1oAstp
         Ga49NvdIM+LCb6e4RObKMuk2eFxeaQBgcmZIzfzQHeFg41ahmy6pe6TKKIJIm/cyoBPm
         X38//rMwI2SzfK8BHu1tSZqTazqaryMFFY41dQYotnPU39YO6+n6lw339Ad97GHlcAH5
         DxHhBMeELIMy0gDkhSBmlFZBYyMVSI9EBIIwZR9kKm3C21hnXXBfxSadQJ1aQ+cMdyRN
         Npdw==
X-Gm-Message-State: AOAM531yZYH5SJ8cRvu0W525s/YplvR1Nagi0GCR15mB6vc71awNjTZW
        1N8PE6AIPjVzv2SF6OMz2jw=
X-Google-Smtp-Source: ABdhPJz/xw/ALhTRPzqp6L9s98fGL64FV1ArHlbskYN26JCZ+0KU7x4PXKxyO+gI5s4L8MYDMefbZQ==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr16515980wmi.79.1617441295022;
        Sat, 03 Apr 2021 02:14:55 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id a6sm17602863wmm.0.2021.04.03.02.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:54 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 26/30] staging: rtl8723bs: place constant on the right side of the test in core/rtw_ioctl_set.c
Date:   Sat,  3 Apr 2021 11:13:48 +0200
Message-Id: <935085037d70767c828fa4cd15f03938401d889d.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
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

