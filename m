Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCCF3F397F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 10:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhHUITL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 04:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhHUITJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 04:19:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35249C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 01:18:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t42so8129059pfg.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RJAC/f07BpsuUiR9wwzNtLb3iU9MWyJ5HfzOTPegqZA=;
        b=Qymu3qti9HvPD6olebVf3QwWfgX7tqoAtvo+fiNBoVq/jnCPaBG1NSrQQ8T8KZaS94
         N2k/WhlmnTj8XDw/qD0i4fFmTvMi0GTazJTFFZrc58/LlJBsN/tD+qL9OJ7eBWiOeUal
         Far2W5nnFNVO/W7tAMnRZd4Egzl50gA6utOzsKMVAxhFmzVlJlU70p+ntm2fLFVwz7Mu
         I6T5k2ISpRYWK/F9sigQisKIQinVBcczpZUEN6hSY0cAbw4A3wNHddQvIU0gQeX8lBiH
         64G2du0pTuNiweoer+hpd5Nj+1Rf5VrXxFEXTZdwnVITZ+suazbNUWVKQgKQHpsWn8vM
         xX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RJAC/f07BpsuUiR9wwzNtLb3iU9MWyJ5HfzOTPegqZA=;
        b=PCBruZyE2jzcApxuy+YwWk2ucY9m4x+oIas/tNkiY8quCcctkMb3ti7/ED8OHkeUaL
         uQDdvhSnrP9Mk61jD8DnqFaNzRxPgnMnFqR534SAf0h99rEC3FHYXWmByxwKcm3EDenI
         LkbRN8LTlYtWrv4KRvC2NuzeWtKFsNb8gH6HNl/+aLjWtIIC4rQ1KiBuUMJdcxQ8OhSg
         GVlGldjycGceIkDrs+B1obtoOiH7rqwbF+PsEzmnIOLCLTHpj39PRICGkVbK9BJlZQNy
         /hcZXwy8RLXNH/W6lxzVV4na76xYKxx1mip7vgICOd6P34U06tmCJ1ydVW0+YehuTKur
         v6Lg==
X-Gm-Message-State: AOAM530A0swr9jOWGVWQNqeSVQK1uH2o0nuiJrjLZ1m7YJlRlDrtj7HD
        P8myrCHevrx7nZTtw+DY1wY=
X-Google-Smtp-Source: ABdhPJxzipel1SxX8sboBYvkUiTP+xSip/Yj3F9h8DRpn7dFGrHF6KW/f67RUv1KYhOwEuidv20vnA==
X-Received: by 2002:a62:1ad2:0:b029:3e0:7eb7:a6bd with SMTP id a201-20020a621ad20000b02903e07eb7a6bdmr23968580pfa.51.1629533909800;
        Sat, 21 Aug 2021 01:18:29 -0700 (PDT)
Received: from localhost ([203.205.141.70])
        by smtp.gmail.com with ESMTPSA id e4sm10803463pgt.22.2021.08.21.01.18.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Aug 2021 01:18:29 -0700 (PDT)
From:   Xiangyang Zhang <xyz.sun.ok@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        xyz.sun.ok@gmail.com
Subject: [PATCH] staging: r8188eu: Fix a resource leak in update_bcn_wps_ie
Date:   Sat, 21 Aug 2021 16:18:24 +0800
Message-Id: <20210821081824.14745-1-xyz.sun.ok@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "pbackup_remainder_ie" variable is not freed when "pwps_ie_src" is null

Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
Signed-off-by: Xiangyang Zhang <xyz.sun.ok@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 1127e9a52458..2ce982390c7b 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -1300,7 +1300,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 
 	pwps_ie_src = pmlmepriv->wps_beacon_ie;
 	if (!pwps_ie_src)
-		return;
+		goto exit;
 
 	wps_ielen = (uint)pwps_ie_src[1];/* to get ie data len */
 	if ((wps_offset + wps_ielen + 2 + remainder_ielen) <= MAX_IE_SZ) {
@@ -1314,6 +1314,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 		pnetwork->IELength = wps_offset + (wps_ielen + 2) + remainder_ielen;
 	}
 
+exit:
 	kfree(pbackup_remainder_ie);
 }
 
-- 
2.19.1

