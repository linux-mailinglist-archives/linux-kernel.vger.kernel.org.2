Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520B53CC3EB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhGQPAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbhGQPAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:00:02 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C893C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso8512734wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkGUfOrzJrq03bJ94d60KH9BEKG2dNakYwWHuVXNqwE=;
        b=lCNNe3OjZxP5P54VFC1ZhVafrOkqYEtoL01Sw5T6qMakle6EOip53JBVBwsA+29YrG
         +1t8J8kxyIB99J6dl28QmI2XN2L8uX8qyDJg/jl0aO0CLNU+UD30iUiU/q47zvbjjkEJ
         P8DQQQQTfYGzXbbG2HF1Kiq6LfOmYcnmqoBcOL2Kmm5HU8manyZVCyiVOghUSSO84udQ
         TrrrzMiE4nV9Djvd37jo1Sm+vQ/KYv0/x+SJ/pVw7Vf30thn/Xo+K0zCOD/42dYtppBx
         49UqBJ1RrFHjxs2g/86AmhPr31vDxH4ORELgwlsaD+fXEZ62fUSeJVOmg8XjCoqM/Sre
         sCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkGUfOrzJrq03bJ94d60KH9BEKG2dNakYwWHuVXNqwE=;
        b=BgCZnTEmE6Os4djVEWZBUoPqo4A8d17SrSb3PvkxSP+kmBSxa92zyLfivF+qY19TNt
         rdVAoOoRd9aqvtQRAEI1GTPOwbojOQ6x4b9dQvCuXn48Q+8hGyOGmtoAUZywOGydPd3b
         q3TizNQxO5B+63DrYGqgj/dWeIQxdTGyshC5syq/UUMYkh5igmBpB6bh24QGw+CbZgbD
         eWgK2KDuYt8jzpUnkZRnupeef/MR+tvff50OIL4CgwhYSXZaC4I8Quski14XKjSUqFmH
         UaJZe+zg5MEG+EHKGGZSvhgyRVSWjFEq3BAC5uQB4b70my5kKh7Auy83ZD80rEZ7hdsy
         rUZg==
X-Gm-Message-State: AOAM533P9t3PTsisNvaRh5vyo08nhUp9duy7JJvu4GeLaNcs5rMM15/K
        AXaWhnCGCAwWMH7AsE1BjvjaGx0VWyc=
X-Google-Smtp-Source: ABdhPJypmgEFcxEUiiJFN6Q95kDh4Imz7D+CHEl3T6cnYmHUZ6oLJen25XNYgd3sIvOrC6i9POa5NQ==
X-Received: by 2002:a7b:ca45:: with SMTP id m5mr16836386wml.46.1626533824674;
        Sat, 17 Jul 2021 07:57:04 -0700 (PDT)
Received: from agape ([5.171.72.101])
        by smtp.gmail.com with ESMTPSA id v21sm14404005wml.5.2021.07.17.07.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:57:04 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] staging: rtl8723bs: remove unused macros in include/ieee80211.h
Date:   Sat, 17 Jul 2021 16:56:49 +0200
Message-Id: <c50cba3974772347888bd55085b1e5e44ef0687d.1626533647.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626533647.git.fabioaiuto83@gmail.com>
References: <cover.1626533647.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macros in include/ieee80211.h

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index f29b7a92d9ac..9fa79146c39a 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -158,15 +158,7 @@ enum network_type {
 
 #define is_supported_24g(net_type) ((net_type) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
 
-#define IsEnableHWCCK(net_type) is_supported_24g(net_type)
-#define IsEnableHWOFDM(NetType) (((NetType) & (WIRELESS_11G|WIRELESS_11_24N)) ? true : false)
-
-#define IsSupportedRxCCK(NetType) IsEnableHWCCK(NetType)
-#define IsSupportedRxOFDM(NetType) IsEnableHWOFDM(NetType)
-#define IsSupportedRxHT(NetType) IsEnableHWOFDM(NetType)
-
 #define IsSupportedTxCCK(NetType) (((NetType) & (WIRELESS_11B)) ? true : false)
-#define IsSupportedTxOFDM(NetType) (((NetType) & (WIRELESS_11G) ? true : false)
 #define is_supported_ht(net_type) (((net_type) & (WIRELESS_11_24N)) ? true : false)
 
 struct ieee_param {
-- 
2.20.1

