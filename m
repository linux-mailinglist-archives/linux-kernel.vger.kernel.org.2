Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1797237CE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344370AbhELRBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 13:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238050AbhELP5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:57:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B2DE61C2C;
        Wed, 12 May 2021 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620833381;
        bh=kqBPCLw3fTjQTbbrkRgQ1iSU7cna6dND4Gyu3RXdw9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=voUS8SwwnqWs75bdi/4/gHSz1I0cvGQDtMWWqkrtvgkTnxpNNbpMVyB6paFEZ8BZE
         FQKzEiK+K8/6Fc84GGpsFkTVoG/o83vrGI6sMuwYlj2akCZ8xEPeXGp0xiz7l6GZoC
         JLklUdHcbvvNvPfGssytH5u/criYW+XjzaT6CWJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.11 127/601] crypto: sun8i-ss - fix result memory leak on error path
Date:   Wed, 12 May 2021 16:43:24 +0200
Message-Id: <20210512144832.010356293@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512144827.811958675@linuxfoundation.org>
References: <20210512144827.811958675@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe.montjoie@gmail.com>

[ Upstream commit 1dbc6a1e25be8575d6c4114d1d2b841a796507f7 ]

This patch fixes a memory leak on an error path.

Fixes: d9b45418a917 ("crypto: sun8i-ss - support hash algorithms")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 11cbcbc83a7b..0b9aa24a5edd 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -438,8 +438,8 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	kfree(pad);
 
 	memcpy(areq->result, result, algt->alg.hash.halg.digestsize);
-	kfree(result);
 theend:
+	kfree(result);
 	crypto_finalize_hash_request(engine, breq, err);
 	return 0;
 }
-- 
2.30.2



