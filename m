Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD240112D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 20:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhIEScx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 14:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhIEScu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 14:32:50 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2510BC061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 11:31:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v123so3824139pfb.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 11:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jXU5smY1OqzWWvbSsjogwB3pDuhKcKHeqTGvWM/hR/0=;
        b=QeiGCOmJ6d5RZxjDOv4RLDUUEiefTmixYvtHKRRGMDASqT53zV9EKXBcwE/+nUTPla
         b7AFuEpCSDUgug8wwoMTk+qzPeuwEGtzQm0SbrXkpDgQal/nBAxdzBgf357AES12LJxr
         PJ78HGn1YJuOpqqKYmPQf3a4tLYY4qhwA9pc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jXU5smY1OqzWWvbSsjogwB3pDuhKcKHeqTGvWM/hR/0=;
        b=lxEP1jwv81U3m82YnYz5DlbjF8lAjNaCjsE1vx1373RWlNr5gWNOQMWi/2vhoyyDDd
         J6p1FGGqsGHGndBdGr31mifiU2T1TDXPrFLmJOZf2qp4shnzqrFNDFRLxZrKxCF4/29G
         0vAjzBJxlg0V8P4U22OUdA+iY9Ge4Ircd/cSggPYXgCtHFO3M4TWQz/vJeLt4uE+yN4h
         jzyJkp6WoOzXxkYP3S9rt7ZpvKCPe7gcuYaF7DpmK0BKCSpGLvRVutao35rGRPP7CXcR
         Erq28MQ3S+gQMoDFhM+5z2A8y6Cp2bjBobRoPZj/cXiHH5hs6WJJUZ3LXDM4M9YQqsTi
         l6Dw==
X-Gm-Message-State: AOAM532ZjYqlhMCFwrk8r1iBEH3J1FwOL4HPH8C+ghSkS7KIqKwJAVHn
        um82ASRQu8YLrTwWjTacyAn8sIbxRceoEw==
X-Google-Smtp-Source: ABdhPJz1qrurDqokxjLX3jEl+qGbItIuFod9R+1hVI9oZbiPM8Hfp1qUnT0UABFv5eqs7/fhgD8XuQ==
X-Received: by 2002:aa7:94bb:0:b0:40a:6478:d637 with SMTP id a27-20020aa794bb000000b0040a6478d637mr8371506pfl.1.1630866706552;
        Sun, 05 Sep 2021 11:31:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o14sm6247256pgl.85.2021.09.05.11.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 11:31:45 -0700 (PDT)
Date:   Sun, 5 Sep 2021 11:31:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] overflow updates for v5.15-rc1
Message-ID: <202109051123.11E4E31@keescook>
References: <202109022012.756B6B5B79@keescook>
 <CAHk-=wiPOXS2f90Ykk3V76sJLx0wMVywke8pc=88r1trmDuhmw@mail.gmail.com>
 <45312958-B844-4B4C-9808-8205866675A1@chromium.org>
 <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 10:36:22AM -0700, Linus Torvalds wrote:
> On Sun, Sep 5, 2021 at 12:38 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Yeech. Yeah, no, that was not expected at all. I even did test merge builds against your latest tree before sending the Pull Request. This has been in -next for weeks, too.
> 
> Sadly, I don't think linux-next checks for warnings.

Oh, I thought I'd gotten such reports from sfr before, but certainly the
0day bot and others have yelled loudly about new warnings (from earlier
iterations of this series in -next).

> I really want to enable -Werror at some point, but every time I think
> I should, I just end up worrying about another random new compiler (or
> a random old one).
> 
> We do have -Werror in various configurations (and in some sub-trees).

Yup, I think ppc and drm?

> > What was the build environment?
> 
> This is actually just bog-standard gcc-11.2 from F34, and an allmodconfig build.

Ah, fun. Yeah, I'm behind on versions, it seems. Default gcc version on
latest stable Ubuntu release is 10.3. I will go retest on the devel
release.

> > Seeing an unexpected "-Wunused-value" in your output makes me think I've got a compiler version blind-spot, with some different default flags.)
> 
> There were lots of other ones too, I just pasted a small subset. Thne
> full error log was 400+ lines. Most of those lines are just because of
> the very verbose warnings.
> 
> Three errors due to "-Werror=unused-value", but 17 each of variations on
> 
>     error: call to ‘__read_overflow’ declared with attribute error:
> detected read beyond size of object (1st parameter)
> 
> and
> 
>     warning: unsafe xyz() usage lacked '__read_overflow' warning
> 
> warnings.
> 
> Full 400+ lines (25kB) of errors/warnings messages attached in case
> you care about the whole thing and can't easily reproduce.

Yeah, the tests are designed to freak out if it gets an unexpected
warning (since it's trying to check for _expected_ warnings), but
regardless, they were not at all supposed to be spewing like this
immediately! :P

Sorry for the noise; I will get it cleaned up and re-sent.

-Kees

-- 
Kees Cook
