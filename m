Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D6A42C921
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbhJMS6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhJMS6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:58:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34966C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:56:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f21so2473870plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ye13OmZ3/WQ5cIUtbfVVB0LIxdrNFZJ8JAtfJOn6tSs=;
        b=ggwVdU/nM2n1VDwOUSzbDNh0n6tH68W7Y1MlizZeUdw5vOgv1Knlj+CukpD4B6DXrz
         xHxkyiCsubqCfhQNj5+NbdGOgs2hbfjZCsixQAm4QagFigeRHP/QXKqjs/A+dzDsd+Vl
         EmuIIytJ1MWGb89CZf8jCdbYbefJNpP5QVB4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ye13OmZ3/WQ5cIUtbfVVB0LIxdrNFZJ8JAtfJOn6tSs=;
        b=Uq77Cdg9i+BPxEQy8efHpXJYf/+/d5rRRZ7kv0wIOVVWXaJ3HgSB333eldLMGs1oEU
         93aZ27zRM5nuYv4hyHYDE31hX6qHIZvBE8bc09rCVoBFcOp0X73hl1n0dUK6XCEd84Wa
         Xh72rIKz1BQgbh954gDjkGpDK6/3tvX6QeHOvMbzhECV93baYCCQNA4CfAHVkeL7op+6
         NbQPuKhhAWN/kn1vyDKoXpVw8u+fLsjwWpbHBO6uaynE3ALyRzLAvC/QV9RZ267VImeY
         553VCmJS6cULH7CjdRzJ2JfV7rYMqws/HJ6jtSz907At3ziRxNKWdRSKL++f6u+4MwgC
         65WQ==
X-Gm-Message-State: AOAM532enwE4ig2F0pxOEGlM2Icid6HXtbHAsT1zw58Dh8q7ZVS8uG7H
        +GC7NBmrs6gOIHDTwJvnUmw7puSCFigBpQ==
X-Google-Smtp-Source: ABdhPJyk4f8iBw/TbgCPI4nSRB9gGx/BtKbfKsMhla90ncq/wBhlkZHwwD0ojZQFgmLLAHQl988/gQ==
X-Received: by 2002:a17:902:6544:b0:13e:dd16:bd5b with SMTP id d4-20020a170902654400b0013edd16bd5bmr856440pln.61.1634151394760;
        Wed, 13 Oct 2021 11:56:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w19sm6949936pjy.9.2021.10.13.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 11:56:34 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:56:33 -0700
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
Subject: Re: [PATCH v5 15/15] x86, build: Allow CONFIG_CFI_CLANG to be
 selected
Message-ID: <202110131156.C52C7F7CC@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-16-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-16-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:58AM -0700, Sami Tolvanen wrote:
> Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled with
> Clang >= 13.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=51588
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
