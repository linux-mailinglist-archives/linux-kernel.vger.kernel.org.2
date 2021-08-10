Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C73E3CCD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 22:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhHHUxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 16:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhHHUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 16:52:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1005FC061760;
        Sun,  8 Aug 2021 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=obVVKT7zJZtqd8jm+BSJkYIVZxA7NA30OpaREitSbX0=; b=iYqRiOLMg7Dxg4Gbg702A8T3Mc
        51ulKVmjipVAWk/AMjNRdz86/OIiDv3Rj3Ni9oxGsCjxk4xnb/vI1MP0xDcbvnw4I9QLSKGANGff/
        eTuG529Bv/qdLtLAPd1TfdNlRzvLXA1AEuPGRZpsD2JrxxqQx1/Wm9QqxXYN1QRQVT1XvyJbQnj8L
        BmGE4iCdd4Q9KVoW2/oJL0ProDr5b5AS/K3NwJx1yABoUgjsi/LjxfpqxkyMJNIO2mnbmZtOmo3WM
        fhyzpAt684Yy63V+e73jcTenoqLioOghOgN9N8X2MlOR7FsDSFLu8DP4vMNZ6xn45I6JvjgVOKncz
        xrMRlEMQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCpmc-00GUaC-E3; Sun, 08 Aug 2021 20:52:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: wp512: correct a non-kernel-doc comment
Date:   Sun,  8 Aug 2021 13:52:33 -0700
Message-Id: <20210808205233.21662-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use "/**" to begin a comment that is not kernel-doc notation.

crypto/wp512.c:779: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * The core Whirlpool transform.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 crypto/wp512.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210806.orig/crypto/wp512.c
+++ linux-next-20210806/crypto/wp512.c
@@ -775,7 +775,7 @@ static const u64 rc[WHIRLPOOL_ROUNDS] =
 	0xca2dbf07ad5a8333ULL,
 };
 
-/**
+/*
  * The core Whirlpool transform.
  */
 
