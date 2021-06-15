Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36323A83D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhFOPYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhFOPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:24:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F99DC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 08:22:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso2063753pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VTuRFnseZqrIBSgnNwdAjUEfKZHGGRHTNL/Ans6om4w=;
        b=UTkvxrNSv/CMKOiYz9XnnCHcnUCXiK4j6undSLaeoi6+XP19q4KGg5V+4ymEaYAkbZ
         wOT8WxEswqHkW9HvhNTviAIlH52pYqUJMMhYOzJNQ55O59x8IH8BjouEAgh1m4qkedWW
         l9six7EIxi+7Xehc7LWtSdAJC67Fmv5GQD7D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VTuRFnseZqrIBSgnNwdAjUEfKZHGGRHTNL/Ans6om4w=;
        b=tQ/IQFyut4VtHea9CHYsNrxNW4EsAWSb8QLYORTsL1tp1Q7mycBaMM5Xom21LNFPrX
         y2SoYPmv1r2edu8GTdHgP4IsXoWPhkzvKSIetKPjlSdukasetVG/JDTb84SpmsgmuuP/
         B/qdxRe4pv3kfy37jtHq6doWEUVb21GPBaEAOFyji3L66jG+EY/cOSQVWxNzeaYNJnZi
         xoMGdxfUME6FSE/xYyG4d2SUYw6z3CQO90ZgTZ94ZLF504ifd8wVm28kRuSARxNJ8zuH
         O/FBzlWm1cSyrKFKd68w9FkETVvElfniyuYONT6a31TUj4Ud8yhUGGOE6A+ZDnXxb+EE
         N4iA==
X-Gm-Message-State: AOAM530eLbzhAfJgbA6x7y4luvJmlxFbQp919Hf2p94Jc6pGVSSH5IVM
        JvElhrY0BRWpQgbgbeqU9llUhg==
X-Google-Smtp-Source: ABdhPJyBnEuE+6p2qLx/BvvdJemzjWP0cmTtY9Lfydj0m42gXMzyzn71v5GR6M5UJcdO7fEUNhHOUw==
X-Received: by 2002:a17:90a:9f8f:: with SMTP id o15mr4567883pjp.55.1623770544902;
        Tue, 15 Jun 2021 08:22:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d13sm15373293pfn.136.2021.06.15.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:22:24 -0700 (PDT)
Date:   Tue, 15 Jun 2021 08:22:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, nathan@kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        yj.chiang@mediatek.com
Subject: Re: [PATCH] kbuild: lto: fix module versionings mismatch in
 incremental build
Message-ID: <202106150821.B4D3E02@keescook>
References: <202106141554.A2D26986A@keescook>
 <20210615062658.21633-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615062658.21633-1-lecopzer.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 02:26:58PM +0800, Lecopzer Chen wrote:
> > On Mon, Jun 14, 2021 at 01:51:09PM +0800, Lecopzer Chen wrote:
> > > When building modules(CONFIG_...=m), I found some of module versions
> > > are incorrect and set to 0.
> > > This can be found in build log for first clean build which shows
> > > 
> > > WARNING: EXPORT symbol "XXXX" [drivers/XXX/XXX.ko] version generation failed, symbol will not be versioned.
> > 
> > I'm doing this, and I don't see the problem:
> > 
> > $ make LLVM=1 LLVM_IAS=1 distclean
> > $ make LLVM=1 LLVM_IAS=1 menuconfig
> > 	*enable LTO*
> > 	*enable a module*
> > $ make LLVM=1 LLVM_IAS=1 -j...
> > 
> > What series of commands (and .config) shows this for you?
> 
> Hi Kees,
> 
> Thanks for you checking.
> 
> After double checking in clean android kernel build, this causes by
> make version.
> (I have build failed in Linux LTO,
> seems it's not well support in contract to android?)
> 
> I knew Google has LTO first in Android and upstream later, and most code
> are same as upstream, so the env here I use Android common kernel for
> easily testing.
> 
> 
> Test env is android common kernel: android12-5.4 [1] with its latest code
> and it builds from build.sh[2]
> 
> $ BUILD_CONFIG=common/build.config.gki.aarch64 build/build.sh
> + make O=.... LLVM=1 LLVM_IAS=1 DEPMOD=depmod -j12 Image modules Image.lz4
> 
> With make set to v3.81, this can be reproduced with CONFIG_TEE=m.
> With version >= 4.2 this is not reproducible.

Ah, very interesting. While there are tests in Makefile for
MAKE_VERSION, if we want to do this, it should likely be extended to
Kconfig, as that's where the initial version tests for things happen. We
could require MAKE_VERSION >= 4.2 for LTO?

-Kees

> 
> 
> Our build env default set make to v3.81, although Android uses hermetic build
> and v4.3 now, but Linux doesn't have such things.
> 
> Maybe we can add build time checking or comment before CFI module versioning
> build rules to avoid anyone struggling with this again:).
> 
> [1] https://android.googlesource.com/kernel/common/+/refs/heads/android12-5.4
> [2] https://android.googlesource.com/kernel/build/+/refs/heads/master
> 
> thanks,
> Lecopzer
> 
> 

-- 
Kees Cook
