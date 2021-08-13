Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4216E3EB209
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbhHMHzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:55:45 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39896 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239212AbhHMHzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:55:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Uiri8dw_1628841309;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Uiri8dw_1628841309)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Aug 2021 15:55:10 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v2 2/3] crypto: testmgr - Add GCM/CCM mode test of SM4 algorithm
Date:   Fri, 13 Aug 2021 15:55:07 +0800
Message-Id: <20210813075508.98854-3-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20210813075508.98854-1-tianjia.zhang@linux.alibaba.com>
References: <20210813075508.98854-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCM/CCM mode of the SM4 algorithm is defined in the rfc 8998
specification, and the test case data also comes from rfc 8998.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/testmgr.c |  29 ++++++++++
 crypto/testmgr.h | 148 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index c978e41f11a1..70f69f0910c9 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4450,6 +4450,12 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(aes_cbcmac_tv_template)
 		}
+	}, {
+		.alg = "cbcmac(sm4)",
+		.test = alg_test_hash,
+		.suite = {
+			.hash = __VECS(sm4_cbcmac_tv_template)
+		}
 	}, {
 		.alg = "ccm(aes)",
 		.generic_driver = "ccm_base(ctr(aes-generic),cbcmac(aes-generic))",
@@ -4461,6 +4467,16 @@ static const struct alg_test_desc alg_test_descs[] = {
 				.einval_allowed = 1,
 			}
 		}
+	}, {
+		.alg = "ccm(sm4)",
+		.generic_driver = "ccm_base(ctr(sm4-generic),cbcmac(sm4-generic))",
+		.test = alg_test_aead,
+		.suite = {
+			.aead = {
+				____VECS(sm4_ccm_tv_template),
+				.einval_allowed = 1,
+			}
+		}
 	}, {
 		.alg = "cfb(aes)",
 		.test = alg_test_skcipher,
@@ -4494,6 +4510,12 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(des3_ede_cmac64_tv_template)
 		}
+	}, {
+		.alg = "cmac(sm4)",
+		.test = alg_test_hash,
+		.suite = {
+			.hash = __VECS(sm4_cmac128_tv_template)
+		}
 	}, {
 		.alg = "compress_null",
 		.test = alg_test_null,
@@ -4967,6 +4989,13 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.aead = __VECS(aes_gcm_tv_template)
 		}
+	}, {
+		.alg = "gcm(sm4)",
+		.generic_driver = "gcm_base(ctr(sm4-generic),ghash-generic)",
+		.test = alg_test_aead,
+		.suite = {
+			.aead = __VECS(sm4_gcm_tv_template)
+		}
 	}, {
 		.alg = "ghash",
 		.test = alg_test_hash,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 3ed6ab34ab51..e6fca34b5b25 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -13328,6 +13328,154 @@ static const struct cipher_testvec sm4_cfb_tv_template[] = {
 	}
 };
 
