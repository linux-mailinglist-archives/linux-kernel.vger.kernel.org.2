Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4344D35332E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbhDCJOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbhDCJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BC8C061794
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f6so451490wrv.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJRj1n/cuhJAwDRjHiH4R8KD3m6yCHecaRSvaH7YYy4=;
        b=sqOqRDGvSR7BfEzg6VgpYtisECHQLZ1K5ogP6z626MyVIvNfYQKd7x+uU2yIpuWdjN
         EYoZVyNIuHh3hOk0twgd53u0XkwHqDYt9lvgNMfwp3ZBQxBskqhuekO9c3eRXM1oeZ9U
         o/5N57IulP0O/xhsi0EN2goFMa2vVd8a7o3TfGXn1bwDSW2qbcXUc8Spw0i3FYgM2P8s
         WW2HECjUXu21FuzuUibeCZKaEVWgkg2Kmg3X4/xnBrmoV0CDeTBHe1VaILaMtAFWoKUo
         Z3F+q5GPrHsjdCNjeCxE4Svum+5oK/X/LuIZcMxWZPRW1VlJ4w4JeBOP0YDWLgwlBRf6
         24EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJRj1n/cuhJAwDRjHiH4R8KD3m6yCHecaRSvaH7YYy4=;
        b=HqmbSS40o8/LzlZOcDhIqa5XX/ps7iO5aShMk6KaB8t9Iec+Y4bQ/xtOJHI/eZfvFg
         KVcBPEWAT9jAszz0ht+S+uznaMAeQFzn8k9YPQZev4uUr0SgfuMy3xRCUxinHwvW+De/
         mBHbnsny7Ox48n1IyLWRSt+TjE5K6Y52SZ/c4Ahn87TGAhxdTDH+0vZSDQuuK1wHA9nk
         TEr/ldU6cxijJORfqE67cWKflaRSNRNQRJ/K265hkBMHLTNRJZ66muyItKlTl9iu6Jn1
         qfneJD9JwXRMKypjlvhXFvw1xIyh1b4gqHIxNguAf3lmd7g4U37pLQWUYa4KlfjP4nqU
         Jing==
X-Gm-Message-State: AOAM531GuiByop3Xd7RnpFxxgz0yzk7Neh35h1/JBMzCJ+6lBjILCvxv
        t03HIoql64ab/l+6/vz9NCRpHO4yfIQ=
X-Google-Smtp-Source: ABdhPJzrgAZIxt/33N9S6giiTq1PrDxRkXrtuMpkSCIcBYS5RMdn4nXjq5Sl5rkC8jY0aWoYDtG8Uw==
X-Received: by 2002:a5d:4b0e:: with SMTP id v14mr19392087wrq.61.1617441268633;
        Sat, 03 Apr 2021 02:14:28 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id f4sm18662451wrz.4.2021.04.03.02.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:28 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 09/30] staging: rtl8723bs: fix logical continuation issue in core/rtw_pwrctrl.c
Date:   Sat,  3 Apr 2021 11:13:31 +0200
Message-Id: <ecbd557c645e280a801c34d235559d2d138ec67f.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
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

