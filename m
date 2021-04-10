Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AD735AEA8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhDJPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 11:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbhDJPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 11:00:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2ECC06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 08:00:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a7so13169587eju.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 08:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HBudnlgBbgfTMMB5wWvaY2YPBfD3jKz3AvHUYC6wfiU=;
        b=KXn/WS0nh8U5TCwCHs9nhls7+Wi1VipCJrtUFEWprx4nvj05F0iCWB/h+lQGtbTTVd
         5GqPxxgtnUH8u1uUkNYjYxa0KaxwjC38zR7sJyZZ4Q4FDxbNU6bxN2QBsofVr11NVb/w
         /Ub0Gz0e/QrXCmviLRWnpZQNuWzv1dGrVpfNJYN/OyP0NkE4khGkp+s5XHOfV5LPSO4X
         1OO3f1IeNn34shVpRBlzlqtHkp1pU7p6UyVIMdRpRo6ytbn+E2yg40K8rU0BNLgHuwSD
         5rMoxaSOMmebyLrC88halSacUYyBuGGoqSMQcqFbXHtFZEPvknuWPdqX1aV8LmY/tp6J
         ioOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBudnlgBbgfTMMB5wWvaY2YPBfD3jKz3AvHUYC6wfiU=;
        b=T3T7k5Sc8PjeNs1hqBEBSNR1NEVdse/BPNptxZZjN+UY0f2z8KAeBRjDkXaCdUy+DA
         1JBgKMUoWT7wLx/K7fIojttCktUo62U029XQawfWlpUlS8mOmwYGVBy8f919FvK60SUj
         Thg8jkA4WxLsPS2qlT2jEkcDHNw8bdBDtHPFo+SBc1LLvGYjoKMsSu+B99ozf/jjKtFi
         JoZA/C8Fe7VQXs0NPb5VNIwaXqrRw1BAEzbMABTovIrhWjPTyg2YdT3J4/W4CQKDx8u1
         s8dOvRCNCRVCkyj1/X12xJv5qvgsbgKJ35FLryFzufC3yAUg678WUQQ8HDwCzTYRKnzM
         OXZQ==
X-Gm-Message-State: AOAM530xVMtkhPa+UkiYqQ27S0RXMUdJ1FtBAjn0vLw5IuAQNrMFKcHj
        wbWNJZrewmDJPL96GBDA/iBcttc4E35/ccBm
X-Google-Smtp-Source: ABdhPJy3Pso3VQyp2/erSKZ1q+PkaTfsXQRbsZgriQsRZJIomIIh6WMSQ6NXwDkOOz4Wcs2NQXFy0A==
X-Received: by 2002:a17:907:9858:: with SMTP id jj24mr20174686ejc.212.1618066842785;
        Sat, 10 Apr 2021 08:00:42 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id gb4sm2719494ejc.122.2021.04.10.08.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 08:00:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v2 5/5] staging: rtl8723bs: core: Change a controlling expression
Date:   Sat, 10 Apr 2021 17:00:08 +0200
Message-Id: <20210410150008.5460-6-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410150008.5460-1-fmdefrancesco@gmail.com>
References: <20210410150008.5460-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change a controlling expression within an 'if' statement: don't compare
with 'true'.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v1: No changes. This related patch is new to this series.

 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 32079e0f71d5..600366cb1aeb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1507,7 +1507,7 @@ static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)
 	if (pwrpriv->dtim != dtim)
 		pwrpriv->dtim = dtim;
 
-	if ((pwrpriv->fw_current_in_ps_mode == true) && (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
+	if ((pwrpriv->fw_current_in_ps_mode) && (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
 		u8 ps_mode = pwrpriv->pwr_mode;
 
 		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
-- 
2.31.1

