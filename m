Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6735387F52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351510AbhERSOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351490AbhERSON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:14:13 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3054AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:12:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q15so7573768pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9UF6JPc9kDNTRCs7ffieF/jBad0EDQKUws2Yd0IxgKo=;
        b=mF2+K3rbAZ0Yt5/HqP3OFrc/Xx54XHooQYogRvZoEYAimzTp2eOmKQ3T5njQWNfslm
         SIJvM9kv40LnTXqBoEg4OnbhyxlzQOZEHXyqyZ3kt9RpvMX3tMxgwpanZrsuczEI+s/m
         7mHCnVs+2eOPFnA43kYZsY5dbADtuu8NXTcpd1JJkTOC0QsqpuU0nCIaPJv0M/eWJySf
         rL/wNW2G6JnQmlN1zIdfZZZ+2ZHa4FuZeLFlOuPY5s2zxCpxTimFfuUF14PYILkRgZA7
         JUUEZgTeJWWZjZaLo+ESU/ec2+W07oX7+9Wytj++jA9y6t6QRmD0EU7wF/iYnmCXQvGh
         qLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9UF6JPc9kDNTRCs7ffieF/jBad0EDQKUws2Yd0IxgKo=;
        b=FzjnQTCBnu+hq1L4YHqGsMh3u4lcUaf1pcvww25FCCypnmcRsVJzZAwmgStiFcgt1X
         aIDEYpdSQmJx/+tpvrWV3Yz9kksxxsH6ji43q+PwkytV17iF0Jw2i5ATQQS6cVLx+Vy1
         ZHWrFl3Ax8P/I3ygcmCZ98ZiickyslYl+0fav7hHZzcnhWV+84bX01UOOAC/FP7060Js
         oWd/Uv+HsdV2s2hMa/met+n7pth+Br+Q7lZJFAq9kmz0M+eWqNTGh19h6yYKIwB3fHWN
         1WsAcDQH4UMPTp6vlzZ27R/tNAuAAdRXzpWr78zT3xcx1/XQX/g62yrOmdmZTnl825tg
         mXQQ==
X-Gm-Message-State: AOAM533VPnRdawI342tyClJ3RULJjsLFF6I/UR7dmZ7Cv1ypr0Ecmb0H
        CozSNVqVK7S5nZlWU02MFcg=
X-Google-Smtp-Source: ABdhPJxlIMg35Y34lyvIH7pG1V8clcjDW70mvdmqgCHA/6d/t4M75yoaEILr9aNOKOIYkc6qb8B5Zg==
X-Received: by 2002:a63:4145:: with SMTP id o66mr6395237pga.4.1621361574683;
        Tue, 18 May 2021 11:12:54 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id gz18sm2463721pjb.19.2021.05.18.11.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:12:54 -0700 (PDT)
Date:   Wed, 19 May 2021 03:12:47 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] mm, slub: Fix support for clang 10
Message-ID: <20210518181247.GA10062@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously in 'commit ff3daafe3fd3 ("mm, slub: change run-time assertion
in kmalloc_index() to compile-time")', changed kmalloc_index's run-time
assertion to compile-time assertion.

But clang 10 has a bug misevaluating __builtin_constant_p() as true,
making it unable to compile. This bug was fixed in clang 11.

To support clang 10, introduce a macro to do run-time assertion if clang
version is less than 11, even if the size is constant. Might revert this
commit later if we choose not to support clang 10.

Fixes: ff3daafe3fd3 ("mm, slub: change run-time assertion in kmalloc_index() to compile-time")
Link: https://lore.kernel.org/r/CA+G9fYvYxqVhUTkertjZjcrUq8LWPnO7qC==Wum3gYCwWF9D6Q@mail.gmail.com/
Link: https://lkml.org/lkml/2021/5/11/872
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9d316aac0aba..8d8dd8571261 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -413,7 +413,7 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 	if (size <=  16 * 1024 * 1024) return 24;
 	if (size <=  32 * 1024 * 1024) return 25;
 
-	if (size_is_constant)
+	if ((IS_ENABLED(CONFIG_CC_IS_GCC) || CONFIG_CLANG_VERSION >= 110000) && size_is_constant)
 		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
 	else
 		BUG();
-- 
2.25.1

