Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E0D362981
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbhDPUjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343883AbhDPUj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:29 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CABC061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:02 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w21-20020ac871950000b02901b1a8294c46so2774697qto.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gU1hOjx3K7IYMK70RtBuGAoh0CWdKH9ubIz9k5V8HEI=;
        b=qnTY33/TYDr9Xvg5TYrpjX+9v7evpKhX+xdQCGNu5E4HtLXpDdp8wSbAU0J2BsOxwD
         KA8muBta7k72GkBdRtBSqH1brqL6Ycbe2m1pQ8/lq9lhaikv86shjHyMXNuO+fhlMQlE
         /CryjQTT5qVpt+pPBec2b3fKR3MvJ5jFf0WHv2LauKYtfORG1xa5cC9/sXGKGaS6v01l
         LWo8YYdakTDtVSqEVaDmQQ7ItC+FPQkba8mWEDHKKBaEkEk4PuHopVzWU0wWYNSEV93B
         mh2CEdnxEeEPFnhVbVF1+QGqL6jsaqwfXF9+Lh1x4oAo3/SbE0nii88Jx5RLnZUbgkId
         o/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gU1hOjx3K7IYMK70RtBuGAoh0CWdKH9ubIz9k5V8HEI=;
        b=Oz9RDTEXU4BXLhK+xcBeVwy5ZRWL30DFfFWtvBzR5URVub6ZBkv1fYD3jskbP3Okje
         6FDKmDdP6Tw3kPJ1w3Mp6Idla+F1CE3wRaCbIqmchPpzGI5l84lTYFmDqLYHvjjjTyo1
         f8YDMukO5WyS0z2uxNZWYSccizIf0GAOI/mPT0Zo8o1kb+SHdd5s//oDE1MXLVCGMYeB
         6ljSN33IQNHhICIvY5aTuP8Vjf0g66nAp8H39c91wJxxEOIsa6CAaWGuEn2LEmRuCoU5
         QxqjRWlUgWnnq31jx1yH1OeIZ+pwyE8qjq5jIYPRFIKvNOKzuubUvk0+6wEuPwqmr0Rs
         4Few==
X-Gm-Message-State: AOAM531gRP5Ks5DXIuAK4f4txberdXXbnx1YNLpQciZbPaFfEwOzcLke
        737IXCqPOdQIY6Tm0zmsvE7MmvvdzuFbSzdunVw=
X-Google-Smtp-Source: ABdhPJxteHgJbT/1BjFZeoPfDfJRxoTqi9nMz9MOu5KRn4NwNpdjN4ilFRIoY+2W8/Iu08YaFgTQY0npKfuaR2h8jzM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:176a:: with SMTP id
 et10mr10444816qvb.23.1618605542149; Fri, 16 Apr 2021 13:39:02 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:37 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 08/15] x86/extable: Do not mark exception callback as CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

The exception table entries are constructed out of a relative offset
and point to the actual function, not the CFI table entry. For now,
just mark the caller as not checking CFI. The failure is most visible
at boot with CONFIG_DEBUG_RODATA_TEST=y.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/mm/extable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index b93d6cd08a7f..a7eae1c4c59f 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -155,6 +155,7 @@ enum handler_type ex_get_fault_handler_type(unsigned long ip)
 		return EX_HANDLER_OTHER;
 }
 
+__nocfi
 int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		    unsigned long fault_addr)
 {
-- 
2.31.1.368.gbe11c130af-goog

