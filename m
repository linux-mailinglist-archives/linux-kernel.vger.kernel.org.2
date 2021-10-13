Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6644742C93A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhJMTCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbhJMTCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:02:04 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AC3C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:00:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e65so835953pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F9f/KoKd1hYZKxslXq7WYINWiftBc0Y2sa1qu99T4yo=;
        b=mznZm6aoTrn+9fmofOmEJxUdlsC0Ctd7RPfZuHr+oV2pinF1avA3HeOGLaH6A6b4xf
         ytNOOHFFymuO6pfIhcnhuDEO+nLtOaVw3INU1sOGj/wAk3S6+DF5YTPn3x2QUDrwmS1W
         PE8YGtuj0YjAyg+6srty0MCMuldh1p8C/EXOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F9f/KoKd1hYZKxslXq7WYINWiftBc0Y2sa1qu99T4yo=;
        b=YtRpNcUzvBU4tS9OmPjZBD0He+bO2UeiCsqaLOZT0btX5Wm22UI8D6YXsPTGKLIxqv
         H0z2WFHY1XJyP6dmjib+9aKxaOfGki+jjczNqr1Su3DO99ZumDtohaVeFX+7DMAU/U5I
         pOptGAHrlYSj/10DXgJmyl5ikDXkxQM/xP18m64xSPoxNs3PlfmXxRREZQVyAYKe1KyX
         I3AC46U8lUbrl5dwk4Nes6cDSu+XQF3KafkOrWD0HOq9wU0ZXE6nrh2jaj9SmfdN29kR
         E+ugpsYXucwQ3rfwAKECop7uJjYWuXtGfTIg8VsuXXOAtmr0nXd6IYOgzPmU2YNuWZii
         iMEw==
X-Gm-Message-State: AOAM533bF+Cdt7Yx2lydKzfDvC4cHX8ajm+TLulbul25mtO/PbLwz1KB
        MTEuPG6q7N/YHGu5v/biT1LAbHrj5I+IEg==
X-Google-Smtp-Source: ABdhPJzUxjWaPArdV/xc7rIFZrQW7VAbqqTyu8rROiGa4ohhyF6E9ngm+I7Cpkn/tSAsBuHJwGbm2w==
X-Received: by 2002:aa7:93d2:0:b0:44d:4a13:5267 with SMTP id y18-20020aa793d2000000b0044d4a135267mr1075576pff.52.1634151600316;
        Wed, 13 Oct 2021 12:00:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4sm239110pfh.147.2021.10.13.11.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:00:00 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:59:59 -0700
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
Subject: Re: [PATCH v5 02/15] objtool: Add ASM_STACK_FRAME_NON_STANDARD
Message-ID: <202110131159.1A0BB2876@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-3-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:45AM -0700, Sami Tolvanen wrote:
> To use the STACK_FRAME_NON_STANDARD macro for a static symbol
> defined in inline assembly, we need a C declaration that implies
> global visibility. This type mismatch confuses the compiler with
> CONFIG_CFI_CLANG. This change adds an inline assembly version of
> the macro to avoid the issue.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
