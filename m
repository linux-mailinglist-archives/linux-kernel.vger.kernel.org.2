Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78213DBB6F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbhG3Oyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbhG3OyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:54:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4BBC061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:54:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x90so13541113ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2xzaJrImseVsg0eD7eqvnQOqrBfMMMSbm0GmyhxbspA=;
        b=TqjqRojEeoonR+e/y6+Hx6KQ6WdoPOvXxyKdLVTVWUFRM5KFTUSlLSXtR9E9iJ3Bo3
         z5eawBJm4Qf4L1basdD0Ms+9ZyVid5buEFyE6lzA3FEOHL6N7wRvCWL6dnEQ25t+BK5J
         ZuP3s2Qcs0Z6GC49LzttaKfvZzu/Z+e25ySX7B2xAuaH8bYZQZuXsdcpnJc6BmdwRpb3
         MnhfuiHGxpBfE7Dif/2Tc2gx/jBEP9E4z/iePfnnFRGIfzG17dNGzG3OtZcZ+j9xhxUS
         NJDJ6H/dKYs2HPIi6LJd2t8vs4BYEfe+T4oHnu/Ys/hKDFoFrzdfrYZbXxrv2uCT+sDk
         OVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2xzaJrImseVsg0eD7eqvnQOqrBfMMMSbm0GmyhxbspA=;
        b=uTwpoN8V/rwswLGvJPFXDlm8OTf4hpmLszGMfZER87gNuZOvVgFIlBNSbUiqVkSt59
         6E/Ihp+/t2Fwu4ET+dmeiqVc8EIhSfu5ltuDDYKf4aAnTmny0KUrXHs5tq89bC6Bj6jP
         u3CXiAH8yMo2ckPVCJ1FFmIAP2vl0/W7FlOPXUqnlaHFqAJFh+1FqLertEbeL+IXkfTz
         4UakqII3GeVefVVV+cIa71gNF8iWMDbixS45UhaENl4EZy0UdovBYYnnc3jHdYAJcXEj
         VukMTRzcfCpLLyJ9A6S82jVCsreSokOQWoMMRXLG14UDFfcuXhUlr+AIktIxtA/D/whA
         oIrA==
X-Gm-Message-State: AOAM531uTkBEd8qCmTkfZxDlmyUfA3zljoK0UejUAQ42eL/f385Dv1BP
        LfGtPZ3WXP2BZM021jjnbe+1MI5OX/M=
X-Google-Smtp-Source: ABdhPJxV+jqRQRU4MYngKlnSSf9iiMKrjIyyZ4MaEz1h2sBi9Ee5Hnv03Z87rt9CEUkAnCgYrwgEow==
X-Received: by 2002:aa7:cd03:: with SMTP id b3mr3473884edw.304.1627656853253;
        Fri, 30 Jul 2021 07:54:13 -0700 (PDT)
Received: from agape ([5.171.81.215])
        by smtp.gmail.com with ESMTPSA id fr4sm642921ejc.42.2021.07.30.07.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:54:13 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: rtl8723bs: remove unnecessary parentheses
Date:   Fri, 30 Jul 2021 16:54:06 +0200
Message-Id: <fca83a857ebb158cf395ea31f1834c04402c39e4.1627656773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1627656773.git.fabioaiuto83@gmail.com>
References: <cover.1627656773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issues:

CHECK: Unnecessary parentheses around
'pnetwork->network.ie_length > target->ie_length'
33: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:604:
+		if ((pnetwork->network.ie_length >
target->ie_length) && (target->reserved[0] == 1))

CHECK: Unnecessary parentheses around
'target->reserved[0] == 1'
33: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:604:
+		if ((pnetwork->network.ie_length >
target->ie_length) && (target->reserved[0] == 1))

CHECK: Unnecessary parentheses around
'target->reserved[0] != 2'
39: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:608:
+		if ((target->reserved[0] != 2) &&
+			(target->reserved[0] >=
		pnetwork->network.reserved[0])
 			) {

CHECK: Unnecessary parentheses around
'target->reserved[0] >= pnetwork->network.reserved[0]'
39: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:608:
+		if ((target->reserved[0] != 2) &&
+			(target->reserved[0]
		>= pnetwork->network.reserved[0])
 			) {

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 9f97986e8680..df599c2009b3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -601,12 +601,12 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 		pnetwork->last_scanned = jiffies;
 
 		/* target.reserved[0]== 1, means that scanned network is a bcn frame. */
-		if ((pnetwork->network.ie_length > target->ie_length) && (target->reserved[0] == 1))
+		if (pnetwork->network.ie_length > target->ie_length && target->reserved[0] == 1)
 			update_ie = false;
 
 		/*  probe resp(3) > beacon(1) > probe req(2) */
-		if ((target->reserved[0] != 2) &&
-			(target->reserved[0] >= pnetwork->network.reserved[0])
+		if (target->reserved[0] != 2 &&
+			target->reserved[0] >= pnetwork->network.reserved[0]
 			) {
 			update_ie = true;
 		} else {
-- 
2.20.1

