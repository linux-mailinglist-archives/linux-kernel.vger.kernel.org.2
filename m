Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E8C457173
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhKSPOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhKSPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:14:36 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C4EC061574;
        Fri, 19 Nov 2021 07:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CstLjnLmS+YYYhfEIDDOcPTXnFTE/q9KPnXHCQpNsfo=; b=ln71mTJeSJVi9JJd80Pft5PFw1
        e6otlfjfahzr13myHbUoSnQMV2lfLyPKk0hvqLvlIXlYPC9PGT85qYbLAbQaVhYn95KyvPlcAGxHB
        DBgrmTPv/+P16kQawT2O+tSPb9I/yc9kniLdTA06EOcOUGd+Ena+WCpwIASvb4WdGfgIfkUl0cVOE
        JbfsYUCaJLpi5V718JQblg+TmTgS49MlRGWEcAbkYfkgNBDlSitNDmjYjxgVIDDTv8UrFk+OUeTjf
        G9JQYhmkkdtkZWahLO831O2faw3yagjz2etdzh9gKZRt7Wi24V0gJM0JQdMFpiP26wZI9IsLEBi0N
        pGeZieGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mo5Xy-00Gvdo-H4; Fri, 19 Nov 2021 15:11:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B50330030B;
        Fri, 19 Nov 2021 16:11:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29DDB20D8DBBA; Fri, 19 Nov 2021 16:11:25 +0100 (CET)
Date:   Fri, 19 Nov 2021 16:11:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H.J. Lu" <hjl.tools@gmail.com>, llvm@lists.linux.dev,
        linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] x86: Use -mindirect-branch-cs-prefix for RETPOLINE builds
Message-ID: <YZe+nfVmA5wrIcv6@hirez.programming.kicks-ass.net>
References: <20211118185421.GK174703@worktop.programming.kicks-ass.net>
 <CAKwvOdkrN0tLMrEyx98JY6wGdwi0Be3Z8fbTQ3vNHckM4dmG8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkrN0tLMrEyx98JY6wGdwi0Be3Z8fbTQ3vNHckM4dmG8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 02:08:04PM -0800, Nick Desaulniers wrote:
> On Thu, Nov 18, 2021 at 10:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> > In order to further enable commit:
> >
> >   bbe2df3f6b6d ("x86/alternative: Try inline spectre_v2=retpoline,amd")
> >
> > add the new GCC flag -mindirect-branch-cs-prefix:
> >
> >   https://gcc.gnu.org/g:2196a681d7810ad8b227bf983f38ba716620545e
> >
> > to RETPOLINE=y builds. This should allow fully inlining retpoline,amd
> > for GCC builds.
> 
> Do you mind adding the following link tags:
> 
> Link: https://gcc.gnu.org/g:2196a681d7810ad8b227bf983f38ba716620545e
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
> Link: https://bugs.llvm.org/show_bug.cgi?id=52323

My scripts will strip that, they only like to have a Link to to the
actual email as posted. I can put in the URLs, the first is already in
the Changelog.

> If the feature would be helpful to implement in Clang, would you mind
> keeping the cc-option, but moving the check outside of the `ifdef
> CONFIG_CC_IS_GCC` block? That way, we don't need to revisit the
> Makefile?

I was thinking that clang would want to name it differently to be
consistent with their own retpoline flags, something like:

  -mretpoline-cs-prefix

> (Tangential: I wonder why RETPOLINE_CFLAGS aren't defined in
> arch/x86/Makefile; they seem to be x86 specific at the moment).

Yeah, I think there was hoping that other archs would find it useful,
but so far x86 is the only one having grown them things. I can move them
I suppose. If ever another arch grows them we can reconsider.

> With the above link tags, and with or without moving this outside the
> gcc-specific guard:
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks, let me repost as two patches.
