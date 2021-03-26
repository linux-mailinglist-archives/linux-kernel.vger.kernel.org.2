Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007D434AE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCZSHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCZSHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:07:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F80C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:07:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j9so4764407wrx.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wAmD6ytTwrfyQlONs9BcZVLvDpM+VeJBCdcfqLiuEa4=;
        b=QleMF9P1oL2czwD76yMt9OAUDXUEDVsHYcJZUYOsgnbEMywbKpX4fWUJyJg6CALK6U
         Enx3xMvFJNOAPObLvdKRvR6VwRpjukJ1SFGMx7tAgn61w4mUpxCDsjv+cczEfFV8/dfP
         g6hDmwx3sNAc56vwdWPvNNbz6Ito+9jBX1MC5mhufuH5kAXgZelGARG23OhfXS/fpHrk
         VXmdt3HR55j7rQS2JAzk3JVOgGYvJyPJ5qfWyJJw/pcITXZNaAwLIBtPJHhk1Iur1IC9
         bcEIyxWPxGsqdIvpseqt5E6VId6gV+sfPARIr7TsYkvAlHDm7j8PggthRR36W+95FZQ5
         4Wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wAmD6ytTwrfyQlONs9BcZVLvDpM+VeJBCdcfqLiuEa4=;
        b=NLHYHO7S8t+51wVGjtYXoZ2SJi6fO5R0OkJUDFRLDEe2BuRHe053HJhg4e493mieFv
         iR+KXYNOOxReqnML3Q9aRCgINeRucwjBFxYd+HEbd9GK8iaQNGCidxBFf2LbUTi73uFt
         8le56wISp7+ChZW8IaDz+Ed3o1r4v9ZI3TgTA5Zy5H7Co7mnkroRdNyBO75bHEz9AAcg
         u4LGgIjuSgG5CGVet5WvzAAxi+/oPURLBpGXQso54JYsoRxAn0gHXjXtNbvRNZLiIHiy
         mjv9SBudQzM9fUakRigjVsOCUAOJkekD7Yq6xfYu2ZZ0juOQA0xfksc7um1GWHDAgSEk
         mjjg==
X-Gm-Message-State: AOAM530wNvbL0FVGbZYWe/8MMYWjNEL75n4vp2XaFzJ+GM2uy99BX57x
        N6a0RiDjZ9VTUqQykJdcqM8=
X-Google-Smtp-Source: ABdhPJwnk7b4LMXe04/G3qi1KbAsSIeYZ307khr9oQ24D2Ylkab7QzqFANcRb6vjmRuPljO/baED4g==
X-Received: by 2002:adf:90f0:: with SMTP id i103mr15423979wri.318.1616782037719;
        Fri, 26 Mar 2021 11:07:17 -0700 (PDT)
Received: from agape ([151.37.215.119])
        by smtp.gmail.com with ESMTPSA id v7sm13030022wme.47.2021.03.26.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 11:07:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix broken indentation
Date:   Fri, 26 Mar 2021 19:06:32 +0100
Message-Id: <20210326180632.1859-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YF4J2JVz1tHiFsGJ@kroah.com>
References: <YF4J2JVz1tHiFsGJ@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix indentation broken by patch removing conditional
code blocks checked by unused
CONFIG_INTERRUPT_BASED_TXBCN family defines

Fixes: 65f183001f6e (staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_INTERRUPT_BASED_TXBCN*)
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 3cd9c61eec99..dc56477eb084 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -907,9 +907,9 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	if (pmlmeext->bstart_bss) {
 		update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 
-	/* issue beacon frame */
-	if (send_beacon(padapter) == _FAIL)
-		DBG_871X("issue_beacon, fail!\n");
+		/* issue beacon frame */
+		if (send_beacon(padapter) == _FAIL)
+			DBG_871X("issue_beacon, fail!\n");
 
 	}
 
-- 
2.20.1

