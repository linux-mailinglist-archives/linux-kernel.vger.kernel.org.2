Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2603325742
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhBYUFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhBYUEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:04:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6F2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:03:50 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t25so4542016pga.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6RPrBVjVcwXNTAfTo4qsgsTEVWd5UOOmYaIsIS+INyA=;
        b=KHFmrqKyyAn/C+4Esw6fFW8E7n1/tbMANIPjWmeVvCK47Yng3sg1nsQwx6jtzV/KwG
         zyOLf3BriP6qL273XcfogmFHtxlu9chPRLPbBtnMitXveKZVhmfQQ536lBp2nM9FyF5v
         CrFJJxikyWs1e6dpf++pd1XNq+sW+4xt/iKqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6RPrBVjVcwXNTAfTo4qsgsTEVWd5UOOmYaIsIS+INyA=;
        b=qzV1MrrvrldlL1o1A+lGvsmVcWVJBu68QTZxw2DMk5oiIIz8ZCazCsfMdwYIQhaFei
         Ko7pSDIJIamustwgs4EmcKlvGc1q2tr2xtFPiTiEdq5Isz2SzrMBhasZfiIF2KSi1U3q
         rBDmpT+QOnD712w8S579vkSxdGCeuwU9FCi84CflpXvGsSIo1QQN0oz4vO1G9u7+26Mj
         Kgp31crI4m66kOjUBj5aruXxnomna16YxzZTxwNdBzQNj8pQLVRD8DXvQTAOQtqIO2tk
         DxDMA1c2y+9maSsIGMsm9pa6abn624lDxOCcjHN8bVIMcykVg8PiPXiO0QQUpHz/eIo6
         K8cg==
X-Gm-Message-State: AOAM533umat/+uzwzf4Ukq2fmVrKc/FuNpHM7wwZlGuf5qry9RmNFoCy
        rQMuN2DTxt4UTv46wFbfhTRHsg==
X-Google-Smtp-Source: ABdhPJxVUdSgw9MSjZT1GK2JXDCuRAztiZcQPY8m4Y6MIVxQu5+77OfWxUwUZQyAImCwXxJ8CbSvew==
X-Received: by 2002:a63:2f86:: with SMTP id v128mr4382566pgv.241.1614283430319;
        Thu, 25 Feb 2021 12:03:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x9sm6546989pjp.29.2021.02.25.12.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 12:03:49 -0800 (PST)
Date:   Thu, 25 Feb 2021 12:03:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
Message-ID: <202102251203.03762F77@keescook>
References: <20210225164513.3667778-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225164513.3667778-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 05:45:09PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Separating compiler-clang.h from compiler-gcc.h inadventently dropped the
> definitions of the three HAVE_BUILTIN_BSWAP macros, which requires falling
> back to the open-coded version and hoping that the compiler detects it.
> 
> Since all versions of clang support the __builtin_bswap interfaces,
> add back the flags and have the headers pick these up automatically.
> 
> This results in a 4% improvement of compilation speed for arm defconfig.
> 
> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Cc: stable@vger.kernel.org
Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
