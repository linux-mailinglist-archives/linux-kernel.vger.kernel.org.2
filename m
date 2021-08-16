Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612153EDC6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhHPRbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhHPRbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:31:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30B4C061764;
        Mon, 16 Aug 2021 10:31:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c17so16200087plz.2;
        Mon, 16 Aug 2021 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8SwTsPx4UYisguWy8Lsk5AZC9AKkSCySPlgNFqLhFrs=;
        b=YKZPt/nFQeR7ewrRldumO8qc98qxVGOwakjPhcz6pDnZt31UHZNjH8PT1lKmtjyC6g
         OC3es6uuEmIIIa6OtlQXbsPcAIwPTkMjYMAGVUmn/Cpzt6wP04NPnDUK/K+5Jivwt62h
         u1peZrhklO+kNSiXnC9tdlNsLpDJHbnRDtvZf0zi1puDJoTp1+DPdyp2OgNCR2/QhMq3
         TzfQnpvpY9Lq7tn2i3FbyyXRl8X/FWwRjbDONkfrwB+UJDX+xOIqMxHyk1E2pY4C93vH
         ecqaRUf4AAcQnjgpLCxLeMLJF8QZ1fhSqTY6I46nmnbvfkoeqH1uCv+ROzI7CNpZIUFp
         9DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8SwTsPx4UYisguWy8Lsk5AZC9AKkSCySPlgNFqLhFrs=;
        b=ELF+oJY+MGF4WmAULE7mPx19FcL1Nq32tnCsP1xEDbHxoT0JBxyvG+DvS4LdQN8fFO
         LWCoqyJ+SMkbJS1hn89e+MRWZKjTvw1ljJNZumPKbpLhZLsYS3fXdd8w96Z28o+jFe0r
         z8sg47ozZuCLUspdq/+A8zohwhmuAERPUY8tpkmaxHXda/XulgllhLCM1GxgWedrKIn4
         aqRZLjX+5DGtKBi6RM9YJfcUX5kAPxfkjpP9iB/rLAKadjCbY/kmihQplmuQWLuj3yP9
         dw/WFiYLRx9MBY+0OR1rN2kamFV5DyZzEOGg9rdmCABPtPvnzOYnK90+PjTKu0o63z86
         mEEA==
X-Gm-Message-State: AOAM530m0wXMQFRtD/a6Gah2TRB8pvOQzei0+6SkFM+p6a3beDqaVe1p
        PXEeNz2AyJhLBw3HDPkPnC8=
X-Google-Smtp-Source: ABdhPJxY9eQN539hPG2ey1JJwFOXWSnRIDbAoc6zuproCURaNlxHrbbfvl0It/fn7u8epRjU26t6cw==
X-Received: by 2002:a63:4c0e:: with SMTP id z14mr17140996pga.427.1629135066380;
        Mon, 16 Aug 2021 10:31:06 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id z1sm17146pfg.18.2021.08.16.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:31:05 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-staging@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8723bs: fix cast to restricted __le32
Date:   Mon, 16 Aug 2021 23:00:43 +0530
Message-Id: <1be80f0196bed681bf55bfe3155f564b4ebf3b76.1629134725.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629134725.git.aakashhemadri123@gmail.com>
References: <cover.1629134725.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
warning: cast to restricted __le32

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 381deeea99d0..5320b1a46dfb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -122,7 +122,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		arc4_crypt(ctx, payload, payload,  length);
 
 		/* calculate icv and compare the icv */
-		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+		*((u32 *)crc) = ~crc32_le(~0, payload, length - 4);
 
 	}
 }
@@ -621,7 +621,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			arc4_setkey(ctx, rc4key, 16);
 			arc4_crypt(ctx, payload, payload, length);
 
-			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+			*((u32 *)crc) = ~crc32_le(~0, payload, length - 4);
 
 			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
 			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
-- 
2.32.0

