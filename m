Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049B9353326
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbhDCJOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhDCJOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61DDC0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x7so6524724wrw.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVLSD6TsWDnyVwfKOiwMsJMVRC8hKmFN/FvLWADHKVg=;
        b=jYcTywjpI9wRKeO+xDLAdA12Ly6M/Tuf0eNBRqpBo6wo9G1JQzI+V1DlJ1I3UHRexb
         qPA4qjAPHcZt31j8I5tNwaLVMxyyUeRy6P2I/JgMXcPktpIc67AxYMvJ8ICtQpCTBxYn
         scCE9jdVnHieBRRjgc5QWt8VQc9W3mVjo67NC/Zg8xAn6p6+n4u/pVo6BaX0jwyQYmhb
         Z7Frm8Cg1h2pQEec1+jWVCgcf0JoXS2Gvs0LBZM5SIN9fQFn2GixLVwl/srJbyKbEt7A
         fehIpn2wLz90YM6NvaK74lfjYDPvXBPDAKCDvB9ebrWuHVTUcV04/FqLJuq9W0UbIUIc
         ifDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVLSD6TsWDnyVwfKOiwMsJMVRC8hKmFN/FvLWADHKVg=;
        b=b1t02aZnvUtiZ5emG0JXG1AxVvUDNxMdzcG9Uo8lV5PLZOQD1OncyAQXvOhZxRjFHV
         osuGwWwm1fduAEB3R+tLcdxcYkY1H+qploDER9hebRCFo+J9iPsX/KXtAV3iMhYUkZdE
         V8gQrGLAFPvjjUyqFWeYani0fmFYslscdFJBeTdFoUDQTHGXNVleR+5kN1OA7gq/9St8
         8zC0H0eao1ARxZFC3Xd7DLsXDQ7kRys5lVjd2UqZoWukROdQwV0HD9TcCd2X/MB0tYkb
         cvCCxPHQCJiidub89WSVNCkBvAHPcdQWcVcFadSDU53bGpm/PksqJCzjss0PSb0TPmwP
         aJBg==
X-Gm-Message-State: AOAM530di79fbQbgvsdPD8wsUEKGYe1oCRLtCcF23OElt1QpP7Cy/BAu
        n7xxH1LZlKGuZpA601tlPJQ=
X-Google-Smtp-Source: ABdhPJwwCLAB+8NG0yQX40fYgzPAkr52K/h+ej3kb2CsDsWQvXMklHKV6Sf+p6gR9FCVjl7XJb3L4w==
X-Received: by 2002:a5d:6a11:: with SMTP id m17mr19876883wru.361.1617441257573;
        Sat, 03 Apr 2021 02:14:17 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id w3sm679711wmi.9.2021.04.03.02.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 02/30] staging: rtl8723bs: fix condition in if statement in core/rtw_xmit.c
Date:   Sat,  3 Apr 2021 11:13:24 +0200
Message-Id: <45793b555f46312ea3c9cd285886dec22f3a1131.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issue:

CHECK: Using comparison to true is error prone
71: FILE: drivers/staging/rtl8723bs/core/rtw_xmit.c:565:
+		((padapter->securitypriv.sw_encrypt == true) ||
		 (psecuritypriv->hw_decrypted == false)))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index beee87db85a5..957d7e3a4d4a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -562,7 +562,7 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 		memcpy(pattrib->dot118021x_UncstKey.skey, psta->dot118021x_UncstKey.skey, 16);
 
 	if (pattrib->encrypt &&
-		((padapter->securitypriv.sw_encrypt == true) || (psecuritypriv->hw_decrypted == false)))
+		((padapter->securitypriv.sw_encrypt) || (!psecuritypriv->hw_decrypted)))
 		pattrib->bswenc = true;
 	else
 		pattrib->bswenc = false;
-- 
2.20.1