+static const struct aead_testvec sm4_gcm_tv_template[] = {
+	{ /* From https://datatracker.ietf.org/doc/html/rfc8998#appendix-A.1 */
+		.key	= "\x01\x23\x45\x67\x89\xAB\xCD\xEF"
+			  "\xFE\xDC\xBA\x98\x76\x54\x32\x10",
+		.klen	= 16,
+		.iv	= "\x00\x00\x12\x34\x56\x78\x00\x00"
+			  "\x00\x00\xAB\xCD",
+		.ptext	= "\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA"
+			  "\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB"
+			  "\xCC\xCC\xCC\xCC\xCC\xCC\xCC\xCC"
+			  "\xDD\xDD\xDD\xDD\xDD\xDD\xDD\xDD"
+			  "\xEE\xEE\xEE\xEE\xEE\xEE\xEE\xEE"
+			  "\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF"
+			  "\xEE\xEE\xEE\xEE\xEE\xEE\xEE\xEE"
+			  "\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA",
+		.plen	= 64,
+		.assoc	= "\xFE\xED\xFA\xCE\xDE\xAD\xBE\xEF"
+			  "\xFE\xED\xFA\xCE\xDE\xAD\xBE\xEF"
+			  "\xAB\xAD\xDA\xD2",
+		.alen	= 20,
+		.ctext	= "\x17\xF3\x99\xF0\x8C\x67\xD5\xEE"
+			  "\x19\xD0\xDC\x99\x69\xC4\xBB\x7D"
+			  "\x5F\xD4\x6F\xD3\x75\x64\x89\x06"
+			  "\x91\x57\xB2\x82\xBB\x20\x07\x35"
+			  "\xD8\x27\x10\xCA\x5C\x22\xF0\xCC"
+			  "\xFA\x7C\xBF\x93\xD4\x96\xAC\x15"
+			  "\xA5\x68\x34\xCB\xCF\x98\xC3\x97"
+			  "\xB4\x02\x4A\x26\x91\x23\x3B\x8D"
+			  "\x83\xDE\x35\x41\xE4\xC2\xB5\x81"
+			  "\x77\xE0\x65\xA9\xBF\x7B\x62\xEC",
+		.clen	= 80,
+	}
+};
+
+static const struct aead_testvec sm4_ccm_tv_template[] = {
+	{ /* From https://datatracker.ietf.org/doc/html/rfc8998#appendix-A.2 */
+		.key	= "\x01\x23\x45\x67\x89\xAB\xCD\xEF"
+			  "\xFE\xDC\xBA\x98\x76\x54\x32\x10",
+		.klen	= 16,
+		.iv	= "\x02\x00\x00\x12\x34\x56\x78\x00"
+			  "\x00\x00\x00\xAB\xCD\x00\x00\x00",
+		.ptext	= "\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA"
+			  "\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB"
+			  "\xCC\xCC\xCC\xCC\xCC\xCC\xCC\xCC"
+			  "\xDD\xDD\xDD\xDD\xDD\xDD\xDD\xDD"
+			  "\xEE\xEE\xEE\xEE\xEE\xEE\xEE\xEE"
+			  "\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF"
+			  "\xEE\xEE\xEE\xEE\xEE\xEE\xEE\xEE"
+			  "\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA",
+		.plen	= 64,
+		.assoc	= "\xFE\xED\xFA\xCE\xDE\xAD\xBE\xEF"
+			  "\xFE\xED\xFA\xCE\xDE\xAD\xBE\xEF"
+			  "\xAB\xAD\xDA\xD2",
+		.alen	= 20,
+		.ctext	= "\x48\xAF\x93\x50\x1F\xA6\x2A\xDB"
+			  "\xCD\x41\x4C\xCE\x60\x34\xD8\x95"
+			  "\xDD\xA1\xBF\x8F\x13\x2F\x04\x20"
+			  "\x98\x66\x15\x72\xE7\x48\x30\x94"
+			  "\xFD\x12\xE5\x18\xCE\x06\x2C\x98"
+			  "\xAC\xEE\x28\xD9\x5D\xF4\x41\x6B"
+			  "\xED\x31\xA2\xF0\x44\x76\xC1\x8B"
+			  "\xB4\x0C\x84\xA7\x4B\x97\xDC\x5B"
+			  "\x16\x84\x2D\x4F\xA1\x86\xF5\x6A"
+			  "\xB3\x32\x56\x97\x1F\xA1\x10\xF4",
+		.clen	= 80,
+	}
+};
+
+static const struct hash_testvec sm4_cbcmac_tv_template[] = {
+	{
+		.key		= "\xff\xee\xdd\xcc\xbb\xaa\x99\x88"
+				  "\x77\x66\x55\x44\x33\x22\x11\x00",
+		.plaintext	= "\x01\x23\x45\x67\x89\xab\xcd\xef"
+				  "\xfe\xdc\xba\x98\x76\x54\x32\x10",
+		.digest		= "\x97\xb4\x75\x8f\x84\x92\x3d\x3f"
+				  "\x86\x81\x0e\x0e\xea\x14\x6d\x73",
+		.psize		= 16,
+		.ksize		= 16,
+	}, {
+		.key		= "\x01\x23\x45\x67\x89\xab\xcd\xef"
+				  "\xfe\xdc\xBA\x98\x76\x54\x32\x10",
+		.plaintext	= "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
+				  "\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb"
+				  "\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc"
+				  "\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd"
+				  "\xee",
+		.digest		= "\xc7\xdb\x17\x71\xa1\x5c\x0d\x22"
+				  "\xa3\x39\x3a\x31\x88\x91\x49\xa1",
+		.psize		= 33,
+		.ksize		= 16,
+	}, {
+		.key		= "\x01\x23\x45\x67\x89\xab\xcd\xef"
+				  "\xfe\xdc\xBA\x98\x76\x54\x32\x10",
+		.plaintext	= "\xfb\xd1\xbe\x92\x7e\x50\x3f\x16"
+				  "\xf9\xdd\xbe\x91\x73\x53\x37\x1a"
+				  "\xfe\xdd\xba\x97\x7e\x53\x3c\x1c"
+				  "\xfe\xd7\xbf\x9c\x75\x5f\x3e\x11"
+				  "\xf0\xd8\xbc\x96\x73\x5c\x34\x11"
+				  "\xf5\xdb\xb1\x99\x7a\x5a\x32\x1f"
+				  "\xf6\xdf\xb4\x95\x7f\x5f\x3b\x17"
+				  "\xfd\xdb\xb1\x9b\x76\x5c\x37",
+		.digest		= "\x9b\x07\x88\x7f\xd5\x95\x23\x12"
+				  "\x64\x0a\x66\x7f\x4e\x25\xca\xd0",
+		.psize		= 63,
+		.ksize		= 16,
+	}
+};
+
+static const struct hash_testvec sm4_cmac128_tv_template[] = {
+	{
+		.key		= "\xff\xee\xdd\xcc\xbb\xaa\x99\x88"
+				  "\x77\x66\x55\x44\x33\x22\x11\x00",
+		.plaintext	= "\x01\x23\x45\x67\x89\xab\xcd\xef"
+				  "\xfe\xdc\xba\x98\x76\x54\x32\x10",
+		.digest		= "\x00\xd4\x63\xb4\x9a\xf3\x52\xe2"
+				  "\x74\xa9\x00\x55\x13\x54\x2a\xd1",
+		.psize		= 16,
+		.ksize		= 16,
+	}, {
+		.key		= "\x01\x23\x45\x67\x89\xab\xcd\xef"
+				  "\xfe\xdc\xBA\x98\x76\x54\x32\x10",
+		.plaintext	= "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
+				  "\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb"
+				  "\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc"
+				  "\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd"
+				  "\xee",
+		.digest		= "\x8a\x8a\xe9\xc0\xc8\x97\x0e\x85"
+				  "\x21\x57\x02\x10\x1a\xbf\x9c\xc6",
+		.psize		= 33,
+		.ksize		= 16,
+	}, {
+		.key		= "\x01\x23\x45\x67\x89\xab\xcd\xef"
+				  "\xfe\xdc\xBA\x98\x76\x54\x32\x10",
+		.plaintext	= "\xfb\xd1\xbe\x92\x7e\x50\x3f\x16"
+				  "\xf9\xdd\xbe\x91\x73\x53\x37\x1a"
+				  "\xfe\xdd\xba\x97\x7e\x53\x3c\x1c"
+				  "\xfe\xd7\xbf\x9c\x75\x5f\x3e\x11"
+				  "\xf0\xd8\xbc\x96\x73\x5c\x34\x11"
+				  "\xf5\xdb\xb1\x99\x7a\x5a\x32\x1f"
+				  "\xf6\xdf\xb4\x95\x7f\x5f\x3b\x17"
+				  "\xfd\xdb\xb1\x9b\x76\x5c\x37",
+		.digest		= "\x5f\x14\xc9\xa9\x20\xb2\xb4\xf0"
+				  "\x76\xe0\xd8\xd6\xdc\x4f\xe1\xbc",
+		.psize		= 63,
+		.ksize		= 16,
+	}
+};
+
 /* Cast6 test vectors from RFC 2612 */
 static const struct cipher_testvec cast6_tv_template[] = {
 	{
-- 
2.19.1.3.ge56e4f7

