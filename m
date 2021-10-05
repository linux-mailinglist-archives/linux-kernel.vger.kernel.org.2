Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3F2422835
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhJENrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbhJENrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:47:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6766CC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 06:45:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p1so11402807pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=q2sJa+RSjEQ0N7P9tx01XDO9P2azq24o4J0vSll+eDo=;
        b=cXEeRWfyVgc7+a+vAFu1PqufAWtHO+k7wsq0aEsswxX82QD0q2jfu12gg78gZb1766
         C3cpGtOwTvvpLZREP6oEP4/YRq4uH42hk4c97yvNQY5D0dPWbkfp9bQ7rogQMf4htQsz
         23DVfwT3HshVS7HBV8zbkMlHeH2ZAo4RaHQFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=q2sJa+RSjEQ0N7P9tx01XDO9P2azq24o4J0vSll+eDo=;
        b=SAISBvw27IlMkh+qUHrQwXH5vxW4SuwLKy6GWLiGJoe/fLDCCEwpeaxZdcjDQaS5xD
         T0d6kAK+Y5vSmxp2stcujAqOckq6+3KJw5t9S1WxuscRf1gEiK8G42IwVhUDT3+E43Hq
         /lXv1yTjME5x+cxP9lM4mTgU1t6tDsfH/dLJA/YmzlY2jumxVp05MJRpknil5tEQh1Bh
         /IvTw1vK5TswzO2NMuI8kfqgzYuD9/yR7SoH03xlnIYSfztfWSA+0H6qXIop4kC5hqB8
         k9r1nl++Ih34y4t6L3QDMfYVI0bdEoe55+cvDTYFnl/u+BWkcc2qoPF8cF/yeJOETAjz
         Wbew==
X-Gm-Message-State: AOAM5306Zxlb4HNkndRP6T9+/WbhmGera29to39/S3jstpEzQc7QWltw
        IXfH6DFOt0ir72hMR13S5MvJ8A==
X-Google-Smtp-Source: ABdhPJy7iJ4NA6q+7SPqcIaqiNE9QXkzRcsUeS6RGtPFq9q43wypdNcy4xB9ksvSy85CFu0gp9dcyQ==
X-Received: by 2002:a62:6243:0:b0:44b:e10e:61b0 with SMTP id w64-20020a626243000000b0044be10e61b0mr30339538pfb.53.1633441548925;
        Tue, 05 Oct 2021 06:45:48 -0700 (PDT)
Received: from localhost ([2001:4479:e300:600:ce15:427:ed6f:99de])
        by smtp.gmail.com with ESMTPSA id q16sm19644560pfk.214.2021.10.05.06.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:45:48 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     keescook@chromium.org
Cc:     catalin.marinas@arm.com, clang-built-linux@googlegroups.com,
        hca@linux.ibm.com, jarmo.tiitto@gmail.com,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        mark.rutland@arm.com, masahiroy@kernel.org, maskray@google.com,
        morbo@google.com, nathan@kernel.org, ndesaulniers@google.com,
        oberpar@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
        samitolvanen@google.com, torvalds@linux-foundation.org,
        wcw@google.com, will@kernel.org
Subject: Re: ARCH_WANTS_NO_INSTR (Re: [GIT PULL] Clang feature updates for
 v5.14-rc1)
In-Reply-To: <20211005131015.3153458-1-dja@axtens.net>
References: <202106281231.E99B92BB13@keescook>
 <20211005131015.3153458-1-dja@axtens.net>
Date:   Wed, 06 Oct 2021 00:45:45 +1100
Message-ID: <874k9v60vq.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>     Kconfig: Introduce ARCH_WANTS_NO_INSTR and CC_HAS_NO_PROFILE_FN_ATTR
>     
>     We don't want compiler instrumentation to touch noinstr functions,
>     which are annotated with the no_profile_instrument_function function
>     attribute. Add a Kconfig test for this and make GCOV depend on it, and
>     in the future, PGO.
>     
>     If an architecture is using noinstr, it should denote that via this
>     Kconfig value. That makes Kconfigs that depend on noinstr able to express
>     dependencies in an architecturally agnostic way.
>
> However, things in generic code (such as rcu_nmi_enter) are tagged with
> `noinstr`, so I'm worried that this commit subtly breaks things like KASAN on
> platforms that haven't opted in yet. (I stumbled across this while developing
> KASAN on ppc64, but at least riscv and ppc32 have KASAN but not
> ARCH_WANTS_NO_INSTR already.)

Hmm, so it looks like the commit doesn't affect how noinstr is compiled
(which means I have another different issue to contend with!), but...

> As I said, I haven't been able to find the original thread - is there any reason
> this shouldn't be always on? Why would an arch not opt in? What's the motivation
> for ignoring the noinstr markings?
>
> Should generic KASAN/KCSAN/anything else marked in noinstr also have markings
> requring ARCH_WANTS_NO_INSTR? AFAICT they should, right?

I'm still curious about all of these questions. I get
CC_HAS_NO_PROFILE_FN_ATTR, but I don't get ARCH_WANTS_NO_INSTR.

Kind regards,
Daniel

>
> Kind regards,
> Daniel
