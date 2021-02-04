Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF62730DE74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhBCPmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbhBCPkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:40:35 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAF1C061573;
        Wed,  3 Feb 2021 07:39:53 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id w20so15606113qta.0;
        Wed, 03 Feb 2021 07:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Szz2d5g4+tntyXnCUwRqwxbX80mODpAHIKwbZzrC9Ic=;
        b=nUlTmPut9KdlDq/IaDkdCQSR39emnvn700krfch+1X+lppYOABQxM+XaxNDp0ngVEv
         kMyclZ7vgPTB92D6RgXJqW2YaMlNquRY50u4TJQtkizqPEQgK1O4SIXsaL8PQESXy8Vd
         T83HGP46Tb5KxQ3S9XNTYpG4dvzmHPlyr3cmLTGQwlthEY2+60ytIpYAja/YF5GyOj4g
         cgl74pvMyq07klF1g6mI42wS5oZqr+ossU7qtgHdK+fmRD7Rr0skrrNH7FY+hzZRGHH7
         999w6aZb1jgB8RIjMmVCsPLsJabAT/OryGoXU5zgfGnmSkE/+WMLtDXqArZW+ZCLccr6
         mpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Szz2d5g4+tntyXnCUwRqwxbX80mODpAHIKwbZzrC9Ic=;
        b=W0FgA5hSJdLIfB0CQJRjcuSpMiGrtvY4W/AeJoV75twK3QLFierP7wi6Z47PCIWgwd
         ZAi9uAONiia1zCUodCKD3x0SIiLyBvR4f6RAf5WsglfBu1EVVL/v6Hp5py/cDfa+xhTl
         xzWbIR1A/l8LMVFjqXnWky2NpHOPQ4KZHvH1hOfBsmrgg2OrcSO5k31FJXyXpkizZgAP
         oSip3Rm3Za1+U61XC5puXjiWxZ0+GUMMAu86sXmSTNHzBw5zGTwRQXLHgARpaKDxsh/U
         vCq0q6qFixk6gOZx80MTgn2KC/WC6eOhq9yAjfwy0L4J20Al4heVMUb3PS1PkAE2O7mg
         DpPQ==
X-Gm-Message-State: AOAM532rl0x41j5cSunWFp8pt+u6dNrjxg+W5nz3QLl1PZzNdZq/+pqv
        zsWUkKiPrHFoG+F396XwZ6k=
X-Google-Smtp-Source: ABdhPJwKPfqoGBqizojzqGe7DRza1dTy/1sxx3WKAZHnMV5KcR/hBuhGfIDxohTlBqnBmij39yAG4g==
X-Received: by 2002:ac8:4517:: with SMTP id q23mr2970684qtn.284.1612366793161;
        Wed, 03 Feb 2021 07:39:53 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.139])
        by smtp.gmail.com with ESMTPSA id t71sm1903316qka.86.2021.02.03.07.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:39:51 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] crypto: Fixed optimzation to optimization in the file crypto/xor.c
Date:   Wed,  3 Feb 2021 21:09:33 +0530
Message-Id: <20210203153933.9443-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/optimzation/optimization/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 crypto/xor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/xor.c b/crypto/xor.c
index eacbf4f93990..c046d074f522 100644
--- a/crypto/xor.c
+++ b/crypto/xor.c
@@ -95,7 +95,7 @@ do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
 	for (i = 0; i < 3; i++) {
 		start = ktime_get();
 		for (j = 0; j < REPS; j++) {
-			mb(); /* prevent loop optimzation */
+			mb(); /* prevent loop optimization */
 			tmpl->do_2(BENCH_SIZE, b1, b2);
 			mb();
 		}
--
2.26.2

