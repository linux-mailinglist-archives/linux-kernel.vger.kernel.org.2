Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934DF3DEF62
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhHCNxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbhHCNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:52:59 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82854C06179E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:52:47 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso8813312otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4UAuQYn94Pb5XtO4XXCL46gk4gccAw2o2AYN2S6RoE=;
        b=dDqtbEaVRVzsjEp6krfkuZvks+F6zs4JvBG8nkkkPo3r+jJ/jbMRLGHVmLbCP56M1L
         ZqG8YkafQm/Ad9TRRjNlC8JX/tV21Rpmr/RDVpbm+KgPXMfpyWGPWqPLiGyl/AlEgWqj
         Bpf2aC8oUVYoLzdMP1BDlofVrbwDyKhPGzDbQl3ivSUEL5RPDR3DGxyvSr6yxk8NEgyT
         Pp2YNbt4DH4895TB3tEAkWoIOPMjorhRgS9SRCcuF/HZrjvDI/7y6KBIC+GJMSBymQAg
         7s3ZGFzor0ZkB/7oH/x+FxI4tFYgEG2pBw20U+xDs/EYrDzMgjdmwiHgQgwKEJw5T3nM
         cstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=X4UAuQYn94Pb5XtO4XXCL46gk4gccAw2o2AYN2S6RoE=;
        b=c2PymuyMOAcfDGsBW6r3856yayX1/RKhdxsrN+v81qZdvW6bZb229XE/3oKFnMhHJH
         7WA6Du+Dlz9ialx4Yfxb4Rd7dXo/tQPZvxQmhGv8Zv3ObONAC0ziyE5WS6YhPtm1UsOf
         JHTtiYikOh6Vyq4q8YQG2pizUtXMTl/GPA1CQEafR2wAIYtyGQPRzqw/4R7M91E5bXoX
         aW0o5S5ulqxucNH5IaDPz6jzgar9wcUlxwxQvRoPYwWVyedBfm1hjQ+PCeVSinNSbO2U
         7+t43kNcJli3qUb44YDpYVO1xf8hMqfX+Ojx03xjxdhywOLLYxpAey1qJRr8ZpMhTnho
         zTzQ==
X-Gm-Message-State: AOAM533v/kskH7HmAXRIFH6+O1UOSpGEOzYPjoZpKhzxPlPAjqN7VvyK
        w9BWh1hcDmpDGDe2/tg0BZA=
X-Google-Smtp-Source: ABdhPJz4ot75JdQSO8b2wXsnG2fRjJX3v6pkUQxemGCZQPr0ckC0pqVPZ19dhALD4zbnoh6uJZq5lA==
X-Received: by 2002:a05:6830:19c2:: with SMTP id p2mr15846766otp.49.1627998766949;
        Tue, 03 Aug 2021 06:52:46 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com. [2603:8090:2005:39b3::1010])
        by smtp.gmail.com with ESMTPSA id y26sm2504106otq.23.2021.08.03.06.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:52:46 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 09/10] staging: r8188eu: Remove some unused and ugly macros
Date:   Tue,  3 Aug 2021 08:52:22 -0500
Message-Id: <20210803135223.12543-10-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
References: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver contains a number of macros that are intended to do endian
conversion. The first step in getting rid of them is to delete the
ones that are not used.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../staging/r8188eu/include/osdep_service.h   | 39 -------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 52862785647f..cb876b50d68c 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -361,15 +361,7 @@ void rtw_free_netdev(struct net_device *netdev);
 
 #define RTW_GET_BE24(a) ((((u32) (a)[0]) << 16) | (((u32) (a)[1]) << 8) | \
 			 ((u32) (a)[2]))
-#define RTW_PUT_BE24(a, val)					\
-	do {							\
-		(a)[0] = (u8) ((((u32) (val)) >> 16) & 0xff);	\
-		(a)[1] = (u8) ((((u32) (val)) >> 8) & 0xff);	\
-		(a)[2] = (u8) (((u32) (val)) & 0xff);		\
-	} while (0)
 
-#define RTW_GET_BE32(a) ((((u32) (a)[0]) << 24) | (((u32) (a)[1]) << 16) | \
-			 (((u32) (a)[2]) << 8) | ((u32) (a)[3]))
 #define RTW_PUT_BE32(a, val)					\
 	do {							\
 		(a)[0] = (u8) ((((u32) (val)) >> 24) & 0xff);	\
@@ -378,37 +370,6 @@ void rtw_free_netdev(struct net_device *netdev);
 		(a)[3] = (u8) (((u32) (val)) & 0xff);		\
 	} while (0)
 
-#define RTW_GET_LE32(a) ((((u32) (a)[3]) << 24) | (((u32) (a)[2]) << 16) | \
-			 (((u32) (a)[1]) << 8) | ((u32) (a)[0]))
-#define RTW_PUT_LE32(a, val)					\
-	do {							\
-		(a)[3] = (u8) ((((u32) (val)) >> 24) & 0xff);	\
-		(a)[2] = (u8) ((((u32) (val)) >> 16) & 0xff);	\
-		(a)[1] = (u8) ((((u32) (val)) >> 8) & 0xff);	\
-		(a)[0] = (u8) (((u32) (val)) & 0xff);		\
-	} while (0)
-
-#define RTW_GET_BE64(a) ((((u64) (a)[0]) << 56) | (((u64) (a)[1]) << 48) | \
-			 (((u64) (a)[2]) << 40) | (((u64) (a)[3]) << 32) | \
-			 (((u64) (a)[4]) << 24) | (((u64) (a)[5]) << 16) | \
-			 (((u64) (a)[6]) << 8) | ((u64) (a)[7]))
-#define RTW_PUT_BE64(a, val)				\
-	do {						\
-		(a)[0] = (u8) (((u64) (val)) >> 56);	\
-		(a)[1] = (u8) (((u64) (val)) >> 48);	\
-		(a)[2] = (u8) (((u64) (val)) >> 40);	\
-		(a)[3] = (u8) (((u64) (val)) >> 32);	\
-		(a)[4] = (u8) (((u64) (val)) >> 24);	\
-		(a)[5] = (u8) (((u64) (val)) >> 16);	\
-		(a)[6] = (u8) (((u64) (val)) >> 8);	\
-		(a)[7] = (u8) (((u64) (val)) & 0xff);	\
-	} while (0)
-
-#define RTW_GET_LE64(a) ((((u64) (a)[7]) << 56) | (((u64) (a)[6]) << 48) | \
-			 (((u64) (a)[5]) << 40) | (((u64) (a)[4]) << 32) | \
-			 (((u64) (a)[3]) << 24) | (((u64) (a)[2]) << 16) | \
-			 (((u64) (a)[1]) << 8) | ((u64) (a)[0]))
-
 void rtw_buf_free(u8 **buf, u32 *buf_len);
 void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len);
 
-- 
2.32.0

