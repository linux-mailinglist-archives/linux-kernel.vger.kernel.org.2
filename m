Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6618940B7A5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhINTNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhINTMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:49 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9655AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:19 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o3-20020a05622a008300b002a480a6b8f4so3289662qtw.15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kfIc+vswMal1y/GnkCq7gBbYkzLItYqo8IumxqOd7RU=;
        b=AqILFiwQmf3jA0AwV/o54cYhmVwlUmQp+5bSFq9OoWy1dNdXVoknMtpdat7iX2/OUs
         rnlDytvYhFwVm46OxThKp/iG76QR5Dwcek8ruO0jd/nGbBJpKGHDka0/LjrRl6QUbMWf
         ofVcQJZXsY4NWEf6/+zB9E5m1/Tm2JlZFvzTDzvB89qeLUu5alUGA6fXsv+SG2PujBr8
         0Kq3hBqhTsap2i8m06wwQs11pP9pO/Mrv52hklDmehZtNP1ZRM6tQVQJAoRvL2LCTt30
         OwfWg5luD7QuyPfWRxOl6hvp1jvSgCcjv82ldkNUAVOk4UFKzhUw/54JAD+m739FMh4G
         Eb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kfIc+vswMal1y/GnkCq7gBbYkzLItYqo8IumxqOd7RU=;
        b=JNKjGpsPEI95w0FLfK+J6WRwb3K+yIKb27S1psHmoJhcM0kp/VTwauvOtAfQOP2yqU
         7mx14Net+2vd4Cw+Zml0xCttSqV5o+jpsnL7yL2WgLgOYhRvdzXh782+d4hB9V6KDtZQ
         FFXivjbpo84T0mlIBaSPoISz5Z9xZh017uIg4E/kOgIL5D9Q8AnEsCH493nNAmB6fNhF
         2b+r1zzoXw1Denud9OH64kbMqVprclnrZ59GZe1u4US6LEAOOFs1PwLc0p0XVMTPKN/I
         263h/XZGVGgeHczhcNozQbKEZzWK7pStYUbRYlGcnnMTLDS+4I5bYganJPk+rQM5htO1
         cM7Q==
X-Gm-Message-State: AOAM530d5Swqep8+pZG7bTO+gazztydYk1feW3tlIfvvREG/dyFd7l+h
        9d70yZ55zp2mGNyHBCceXHyEpLB0Z/LpHtKJDDo=
X-Google-Smtp-Source: ABdhPJwriSMOh7PYI7oetLeMw8cyOwxNlMbnOWj5jax2QNj7qwyVuB1yCuGw4uHleiM9+s5hIKACogvIl+SyHoY+Y5Q=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b2d6:: with SMTP id
 d22mr7033291qvf.7.1631646678669; Tue, 14 Sep 2021 12:11:18 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:42 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 13/16] x86, module: Ignore __typeid__ relocations
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

Ignore the __typeid__ relocations generated with CONFIG_CFI_CLANG
when loading modules.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 5e9a34b5bd74..c4aeba237eef 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -197,6 +197,10 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 			val -= (u64)loc;
 			write(loc, &val, 8);
 			break;
+		case R_X86_64_8:
+			if (!strncmp(strtab + sym->st_name, "__typeid__", 10))
+				break;
+			fallthrough;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
 			       me->name, ELF64_R_TYPE(rel[i].r_info));
-- 
2.33.0.309.g3052b89438-goog

