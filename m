Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650843A7260
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 01:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFNXNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 19:13:09 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:47095 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhFNXNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 19:13:07 -0400
Received: by mail-pg1-f180.google.com with SMTP id n12so9880604pgs.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xjx68w65fQQOZjwsL4rBc5IndNejAizyHVHEks/ULIk=;
        b=ZbzriAM5GRBcaZCLWRylOqMA4kOgmnflpB61TfCq//LMxzYKJ5sYbUwSxFbozU47K8
         IT9h+H9O/zqcuZHRyMQhGlcasyiN+KQxvi+kbCRWDyn41F/SGXiBhVYSKMU2Ksa01TXa
         NA8sf5OTKxC4fg7QrnGUTXYeub+oQBx8WD1dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xjx68w65fQQOZjwsL4rBc5IndNejAizyHVHEks/ULIk=;
        b=QXpjCv4i1hbtLLkfQbHYaGzCjVwr4UA9JzLgoQ+Q1IiNf3oaN48WwpZQq90Tb2WciS
         SHmGqmo/SlD7XDeN481AgykZ7Wwz0PrSXAI5uoiSEuh4i8zNG8u8ct39kdrTFeyxZz6l
         kKRDrNzi50XIihh0TnZQ+IJ2Vfdg5yCNCjh7q3UOclODnUi8qaoga4icAs4KPC1B6hm4
         3qvcYP/TI5VIkRKrGWz4BASDglkyz7ECpVbJqDgUmHH7XpjzQVJXPIU4CQ6zgvaQF7FT
         ODP3Uqrk9uITRp7PIu2Io8V5BtR3OPXp9U+kgZxfCvbsXg08g8ac6fWVNWLUiMDEnbMp
         UZ8g==
X-Gm-Message-State: AOAM531OkZvVCG44dnZmyfWeigY/46S7xSIqIb0KQj4IxnNHzH9WAPqu
        DocgryinpyxPey+mAuaRkeoOOA==
X-Google-Smtp-Source: ABdhPJwP/LUViaDtZ9HJNdb0UB4GShVFMWDa7L9q+z3JSG7Mw9KnsuMRLFmRCbI6fAFYr22ue64Dvw==
X-Received: by 2002:a62:53c1:0:b029:2ef:25e8:d9e5 with SMTP id h184-20020a6253c10000b02902ef25e8d9e5mr1526062pfb.74.1623712187446;
        Mon, 14 Jun 2021 16:09:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z205sm13535380pfc.165.2021.06.14.16.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 16:09:46 -0700 (PDT)
Date:   Mon, 14 Jun 2021 16:09:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net, nathan@kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH] kbuild: lto: fix module versionings mismatch in
 incremental build
Message-ID: <202106141554.A2D26986A@keescook>
References: <20210614055109.28774-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614055109.28774-1-lecopzer.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 01:51:09PM +0800, Lecopzer Chen wrote:
> When building modules(CONFIG_...=m), I found some of module versions
> are incorrect and set to 0.
> This can be found in build log for first clean build which shows
> 
> WARNING: EXPORT symbol "XXXX" [drivers/XXX/XXX.ko] version generation failed, symbol will not be versioned.

I'm doing this, and I don't see the problem:

$ make LLVM=1 LLVM_IAS=1 distclean
$ make LLVM=1 LLVM_IAS=1 menuconfig
	*enable LTO*
	*enable a module*
$ make LLVM=1 LLVM_IAS=1 -j...

What series of commands (and .config) shows this for you?

-- 
Kees Cook
