Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319B7339EFA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 16:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhCMPoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 10:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhCMPoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 10:44:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B31C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 07:44:06 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id o10so1100985plg.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 07:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=S9+2IFN1dv7+M9NnZ3JAWoiEoZQsQf5Cgay5lNY5ss4=;
        b=fnHgpB/SiaeX/3oYBL7Ek++HPE2DGn/hgClmOPjp8pHIcqNYBcbZ92qozOhAFpVP+/
         XFXdEj6GHCAn6jaz6y2ECYrQGE4KWSHJkIrTrVW63WIxPXnFypjaEhS05UozwKJwp8Kj
         oNtdr2s2hm03PMMjOXHE1FKhTPxQBpb5S6sYFT5b3ZPhdE1r4BbFgmz+mldsHyD2hE/E
         DGo4Qxoi3mxSuFhL6PQlVcQynFbLRZpCOwWcVCHZOiwKuRlG6yfm9f/oRDGdprhZdE+4
         miv+C3l3B+578eq6UA2FehZ95LBZV/3+WXxtKcrMw5Q3oow5s0jZ5ySGthgrsroXwkGN
         DK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=S9+2IFN1dv7+M9NnZ3JAWoiEoZQsQf5Cgay5lNY5ss4=;
        b=X2OY5hhJ30d+z4R77lQU4KdToP+CE/0gbItwWjc4S7svMwJPbe+hH4HEuh6wbfQS+7
         PA+EQp37dbne7fopkbN4dPFHUUNqfXHCByKTrkCVy5r9I8Dgb9sxXiLYO9XWSpPODRQi
         WqywYn+aaCcuYePaoBZAnmxxI52DKi8Ut/zucs3G7djGBzsmBIWHmteLTKcpc9VgKvXX
         U+UZd6qJcYnMOebH/P9yZAa6nG92uUP+20MH3UAcbUD9gSF2BYkgmMe/Ws8KaXaYnAnv
         48wLelu21BvsEZzWLlxQHAfBxd+pWJ9tfJa4laXEHmcw1+mo9Dml0ek2RKNxbVU2V39f
         unKQ==
X-Gm-Message-State: AOAM532nO2uzu9LwS6MefZHlSpSgD558wNrgKMfVwIjS5hognRPs2ZtE
        8L4Cn6rgsSoc/kU8mSbhKKW51pY/4ue6s44E
X-Google-Smtp-Source: ABdhPJzAJoemsc8BKTVt+RTiB9Y8TLWJ5WsUquHIruS9nqmNKURerImbotok1eXv27CbyNL2iN7JHQ==
X-Received: by 2002:a17:903:30cd:b029:e6:a1fa:403b with SMTP id s13-20020a17090330cdb02900e6a1fa403bmr1709838plc.43.1615650246209;
        Sat, 13 Mar 2021 07:44:06 -0800 (PST)
Received: from client-VirtualBox ([223.186.9.86])
        by smtp.gmail.com with ESMTPSA id mm12sm5687160pjb.49.2021.03.13.07.44.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 07:44:05 -0800 (PST)
Date:   Sat, 13 Mar 2021 21:13:57 +0530
From:   Chinmayi Shetty <chinmayishetty359@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] Net: gtp: Fixed missing blank line after declaration
Message-ID: <20210313154357.jtapnmtnkyxvjq2d@client-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chinmayi Shetty <chinmayishetty359@gmail.com>
---
 drivers/net/gtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index efe5247d8c42..79998f4394e5 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -437,7 +437,7 @@ static inline void gtp1_push_header(struct sk_buff *skb, struct pdp_ctx *pctx)
 	gtp1->length	= htons(payload_len);
 	gtp1->tid	= htonl(pctx->u.v1.o_tei);
 
-	/* TODO: Suppport for extension header, sequence number and N-PDU.
+	/* TODO: Support for extension header, sequence number and N-PDU.
 	 *	 Update the length field if any of them is available.
 	 */
 }
-- 
2.25.1

