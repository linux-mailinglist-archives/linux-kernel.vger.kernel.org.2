Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95356446357
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 13:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhKEM2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 08:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhKEM2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 08:28:18 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5BFC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 05:25:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j9so8265765pgh.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 05:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wFA/PQHqVLHAswIP07odo99SFSBTmuENHHzd1hwpl1I=;
        b=ANwh8ajyZlakCf7P/G/GPbotqbSgxZe3ye0P5ORMtyJVFfYZOXrApWoMhUl4A6oJN8
         DoOAPKaKcDl+Th0oyk7s180uogyJUpVasfIutXgKeBfc97hT4+JLC4TglUzcp9E6n5VD
         HIcPCUhUtSQvP2lm3+XOD8d4d1Pb/LE5TZTuSfJOnZ+QBvmrJx3NyYWLJ5X+XtPNYtTB
         6MEFia2GvE5yHoyUQDgzNfQNmP9lL8LZvOSpxQltBaWui3OASyc0f0qcJJ2d8mVXTg1u
         DPqoxpWMr+7p7BTRqMV1RBWQo4YzFYi2UYnkGYLxwqOc52xTJLYe12zWDzoHZUB/exLA
         4HfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wFA/PQHqVLHAswIP07odo99SFSBTmuENHHzd1hwpl1I=;
        b=eKwmLTnysWPGh+MEgH9abZpPWRJGVlW54iU30Lh6278DIVt9k7LZnYtj5lRBtoPFpO
         O4CJnnUweGfswvLCxnU1epNjprfFR/47WMPIZ9IUzSxxaEuIEZ4It3OyjLeCc3dLjSQs
         /x8D4Sc6ji4VRQAnWhIT7v1tQo9Nx3DnK11VG2divC+ZqA4EaO5m3m8ri5yZLKOAKGN4
         yvR7jjBXmnmeedbTVGzEnjo8OWGZGNWnCnvKpAq8nBh8uqHuslBAfVtpe6XyK4WEIg0i
         ep6xvsOhvcwBUfPPwvOl9hTYXBa/qbgjPaA/qjCvxSPF0Tf0R0DK+Q4GltsaDHBp8d71
         COJA==
X-Gm-Message-State: AOAM5315DoQWv42+b0Y7hTgloMLifb/pn+XWq5ZRx5O8Xi+7a8NecU0H
        6j8SFbw7Xw3FUyhklHAQsCUPig==
X-Google-Smtp-Source: ABdhPJy3rPGP1CEIeXpZ+EdREFacYam00MXt9smlAzcYMpEUXnGTFSL/Q/0fbgGJmUfLTdcOlVUnpw==
X-Received: by 2002:a62:6411:0:b0:44c:bf9f:f584 with SMTP id y17-20020a626411000000b0044cbf9ff584mr58429077pfb.29.1636115138711;
        Fri, 05 Nov 2021 05:25:38 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id hk18sm4770620pjb.20.2021.11.05.05.25.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Nov 2021 05:25:38 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     herbert@gondor.apana.org.au
Cc:     helei.sig11@bytedance.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, pizhenwei@bytedance.com
Subject: [PATCH] crypto: testmgr - Fix wrong test case of RSA
Date:   Fri,  5 Nov 2021 20:25:31 +0800
Message-Id: <20211105122531.73891-1-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the BER encoding rules, integer value should be encoded
as two's complement, and if the highest bit of a positive integer
is 1, should add a leading zero-octet.

The kernel's built-in RSA algorithm cannot recognize negative numbers
when parsing keys, so it can pass this test case.

Export the key to file and run the following command to verify the
fix result:

  openssl asn1parse -inform DER -in /path/to/key/file

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

