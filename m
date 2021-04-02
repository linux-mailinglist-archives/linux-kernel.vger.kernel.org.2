Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B136F352E51
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhDBRax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbhDBRae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F596C061793
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x16so5299144wrn.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ULcQBJvwq00kxo+MUlfT6iZD9rWlW6MHdTP2UqY74JA=;
        b=So9JIf9PtjZm33IXUzoEqTlz1UKnZK/cVt9puaVLhRD43wm99IVpnMb1JVn8ieh9w4
         kPdWzPuHiuQWMFeiKsnfXwPslUZi2qQVKqX2tHu8+1zZHDVYZFedrnt99nl0oSf8I+by
         CxX1PBpnduPmZXM0Pw/HwxKZT97orfRN8vaoSMyK3Er5aw5Z11j3wxKADG9MJUdAbeKw
         Ws7FfpwZRtnTH90S0N+wKhRIZVVrxtyxOgwzCyPiaRtaKHfFtf4l+IHNeeh0EY+yp0Nx
         TIchbD6bEBwbe23xJF46U/lRX/y/Mlu46E+62G7Pwz7ydfuX5DRvJt4yq0sK6hBBbfW8
         p2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ULcQBJvwq00kxo+MUlfT6iZD9rWlW6MHdTP2UqY74JA=;
        b=YaNJ3HYzwmE+2qZDayj3PiYuY+eqjglgWy5QE23cZeX9BudlIpB11QhtuDsqfs1Zmd
         euaJKvmdsDC2tzObja/Lm1nN8h7Y9H1V8/cGg9gfCs+PzSzv/NwDRtm3lnIrQGUOp6KT
         5d7SQTVqbQfZadcrHsm/2wUKOxIHXIoyitmI+kB7EPnWB4mQ49sfetRTZXsPnDJubpeI
         uoTQrqzYuqKxsurTeAISnPlqgZ3wc30ep8AZijl91ggxaR3xN6e2hL/Bsiu9EzfGjWge
         mdYRvfFlkGU/qy6HeJvNcDp6uV5SBZq44wA2oib4eq0vs8+ay5NwCD2VI+//Bw7MgzEa
         kNtg==
X-Gm-Message-State: AOAM531vJhzogfWkRPgZ4vE0Q5SYXwWud8vQADr3VW2lq9UQu/tP0YhU
        Tl6AKDzmElLu4njS8daTxLo=
X-Google-Smtp-Source: ABdhPJwm9k9VkqyTGYxUHUUHs+lUCiqeTaCj0hBX+Jhp/+IULblEjAdrHuTr7PBFCPG4d+PIKmHXow==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr16578327wrm.148.1617384631850;
        Fri, 02 Apr 2021 10:30:31 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id g5sm15456952wrq.30.2021.04.02.10.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:31 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 09/30] staging: rtl8723bs: fix logical continuation issue
Date:   Fri,  2 Apr 2021 19:29:51 +0200
Message-Id: <178814363f7d1282e0bc79d86ba182a35c4b8d85.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook issue:

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

