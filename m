Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE35B42C93D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbhJMTCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbhJMTCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:02:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3FBC061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:00:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23-20020a17090a591700b001976d2db364so3010649pji.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vSdCvbsYkIt0Z0Dq92fR0cKB12M68Rwm2Rm4i81p0qg=;
        b=S83D+KnjIrnVXCEAw6xUqC54LMfAZq7UxSajP3TNsE7IodzP4qkKJODPxsupKv1JV7
         RBHwwjdxYBt1aj+Mkj3eJPnrmP1k1AKIcAcGx330nxxQuYr/bf9o91eAAqWtvyWUx/PU
         zrQk7dFVKsoXP9j7/aU62ewAhhYuReCo8f4j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vSdCvbsYkIt0Z0Dq92fR0cKB12M68Rwm2Rm4i81p0qg=;
        b=tSwC4eVGdqv7XsYDKrZ0gMcilqLOBfLc2Os4wEBQ9vrwdzrr2AkQkxSMwNwEcmHIPz
         ltJhqcLTEXgdlS9xwHFu+1jk1VNZAPFxwFzL6M3TL/81rUhDLHIgL2WUI7Ovwil3nXOY
         P1nCc+a5vkJ37qW9a1Tcvk24zkpT3+gGCyhOXDS/3fVmTKxHLTbhqjkNesK6sznXAwYZ
         z6nlyMEAJTZjQFrFvfICtmF8507f6wyqXfeBQZBHQfnf0nX6OOSC+9jr609R/Li+qgMM
         7QEWAOGxfEmUcukbH6JcLBQCs8+Gl9OCb31NBCj9xd4A4lZSZrBNodUDDeXj796xXJ6U
         6a6Q==
X-Gm-Message-State: AOAM532NF/vIdbn33xUR6LTz+b4dtTFxZN5VHL/mqDoXUVjtvCrmDVXI
        E9gUCeOJCvJaxajFtZFDHkkdVw==
X-Google-Smtp-Source: ABdhPJy7uZ/FwGtvkefI9YhZchrZQeeAa710u9Jhh7h46fIGalxym08H/KMiNgWsnZRij3s2r/9+RQ==
X-Received: by 2002:a17:90b:4d8e:: with SMTP id oj14mr6818560pjb.237.1634151639646;
        Wed, 13 Oct 2021 12:00:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f15sm224820pfq.193.2021.10.13.12.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:00:39 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:00:38 -0700
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
Subject: Re: [PATCH v5 03/15] linkage: Add DECLARE_NOT_CALLED_FROM_C
Message-ID: <202110131200.1CAF319F@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-4-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:46AM -0700, Sami Tolvanen wrote:
> The kernel has several assembly functions, which are not directly
> callable from C but need to be referred to from C code. This change adds
> the DECLARE_NOT_CALLED_FROM_C macro, which allows us to declare these
> symbols using an opaque type, which makes misuse harder, and avoids the
> need to annotate references to the functions for Clang's Control-Flow
> Integrity (CFI).
> 
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I like this; I have a sense CFI won't stay the only user of this
annotation.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
