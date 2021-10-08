Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1544261A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 03:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhJHBYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 21:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhJHBY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 21:24:27 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EB7C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 18:22:32 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id p2so8790853vst.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 18:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ei10kcGMvMcyDZ3ZmNsU37HKmYhFg9rDN1UeR3hZi3Y=;
        b=QJNryHgked3U3lS7vrOeYjDn7mugdqYz1ozfYMnrFwMzT4KEASOsbDEsHkFAY5Cu5S
         LP8oEMsVN2U8HLqmbiA6QM+P0ltu7uyGDH5sg6pWiQbAmVq7IWK818Lt66lgt+aYzAqB
         4OchEVsCkSVmq43QefWF3VT3bilNLYjiM/tkgewi4Irj7tc0EJau+iFKjlUqjrCIIhCM
         tsQM4StzPwNTFjGbTte2rvn12K2onzLLjVSY82Q+pUaPXUrtsCBvzGoW/W2B1z+OzFrr
         +hiOMHm0Kph4Epu5I6WAgX7bz1sM5KCJPOC+RGtPR0LAbAbhbknAr0bX8n+OEUl7hSro
         CFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ei10kcGMvMcyDZ3ZmNsU37HKmYhFg9rDN1UeR3hZi3Y=;
        b=ege/urTAa9zn4qfLigal0BUkja5SgPABiS1Q7ROuRq1IUrMvfbRKOE7630sWVmKuu4
         vyu8VY89JGenLp5FP34mkdxV9Uu3s0pLdNA1DcJADLaoxKc768dX+UKVqEyxUHfQvGTE
         dDAo9Nk385uIwHY7sd38DlzhbRalI0TsBnbX6xZUZvAJQO3nyTOVeTawC5eN4UbLlyS4
         fxXGhhjYhB0MMflkpEYvUashjtzznPY1eDx8mbEDN9UNvedvOiuUV0qa3hEspXWILGaU
         TE98fPhg8GAxZlR/YGFN8oBLm8Adr7UkfoBavrwXiVLHYd89WIk6/gJb/7XQca3FQ0Cw
         pR7g==
X-Gm-Message-State: AOAM531IX+gGLCi6dkEtM0dXqCru84v0qHpdPyx/rSJvOg0BEe2AiPsX
        N40U1xaTIGqlzgDqW+7DAeBrpKV0Ol2/m4KVi15dBoD88OY=
X-Google-Smtp-Source: ABdhPJzJeFEk1VqzAU5lnBpKsZ9oslsukJavpMhDy81w9Mi7oOFozy+K2CMbzTdB1IdHlFCAKoKAU2WO0ItPARskbyg=
X-Received: by 2002:a05:6102:b06:: with SMTP id b6mr7981492vst.17.1633656151361;
 Thu, 07 Oct 2021 18:22:31 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Fri, 8 Oct 2021 09:22:00 +0800
Message-ID: <CAPm50aLPxJCiVTqqwiz00oMNiqHggB84sXB3x=tv_HUAd5UktQ@mail.gmail.com>
Subject: [PATCH v2] mm/huge_memory.c: disable THP with large THP size on small
 present memory
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <flyingpeng@tencent.com>

After setting the page size to 64k on ARM64, the supported huge page
size is 512M and 1TB. Therefore, if the thp is enabled, the size
of the thp is 512M. But if THP is enabled, min_free_kbytes will
be recalculated. At this time, min_free_kbytes is calculated based
on the size of THP.

On an arm64 server with 64G memory, the page size is 64k, with thp
enabled.
cat /proc/sys/vm/min_free_kbytes
3335104

Therefore, when judging whether to enable THP by default, consider
the size of thp.

V2: title suggested by David Hildenbrand

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5e9ef0fc261e..03c7f571b3ae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -437,7 +437,7 @@ static int __init hugepage_init(void)
         * where the extra memory used could hurt more than TLB overhead
         * is likely to save.  The admin can still enable it through /sys.
         */
-       if (totalram_pages() < (512 << (20 - PAGE_SHIFT))) {
+       if (totalram_pages() < (512 << (HPAGE_PMD_SHIFT - PAGE_SHIFT))) {
                transparent_hugepage_flags = 0;
                return 0;
        }
--
2.27.0
