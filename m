Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1642C94E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbhJMTGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhJMTGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:06:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226E2C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:04:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id g5so2495037plg.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aGF0syKET/14pAZ283IwwssrcdQD4oceHIsj+/z6tks=;
        b=LnqQnYl3SGc8N9da5oJ7HSa9JQluc0g0UMXaBb59l0VvGm3rZTsDEJ3cWkzZmxjid/
         YJNnC+reIBHb27GLFgvmXO/GujmCskpdflq1rRdb/vMqb8PA26FHlXzR+mnQSz8fnRGI
         UrA48mlhSXLYQxTJEcuJCIvV3bQ4XLqFKLR54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aGF0syKET/14pAZ283IwwssrcdQD4oceHIsj+/z6tks=;
        b=B8Oc7yCx0ji3oXJomd9oaQCr1GeUJrcHgLpiuMKuelfdTMJTpTF7QZxwQp5hdP0PMG
         H1HzjE9UopTCkDcQos9ogMIyt15WKopC0ZEdkcIO0xBriiTo+pJzTTs6gIW1LrB9N2i8
         MAKhG4AIh41/1hYClRCHUKf+RHgmyuuj+6GgLdPE6uzTCEh2SBqTxf/pgP+0GMSjaEOh
         5UnoVIm+RSWS+iVaorGA5dPDegQofD2KYloZ0FEoZ9lBxJNYmrVuLDleL/hckSBDZ7Gi
         GS6ebQt7v/JeoLMk5WQsc6yknHO33AOpRDoujsBa6vhNnMVcmI2oU/hPsprk85VoE9v8
         xUgw==
X-Gm-Message-State: AOAM531NuwN2/Ywty9Og0EquswX8yBan/90e5uU2vb8ZWzLV+aDGRUoz
        /+Mb8/d2RRkDWHJXYKpnX4r0OQ==
X-Google-Smtp-Source: ABdhPJx5pfyX8v7LhaYjRI5CoTPdMyHqAmlRIlZV4O0fS14bFrkrUzbhDoAM/N5JvBN2YmHRPA8MzQ==
X-Received: by 2002:a17:90b:4d0b:: with SMTP id mw11mr1137541pjb.135.1634151848679;
        Wed, 13 Oct 2021 12:04:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l4sm248494pga.71.2021.10.13.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:04:08 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:04:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 06/15] ftrace: Use an opaque type for functions not
 callable from C
Message-ID: <202110131203.2BA230B8@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-7-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:49AM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler changes function references to
> point to the CFI jump table. As ftrace_call, ftrace_regs_call, and
> mcount_call are not called by C code, but are trampolines injected
> as calls replacing the nops at the start of functions added by the
> compiler, use DECLARE_NOT_CALLED_FROM_C to declare them.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Looks right to me...

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
