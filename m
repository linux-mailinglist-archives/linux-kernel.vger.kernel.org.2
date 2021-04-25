Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6036A969
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 23:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhDYVOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 17:14:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:47840 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhDYVOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 17:14:14 -0400
IronPort-SDR: QfunEUqbkP+rV9PvisVarmrfXuVr3/nNrKG5latxRtJubTq3w5huOsYocm01DziDZGTD90blDm
 S9TQaPOvUnWQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="183739451"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="183739451"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 14:13:33 -0700
IronPort-SDR: KnJSpang80nACaVwH+kWyj2nLYwsNNaRPyKuZOJDR2iQurCo+qm7sW0pBaAsYl8ufS56iR3jYy
 c3VyK+6QIfSQ==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="429116042"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 14:13:32 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] poly1305: Make prototypes match
Date:   Sun, 25 Apr 2021 14:13:25 -0700
Message-Id: <20210425211325.3157769-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

gcc 11 complains when arrays in prototypes do not match the function.
Fix this here.

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Andi Kleen <andi@firstfloor.org>
---
 include/crypto/internal/poly1305.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/internal/poly1305.h b/include/crypto/internal/poly1305.h
index 064e52ca5248..90ee36411e36 100644
--- a/include/crypto/internal/poly1305.h
+++ b/include/crypto/internal/poly1305.h
@@ -18,7 +18,7 @@
  * only the ε-almost-∆-universal hash function (not the full MAC) is computed.
  */
 
-void poly1305_core_setkey(struct poly1305_core_key *key, const u8 *raw_key);
+void poly1305_core_setkey(struct poly1305_core_key *key, const u8 raw_key[16]);
 static inline void poly1305_core_init(struct poly1305_state *state)
 {
 	*state = (struct poly1305_state){};
-- 
2.25.4

