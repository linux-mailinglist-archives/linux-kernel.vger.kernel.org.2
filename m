Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1853174C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhBJXw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbhBJXwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:52:43 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F36FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:52:03 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t25so2369074pga.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RqrcmBvSp+AfCyDbTNQeAWJW47jyI7LST7znFnRbaY=;
        b=S/w5ZkWkNMRWHoojAYD/diEh4aI3LfPNbz+6i3xiI3H58fp1VX0ZL29+rFGi2y/XRZ
         HJund21d+QVhCZUtZ6FDzi83Vf+esFKIN4JDBwTFyPVxZf+uTkb5JCk7QEu2UC7bioqG
         tSinMcigd7ma1Cuf1I4X3wS0nwWLgKw17UlzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RqrcmBvSp+AfCyDbTNQeAWJW47jyI7LST7znFnRbaY=;
        b=W6AlLHaI4EjAIzsfdOX2U7cZvxIzbxjKBd0tJlhx/52R2EJWzpxjIU7tnP455NJeBo
         rfRi7WoUsL5z8UnyyGnf71ahrZ4FxcVF5G+Ff0lo2fvXXI9fOCOpecNwVzh01N2/2s8/
         RjKGka43q9uQNTgvuRqFIRgU0E4F2SDj3Cb5ES0yfaP2wSeY18ibV0/tHBu0IzKhtspb
         yIXGTZBtmbvGY6iizRqT4zEQWU5kc9Onma2gs9INZrZfY2Pqvoq++6mVpdvd0curEsKa
         Zm5ey0xGP3457TPGpnCsG1g9c+tJOirFnYvBpghWb7i2I4Iw1PzKOgnSTDNPIAH1lBqc
         ruSQ==
X-Gm-Message-State: AOAM532ueY/O+13u1ZKpH/YGZKhg0F6KMEojYm/nZPHNUVS7GgdCoWew
        lBpOvMVSxS9MvqKi4o0EDxdqPuzhcV1XPg==
X-Google-Smtp-Source: ABdhPJxO6F2cxeUUIYk3TZlrfEHU7oXT95eujXQYKA24s93iFWEPgApaorjplCrx1gcGdPiHZeDHKQ==
X-Received: by 2002:a05:6a00:1a46:b029:1d5:9acd:798c with SMTP id h6-20020a056a001a46b02901d59acd798cmr5302704pfv.25.1613001122869;
        Wed, 10 Feb 2021 15:52:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s23sm3427212pfc.211.2021.02.10.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:52:02 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org
Subject: [PATCH] block: Replace lkml.org links with lore
Date:   Wed, 10 Feb 2021 15:51:59 -0800
Message-Id: <20210210235159.3190756-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=2b392b78f5ee01e9203448b6ce61edad507ab0e5; i=IGI1xt74lLuj6j2hPzpbXMCl+rubQWiCF3jE3okcbg4=; m=kc8NgBcNkR1FdAUFoBcecPqIFWVDlhJwDI99K+gzg58=; p=oMk8zTlanqECFHj8udWi0YpfsWy8cY89E6aJQBmmOe8=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmAkcZ8ACgkQiXL039xtwCbGrg//QRf WC+6w+4+XFz6/a4mLgBIP9S8YfZuJplYzrME1LlHhvpyxujFiNnqNQkorD5vi96Nc/YKvc0VHtqmS gLeCaRmgfj727yCD0dt4uALzq46f+gAgARD0whwcL7MZmKr9OdduKfWiL3YA5kHhz3leVZ+Ezb82t RDUWrIp4BwRnuY77gI24ayM7l88W+8ARr3oMul05ScA5Jz6J7f3yLhylMk+4n1apcS34U23dOVcAM qxicR0o2X7UmXgy7WR/628buGJlqdt8Su8VrnFVY7d+e3U3b0eSm1yyGEOa4EIxdbs6cHy2OYKs0A S4u85+6EblJXRKPnUJ8rg0hnlPf3M+cOcwedjnKwtjkJsbUBBQbx8/5GJ5LVxQ9owEcYi3W2wMZxr r9rwV/Ek1yMwn0Goc5PzOX9doOle92gsZyPxpZBZ2Ofv9go8/nSgKWya9kaERT6NMVik7dCJVrvgU 6K7tIicCx9FqdtCtW2QzB9nyPDvKNswLxgzg2GulO+CAZ0G9iE3KOPGUDS/aRUMd0mpPufhAqmANH UmGekl2/eqCjHdTYcMS+mcb9sGNuZ9Vw0hy4DU5zGBT9TCUFQ/RsJiiXKJVfyJduwrEBY5+MIvrD5 2fOhrKLE3qk0+ZeWXkWnV2/V2ROg06LovATrjMuoqql5HY1qJf5xxYMdtCw67g+E=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
links with lore"), replace lkml.org links with lore to better use a
single source that's more likely to stay available long-term.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/block/aoe/aoecmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index ac720bdcd983..ecd77897a761 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1046,7 +1046,7 @@ aoe_end_request(struct aoedev *d, struct request *rq, int fastfail)
 
 	__blk_mq_end_request(rq, err);
 
-	/* cf. http://lkml.org/lkml/2006/10/31/28 */
+	/* cf. https://lore.kernel.org/lkml/20061031071040.GS14055@kernel.dk/ */
 	if (!fastfail)
 		blk_mq_run_hw_queues(q, true);
 }
-- 
2.25.1

