Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14ED35332A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbhDCJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhDCJOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60166C061788
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c8so6525755wrq.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SpB21ddvVB478zlEeuyOklnuQn3Gxt8QZHrAoTlf3oo=;
        b=SDZMm2e7we+84iEltYZk+/XqH4Pt+LlmynNJp2mNpgG6tRUkvABK5Mop/VJNg7cAQ6
         qm9yZ8A1bppobP6Z8hmGW/t+8i4o+dY/Hk6GYaLfy4tRAt6fTolhgaYmIJNmyHKJ2TKR
         d5TFCD9xmZrzqHlyX/9XaEYJO5eTni59hbaGR1i2vqwqnPoRMC3baGqNgrlrLV4Rf03j
         efwbz+Uvr+kcICCt5N5MtQOxEFEYpEXi9mnGE/DwrJHA6MV64FjnWfdwt366fy7V39Vw
         SvX325R1muMDi2vMZtmXNmObbCWI/FrGc68MVx/64D1FH6fG1bm6D4TrAP+joWqZ8GDi
         Vssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SpB21ddvVB478zlEeuyOklnuQn3Gxt8QZHrAoTlf3oo=;
        b=MOvPiinG3JNUCMXIVY/mn/kRcYjDnkOE/Oio1BO0aCoSnhy/gABv3coTXBUU0P870f
         Ur/uynstb3h6CUOh6PpHDSceZthwOY05ekRomm1dPKdslNu7fa7/S6YnKoFgzuJwTwxs
         yo8J4aaWGBDlsHKnBcyCJSxVK+06nu7nL0+C42iAUTRLRRfTsOStDoYeem0Ol1cnNbCa
         B1U7DUTFW+5XDFmwDcAAEZv1I4Vl0nRkWxvUD/12/XYnELoD5Me/zq9dC03YfwQVhAMt
         em79jbV9fodLBKFj/hLAzZxQ1uWX+Ja7CwIp3YDRAoB2PZiabSYtXTjrkxQqR0+Wks7v
         b1aA==
X-Gm-Message-State: AOAM533p4qD2uJ6OrbEnxGFDQ91QE9ehef9tY4JsmqOQjFKZL7Krtmrb
        8scEnGWm2ZhfIsar5UV++KY=
X-Google-Smtp-Source: ABdhPJzqhjoJPGKIcRLcI2E+3hcSOOWJu7mF9CvazfsuiV7G60S9oBGPZsSLRBkJ8QDa7lIEyAdrwA==
X-Received: by 2002:adf:edd2:: with SMTP id v18mr1347532wro.305.1617441262186;
        Sat, 03 Apr 2021 02:14:22 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id c16sm21684102wrs.81.2021.04.03.02.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:21 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 05/30] staging: rtl8723bs: fix spaces around operator issues in core/rtw_security.c
Date:   Sat,  3 Apr 2021 11:13:27 +0200
Message-Id: <9143a02ae6959d4deae6c22bdba42041bf6484a2.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post commit hook checkpatch issues:

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

