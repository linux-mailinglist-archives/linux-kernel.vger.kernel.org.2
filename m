Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0C6352E65
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbhDBRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbhDBRa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1440C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v4so5273722wrp.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HW8zP7DoM2YfAVkpuEz006Zh/rGoWUODHC32UiI5NeU=;
        b=LBQDvdQOdjzGKgtB763p2eI+OHAjKW5vCaTn21nn2gP5+n2DeNmtK/TPJyJUHqWqII
         yHXruJzoJs+IR/VLnM8cmmXd583OVLj95sIyEuGfkiCrnCeuxomNpMVWosbhIGhpstbl
         w3+qyymujACljzJP/4QAMsQBT6LerbJHKJrb2C1V16chEPYXKSkN78UqNWa0GUzga2Wp
         T7mL3XBUw3Msrc70kfka9nmZnf7eTvzuDLtsNGWfUg9uroMKhqVEK/RenxnX3D0yfbfY
         X8Ew2be6gkz/oKNmb2R/BGywMNveIDU5vabpMMf4WP/PFlhWwCFsnfJ+iQ55Fgyy0ymx
         OJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HW8zP7DoM2YfAVkpuEz006Zh/rGoWUODHC32UiI5NeU=;
        b=XffbRyn7KjEXl0qrz2wHYKY/4D2UgvAvjqQiLJKGjQTN8GOEKJY3j3VnVcaO7Jj/XM
         grRDDSEC3ctFw1U1NUO0Qh06jhk6J3Lf1jYBfKV9xxff0EJuOnqJQdcCjH91aW5G5l0v
         NANyH8eQf1oCoJFuXJpvZrVcCS3OmxH2JtzIq9R8Ri0QOoQ46bamFi1Tjfl8GVrdKCOJ
         395UJCX0HbtbrbzTtCS6+izdmM3p6Cb+Y3tbvXe/paDXrV5M3QvThkVMFvag9nQAVZue
         yIpV2wjZQBE0ENydwyxv6Uu9iXRp4tLoVCtWqE+nji2ChSIfQoTbMDhCtjZmjaEiKfkh
         rpXQ==
X-Gm-Message-State: AOAM531icm7SHI6lv6m21xR7s8/0oO0H+GB9+2fcPwBJ81JuYRF0bVTz
        pgFwaP9cuNzgewRsGM1Ty2I=
X-Google-Smtp-Source: ABdhPJw1NbZ2CtGu1W3vPbh86GHMgiqTV0pwBLy0CgY1z7cNWVVlvqTyOhuG97oDuO0XOjtTLJrIrQ==
X-Received: by 2002:adf:e541:: with SMTP id z1mr4091602wrm.383.1617384654730;
        Fri, 02 Apr 2021 10:30:54 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id f7sm12130341wmq.11.2021.04.02.10.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:54 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 23/30] staging: rtl8723bs: fix comparison in if condition
Date:   Fri,  2 Apr 2021 19:30:05 +0200
Message-Id: <d35e38ba478476a2fe38cfce73ab8bd80a1b2c51.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit checkpatch issue:

CHECK: Using comparison to false is error prone
27: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:381:
+				if (psecuritypriv->
			bcheck_grpkey == false &&

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index cd4324a93275..21949925ec77 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -378,7 +378,7 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 			} else {
 				/* mic checked ok */
-				if (psecuritypriv->bcheck_grpkey == false &&
+				if (!psecuritypriv->bcheck_grpkey &&
 				    (IS_MCAST(prxattrib->ra) == true))
 					psecuritypriv->bcheck_grpkey = true;
 			}
-- 
2.20.1

