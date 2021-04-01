Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF73511EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbhDAJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhDAJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BEAC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a7so1853183ejs.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vwTkwJLj057qjRGk5qprK4YhJpBpmhOZC6UYL7UeweI=;
        b=uTirED+FkCcb3BNVfz9ujknRCRyIrBiBji+BmnqA8dNcTdxB3JJk3QfpqUFu4Rv52p
         C8w/JDRv1FBRr6VM/YXaL+/8sUv5SujIGvAqIYx8MvWgkGZvMoYRPqw9cgf5XPr3O/8L
         tNrE01NLv6GyRgzvATfar4moPqaCnEvLXZ1fCL5SwfYpVqZqHzIILeLL/+X1ZYI1Msy1
         0x7cH3iersyfH8RxlkWT+YkJ0pOj/SdyMrQ420+Ik83BgT9h6Au2x3pXYDKJiLfy55r0
         X603+/3EO9EoGmvm7zhCC43MdOE68+MMFFjkCeH1Q9+4Us56Q6SKMuTIA+3p5mUG88l1
         LZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwTkwJLj057qjRGk5qprK4YhJpBpmhOZC6UYL7UeweI=;
        b=aFICmeyCIYeTIN2tI9tuUI0DG7pUQBfM1zAxBB4uPstDT+NX14U1OMBHda3biBnaxS
         Z0K2dXnO1XFstRO+cX9IyM6+gX5Qea2ghrunCGdinjDF2CAKUYeut1sxsFxQsYtYxzgV
         i7hC8FMoNN4Cg77bVdexefbDvUgLUEPgVvMmr+Cu6yWBj1aUZJxCgJObYQnp92stN2UX
         VuVllME9YcxA4d04meF0mOY0JF13i6gHG+ccP+EAMK8dQCewKpfB5gIGZ1tgr9qupSul
         YnccjeIPEG8vRpWgtizjFYcjrrpTSqgSM37KvhZy1fH7l3qn4eStMd6rdYC+gUrJKaT+
         y2AQ==
X-Gm-Message-State: AOAM5306aZyX1YYmnwgGVSwLWIpwwrRWWIm3vz0Y83SmTroqc4GTeoJL
        qfOSAerQU/7h3NnsVPgjo8U=
X-Google-Smtp-Source: ABdhPJxCGTHm9inhFrNpARSfK+PfwuAx3q7jeeXJH91KTa8dCBKKFt9CvJXys4gPP02Cttk0TIcr9g==
X-Received: by 2002:a17:907:f97:: with SMTP id kb23mr8069497ejc.33.1617268909375;
        Thu, 01 Apr 2021 02:21:49 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id s6sm2476360ejx.83.2021.04.01.02.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:49 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 16/49] staging: rtl8723bs: remove empty for cycle in core/rtw_recv.c
Date:   Thu,  1 Apr 2021 11:20:46 +0200
Message-Id: <a65299f9b659d9904fd105da50ab67772125b31a.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty for cycle

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 9bd742e22ed3..5eb9914c48fc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -363,10 +363,6 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 
 			if (bmic_err == true) {
-				uint i;
-				for (i = 0; i < precvframe->u.hdr.len; i = i+8) {
-				}
-
 				/*  double check key_index for some timing issue , */
 				/*  cannot compare with psecuritypriv->dot118021XGrpKeyid also cause timing issue */
 				if ((IS_MCAST(prxattrib->ra) == true)  && (prxattrib->key_index != pmlmeinfo->key_index))
-- 
2.20.1

