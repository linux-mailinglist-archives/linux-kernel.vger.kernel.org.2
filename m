Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401544474E4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 19:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhKGSLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 13:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbhKGSLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 13:11:22 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9E7C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 10:08:39 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v20so14309676plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 10:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tRTkUL4b/IclFaICDSMtWkDgnrkgp3k8b9yxWekP0Y8=;
        b=fDq4DmzKqveY95pRinYiSMpm27KJdKM9s4iv2PCjY3mJA+1A2ZkXSjKXzJbfGfwn6J
         ejm88XAmveBmsfy/lXwdjUOvTbEKZOkm1H2gjYzKDr7SA+zNfVmukO4/3Md/7laK95z2
         JNhHJMhHPT6GtkFKiUCL2oqDVT1iR9TRibcEznkEMZwMLEhcoLCQwQaPJR3+4bKKR5ec
         5qPJHJ3oz2bNMpVA9DZ0hd/eibnZZegXEBhePhC4n5OdsZ51mJ31f58K3B7PA5Zf2s8+
         CrpXrYGhnFGHx25VtRiBgbI5rIGIs+6HYtj9dYY2ioVzcY35UZQGmxp7tNWiTOVQVjT9
         g/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tRTkUL4b/IclFaICDSMtWkDgnrkgp3k8b9yxWekP0Y8=;
        b=UNy+mY+7qNchjJaN+kGZqXn8h6breRmi7WbV2WBuonlTBJtAERqkmlzhx4RrE888ic
         xn34AFmbUUMnoq+yOO/ywEDVyUAIS8R+gJiYzLTnZRjGeBRBjO5GjP0ZCe+BuQeuC6X8
         5qcKrUZlvL9mvKc10bz5yn707aO6Lj6KzStyv1MIuUKo+woPp2jXmChc5dvH9+uF53vQ
         0juthMSi1qzyxFE+MUF5T5vGAq2hWn+ei8Xhr/uVkAaVr31gIxFyUiqUG3g5txoJJmXI
         T3+XIFd1uNnKrdhIY2lW3cUy+B6iyyEO570TxU1h6PH4LPtlwN73XIXw7KJpOgX0mqXG
         zl+w==
X-Gm-Message-State: AOAM533uvI+hL7W8e6z4rM6i/xT0v6mfniOzx8mHUe1Pu4dCXIW8CevO
        AFf6RoQitk1PxOAH8d6/sIQ=
X-Google-Smtp-Source: ABdhPJxR+zGhqbQeQM11xV9Or4sbOYBA3ysWv3GKcQtsi25ffpfgvDv83PAlD6TD4v9YckaCVJX61w==
X-Received: by 2002:a17:902:7107:b0:142:7a83:6dfe with SMTP id a7-20020a170902710700b001427a836dfemr2938682pll.0.1636308518407;
        Sun, 07 Nov 2021 10:08:38 -0800 (PST)
Received: from Sauravs-MacBook-Air.local ([59.88.109.27])
        by smtp.gmail.com with ESMTPSA id r1sm8450445pjm.23.2021.11.07.10.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 10:08:37 -0800 (PST)
Date:   Sun, 7 Nov 2021 23:38:30 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        kushalkothari285@gmail.com, fmdefrancesco@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        straube.linux@gmail.com, philippesdixon@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: core: avoid unnecessary if condition
Message-ID: <YYgWHt+PpyqOv40R@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rtw_lps_change_dtim_hdl remove the if condition check
to compare the pwrpriv->dtim to dtim . If both are not equal dtim
is getting assign to pwrpriv->dtim. But if both are equal assigning
dtim to pwrpriv->dtim will not make any difference on value. So remove
the unnecessary if condition check.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 639459d52261..bddfc02fb73e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1498,8 +1498,7 @@ static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)

 	mutex_lock(&pwrpriv->lock);

-	if (pwrpriv->dtim != dtim)
-		pwrpriv->dtim = dtim;
+	pwrpriv->dtim = dtim;

 	if (pwrpriv->fw_current_in_ps_mode && (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
 		u8 ps_mode = pwrpriv->pwr_mode;
--
2.33.0

