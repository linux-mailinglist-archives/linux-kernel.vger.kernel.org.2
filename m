Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D533438FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhJYHAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhJYHAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:00:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55054C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:58:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c4so3362194plg.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NtT+Wof4jWQrra1PIt12aFx9JGnHbFl4ORoSxYDOL7A=;
        b=Lr75rl1N8fb9rmzYIW1MYozI13Nze6A51avkr4Q6P4VQ8P1f+CGuF5DL8UK9dcvTAf
         KsmI2G9PNaj3bDJgoO/SiqyZd0wKV6FVNiE2CVenEQ18atLKiNoyLh/6o/ewpYSP7j8J
         QKqqIDDwmIVARrZiSQiaAhhFiJZNQi8i54Nh3jJc7qz4xNoM8Pv7gFidvikMRI4v4tLK
         pXUvzhRKk4cmHcBIALpZA5+7a08ss792aEUembYRffcZZ9Uoggzm/S5lVUhUfZ5c1lX3
         qDE7itKEhuewqk9ZC4lb76/yKC1snEmf9dVrV1j+COZkUVR56DtD9iGL3BVgnKrRLAvL
         vAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NtT+Wof4jWQrra1PIt12aFx9JGnHbFl4ORoSxYDOL7A=;
        b=gFZQFk2b36RLXykbyaDegeFeZT8ZVvrB/AeoAljtcOg9AckcxHDTkwSJSoTKHTxQGm
         lM3lxh7FnBC/Z0qHEY+VBnnP741W7uLNaj2R/wq0d1Wg9zQXK4dv5kE+kwyzHlQ4S4xW
         r/puE1Yxru1QPjjT1FqMh1YtiP3vkdZ3R9nn1k6TE2uLUnvqRaYLSbSpd/OUQbaSzho7
         0U4Kw1Khppt2gJnlafHWHCKeirD+GHGSG8JBgC+HE0Ej8wvKHzO1KppnMMObZIWFZIaT
         C4ezlBB3Oocvj+HiEA/3mvjJ5hEQ4Flsg+cP85oLADv2LJiM39SOZ927xQd1BYN32vk+
         5DVw==
X-Gm-Message-State: AOAM530s0HDePMf60Y90lm2Tvm7BZRK1/5UrIl/JDlOxslM5eVtlTO3f
        P3lRzqR7cQM0c7Ohgd13Yr5exsW9vANG3IkW
X-Google-Smtp-Source: ABdhPJwEVEnSmTwj9187utQ8C28rPaGtAYPI8NTYs2AX1MxbaBZ3nNstBtTe4p6iJM6pwPTFC7y/9g==
X-Received: by 2002:a17:90a:4283:: with SMTP id p3mr13137115pjg.23.1635145105861;
        Sun, 24 Oct 2021 23:58:25 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b8sm18577380pfv.56.2021.10.24.23.58.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Oct 2021 23:58:25 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com, Lei He <helei.sig11@bytedance.com>
Subject: [PATCH] fix negative modulus in rsa testcases
Date:   Mon, 25 Oct 2021 14:58:10 +0800
Message-Id: <20211025065810.87080-1-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

according to the BER encoding rules, integer value is encoded as
two's complement, and if the highest bit of a positive integer
is 1, should add an leading zero octet.

this test case will prevent some crypto-drivers that sign sensitive
from passing self-test.

Signed-off-by: Lei He <helei.sig11@bytedance.com>
---
 crypto/testmgr.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 779720bf9364..a253d66ba1c1 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -257,9 +257,9 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	}, {
 #endif
 	.key =
-	"\x30\x82\x02\x1F" /* sequence of 543 bytes */
+	"\x30\x82\x02\x20" /* sequence of 544 bytes */
 	"\x02\x01\x01" /* version - integer of 1 byte */
-	"\x02\x82\x01\x00" /* modulus - integer of 256 bytes */
+	"\x02\x82\x01\x01\x00" /* modulus - integer of 256 bytes */
 	"\xDB\x10\x1A\xC2\xA3\xF1\xDC\xFF\x13\x6B\xED\x44\xDF\xF0\x02\x6D"
 	"\x13\xC7\x88\xDA\x70\x6B\x54\xF1\xE8\x27\xDC\xC3\x0F\x99\x6A\xFA"
 	"\xC6\x67\xFF\x1D\x1E\x3C\x1D\xC1\xB5\x5F\x6C\xC0\xB2\x07\x3A\x6D"
@@ -299,7 +299,7 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	"\x02\x01\x00" /* exponent1 - integer of 1 byte */
 	"\x02\x01\x00" /* exponent2 - integer of 1 byte */
 	"\x02\x01\x00", /* coefficient - integer of 1 byte */
-	.key_len = 547,
+	.key_len = 548,
 	.m = "\x54\x85\x9b\x34\x2c\x49\xea\x2a",
 	.c =
 	"\xb2\x97\x76\xb4\xae\x3e\x38\x3c\x7e\x64\x1f\xcc\xa2\x7f\xf6\xbe"
-- 
2.11.0

