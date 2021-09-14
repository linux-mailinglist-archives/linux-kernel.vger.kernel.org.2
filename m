Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8AA40B816
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhINTdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhINTdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:33:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62136C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:32:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o8so69379pll.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7HJuxS291se7h0pWa8RwOF5pMXHcq2hWKO/DuoK0nSw=;
        b=YcuSryWcll5qZWFgHfCzkDhCl/66XVdRjSv6JbOVPFPcgy0ifWt+iJ4I67uLoOfz96
         ljG8aT7RCWjDbEzYCmmjafKuNtT6gxSQ/6Iv1+q/yNgvNCrUTFxlctrM9ZfCehlbpHcB
         wE2alCrI13VE0W8/6XPfkD8d/v3z2M1+pF/ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7HJuxS291se7h0pWa8RwOF5pMXHcq2hWKO/DuoK0nSw=;
        b=JpYPmt62gNFR5+U9BVyixuM8uPniR4yFIC6xq90gikOKWYKwfUAAV8OKcwoZ1gPTBw
         SFK3lRRHKkN74YS6wKFVZRbZr1j5tDi4hktW1Cg1OgUjlcpN8SjHJ7UXk7pVohqm1Z03
         iNT9drwypwzngying1el1mLGbubia315DeRDhbXteRif3jQYLp0KsInmXAX2EHemG7Cy
         Y3XP4RIVQX0/neKuzVL5GB92uQoD0584SmlX6eTcdqvd5ShjSoH7vofrYQIhVd0mVd0O
         OuEWiO+XMqATc0siDpImedCdajXD1H0dT7yGQgGmOOYdr/4LmoZwjniTfedZcQfcP2bh
         fhig==
X-Gm-Message-State: AOAM533Lq2CW7oPz04ujPu558jFQpaEJnptYeX1bw+B7lkhYnhykdqeD
        HDKZBk0vVuK0nUhyy86hbm2+0A==
X-Google-Smtp-Source: ABdhPJxAfgyQ+0BOY7pY+EQe0yRgyPOYJ2jE1ubX84l0DdSbIMZJuiU2yae5vGJ4DadJ6Ju+1sfzqw==
X-Received: by 2002:a17:902:ab5c:b0:13c:87ab:15f5 with SMTP id ij28-20020a170902ab5c00b0013c87ab15f5mr3703119plb.79.1631647922974;
        Tue, 14 Sep 2021 12:32:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p5sm11377017pfp.218.2021.09.14.12.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:32:02 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:32:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 08/16] lkdtm: Use an opaque type for
 lkdtm_rodata_do_nothing
Message-ID: <202109141231.CD2DE05@keescook>
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-9-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191045.2234020-9-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10:37PM -0700, Sami Tolvanen wrote:
> Use an opaque type for lkdtm_rodata_do_nothing to stop the compiler
> from generating a CFI jump table entry that jumps to .rodata.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
