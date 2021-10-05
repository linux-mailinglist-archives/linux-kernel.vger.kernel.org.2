Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B854C421B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhJEAwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJEAwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:52:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE26C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:50:48 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g14so15968549pfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SEKA9eUvQTNrOEU0fVe9Oqo1M4Yd25Z/pj7b5KUJKIM=;
        b=WWWCnRoDUJPBY3ffxH06sF9uD9/8LAHeZ8/v8jzQmn3oDFDRtqjZjLRsuPlQTzwuXD
         1wH/q28vROmEvvplL7fs98Bp3waAHcYjtqW6AL3lannRpc98Vd0HSVMK6FTYvIGyyezB
         N1TvpFzrCX7j9hw6W9zfVzJLtyXZo9WiPYBvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SEKA9eUvQTNrOEU0fVe9Oqo1M4Yd25Z/pj7b5KUJKIM=;
        b=lyxDo+ihy41CYmpTVNGwhHiYPukkln8Um63SNKkkf9qI/e0IILoeSWD073H3N9uaY0
         6psvEssdsp5r2uxABFGN/iaB2qHV+Z8TkeRkOuPlyagCoW2tXQDsHIyB1YqK3K2nYk1p
         M2UJVXL24dNxy+TVX6mXMT2BBmNp7+kzGT/SsTZHqDgWHQe4T5YuO2M8zp8gMo6Dt/OF
         30hHS/FUA2+3d6IpfGpPqzYaL8XVj1wdo5/iB9uph2JGIBr8Tj3nDgKVCix+BHd+N/cH
         xHG6U3toYTVMgk3JtQRZLK+CEp1QgrraCxkD6RIQYj57rp6/E2dpIr71l01KYJ3bBe7z
         HtYw==
X-Gm-Message-State: AOAM533fP38lPe1ha+lANBpKeaMlMbBS6t2kgiU3m17w4KqFGLG2f8Dc
        v+vESID/h0k0jDASLPvr9r8Aug==
X-Google-Smtp-Source: ABdhPJxtStb/HuVbBznifn02CPo2ct45dVitFgpYgXK80binzVlQ/40jVorsYKbUDcKXdgARfQO4bg==
X-Received: by 2002:a63:b448:: with SMTP id n8mr13690353pgu.31.1633395047522;
        Mon, 04 Oct 2021 17:50:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i128sm5884418pfc.47.2021.10.04.17.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 17:50:47 -0700 (PDT)
Date:   Mon, 4 Oct 2021 17:50:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     ndesaulniers@google.com, akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux@rasmusvillemoes.dk, nathan@kernel.org, masahiroy@kernel.org,
        joe@perches.com, arnd@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 05/10] riscv: remove Kconfig check for GCC version for
 ARCH_RV64I
Message-ID: <202110041750.C90595D1@keescook>
References: <202109130923.E294BFD5C@keescook>
 <mhng-387507df-2708-4ea1-9854-780fcb35eb1d@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-387507df-2708-4ea1-9854-780fcb35eb1d@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 05:40:42PM -0700, Palmer Dabbelt wrote:
> On Mon, 13 Sep 2021 09:23:45 PDT (-0700), keescook@chromium.org wrote:
> > On Fri, Sep 10, 2021 at 04:40:42PM -0700, Nick Desaulniers wrote:
> > > The minimum supported version of GCC is now 5.1. The check wasn't
> > > correct as written anyways since GCC_VERSION is 0 when CC=clang.
> > > 
> > > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > > Cc: linux-riscv@lists.infradead.org
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > 
> > Yeah, good catch for Clang too.
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> Only this patch ended up in my inbox.  Where you guys planning on keeping
> this whole series together, or did you want me to pick this for the RISC-V
> tree?

Linus already merged this series (see d20758951f8f28c0ee1b2a8a6bb8189858083895)

-- 
Kees Cook
