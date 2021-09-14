Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777E140B846
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhINTl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhINTl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:41:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E193C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:40:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id bb10so81755plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tcEmJONXzFctWoWAbmoyFCWtMu++a2TB+LdKgluV5F8=;
        b=b67l9+LmGiNJMncgt37heGIa5UQNPduT93QdVJx5GAJ47eIMnEysXAK67zMtur4ffr
         kmwp2SMskf750h8rbaW2gKeA9RbZxn2pgByKKIBkWHmbsDqBni80cuhkQjdWGap7rUkg
         A7PRp6V9lRIT5Kn6iFNaEs1/fij2HOq1ve17k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tcEmJONXzFctWoWAbmoyFCWtMu++a2TB+LdKgluV5F8=;
        b=2x0uEhgqrheJVNIEKbLQA1HeuSVnpkDpvZE5SIyhkiF8aSOpm/jfKwH18bVlbJNNJV
         vSTG59cC3ss4morc8WrEQ4Yvi67VrjoaHsJoYvrWoNImyC1bwENV9XvomHE8bTujVluV
         gy/FYHzbVkD23k8f1XKbtn9HzBst817FWBMT1KvNzJlMBZSCAYybA1zF45h7DNbzTXgj
         eKcIEpmbeB3L9S57iRyxpCDWJIN1EOASthQyQ0An0Vubn2lXuBwCa9bf938YXv1jAzyU
         M/tx9kNLVP2uqiO5z3y6uQZy3ilm4Cjcr0wb72oFroViA7kQ9fHmxEx5bnvGHgewnsT0
         JXGA==
X-Gm-Message-State: AOAM530l1QlPMJYO/c1w0dIE+lDDQc9VcrcutXZWXuFhm82eHNwUeWEC
        j2u9737Hnr0u4T2G4SJzyVlcIg==
X-Google-Smtp-Source: ABdhPJyQ2jde2kQCG8xG2FpSQla1sqvqKIfFblIQE21QUYBOqODtnpyqi+wdRz0ZEUo2GLzDt4e3+w==
X-Received: by 2002:a17:90a:1984:: with SMTP id 4mr3968880pji.87.1631648409751;
        Tue, 14 Sep 2021 12:40:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y3sm2464895pjg.7.2021.09.14.12.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:40:08 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:40:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 15/16] x86, kprobes: Fix optprobe_template_func type
 mismatch
Message-ID: <202109141240.4843E7A9@keescook>
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-16-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191045.2234020-16-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10:44PM -0700, Sami Tolvanen wrote:
> The optprobe_template_func symbol is defined in inline assembly,
> but it's not marked global, which conflicts with the C declaration
> needed for STACK_FRAME_NON_STANDARD and confuses the compiler when
> CONFIG_CFI_CLANG is enabled.
> 
> Marking the symbol global would make the compiler happy, but as the
> compiler also generates a CFI jump table entry for all address-taken
> functions, the jump table ends up containing a jump to the .rodata
> section where optprobe_template_func resides, which results in an
> objtool warning.
> 
> Use ASM_STACK_FRAME_NON_STANDARD instead to avoid both issues.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
