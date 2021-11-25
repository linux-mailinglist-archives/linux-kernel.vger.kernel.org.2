Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F108F45DC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355768AbhKYOYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355455AbhKYOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:22:11 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE474C0613FC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 06:18:24 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z6so6031435pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 06:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igAQYittwj2sv4G11NsIvFax7f6VQwvfUotlmNhyHWE=;
        b=GIji/OLbPWA0UNqU5nDdcTRbV8IZ/r+UVCQm6RpOUxY+dzpzjOoP6ezF70a230LT0o
         NO4tEGaez/1vTmbp3fHyWHgj2SZi43IJd1VX2FQcOhIl/wLyfjjpCKk9g324xEWo9GtC
         46B4I4xBkqGC4oJJ4jbLSPYT5aZC5b8m2vHTUtzDIjLcK9oCLvcOEJyBrDd/e6SXAzor
         n1UpXAqZWiuVslPEJCSGOZztcoHTouSbv5zsnN2/1QkFfQHrF2Vrl93G2huVD7/ZvEqd
         5LIhffn0YtEP2t44rwEbE9p87MyoP7mqTyZzq9Mh3gf4qqcc8QgWmymZPyJ12o/JA6iV
         /lhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igAQYittwj2sv4G11NsIvFax7f6VQwvfUotlmNhyHWE=;
        b=v85gG9bHNYDleKUg7RU6grt4KsxoYluGMWYQX0T+0JU/13wFP+oH9cBgYFGWPI935k
         eeMBmJzZAfe45YUbtYA50jU77U4jBMvZwAb+WIx253NqXMWWnm8Yl/uHpo/RLQ9b7jl0
         z5ngSYK59mJ2+fOprUXFdLRD88QTEqtFw7lxgsh5xPSIiDC5VzdqQoubgNOeG2yxPwx4
         yKjBnASrgPUu5zdePdwnA/hWnfD0rmuQ5U3ohrTDzkml5k5W4jRf2Hu5YSOk874/ZncQ
         eXFYUG0PPrZfaORJSbc3IyPrJ0ZpOSUYAv8MzOBOfNtohSCg7R0xzYk4ea7HII2myjvR
         eTKg==
X-Gm-Message-State: AOAM531y3SZ39g5xe84c8lng5ewPUphz5gV8JhNPe0dX002SCEd/Rg97
        vTuTm63Eux1RuMmsiTI7n5UK5XxBfZg=
X-Google-Smtp-Source: ABdhPJwYATOqMFz7WMkO0k/V4O1xudODMzvijfuM2UgC2qZ4FzhccqPioTPOJ1xmvAGbWXIfqtUUcA==
X-Received: by 2002:a63:8641:: with SMTP id x62mr1332302pgd.232.1637849904538;
        Thu, 25 Nov 2021 06:18:24 -0800 (PST)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:b6ed:6a42:8a10:2f32])
        by smtp.gmail.com with ESMTPSA id t13sm3479870pfl.214.2021.11.25.06.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 06:18:23 -0800 (PST)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Alexander Duyck <alexanderduyck@fb.com>
Subject: [PATCH] x86/csum: fix initial seed for odd buffers
Date:   Thu, 25 Nov 2021 06:18:17 -0800
Message-Id: <20211125141817.3541501-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

When I folded do_csum() into csum_partial(), I missed that we
had to swap odd/even bytes from @sum argument.

This is because this swap will happen again at the end of the function.

[A, B, C, D] -> [B, A, D, C]

As far as Internet checksums (rfc 1071) are concerned, we can instead
rotate the whole 32bit value by 8 (or 24)

-> [D, A, B, C]

Note that I played with the idea of replacing this final swaping:

    result = from32to16(result);
    result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);

With:

    result = ror32(result, 8);

But while the generated code was definitely better for the odd case,
run time cost for the more likely even case was not better for gcc.

gcc is replacing a well predicted conditional branch
with a cmov instruction after a ror instruction which adds
a cost canceling the cmov gain.

Many thanks to Noah Goldstein for reporting this issue.

Fixes: df4554cebdaa ("x86/csum: Rewrite/optimize csum_partial()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>
---
 arch/x86/lib/csum-partial_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..40b527ba1da1f74b5dbc51ddd97a9ecad22ee5ae 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -41,6 +41,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 	if (unlikely(odd)) {
 		if (unlikely(len == 0))
 			return sum;
+		temp64 = ror32((__force u32)sum, 8);
 		temp64 += (*(unsigned char *)buff << 8);
 		len--;
 		buff++;
-- 
2.34.0.rc2.393.gf8c9666880-goog

