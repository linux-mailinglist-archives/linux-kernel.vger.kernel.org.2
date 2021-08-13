Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9051C3EB205
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbhHMHzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:55:39 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49634 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235010AbhHMHzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:55:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UirXvYB_1628841308;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UirXvYB_1628841308)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Aug 2021 15:55:09 +0800
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
Subject: [PATCH v2 0/3] support test GCM/CCM mode for SM4
Date:   Fri, 13 Aug 2021 15:55:05 +0800
Message-Id: <20210813075508.98854-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCM/CCM mode of SM4 is defined in the RFC 8998 specification:
https://datatracker.ietf.org/doc/html/rfc8998

There are several places where the return value check of crypto_aead_setkey
and crypto_aead_setauthsize were lost. It is necessary to add these checks.

At the same time, move the crypto_aead_setauthsize() call out of the loop,
and only need to call it once after load transform.

---
v2 changes:
  - check the crypto_aead_setauthsize() return value
  - move crypto_aead_setauthsize out of loop
  - update commit message

Tianjia Zhang (3):
  crypto: tcrypt - Fix missing return value check
  crypto: testmgr - Add GCM/CCM mode test of SM4 algorithm
  crypto: tcrypt: add GCM/CCM mode test for SM4 algorithm

 crypto/tcrypt.c  |  74 ++++++++++++++++++++----
 crypto/testmgr.c |  29 ++++++++++
 crypto/testmgr.h | 148 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+), 10 deletions(-)

-- 
2.19.1.3.ge56e4f7

