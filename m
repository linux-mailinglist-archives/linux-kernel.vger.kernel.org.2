Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C153E53AB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhHJGkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbhHJGkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:40:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B33C061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 23:40:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so2921593pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 23:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gJh5g6sBkUyDOxH0aazRQXEM04p3XrayCtaq3Xsy8GM=;
        b=yeGYerUfG0kXBiPcCujcvz6H84DiZtZfboDXJUsbds5MuuXbah9S4F8JURE6f0/Pu4
         w10WRWwPwTRweg+7Rp8mD32OKwsEYIb28WLedjmAXZAPa6QYDlBRLtZ1gfWXLusFKQu/
         U439iCD6UHoEsCwyshBGhnBqxQVdXyPS1RdK8RqfuDKwqAswf0/poUvb7dbv2L0nhnxQ
         2yZQZhry4s3r4o9ohN0ePux2dIPrGVrWTnQsGLkW6C1QHGCSlMQfw2gAutQq0g6LVHVw
         46Dm7ddYllxXF8DwQwVrZSFcXja92nqCiXnJ2pnXpEH06RGP6Ojd1xHWaiOEvHSwNj4p
         REEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gJh5g6sBkUyDOxH0aazRQXEM04p3XrayCtaq3Xsy8GM=;
        b=YlRq3y3aV0VCzIUTwUXm83cjhySUOzx3L5ev8njlHSpzfBsWu6gcjSH5/X1+a4maLM
         QUEkmoVrTWLFewQgjYS169jctA+OR9WMfk6A+JhwNRy1j7MvTNs6fi+cVdAobNXAlv2t
         rBbaGkhwcxo1tQmcXmxqi98Akj4B1c9jpq9q18n+uf9LkOjYkObl4DiqZ2x48Or0ZS4w
         3p9/rt208dA9gAypN30Onhxr6S86rh3LejXqko8ZkfVKtKTDTjvZf4M2jAUPedoluPjW
         2UN/2caTuLgISi00HKPbpyh+8QYrtoyITnH2/aVkz3q51eAlbbsqKaiKYVsYw7FQfcBj
         rghw==
X-Gm-Message-State: AOAM533rdyadgfBqF/mcCVbhATaxN4sPTfV2spkt5w5IQE2QmNcdsv6d
        bk07WKwv+fWSjKPJJiLu3i8viQ==
X-Google-Smtp-Source: ABdhPJwjGXEPnknZWOpS6jE/Tehvvsx9C9n+uRUSkeCrF295hclr2rjt9RO6XkB4IapiATVWdosRLA==
X-Received: by 2002:a17:90a:7e0d:: with SMTP id i13mr29815845pjl.146.1628577602836;
        Mon, 09 Aug 2021 23:40:02 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id q4sm25769355pgv.16.2021.08.09.23.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:40:02 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] crypto: public_key: fix overflow during implicit conversion
Date:   Tue, 10 Aug 2021 14:39:54 +0800
Message-Id: <20210810063954.628244-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hit kernel warning like this, it can be reproduced by verifying 256
bytes datafile by keyctl command.

 WARNING: CPU: 5 PID: 344556 at crypto/rsa-pkcs1pad.c:540 pkcs1pad_verify+0x160/0x190
 ...
 Call Trace:
  public_key_verify_signature+0x282/0x380
  ? software_key_query+0x12d/0x180
  ? keyctl_pkey_params_get+0xd6/0x130
  asymmetric_key_verify_signature+0x66/0x80
  keyctl_pkey_verify+0xa5/0x100
  do_syscall_64+0x35/0xb0
  entry_SYSCALL_64_after_hwframe+0x44/0xae

'.digest_size(u8) = params->in_len(u32)' leads overflow of an u8 value,
so use u32 instead of u8 of digest. And reorder struct
public_key_signature, it could save 8 bytes on a 64 bit machine.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/crypto/public_key.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 47accec68cb0..f603325c0c30 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -38,9 +38,9 @@ extern void public_key_free(struct public_key *key);
 struct public_key_signature {
 	struct asymmetric_key_id *auth_ids[2];
 	u8 *s;			/* Signature */
-	u32 s_size;		/* Number of bytes in signature */
 	u8 *digest;
-	u8 digest_size;		/* Number of bytes in digest */
+	u32 s_size;		/* Number of bytes in signature */
+	u32 digest_size;	/* Number of bytes in digest */
 	const char *pkey_algo;
 	const char *hash_algo;
 	const char *encoding;
-- 
2.25.1

