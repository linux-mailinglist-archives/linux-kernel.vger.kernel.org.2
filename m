Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D4535FA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352870AbhDNSOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352365AbhDNSMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D90DC06138C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 18so24854826edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYMye0IWAuj8RFeZy63MkMZcxL0iTXzS4xtWYLiHck0=;
        b=yyXxxjs4IKHkj4wqcKroBryTI4rZQIegaaGKaAxZLY6tX0F6fdM4pMjkoT6R3EJTpl
         NtX6HJNG6M9w+OgqUOefcuXQwjTfShrEbVVvQIQe7EqzNkohAzNoOe4kS5W7443xtJ0k
         Xss/6U47Uyo2jesmXehzExNPzJ79Wgntv7QBy0LGoBaENwvA9RjQKxBcmnIpP5d5j4Xo
         C7xaBiNjWyVw3ZfKGiko9jjQ499ZmkIknvIkBMK+PNswu5NpQBnDK58CtVK6tcwNydWR
         +Cky4KD8RHcEJLGmVXU7OohKg68+zYmS6Y5VQF3f1UFPzMJdeYxWHv3EsSLyuN6hzFEK
         qU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYMye0IWAuj8RFeZy63MkMZcxL0iTXzS4xtWYLiHck0=;
        b=DyI/gzub1YxJKoXwn1D/i6iDxKBq6PpJSRxt2k0Kgaj12o7QmgeMm1rAcuD+B1xrIq
         pcWLt4yEXOWVvmHc3FHzUaAWG27kXhQ01qggTwvXe+ln5mitV0/mWyxYJeySX48zyUGO
         I+iP/e/+aHUiyn69wAVybKsXuuEsMR5G2hYOac93QFPRmTOw2ayGNFMuVngS0bfJf5GM
         1YHQc3rnlSmBfgEWDbLqaQcq9NRcfMU0chK3z4WlpK9peYQYDuVNPipSBz7PP/oEKktT
         yhFB7jdQsVBwv68ueskSBW0Wui77w+Hyg9+Qi4RN1zbNEdk8eZ8lAT1ova3MUXMvd06S
         Azkw==
X-Gm-Message-State: AOAM531nt6fXj9znnmVe3NsrUiHZtuiPsaDM3+OvRXduQk6QWcPWAIRt
        zaRfWZSLwkbxtRdR2xF08p0B/w==
X-Google-Smtp-Source: ABdhPJyf++VxWRoCuEVm0bnW+BwiCWtOScPptcrs64C6V2Xn9nFfEGPc7ER5jnI3NBYwMx7RkrHCuQ==
X-Received: by 2002:a05:6402:ca6:: with SMTP id cn6mr162082edb.169.1618423926974;
        Wed, 14 Apr 2021 11:12:06 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 31/57] staging: rtl8723bs: core: rtw_mlme: 'retry' is only used if REJOIN is set
Date:   Wed, 14 Apr 2021 19:11:03 +0100
Message-Id: <20210414181129.1628598-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/core/rtw_mlme.c: In function ‘rtw_joinbss_event_prehandle’:
 drivers/staging/rtl8723bs/core/rtw_mlme.c:1192:12: warning: variable ‘retry’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index c624887aeed0c..f8ce4f2d31e13 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1189,7 +1189,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 /* define REJOIN */
 void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 {
-	static u8 retry;
+	static u8 __maybe_unused retry;
 	struct sta_info *ptarget_sta = NULL, *pcur_sta = NULL;
 	struct	sta_priv *pstapriv = &adapter->stapriv;
 	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
-- 
2.27.0

