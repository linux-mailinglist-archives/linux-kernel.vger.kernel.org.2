Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76769356DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352696AbhDGNvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352639AbhDGNus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4692BC0613DD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p19so9069876wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZHPPmH/9scj2tTqrM6KnTGx6qYluXiPbPCqtebRoBKI=;
        b=tO1RHbrlih5UBJyU6ZDZsGAiXYZA6Snuc3mjqpgaVsZ0quAtnYMeCAOsJ4WoAxk3A8
         Uf5xLgy4tHLEcIoXIRw8HNcvzQ+ki0Y9A4r8wo/vGbgihGxjPn89d4V2SIqgvz3zSDqq
         c9fJsERb8Z47JTPxHS2BMCkABj0hJP3ObqzbZuyMO/5a5C/ZGJUt5nFSsyeUBetaFXMi
         q/AGsYOKBiF6ex/hp+dbn56UXYIQBOjukEgPVUK9NaTFkx137yYPT228uITNvXnIgEPo
         FBYS/3IvYj2yt64X1s4uqrKWT3KNz//6KtLcyiWcPGGzZhzrKC60Tx+vRebMVUxL74+u
         VHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHPPmH/9scj2tTqrM6KnTGx6qYluXiPbPCqtebRoBKI=;
        b=B5ve3YACIgeSM/sy/QhNTmprLXhls/aSOLZsGZLmre+Rz48LZIAGs6FfGWqzyVzuKB
         Fv+ORLtBuGunFBwUobJEUANZ5rZSahQ/Uy0Dp3dekbr3jN+HJQwOwsjeKDaDxHvimVwT
         HGclui9/gzmj8VCV6l6dTQUK3dJ+bmgapYBAFDKlhwuB9uQtP5hLk0cIcmhsABrw1kws
         YUQqaRk+l5plmr3DKLO3O6ElHgUjUSmlMjhvk63KxaxU9S2ALjXUN0K20oxFRBj8m5PY
         XLHS3/kGM52jO7lNownrKILHBYyh27nySItE1iwfPB4975g10GVSOxtstq+AbkTN393w
         V5Ng==
X-Gm-Message-State: AOAM531qqIDexGLYvUFoPSG3oUlNJF7WF7kgB9czarAKrP/Rz/JqH9k3
        pCSZHkc/caYPCO7BdDmfhIlhRptTA1HyPA==
X-Google-Smtp-Source: ABdhPJyP36q4Qk3lamjjEWPQUjJMdSRoMpJqh71sR8CZq+cRCb+1pdLlV83kwvybx1CaHRQ2qBMVHw==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr3251889wmk.139.1617803422380;
        Wed, 07 Apr 2021 06:50:22 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id o1sm13431619wrw.23.2021.04.07.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:22 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 16/19] staging: rtl8723bs: remove unnecessary parentheses
Date:   Wed,  7 Apr 2021 15:49:40 +0200
Message-Id: <1453eec49833fc940e134fc14bc65d218ace0663.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit checkpatch issue:

CHECK: Unnecessary parentheses around 'prxattrib->bdecrypted'
125: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:365:
+				if ((prxattrib->bdecrypted) && (brpt_micerror))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 18ad719c9826..668a703dee7f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -362,7 +362,7 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 				if ((IS_MCAST(prxattrib->ra) == true)  && (prxattrib->key_index != pmlmeinfo->key_index))
 					brpt_micerror = false;
 
-				if ((prxattrib->bdecrypted) && (brpt_micerror))
+				if (prxattrib->bdecrypted && brpt_micerror)
 					rtw_handle_tkip_mic_err(adapter, (u8)IS_MCAST(prxattrib->ra));
 
 				res = _FAIL;
-- 
2.20.1

