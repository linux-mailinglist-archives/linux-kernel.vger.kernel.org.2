Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0096C3AA517
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 22:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhFPUVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhFPUVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 16:21:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCA9C061760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:19:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x10so1719595plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqbW6wqdYKyy4WfeF6ZmLgowin8B9rsAJ4z+U9eQSMQ=;
        b=CF6ai0bLIJ6HcSlgTp6wPq5zdhafbSKeqR7mdBCfXbmQl8/7eTl4BMprknCpMkx3C+
         n5WwPl3W99yPuBz+LL7As5afk1xYEjDPJCpMAcZC/3LXpQ2d98EGyJ6XHmaz9Q1d0ag3
         0rtUWam3IUtRd1h4kz7e265ZG6kA121neSGY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqbW6wqdYKyy4WfeF6ZmLgowin8B9rsAJ4z+U9eQSMQ=;
        b=ZAo4RFJ4+hp9P3hSw09RdCcsbI2U6U8jkxBRC9wa5MctECyW/nxLLBF4r1EtyG3jd7
         SKTfW8dpiPSkYCDimXMJ2o9hFRfzEOmHaFtDST0LDadzy2MUib5au87WvfU9nfiO6zZJ
         63jICj+CnWapZ78+jdJp+1S1UVuJYuH/f87SQgGlonba4crpV9WetfL11DVVA7pFO2vp
         uS0VBCGGsFOSlCvh+ss4fqq0Z2fLlky+Cd8aRqsfjPOSZjp9S+gbukXaDnVX0gnUzDuu
         sS7djjpus/o0/QP+t/GEsQBV0vlwRKV1D7B3ZtfuKAweqjrTB6HpIFRgEhXf5dnTR3ZL
         Em/w==
X-Gm-Message-State: AOAM532B3DnNM1//2Yqlf1eIFMdV9mXJjom37ggKtIIqeVxKqWSrQwoB
        xuh5y4oE06Y7uWViyem1oitAXg==
X-Google-Smtp-Source: ABdhPJwHtR9X0jnxiOYZC3aaxgtPXTYur3JDAb27xVsacYRsXhB7QPhVBYS8U83RQAYrs8Wr6+OBnw==
X-Received: by 2002:a17:90a:fb57:: with SMTP id iq23mr12553283pjb.205.1623874745158;
        Wed, 16 Jun 2021 13:19:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fr20sm2957435pjb.29.2021.06.16.13.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:19:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] s390/zcrypt: Switch to flexible array member
Date:   Wed, 16 Jun 2021 13:19:02 -0700
Message-Id: <20210616201903.1245949-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=4483ac10d5342f8b9e848210b5d0401b4c60bd9e; i=xMY/2r78xefmc9bYEAKa8rdXHRR/8WjoMFOpmyCR6Lo=; m=6TCQMucoSIMP4FwY4gM8q062WQeIzX5fHh0dxX9eWvU=; p=kH8A+g4eyFnEn3S09lGURELtIjB3hNzUJBFOkgYt5dk=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKXLYACgkQiXL039xtwCaAyw/+MpW p2ZkGOBi7NslQtjabbhuMY8AhIrEC5XXFLbyoYZoD77bZcroE6XpRFe4eZHYiWsqkykPf6E7AcI43 a8o8zm7s1y7oVQfpJHMuYQOcW1ztA6TSr57c1/W6/K8fDpOTfZ2vYq+cfbCJEyxOe4aWHmFCms9Kd 1XeHVeF25LRooITrG8aI98zOafyyevJEUuGyYITmYXzNj2RqJrHBE0KAngUaDhrSqrRli+POMJniD htN0XhRj3NrYunPQ/49tYcEOrZHM7bYXQRPzpIdImAMfkw8N8WdGTVIWLCGMLpkRlkqHbpVSNWY7f NqPl633+bkjBeNA1F0XjNcV1AtdpLh8DtbCR9g5/Apq8RZLfLYANKMkqw6k4kzF/28bcLG3eHeWUn /L6zXUVpxXSnHn4sCbEk2+5u5UJq8Z5U4oFX891WhnM533CtwddHoSQiYRRpj9fygTJ3Jm/H23mUo BuaCd5fIH4I0ihmmVifgNvFaF8rvV+Hm4AAGOR0i2gv16FKwDOiltj12JUc6p/Ob0r+PRB8UqSqYP OcfqQcxtyjW0rivXWiBATUCSBX3LbWP9AWUDzXT7UdtsYjjqX7DMzpocSCqlQUVIL/L4/RJurdlwM kRnyqe5A/BI4OG3kbieT/oa6IOvTLKIN20OKdPibRjh68euuLUL/VVXjADo7v2h0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally reading/writing across neighboring array fields.

Switch from zero-element arrays to flexible arrays so the compiler will
perform appropriate bounds checking, avoiding these future warnings:

In function '__fortify_memcpy',
    inlined from 'cca_sec2protkey' at drivers/s390/crypto/zcrypt_ccamisc.c:645:2:
./include/linux/fortify-string.h:244:4: error: call to '__write_overflow_field' declared with attribute error: detected write beyond size of field (1st parameter)

In function '__fortify_memcpy',
    inlined from 'cca_clr2seckey' at drivers/s390/crypto/zcrypt_ccamisc.c:568:3:
./include/linux/fortify-string.h:246:4: error: call to '__read_overflow2_field' declared with attribute error: detected read beyond size of field (2nd parameter)

In function '__fortify_memcpy',
    inlined from 'cca_genseckey' at drivers/s390/crypto/zcrypt_ccamisc.c:429:2:
./include/linux/fortify-string.h:246:4: error: call to '__read_overflow2_field' declared with attribute error: detected read beyond size of field (2nd parameter)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 6a82033696e5..bc34bedf9db8 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -330,7 +330,7 @@ int cca_genseckey(u16 cardnr, u16 domain,
 			struct {
 				u16 toklen;
 				u16 tokattr;
-				u8  tok[0];
+				u8  tok[];
 				/* ... some more data ... */
 			} keyblock;
 		} lv3;
@@ -471,7 +471,7 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
 			struct {
 				u16 toklen;
 				u16 tokattr;
-				u8  tok[0];
+				u8  tok[];
 				/* ... some more data ... */
 			} keyblock;
 		} lv3;
@@ -596,7 +596,7 @@ int cca_sec2protkey(u16 cardnr, u16 domain,
 			u16 len;
 			u16 attr_len;
 			u16 attr_flags;
-			u8  token[0];	      /* cca secure key token */
+			u8  token[];	      /* cca secure key token */
 		} lv2;
 	} __packed * preqparm;
 	struct uskrepparm {
-- 
2.25.1

