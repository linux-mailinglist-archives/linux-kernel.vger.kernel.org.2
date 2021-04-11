Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9889B35B33D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 12:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhDKK4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 06:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbhDKK4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 06:56:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DED4C06138B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 03:56:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m3so11582511edv.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 03:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qc4L7mpVhXQBQoYV5Tcy9Lej5AGDlHmGHEiah52/mIw=;
        b=mBsMRDorAk089raaOhTUTUiHHHCe9k1DiZ3++uqwkN3GgtnEUhp88W2JSd2oZiXmin
         0RdtZ2cGEsrjoUBNAmf+AIQvC0EOLDs3bUY5DZuJduXTlNgfKcb7oIw5llBTKADMK+sG
         N9/1xbtHihljNMwZVB8lyCgZ4bqCyYLngCPZjN6MagvwRjIO6D0xBW8GNQJlgVumBc6O
         gXdE1l5vrZ+kL1QZ1cnjuh+5eUDDomrVls/cr24ratQC4Rty7a4YaDpu+qxsxs3BJ9iY
         XVci0CKIgjLmoZymtRGVbnt5Ojy45DhiY89h9GAyeWO6uQGMTdeBaM8uzMSooCe/0VYH
         Eo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qc4L7mpVhXQBQoYV5Tcy9Lej5AGDlHmGHEiah52/mIw=;
        b=mTy2izNfoiwgH133ZK3yA+EML932mffC3cS2YzrKugUHhLOvvu0JDGicxwfk2ELCel
         acuCkqiKjnInH18caNQG3i2zjifat8nn16wt3OkEppnzgJu3a1DRPzwrtStlVmlVWTJi
         IWuEoyOaLe/l4zCRiwXwe0f9osQ1GX+e618ovGBZP97osWeiQjyxT6YB+5pDyW4pSQ6w
         33dlpoxk6m+Oov8aHtZPqqi3eyDfvIpKQ/oDlE/S5YZwXR1c84LIgRdWyJFwm9E80CYk
         UBzzzlhTAS7SM3T/7Ya+pqsrVfPZUZhx2TMEpB9WIeTKIdyKo4j6ir3+6LiHhgrgAjUN
         VRgA==
X-Gm-Message-State: AOAM531JuGqIeZ21ESZPL+GChiwzzk4kVNqtNg+Pa1iPfmxkNsJRC2n2
        M77XH6ZM6hF7LEJ4dZfVrXI=
X-Google-Smtp-Source: ABdhPJyPDSCZQXH1xy/RfnN1chwFcehB0kN+sYLbW13jc9jR+RWT63U/7Ct+VVY5FfdDuNCiqZOf6g==
X-Received: by 2002:aa7:d54c:: with SMTP id u12mr25795830edr.234.1618138580394;
        Sun, 11 Apr 2021 03:56:20 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id f10sm4369100edd.29.2021.04.11.03.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 03:56:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v4 3/4] staging: rtl8723bs: include: Change the type of a variable
Date:   Sun, 11 Apr 2021 12:56:07 +0200
Message-Id: <20210411105608.12900-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210411105608.12900-1-fmdefrancesco@gmail.com>
References: <20210411105608.12900-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of fw_current_in_ps_mode from u8 to bool, because
it is used everywhere as a bool and, accordingly, it should be
declared as a bool.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v3: Move changes of controlling expressions in patch 4/4.
Changes from v2: Rewrite subject in patch 0/4; remove a patch from the
series because it had alreay been applied (rtl8723bs: core: Remove an unused variable).
Changes from v1: Fix a typo in subject of patch 1/5, add patch 5/5.

 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 0a48f1653be5..0767dbb84199 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -203,7 +203,7 @@ struct pwrctrl_priv {
 	u8 LpsIdleCount;
 	u8 power_mgnt;
 	u8 org_power_mgnt;
-	u8 fw_current_in_ps_mode;
+	bool fw_current_in_ps_mode;
 	unsigned long	DelayLPSLastTimeStamp;
 	s32		pnp_current_pwr_state;
 	u8 pnp_bstop_trx;
-- 
2.31.1

