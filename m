Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13213DE6CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 08:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhHCGmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 02:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhHCGmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 02:42:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC413C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 23:42:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nh14so16689700pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 23:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AOXfrDIBSrb8A0VQUvY+TBcWqM660sA1rmEZT8mFt0s=;
        b=JMZ1FFInEUptalCSIejCN3MZUGHjikyvbOOtgsgW6ZRQpBohkY6r7m/nMwZZT35YEX
         orzqYiY7JOSJLCnZiUVzjoUVxOxYaEwgWVErNrB/rDzmDWJ1aU3i+k2GwHbYUm8vgOcB
         8yMhHxI7J/TVOeuMWbBMjY+gvnzNrN0e02Kqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOXfrDIBSrb8A0VQUvY+TBcWqM660sA1rmEZT8mFt0s=;
        b=CRWJOUvMwclDZaaqkYuCCVIPirrVZFLqD5wFQjcz5ZvC7kU3Yvv/o4F2wShmZqMO0E
         rpqg1qFl3M8n153D0YkMl+iPkRWtbhuq9t0wjCQ7kwQ1j7zGTFk5BDFBhuqQZ9RfmGkD
         Hyfr2iY6772fR2iadXRVLbwtsvgVJkjBJxBcjzVmm2XdQ165nyJ/NNNz0mPOdn9cPe8x
         e1T3e8JZ2HZ6QT0ZjBZio3Vc9ZqWwgyFfCqlqxyPfk3zs9gWLVVQbrjvHlGWHURosUdp
         bzfzkI2E0tIIzjJaj4nJz8TuaW2FdU/2kG0SkxJ6V8SXS2RQEMlbWTi7krX/3+kmLmxk
         yqMw==
X-Gm-Message-State: AOAM531Vkz+joOfSc8O5zkjLR76tBznp9be808qE3O+8GfUceoG6pXN8
        2kIhuGjlC22+JktrAVnJn7ILug==
X-Google-Smtp-Source: ABdhPJxDyJZssN32O26UbKqbNpr/MFPRDr/n3PMj9gYQuMHK587WiWxMOfYcHrsJMKNC2MUrpkSX0w==
X-Received: by 2002:a63:f804:: with SMTP id n4mr1526796pgh.341.1627972925206;
        Mon, 02 Aug 2021 23:42:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j25sm13953813pfe.198.2021.08.02.23.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 23:42:04 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:42:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] compiler_attributes.h: move
 __compiletime_{error|warning}
Message-ID: <202108022341.BB8EEA7@keescook>
References: <20210802202326.1817503-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802202326.1817503-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 01:23:20PM -0700, Nick Desaulniers wrote:
> I'm working on adding support for __attribute__((__error__(""))) and
> __attribute__((__warning__(""))) to Clang. To make use of these in
> __compiletime_error and __compiletime_warning (as used by BUILD_BUG and
> friends) for newer clang and detect/fallback for older versions of
> clang, move these to compiler_attributes.h and guard them with
> __has_attribute preprocessor guards.
> 
> Link: https://reviews.llvm.org/D106030
> Link: https://bugs.llvm.org/show_bug.cgi?id=16428
> Link: https://github.com/ClangBuiltLinux/linux/issues/1173
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I'm looking forward to having this working in Clang! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
