Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7572F42C948
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbhJMTEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhJMTET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:04:19 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D568C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:02:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id g5so2491816plg.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XYUZdSbtY3yILKq30armlw/nLFSTpxD7xzR0LPRYz80=;
        b=gpYKK9FHVxBdFJtwWQViBwA6f8A8yxtHj5zqNEzFZ+S0843PtoWAyD5MADhc+CKcZ4
         5ngK1kdS6dIScpdJWiiYbns6hn+I0/aa3zc8aYsrcaVwjDK/PyNeqgmgGZSw1ruKlLVJ
         KmTGnrOq0PccZ2Svs/+X9fiN4LSaKncO8PW8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XYUZdSbtY3yILKq30armlw/nLFSTpxD7xzR0LPRYz80=;
        b=AyhpZKH7AHM+1U1zgVbiwSuRcNRIWHFmhedSzv8quA1+L/ukW3QV4/AxDi8QNoe2U8
         2Aw3zTmR7EB+C3eBMmtF8Q2uDUsBWdiCv5lkpYvW+wbEgt1t5nPVrmXvuH4EETCPqh1r
         vtrUs+AES4fanEFov/69ynV/GtaO+H0+EAsGw+WF5bxmHqG+u65KAsLjTBnmlrVEIILe
         8PiMGOnbD1MzblVlR09TaJI9SaM4vpgMXMRCWurBJeuGhF96RTXKGer0G4H5WZNJ38cJ
         CDYnvd7qPDm+frqlu6/pbTLZch7l+80MrrA5LVD/065t+YI1ipwYA+b08HVc8d40AGbe
         fxyA==
X-Gm-Message-State: AOAM532S4qG6hDOPI+AHXedArvx9y7G30blspWMxg0fvzAyPQrN3JT2P
        dMHYsq8cToJI5j7sX/Hmkn/bsBuTCCCcLw==
X-Google-Smtp-Source: ABdhPJzr8pB5JKBpq4Ks8L5I/+V7O+fqmjtmqNIRDwvNRhToQtzGptsraxsDs7uoU+If38Zs1gAazQ==
X-Received: by 2002:a17:90a:1548:: with SMTP id y8mr15961214pja.151.1634151735724;
        Wed, 13 Oct 2021 12:02:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d138sm251374pfd.74.2021.10.13.12.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:02:15 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:02:14 -0700
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
Subject: Re: [PATCH v5 04/15] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
Message-ID: <202110131200.5D551C2D@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-5-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:47AM -0700, Sami Tolvanen wrote:
> This change introduces the DEFINE_CFI_IMMEDIATE_RETURN_STUB macro,
> which defines a stub function that immediately returns and when
> defined in the core kernel, always passes indirect call checking
> with CONFIG_CFI_CLANG. Note that this macro should only be used when
> a stub cannot be called using the correct function type.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I remain a bit worried about this exception infrastructure, but it's the
best way forward right now.

One thought: add DEFINE_CFI_IMMEDIATE_RETURN_STUB (and maybe other
things to watch closely) to MAINTAINERS:

diff --git a/MAINTAINERS b/MAINTAINERS
index abdcbcfef73d..2c9a24fd6a3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4553,6 +4553,7 @@ B:	https://github.com/ClangBuiltLinux/linux/issues
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/features
 F:	include/linux/cfi.h
 F:	kernel/cfi.c
+K:	\bDEFINE_CFI_IMMEDIATE_RETURN_STUB\b
 
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
