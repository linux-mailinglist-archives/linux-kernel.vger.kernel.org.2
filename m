Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441C74098EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhIMQZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhIMQZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:25:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB274C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:23:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so422615pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2/RkgLMSeLMdfX+PInPfTpRLPSRgorj3I7Mh0Kf9swA=;
        b=JmPq/ZgLDL/FyAXQlzN3Pxt/6RHQBe1O37S+nQ61rkmBypwaNCBZrelrqFzD38G68y
         ayLL6KmmBeXGuHjWhRWlBTWLjOa1UNjPI0bNb+dmgGb0u2BkXyd5S68cDztZayVOnRQr
         NZSmhj83kn4QL3EQNMIVRoRdS0yiL5duqY1Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/RkgLMSeLMdfX+PInPfTpRLPSRgorj3I7Mh0Kf9swA=;
        b=L0CJMat8LIoTxMjwuUIHMmZbK5ct99Nj6k/4ZgHeONZJPuuQ/W1GK8TyR00paLNj5m
         kH59G3g5SXmlZO0QzgsrZ0tFOJyLt0hx1pHj93dTIqvOCx7+Gd+8gzv0CI99+R113osG
         c8YwYxdbRhfj/mMUpNgF1JQuvPbfr+I2Tpklt7kMZhgLQn7FPMB+RxifzGx8lVbC3sbt
         wBtPDj++MKntDUZgCT9SyO1az2mN0c86/t7J7MpJPAO6J9eVxjJ98qqEmBkSqX36MZ8N
         uY1diGiPBFENXv2KfeH4qgGluRTfPaStUj1XVMpHVaEojC1hBdtqH0MEYe2fM2Axpga2
         QPHw==
X-Gm-Message-State: AOAM5305FWAVr2s7sUjyZGfWlIoLQRm1VI4W/R7qsC1LFWpGF9LrHj5u
        OCbq7gsZUQUF8HKE1rsT1LavsA==
X-Google-Smtp-Source: ABdhPJw2iVAwBpkklvDVrdBl1O3eT09j5TQwikncidkQDt4RPNA+MefgACjymKzY8c/7zuWh9A9MQA==
X-Received: by 2002:a17:90b:f08:: with SMTP id br8mr301973pjb.119.1631550227353;
        Mon, 13 Sep 2021 09:23:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d3sm7597340pjc.49.2021.09.13.09.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:23:46 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:23:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 05/10] riscv: remove Kconfig check for GCC version for
 ARCH_RV64I
Message-ID: <202109130923.E294BFD5C@keescook>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-6-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-6-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:42PM -0700, Nick Desaulniers wrote:
> The minimum supported version of GCC is now 5.1. The check wasn't
> correct as written anyways since GCC_VERSION is 0 when CC=clang.
> 
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Yeah, good catch for Clang too.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
