Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6C2353329
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhDCJOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbhDCJOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D927EC0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x7so6524786wrw.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOA+21vzY0bmS8hxfo90qK5+QTR3YadbSYJH3ev5WXU=;
        b=fvsoRqAeDr+V0AOQjQ2l1mhiYjkuTHAfUeVMqB5RJ3sPcztS8Z5SeCkgul2MUgSV+y
         PU8hl2N5Kkgkq9gNmUIHpoGJ//alfR4jdkxt7DL6R7r3BB3NA9irlYrRWekZP3spTT6N
         SE9cyhdHP0I5npU8h2Gnc53SdfQpSHJQm8GfpD6YxpA4QxhQNtpLR5VVLJpsIv7szZnK
         ZVv1sfcyCWmc+k7Znt2YwSXKnz0xaZFJfae23HICWBHIKwcWqgfyaaXDUjI/g3HCh8XI
         QPlfND6OOoTmYxGis6TbIKiN1V8Zm+NVrX/DaO4erutD7nz1i+ok2D7cCGUi+y5jlPXK
         7Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOA+21vzY0bmS8hxfo90qK5+QTR3YadbSYJH3ev5WXU=;
        b=SPweFebcL2reYTX47fiGoUPI+N/wFF9rK1M9Z6ADR3ziSYn1R0Alcx2glRqvVXqgQf
         u0yAMsqKzjYgm8Q6EVKsQ6aAEymJ76AENjemD43MZgwl7wo0mm6/1W4uiHz9PnXpEWK3
         sqgjgwePA9NLqS3aVyU2AvJm/BeBOWDviSIHlQXYHzXjqwuFeVLLzUIdSSSJ/efKE+pb
         8gLA0dY0iKJ0STFihlf4osblDUYqK8STe8W9JQsgGYOlsEEwge8BAiFj+0RslgRw4jSL
         2b+dj8gIv9/O4nmoW/k7y+2YxKG7W/N7iItPXmQPLuaJUjib52gFnydwzfPmocE9bLup
         w9CQ==
X-Gm-Message-State: AOAM532O3WYBF4Vl1qxN82iMlxZFAko2Wm+32yuxZ7ozLs6OlWWtPppK
        ojO+COYYCn2IWGHsqi9SfODYBlmgxfo=
X-Google-Smtp-Source: ABdhPJz+aqppJ32GVh/FlTwmAlPFGOhsIpkPnNLoDx6zZOF5PLOFPQTuzfcUOVbBe822jMaOUwFT4Q==
X-Received: by 2002:adf:c64a:: with SMTP id u10mr19409584wrg.412.1617441260670;
        Sat, 03 Apr 2021 02:14:20 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id d13sm18552065wro.23.2021.04.03.02.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 04/30] staging: rtl8723bs: fix line exceed warning in core/rtw_security.c
Date:   Sat,  3 Apr 2021 11:13:26 +0200
Message-Id: <862862a3e309209e2508de0c9a1b5a02ce1312b2.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
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

