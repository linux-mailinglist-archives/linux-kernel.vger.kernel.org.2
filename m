Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A335A34A3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCZJKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhCZJJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:09:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11E5C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so4496611wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T70nnYT1S74ukfHVQnDEfFZYXw40llpY2tBON0+87cQ=;
        b=ThIaQdTN0n4UBBJHBnv/3yTyrAUrvOuxJ0TPzN1GreVZtclPIesu1jbKm7RVp9/ASm
         yKWRTcyQkUybH0tLmjzL/T0y17NN+YZB4blVV3/Gh6HgMI/4beYdE2O6P3sxM9R9eAd5
         9w/8A2KnTy1V4goMi62EYdmfT7Gkh0JQng1EBi9dYiLVek8s3R7oC+lnVhzSD7N4S490
         P9Xw33Pcf+wYmMnQkeO8xoAHHk6PFPjdggCKv8tQKgz/aHK6jH5SWcL/weLfEJupJNd7
         JoHs7oOqPwzkffWwx4qyaUztbiwsjOuEx/9rbXLjOcojBYivN5aLt7K7YNpLtocfGT+v
         pbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T70nnYT1S74ukfHVQnDEfFZYXw40llpY2tBON0+87cQ=;
        b=gDE3DwWeb/M2Og3kxPvuDhl2Fwm/CBRKPZWyNI8DAQ/PvoKVP0rLfErZgmchRd3EFQ
         HxcTWI6guES60TWbHmbG0qsSUqhKNx/AQqGgWDujHYahp+UnJI54/wLBxMCxm7BPM/W/
         07vU7c2UpNfsiV21TVzsD1GxlHYcqDxmlygKdesDGfI7fdGvSTW7uCzYEx3o7cQ3PFHD
         9GbYd5p3wLVQN6WMvSZXSKMQO6Av5p8YxQymCpa/o30OyMtqmzD9ISFmY7dlMIE5FTHz
         4HZVcBEnGnfJsBPXQs5907+Us04TxlJd0XDNZiF/36tqI2psPfTFsYgsXFYabYJMSIq6
         joCQ==
X-Gm-Message-State: AOAM533ffqTstV4dJHVAIO3mo99So3NrBRqnevbEdI2XWy2r2rEgiB9B
        ezIjKipVea3H3Hb6I7zVo20=
X-Google-Smtp-Source: ABdhPJzq1Ods0QzbRAKBqZHoB/pb5hjMdTQH+r4TAIQfSaP03IeyX2nhSNl1k0nNCuzAYkiFVIwqLw==
X-Received: by 2002:a1c:ddc6:: with SMTP id u189mr12297032wmg.171.1616749787435;
        Fri, 26 Mar 2021 02:09:47 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id i8sm11309269wrx.43.2021.03.26.02.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:09:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 04/15] staging: rtl8723bs: put parentheses on macros with complex values in include/basic_types.h
Date:   Fri, 26 Mar 2021 10:09:11 +0100
Message-Id: <2c7c198ccef194b06921bc476eda7d5102ab70dc.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warnings:

ERROR: Macros with complex values should be enclosed in parentheses
154: FILE: drivers/staging/rtl8723bs/include/basic_types.h:154:
+#define SET_BITS_TO_LE_4BYTE(__pstart, __bitoffset, __bitlen, __val) \
--
ERROR: Macros with multiple statements should be enclosed in
a do - while loop
161: FILE: drivers/staging/rtl8723bs/include/basic_types.h:161:
+#define SET_BITS_TO_LE_2BYTE(__pstart, __bitoffset, __bitlen, __val) \
--
ERROR: Macros with complex values should be enclosed in parentheses
168: FILE: drivers/staging/rtl8723bs/include/basic_types.h:168:
+#define SET_BITS_TO_LE_1BYTE(__pstart, __bitoffset, __bitlen, __val) \

parentheses solution preferred for all fixes and made macros more
readables

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/include/basic_types.h   | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/basic_types.h b/drivers/staging/rtl8723bs/include/basic_types.h
index 76304086107a..5054c2e3384c 100644
--- a/drivers/staging/rtl8723bs/include/basic_types.h
+++ b/drivers/staging/rtl8723bs/include/basic_types.h
@@ -152,24 +152,30 @@
 /* 		Set subfield of little-endian 4-byte value to specified value. */
 /*  */
 #define SET_BITS_TO_LE_4BYTE(__pstart, __bitoffset, __bitlen, __val) \
-		*((u32 *)(__pstart)) =				\
-		(						\
-		LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) | \
-		((((u32)__val) & BIT_LEN_MASK_32(__bitlen)) << (__bitoffset)) \
+		(\
+			*((u32 *)(__pstart)) =				\
+			(						\
+				LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) | \
+				((((u32)__val) & BIT_LEN_MASK_32(__bitlen)) << (__bitoffset)) \
+			)\
 		)
 
 #define SET_BITS_TO_LE_2BYTE(__pstart, __bitoffset, __bitlen, __val) \
-		*((u16 *)(__pstart)) =				\
-		(					\
-		LE_BITS_CLEARED_TO_2BYTE(__pstart, __bitoffset, __bitlen) | \
-		((((u16)__val) & BIT_LEN_MASK_16(__bitlen)) << (__bitoffset)) \
+		(\
+			*((u16 *)(__pstart)) =				\
+			(					\
+				LE_BITS_CLEARED_TO_2BYTE(__pstart, __bitoffset, __bitlen) | \
+				((((u16)__val) & BIT_LEN_MASK_16(__bitlen)) << (__bitoffset)) \
+			)\
 		);
 
 #define SET_BITS_TO_LE_1BYTE(__pstart, __bitoffset, __bitlen, __val) \
-		*((u8 *)(__pstart)) = EF1BYTE			\
-		(					\
-		LE_BITS_CLEARED_TO_1BYTE(__pstart, __bitoffset, __bitlen) | \
-		((((u8)__val) & BIT_LEN_MASK_8(__bitlen)) << (__bitoffset)) \
+		(\
+			*((u8 *)(__pstart)) = EF1BYTE			\
+			(					\
+				LE_BITS_CLEARED_TO_1BYTE(__pstart, __bitoffset, __bitlen) | \
+				((((u8)__val) & BIT_LEN_MASK_8(__bitlen)) << (__bitoffset)) \
+			)\
 		)
 
 #define LE_BITS_CLEARED_TO_1BYTE_8BIT(__pStart, __BitOffset, __BitLen) \
-- 
2.20.1

