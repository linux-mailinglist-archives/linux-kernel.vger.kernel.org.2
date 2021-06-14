Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25003A6B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhFNQZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhFNQZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:25:17 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8274DC061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:23:00 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id w31so6550692pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/tqMNBdE4qHdzJKBoF81z2rnqzQbtDIbs5Mv0crRZTA=;
        b=kc8k59SHuwOaSDz4EZLDy/tjNmjX3sHx+Azxk4Uprh6yYNI/O7BgElJNrrJZE2jRji
         mCGEDJsuMfh8V5FyznUU3aTug4Pj9NzHk3Myu4dUt1RdlHv3GNfc/4Sx4Uef5FqXhZL3
         uXeLN7/9BOdNG4fXsEcvyEwivlOob8kn+9hZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/tqMNBdE4qHdzJKBoF81z2rnqzQbtDIbs5Mv0crRZTA=;
        b=Xb/bmOg6gbYCiAyCZmRGxWxAfj8NRkCm5B8Fm/Xs/caq2Jk5I1yXxDt7L+l68v5b7j
         9yzfC6eLCpNR6pMnEBtsC47RViU9QQSh4llAWa7XrKcEpXvksszkEDd4EKEhle6o625H
         5DV8YDocrAOTMlHUhPE60rq66PxMGOhgJZtwme1BNWQn5LX2AAfALlUNGEX1yGg+Z1cQ
         Wb1/Kt6SPnH0VtSuOo9/Cj8hs4cKW6Z5E03a476gP44sLgiUBSOfqX/invRCu+QCEirX
         Eu4FXTXJou1jucKKZjpLTTVkFieNcUFm3RFyOrGMhRBwtstOuO2iIEY3Vr4rLuHg4bJp
         1cGA==
X-Gm-Message-State: AOAM533SmB9gbihVRr7+IIk7dt3wEWRMgy5I9DXi3GNIcs9K1Umzjdpp
        cWYVYB4xOM97Y0qlFuk0ZiDUdQ==
X-Google-Smtp-Source: ABdhPJwixa3iu8aLgRgs1bvYerT2BJB3n8QFCj4rML9cDEQz4n41UsDtRE9d9b981B4LBVyujggAVQ==
X-Received: by 2002:a63:d347:: with SMTP id u7mr18165235pgi.434.1623687780120;
        Mon, 14 Jun 2021 09:23:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mi10sm17066933pjb.10.2021.06.14.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 09:22:59 -0700 (PDT)
Date:   Mon, 14 Jun 2021 09:22:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, Bill Wendling <morbo@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, johannes.berg@intel.com,
        oberpar@linux.vnet.ibm.com, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v9] pgo: add clang's Profile Guided Optimization
 infrastructure
Message-ID: <202106140921.5E591BD@keescook>
References: <YMT5xZsZMX0PpDKQ@hirez.programming.kicks-ass.net>
 <CAGG=3QVHkkJ236mCJ8Jt_6JtgYtWHV9b4aVXnoj6ypc7GOnc0A@mail.gmail.com>
 <20210612202505.GG68208@worktop.programming.kicks-ass.net>
 <CAGG=3QUZ9tXGNLhbOr+AFDTJABDujZuaG1mYaLKdTcJZguEDWw@mail.gmail.com>
 <YMca2aa+t+3VrpN9@hirez.programming.kicks-ass.net>
 <CAGG=3QVPCuAx9UMTOzQp+8MJk8KVyOfaYeV0yehpVwbCaYMVpg@mail.gmail.com>
 <YMczJGPsxSWNgJMG@hirez.programming.kicks-ass.net>
 <CANpmjNNnZv7DHYaJBL7knn9P+50F+SOCvis==Utaf-avENnVsw@mail.gmail.com>
 <202106140817.F584D2F@keescook>
 <20210614153545.GA68749@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614153545.GA68749@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:35:45PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 14, 2021 at 08:26:01AM -0700, Kees Cook wrote:
> > So, AFAICT, the original blocking issue ("PGO does not respect noinstr")
> > is not actually an issue (noinstr contains notrace, which IS respected
> > by PGO[2]), I think this is fine to move forward.
> 
> It is *NOT*: https://godbolt.org/z/9c7xdvGd9
> 
> Look at how both compilers generate instrumentation in the no_instr()
> function.

Well that's disappointing. I'll put this on hold until Clang can grow an
appropriate attribute (or similar work-around). Thanks for catching
that.

-- 
Kees Cook
