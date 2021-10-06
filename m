Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A213B423656
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 05:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbhJFDjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 23:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhJFDjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 23:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633491464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hQgwvO1joc+8xZdxI7msExSbMFXW62NaKXjYt60o60Y=;
        b=FTYnuXKJCSD0NQcQApjO4E+y0vIqVU1AnLS1vassOR1nLDhwJJSQxy2gau0eAg1GOi1x1I
        ZNoyg01nctCyPxgTlEnKFq6J+54ny8FTCW9uuQtSRurFzF4ZufNBI5RvR4nUR0LEr4f3Xf
        +i4xLgcWxrhg4agSHxs0JwyUSwV9a4U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-NbYIwMAaNouqp3aGAcFCOw-1; Tue, 05 Oct 2021 23:37:41 -0400
X-MC-Unique: NbYIwMAaNouqp3aGAcFCOw-1
Received: by mail-qv1-f72.google.com with SMTP id gg11-20020a056214252b00b00382e4692e72so1607632qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 20:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQgwvO1joc+8xZdxI7msExSbMFXW62NaKXjYt60o60Y=;
        b=5J6cUVG5T14CJ+8s8cgf81iFJRjM6HR9LTMdD0NT/RcLocGb4OAxHZ7DfhgLLVC0jx
         l5NsqNsSBzvl876ANLndW99oyOhRagqy2F84mugvNQnbt1Iyzf4jGDuzzS+6tZEmp+3Y
         bB1+zCEmIwSNmroocWkt3zLn4Si2kLi3dvfK+FzDDJXOGX3Ca2MHDvAAQH/PpgWHdgEe
         hTWyZ77W2sjTLMSWT55gzowQQ/lat+i00mgxmh7DaKHdS3BRdTjK4mV8rc89hOXeTqFJ
         XcgBjjBhEFkujsdHYHQRmS0Ds3bzvm2QANBT+jeoJ21AYiv79x5X3s3eoemv2WzcNFSD
         zc5w==
X-Gm-Message-State: AOAM5316TCip1/RWcR6A/RPkD+Tq1YXWvbgqPamZStew6z02J8l1jyS9
        VnAqm6uTh6Eq/q/MlXQ0L8DnHuTCVE8yqZu711iR1sd1ppT+dhzJjfpZJmLMsPid3YkFgSOtbi5
        Oo4Q9tyEqIX2MLRgMhVFaXmqL
X-Received: by 2002:a05:622a:1cd:: with SMTP id t13mr24476055qtw.283.1633491461277;
        Tue, 05 Oct 2021 20:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1rqsQDW73oW5IpwjjqQp7qLI0RWKug5ueJvzxcJCbW+Uc/eOz0fUprINDj9JdXsUQ3ob9QQ==
X-Received: by 2002:a05:622a:1cd:: with SMTP id t13mr24476045qtw.283.1633491461113;
        Tue, 05 Oct 2021 20:37:41 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id d18sm1733576qkk.3.2021.10.05.20.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:37:40 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:37:37 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 02/15] objtool: Add ASM_STACK_FRAME_NON_STANDARD
Message-ID: <20211006033737.7duncwbqmporicer@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930180531.1190642-3-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05:18AM -0700, Sami Tolvanen wrote:
> To use the STACK_FRAME_NON_STANDARD macro for a static symbol
> defined in inline assembly, we need a C declaration that implies
> global visibility. This type mismatch confuses the compiler with
> CONFIG_CFI_CLANG. This change adds an inline assembly version of
> the macro to avoid the issue.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

