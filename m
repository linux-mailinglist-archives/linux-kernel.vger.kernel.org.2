Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E79F40B81B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhINTey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhINTex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:34:53 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2DAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:33:35 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w6so64212pll.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9HtM5LJiLlnoib4lYiLRFHMJjkrTtS7BIKN49Lg7zyU=;
        b=RHFMNiuVUUspmr+lhdCReOoOs7+PeEiR7YxvRBK+bOaJjHyjmsWEsHDDfPvqOW5yDt
         zDszNFdSaCO9MJJDSYfPopSCiem5AU0gZoCRKqDh/QvdN2Ymcesw1yLpXVJaTU6eUXqv
         npcnYs7mz2Z5E88V5YhqqQwtlO4PQG7pJ5e0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9HtM5LJiLlnoib4lYiLRFHMJjkrTtS7BIKN49Lg7zyU=;
        b=pEXJmTOuaJWPKq3gWbwVE9b9JiJVAaxSRkW0coBhZ/dZlyaCGERY7fflBqd9YBOFwL
         CO5JohsbyvXNmub0mupBGl2quUEqSF8vr3zT4bgCj7HH+41J95OnpNIprUVyBdrG1ean
         XpNseywa9TfFBVM1S6OtyP71NIpe8NyCjT+0tqEfVdk1e441MVUh20ZZ3ARUisu8FcEv
         xOmzhfwe/zTQ43yrZMwyFAoelHfWy+okXpJBoXjo1QBapsR9ThAZjK169M0cUaBrzK9Q
         ZGw0LqHHiDqOCn8DNgBe86Xg3W62hMAbZ+LTbOL2LgQucSRLUeiNgy2a2JHGoLHvCiuA
         xs/A==
X-Gm-Message-State: AOAM5312jXYJZPy5WvE9auQFWerjMbiNjonyL4AfimXYK25/jUdGCFTf
        MR9MDK5/ko3QZJJ94O35HFecsmimp0KLuQ==
X-Google-Smtp-Source: ABdhPJxt3I/wU2dbM+lhO1fHQtKXL2+tDL6MvOTSBjT+HagDNkkLLV/diGyDZV6HNqrasy3yCjtLNw==
X-Received: by 2002:a17:90b:4c8f:: with SMTP id my15mr3924149pjb.131.1631648015192;
        Tue, 14 Sep 2021 12:33:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i1sm2464576pjs.31.2021.09.14.12.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:33:34 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:33:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 09/16] x86: Use an opaque type for functions not
 callable from C
Message-ID: <202109141233.01761C8@keescook>
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191045.2234020-10-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10:38PM -0700, Sami Tolvanen wrote:
> The kernel has several assembly functions that are not directly callable
> from C. Use an opaque type for these function prototypes to make misuse
> harder, and to avoid the need to annotate references to these functions
> for Clang's Control-Flow Integrity (CFI).
> 
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Suggested-by: Alexander Lobakin <alobakin@pm.me>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

This looks clean to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
