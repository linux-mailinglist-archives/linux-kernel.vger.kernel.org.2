Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC7339BF51
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFDSJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:09:26 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:38705 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFDSJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:09:25 -0400
Received: by mail-pg1-f182.google.com with SMTP id 6so8497144pgk.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HDFTGAj6Z0eA9X6bD/2la5+ICNWOiTOk2dOvd/PVU+M=;
        b=INCtCIhYWzQVjUtOSVBFc1ZYYuxX7pB95wGe97bAqKE/NecXskXoDiZtORo0jJW/GZ
         qtRtCbBAmsP9B4+u2o7iH9akoLvWdYVXEMvPtLlyYevt9KCyO6ya4Hod/0yYkoF2+c3P
         fuQm3xbIMyQJoYFhqnLaWKYhcak863Aw1vgfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HDFTGAj6Z0eA9X6bD/2la5+ICNWOiTOk2dOvd/PVU+M=;
        b=VHpTeKCrcl1WsdeaYNU7HPYS2jvgGRKDAEVig4bEypAPXh30UeKZZrPVCiERA6GDpY
         e1upnxPrKPGbb0jl/1SEVauRGFbI2qmcL08ryFPvPXV3hWYjNkDr5I1oqCgjzXP3oLcu
         /fwxoPf7FsQMb31sk5EC6zoxkX6NsInIJsxyw0Z9DLRQjrkBhx1Py4XAIgzO3czE4hxN
         RzSY3alXcl4AuLZDsxg3gdhi5RzpiCmiaWfFwYHpvgakwcN78h/K1EMqXb1xFdKXeM0/
         h3juhTFFit7Sxc5kU9Us6FD1NX9KEgm5/Yu8WrUURUjLypJkaehyDcZ3q+u2TtzkZN8U
         rN6A==
X-Gm-Message-State: AOAM532cGtsRP9g5oVZ0jkWdlL1DyFnJ3N8mA/e4Ojmx3MUrt1QBYXPj
        GDS5p44QB/HOXBHshsIJGciA2w==
X-Google-Smtp-Source: ABdhPJyUchR+RCOM8PLNqPURyeGAPGQfkpKX3JHL9yU67QDWyfI06Xro/dmMalTlrhVu1WMEbmhAOg==
X-Received: by 2002:a62:6107:0:b029:2ea:3f3:a52a with SMTP id v7-20020a6261070000b02902ea03f3a52amr5728229pfb.37.1622829999408;
        Fri, 04 Jun 2021 11:06:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gq5sm5249999pjb.17.2021.06.04.11.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 11:06:38 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:06:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [PATCH v3 1/1] pgo: Fix allocate_node() v2
Message-ID: <202106041104.929FFB3@keescook>
References: <20210604165819.7947-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604165819.7947-1-jarmo.tiitto@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 07:58:20PM +0300, Jarmo Tiitto wrote:
> When clang instrumentation eventually calls allocate_node()
> the struct llvm_prf_data *p argument tells us from what section
> we should reserve the vnode: It either points into vmlinux's
> core __llvm_prf_data section or some loaded module's
> __llvm_prf_data section.
> 
> But since we don't have access to corresponding
> __llvm_prf_vnds section(s) for any module, the function
> should return just NULL and ignore any profiling attempts
> from modules for now.
> 
> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> ---
> Based on Kees and others feedback here is v3 patch
> that clarifies why the current checks in allocate_node()
> are flawed. I did fair amount of KGDB time on it.
> 
> The commit is based on kees/for-next/clang/features tree,
> hopefully this is ok. Should I have based it on linux-next
> instead?
> 
> I grep -R'd where the memory_contains() can be found and it is only
> found in #include <asm-generic/sections.h>

That's true, but the way to use "asm-generic" is to include the
top-level "asm" file, so that architectures can override things as
needed.

> I cross my fingers and await if this is my first accepted patch. :-)

I tweaked it a bit and applied it (see the separate email).

Thank you!

-Kees

-- 
Kees Cook
