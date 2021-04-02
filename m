Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED85A352E4D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbhDBRan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbhDBRa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7303EC06178C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so4621435wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YIXmba9GZGAqIQhah5BMvewcGrBpfMrXUBmt8lWw17w=;
        b=A3rCmKO2FJGVEjrpXsrA4PoCCEKBWX6ejliH2nlT6tG7kE8aC9+Q8AXE56fOBWZ5+E
         JYzPkhoo4dt2IrUREcd6K2AlfBMh7J2Z3AMaUUxMCxPXsCaqKEYe2UIAb+aiSp/hxgYs
         NwyVIKGgkzAdKPbb0R0VH1KOGxoBm3SU/wO416iDmU9sOLk8h+TM/S6+CxV3e0u1VJaf
         QZXQX7J9ytaQQp0Ugh0+mc3DTiBcO9kPiaXcZybKu4ZfPFa3M/IEu+pzzqcWwyjeyaUb
         3evbORs1VlQXE/oVYVbpk+czlTe71NKuaqVj34EuLnJg4aRX8PMoHojHEij/g9X05igC
         dZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIXmba9GZGAqIQhah5BMvewcGrBpfMrXUBmt8lWw17w=;
        b=Qb2qzw77Tm2SX2Ws8lIrOtcHmXkt+i+W0JO+amdvi28HSD5xi9AvOiXfYkgg+kOvXf
         XQObmLw3oG8Zh5glgWZSoASedNXbo5P1FjehmpJ2dkKUqS+kJP3WgrKBvqrEnY0koJtL
         erl/1/kSYM7XQTHEbNEWXqkPvEJHlGQ1Iz/OX3NoXx72lU3WNFjOZfL6hh/psrml9127
         P95yWcK7ZZ6rNvo6T+mEpAy5dAEp6sblR+qsOplWoPBujvLIdct6ukRPurw+ZkAnIZcr
         2K6GUGcIn9b9aLucG6VOB8ry6qD0vl2eQhnigvJq3wpbeSWFULIK40stiKDKzVHax9x9
         pMNQ==
X-Gm-Message-State: AOAM5326zDpI3XSSATXIe/fP4hzh8W7TnbxgcsmYxcWyXvG5/n6rQi5x
        889trnDJq3qyN6uekQRQ/cw=
X-Google-Smtp-Source: ABdhPJyKilVZloozLFMF40OIjSQJd3QTektX2EeRE3GvoyNan2Dx6v70abmJYGed/QnqZE8HN3VC7g==
X-Received: by 2002:a05:600c:2e43:: with SMTP id q3mr4104128wmf.68.1617384625287;
        Fri, 02 Apr 2021 10:30:25 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id p10sm15635935wrw.33.2021.04.02.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 05/30] staging: rtl8723bs: fix spaces around operator issues
Date:   Fri,  2 Apr 2021 19:29:47 +0200
Message-Id: <501f33cd47ffaf9f7b41dd01776516f333e5de0a.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post commit hook check issues:

CHECK: spaces preferred around that '-' (ctx:VxV)
25: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:729:
+			if (crc[3] != payload[length-1] ||
	crc[2] != payload[length-2] ||
 			                            ^

CHECK: spaces preferred around that '-' (ctx:VxV)
25: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:729:
+			if (crc[3] != payload[length-1] ||
	crc[2] != payload[length-2] ||
                                ^

CHECK: spaces preferred around that '-' (ctx:VxV)
26: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:730:
+			    crc[1] != payload[length-3] ||
	crc[0] != payload[length-4])
 			                            ^

CHECK: spaces preferred around that '-' (ctx:VxV)
26: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:730:
+			    crc[1] != payload[length-3] ||
	crc[0] != payload[length-4])
				^

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 663a8ea199ee..6c74c0444abc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -726,8 +726,8 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 			*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
 
-			if (crc[3] != payload[length-1] || crc[2] != payload[length-2] ||
-			    crc[1] != payload[length-3] || crc[0] != payload[length-4])
+			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
+			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
 				res = _FAIL;
 		} else {
 			res = _FAIL;
-- 
2.20.1

