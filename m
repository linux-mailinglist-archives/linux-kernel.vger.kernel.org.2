Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A0E353857
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhDDOKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhDDOKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0FCC061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:09:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so4468463wmj.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOA+21vzY0bmS8hxfo90qK5+QTR3YadbSYJH3ev5WXU=;
        b=geC43GSlEmn6/QX/7D+HM7Tvjkv6H2cFHdox4734ap2n7xErKGv4pFaVcQoHjO3wJl
         SL4wWGr4UIecOB9G3HTI7ew6o1iQTozU32ts+qNl2/wc9EpxtkCqBiaafhmLcYkGq2wO
         pOHhwl075Gk53XEhUp853lwKlWoKsyYEniPuFahMMVjdlErQaQuEjKebvS9UF7MvFepN
         /Mx4VW8e9ibNYbeBN9FHCDEYq/jMdnDSVm88pZyHftGOw0f4XqQLWoixQU1OKU+XWLAq
         +I3zECsWjJ82FpNHu8svVw+uw4jQRSOk9yXZg6ACGO67QexbokGb3JVMMH6vWAVoQj2R
         z6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOA+21vzY0bmS8hxfo90qK5+QTR3YadbSYJH3ev5WXU=;
        b=jVXRS4IhtoKgyGieQ5nVROpM4QmMLzQD2Ipgiq2qmbK6gmzBVe8wSeeldYKtVNYb6+
         Xm1VHtzgdq+BXd1jHw3leIq7UkyWUjJs+WzyZUMWlLUWutjg5WjqR9EB+ATUF/5uDAP9
         8uhwdmnp3M1Cyfjs/IGENSGhVOvoncJv1DTJsTmKpONtEoFXxOT+y05PtYbNEL1VhlON
         OTmbQgWS/4q/vDX6vkafLDu9CQQ/8zaPb5AnIssobk5guHjE9g+/Y7S6oafQohJo2ZIj
         PV9+geZavh+sZ9U9vwlMK1Q+NBOVuFeXntOvMCT8vWdrPwVGL76b9Sye+tpeohRoEcOp
         QG0Q==
X-Gm-Message-State: AOAM530VNO/P590Wn8D1anjbmQ3nm3Z6bB87Fnds484nk428s3QPKbJg
        Vx64J2QP7XRgfO9YCP1xwSQ=
X-Google-Smtp-Source: ABdhPJwRYryuSqTyUfUjwJBz/cfsMNsZvB0tCW+s0hPhlDJAHqveBrRVuxhWui4FNbPXGIYJp87oLw==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr21936001wmc.2.1617545397329;
        Sun, 04 Apr 2021 07:09:57 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id o2sm19546681wmc.23.2021.04.04.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:09:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 04/30] staging: rtl8723bs: fix line exceed warning in core/rtw_security.c
Date:   Sun,  4 Apr 2021 16:09:20 +0200
Message-Id: <862862a3e309209e2508de0c9a1b5a02ce1312b2.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post-commit hook checkpatch issue:

WARNING: line length of 149 exceeds 100 columns
61: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:729:
+			if (crc[3] != payload[length-1] ||
	crc[2] != payload[length-2] || crc[1] != payload[length-3] ||
	crc[0] != payload[length-4])

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 689419a76d94..663a8ea199ee 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -726,7 +726,8 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 			*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
 
-			if (crc[3] != payload[length-1] || crc[2] != payload[length-2] || crc[1] != payload[length-3] || crc[0] != payload[length-4])
+			if (crc[3] != payload[length-1] || crc[2] != payload[length-2] ||
+			    crc[1] != payload[length-3] || crc[0] != payload[length-4])
 				res = _FAIL;
 		} else {
 			res = _FAIL;
-- 
2.20.1

