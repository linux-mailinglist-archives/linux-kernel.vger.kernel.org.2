Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDCA353858
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhDDOKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhDDOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A81C061788
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 12so4595117wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SpB21ddvVB478zlEeuyOklnuQn3Gxt8QZHrAoTlf3oo=;
        b=HctwjQkHD+k+CMCkTVYI/r1VtxPV/Dl8a+E7V5gjsSxwQTLlAA2RNaWAtOUZcfskOe
         8s107K+GenCYTcWFuiZZdFQns2X35RlGiDgQek4OWDkQj1kIWTpPa5ml9cchEoizbcTG
         GSyXx4phqUxahIHTioI6QfKCwiuOTgVz4uP9Y1qeK313yZsIPCHzzw3/TOnc1AyOeNfg
         mVGaDQyqbLn/lqacVeIqfu5gz84xmTEifUkJYpp8eENC7RcS9fzNPJkpVAztLjh8LKGf
         AOsyqGfdFDBNUB7Z/Q0IhsckV0UrmLl5hsJoSg3yRbjPWG05oWFKThQR/F/zsDn2cbR7
         LTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SpB21ddvVB478zlEeuyOklnuQn3Gxt8QZHrAoTlf3oo=;
        b=HbsCbrI2aLiNe3JbnaKAfmZEBnPbTMUe7JmywfQjJn1FfsZyUspri7eWW+Bzuei83j
         uf6tretHxwgjY1WSTUGDCuQkDdA0QoCQebPnssLNW79L3uvfUYriTSx0gGslkx/wHWru
         U1VmFEDdJdQ9bid34zvKtjoHMZMx5aYPF1n4jPaaadru2n3grMMvkRwzzpp53BZDRdjN
         kXvccl9rsKkxpgOy5Ag3F/fEQv0PlW8T6lXauQluPJyWX6lxYEYRnfL9guiy0oPs+c7c
         II7I8raiElfalrWkrdIYL57B+2XSpSbhamHee3QGT/TId+nlze4nk1sZAp5tNDykkAVG
         v+CA==
X-Gm-Message-State: AOAM5339DFzriMeN8Tyv5auZBalZ8uESYEGnNHHN/KzAkeFZd7SoKrie
        Yz2/1oibP+65MWplYSXqxh3/TmpsZw7ZIg==
X-Google-Smtp-Source: ABdhPJzZGzMgoksgLI6Bqv2AottamKK5PDZ3HLN0LB7ke1JgauaX5zqFmR/qAkLAhTNwUW9MATZrWw==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr21219632wml.123.1617545398905;
        Sun, 04 Apr 2021 07:09:58 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id l5sm20022342wmh.0.2021.04.04.07.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:09:58 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 05/30] staging: rtl8723bs: fix spaces around operator issues in core/rtw_security.c
Date:   Sun,  4 Apr 2021 16:09:21 +0200
Message-Id: <9143a02ae6959d4deae6c22bdba42041bf6484a2.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
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

