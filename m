Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CDE4098FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbhIMQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhIMQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:26:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AD9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:25:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso422319pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=taCjqdDSME7vR7lF+EW1BqEPTLTykFPbYK6SPDFQl0A=;
        b=eh1rxFNPw+aCEFZyqDEkXAB5SU6WvscIm/FoYq+F+NbA5PM6WDQVyREPTH+Zmt42Wc
         056LnzzjAmbFc7awWxnztYEHl6BpujZt+Bfv/k8RYN4uu0bzV6hDU3IkNbIw5Tq8MdN9
         By38+nHsFcvmDLl+Q5uYLo+KGPTiNsy3rN/dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=taCjqdDSME7vR7lF+EW1BqEPTLTykFPbYK6SPDFQl0A=;
        b=cyFkFgtOuqUHVRtpV0HpA245mYIkmwf5TWxxXf/m5Ryk0BxJMGSphFYkr0TTRv7IBj
         2wn5quQxQFOVa2nz1+JMEmZe4ouy4uQBGiG7Qb9Zj62ePEyNNtsIDyesWFluQS82Goo/
         JSkc5VMitrOEGOjhnvtfyatIZla7zyb7JIDS5s5o0P2wkkFw1WQ5LFlxD7JQsXHCG38E
         speqBDyUujmNA2ro4St0qOIA2ocpq7WkKfHVHpzuZRAQz6Sav5bnQBjrn+h5SJVRCaYw
         8CDEIv95lg2U1XAgETIJK2EicNAMLiyqV3AyuwEeYAvGYoKfE5bwOrQMONrIeXpEuZac
         uGwA==
X-Gm-Message-State: AOAM530oDL6vM4dADsp6TbrpRJNKr9nds1JgaDDSiw6Ef0ABPdaPNUJi
        xxiDZ5eQLzzSjiuHQNbsmljayw==
X-Google-Smtp-Source: ABdhPJyGnb96Au30P7aC4qM0B6pg/L/NzYt1VlVh+hgL2adQWRvqsZTTS4seDlUN6x/+GDQT2LbG0g==
X-Received: by 2002:a17:903:248f:b029:128:d5ea:18a7 with SMTP id p15-20020a170903248fb0290128d5ea18a7mr11321531plw.83.1631550324907;
        Mon, 13 Sep 2021 09:25:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s9sm7064889pfu.129.2021.09.13.09.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:25:24 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:25:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] Makefile: drop GCC < 5
 -fno-var-tracking-assignments workaround
Message-ID: <202109130925.A47FB0185@keescook>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-9-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-9-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:45PM -0700, Nick Desaulniers wrote:
> Now that GCC 5.1 is the minimally supported version, we can drop this
> workaround for older versions of GCC.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
