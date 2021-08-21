Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1B33F3B63
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhHUQTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhHUQT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:19:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D407C061760
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:18:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y23so12306073pgi.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KG5rw8fq9QClpiKXfvagJa/MQ1uYCf2JiD/gsJPzlGY=;
        b=XltUDgMW2Qf2bAKXI4A8LtmvSxIKAnIMye7ZdHSOcsDNDXXgD8iosp+UE2wSPl8waO
         DTKyqcHlVvbjGFW5a2HRMuxf6XXrHbkM+LCDcjr2fHZCO5GxepkzYNkjaYsoM8o2QvC5
         3OngRRWe0H99//lU4TaZ6IWZzjr5QwsyGIDuKxdBW4hz4/5dVoOW1k8rZku4felSOX/u
         sFPFjU3G+rIub0EIOqW1iG6qGkeI+q9093FcOop8ex2BD9L7TPhxhAv85eLiugDCYZY5
         JSg5J+XTaetCRxV4BPgxvv7OwCIlEXBMrR5QTU5vBjkFiDmEk14VpIO/n0vJFt40vZ3S
         0gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KG5rw8fq9QClpiKXfvagJa/MQ1uYCf2JiD/gsJPzlGY=;
        b=bt2Cnw2aeonVoxVZCY9RZ0aSflkMHR1GnRdzqM99Gjly1+VhPyBO+Bn/LomjrY5S1b
         43rr0x4jsNi/+FJlRExLN9Pk2krN9gFzmMIWpijxu2uqYgYPUPNig7ylhxKa08ZmuXf8
         r95mIkQi4I28OsxDP9LVm5PDq+lviNkfNKyLcoldtrbXDwGIqeYtDAwpUZ5YBvLfxwDt
         eBmRKl6BHCfGIl4P9xLtHgR+mLNANG/W4mzxyyouHx0r7+utO1MwAGwtlTx6fOot5k7D
         TAuJHNJP88hQqvY+2Xj854y87Tk8qzMeQu4mdk6TyfiJbsvn2qNx074SEtybHRfo3bzd
         I5aw==
X-Gm-Message-State: AOAM530obQtszUaIWMWoZ0Z1L4Z+8my+Mua4EgdlMYS0H4A4LObTu7Wb
        1omOoVymYyOsAhCzG8ICEXE=
X-Google-Smtp-Source: ABdhPJxKbgmWixqtmMs4fMYk4ad1KqvahkKC1vk88SrdYpz5tvLB5KnBsl36uAcj+PaqcGZSX0Y7GQ==
X-Received: by 2002:a65:664f:: with SMTP id z15mr21347363pgv.252.1629562728788;
        Sat, 21 Aug 2021 09:18:48 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id y27sm4227011pfa.29.2021.08.21.09.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 09:18:48 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] staging: r8188eu: incorrect type in assignment
Date:   Sat, 21 Aug 2021 21:48:32 +0530
Message-Id: <876b83dad76a6f561879da0db1fbb25b251374d4.1629562355.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629562355.git.aakashhemadri123@gmail.com>
References: <cover.1629562355.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:516:57: warning: incorrect type in assignment
    (different base types)
> rtw_br_ext.c:516:57:    expected unsigned short
> rtw_br_ext.c:516:57:    got restricted __be16 [usertype]

*pMagic holds __be16 change it's type to __be16

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 83a4594a4214..14cf13516d34 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -474,7 +474,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		/*                Handle PPPoE frame                 */
 		/*---------------------------------------------------*/
 		struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
-		unsigned short *pMagic;
+		__be16 *pMagic;
 
 		switch (method) {
 		case NAT25_CHECK:
@@ -512,7 +512,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						tag->tag_len = htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);
 
 						/*  insert the magic_code+client mac in relay tag */
-						pMagic = (unsigned short *)tag->tag_data;
+						pMagic = (__be16 *)tag->tag_data;
 						*pMagic = htons(MAGIC_CODE);
 						memcpy(tag->tag_data+MAGIC_CODE_LEN, skb->data+ETH_ALEN, ETH_ALEN);
 
-- 
2.32.0

