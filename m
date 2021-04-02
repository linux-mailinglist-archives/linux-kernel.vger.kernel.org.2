Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C937352E6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhDBRcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbhDBRbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:31:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F978C0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:31:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e18so5294057wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H7gV2Io75BmHpwhQaw6NovithxcDv0ix+Sn60I7HwJo=;
        b=pKGiotCcrQz5pFszeTD6f9yDGZSlaGCS3aqLvuhtA3bKa1tJgaHoEHvi3flxL/J0Ee
         8MTLml3KZviC8nKyEiyZ+jqrSJtyaC07UsA06nrfet538QtXSIIvGMsLtZFLUTq2bMMI
         lfnAvWknnEiUAnPG38Ha/+ueXLeggua+hpahSCaUZ4aLqUcJLQkCap8SvLdB0cunmvg8
         HAIgzI11uk2P3cUNPIwq/xsAITEeY/BguojAV6kr+KPz1zQblmClZlZM+M+Ux1Am6W93
         dnvfi79Kg2HDRMGq6DfHlwi8h3CW/uC3Vw0o/Dgelumh2SyVhEh1NfTgxxw/3PS5anUV
         aN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H7gV2Io75BmHpwhQaw6NovithxcDv0ix+Sn60I7HwJo=;
        b=J2013YQIqub5XRjkv8RjU33/tabIZjciG2y4NJBNSx0YfDbUPqtUWbvk8KGTikasdN
         8qHoAKJCb0rakMu/oHaKg2nX+5tBmrsuj9Pr6Nl9ubXVSnKt5cr4riaLBx/iDdWw3gbz
         n4qDsUHDsoQYwflOr7huFdVXsnnrflo1Ce8V/MSBypSr/doKAVL00q4/yNHgBDq4x64N
         rjnXADXyLW6wIB38SHXGaKagavFgetjNZMaFZVnJoDbeO7U1IwKm4F2wMCNrfiyomQdI
         sx6nAAOVCNto8Wm8HrVZiBjDGmcP80zgKgPDu+y9sJhntHyJ2IXgfXCqOaBM66uJV1Eh
         gyuw==
X-Gm-Message-State: AOAM530CiGrpPh1Bz8xVg43AgxFcHsIXKBgrcSRTfRCl7IJQlytBVcAF
        IhwjEvfkJvm3A0R57u9JgQ8=
X-Google-Smtp-Source: ABdhPJwj3qNDgK5LiKlA2HmtBn18REMsm+NuhHHnNLSvlO44ziCBPkiyaZwQv5wG/SLX3ue/Atwsgg==
X-Received: by 2002:a5d:4203:: with SMTP id n3mr15992886wrq.116.1617384665895;
        Fri, 02 Apr 2021 10:31:05 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id u9sm12408511wmc.38.2021.04.02.10.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:31:05 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 30/30] staging: rtl8723bs: add spaces around operators
Date:   Fri,  2 Apr 2021 19:30:12 +0200
Message-Id: <c79d3561d861f59c23e251b28da7934b20b7e096.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issues:

CHECK: spaces preferred around that '+' (ctx:VxV)
161: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:648:
+			*wpa_len = in_ie[cnt+1]+2;
 			                    ^

CHECK: spaces preferred around that '+' (ctx:VxV)
161: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:648:
+			*wpa_len = in_ie[cnt+1]+2;
 			                       ^

CHECK: spaces preferred around that '+' (ctx:VxV)
162: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:649:
+			cnt += in_ie[cnt+1]+2;  /* get next */
 			                ^

CHECK: spaces preferred around that '+' (ctx:VxV)
162: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:649:
+			cnt += in_ie[cnt+1]+2;  /* get next */
 			                   ^

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index eb2058f2d139..a0d664e254a8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -645,8 +645,8 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 			if (wpa_ie)
 				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt+1]+2);
 
-			*wpa_len = in_ie[cnt+1]+2;
-			cnt += in_ie[cnt+1]+2;  /* get next */
+			*wpa_len = in_ie[cnt + 1] + 2;
+			cnt += in_ie[cnt + 1] + 2;  /* get next */
 		} else {
 			if (authmode == WLAN_EID_RSN) {
 				if (rsn_ie)
-- 
2.20.1

