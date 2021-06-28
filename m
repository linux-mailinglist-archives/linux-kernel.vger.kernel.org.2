Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443173B685C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 20:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhF1SXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 14:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhF1SXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:23:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B51C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 11:20:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j4so34250455lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=beso7VBAe7MQCcx243Y/tF0q9TE4lE7EjU8nTpd7jTs=;
        b=INpVfpbHRshQB5FvW1owFUibqPb80t8mMeuTMDUhKCiZXhrI3GeyDSrg4x0eR9ycyf
         SCt1QiDDpcJdXlk8QCCCJjhKRbGwsGVRRW/E0Kfwk6wM1PpJ83lD8Du18O/r67vJbaAH
         wS3LKhFnuE0eo9X9sUzB0S28jSArTaWVC2H01rs0nIvrDzses72eW+dHBNt/P9/Fr3SG
         P0btg5jNWiHA5qI1WktBZ16k19iQr0xgp2e6uhlq8iFl3B4Ji4oquyhnS0Ap7pxNCY/Y
         BdHnTJKMM+JMkGL/O7QdOy+AwyNCjOPTyW1SZuYoDrn8qfmEjo0LPZuj23uHCWBx2jeQ
         okqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=beso7VBAe7MQCcx243Y/tF0q9TE4lE7EjU8nTpd7jTs=;
        b=a9pkvI/YC+ipWK8JSbysK7G0xnYrY4DtQ4Vt68N4Zem5DAsqpedjavzOzmD1mBH2cj
         QeZVc8+Gs3R/xuvVWlR7Gj/WYjPf5cgpnRXlderBxvT/sMiTGhnt7VEtF9jDt/wH93Eu
         lTPwbq6H31F03P4NYZD2qZMs7jXFFSMevBlvwEvG0jS8Oyea1uEettQEUx75h3urkK7+
         ifaardIWWWI6rqv3Ju35GQVQqYVKK9xcXuDNOnv6UfWJRNqTMWvVR/Uj64Pt220PGUjR
         LzI1709kRl4BVj892VTQzCBQkQau3LNb2kZdsxod8Lm5kHRvSjITiEIhkFj4HqEJeuI/
         eD5Q==
X-Gm-Message-State: AOAM532KBRAZJ5l/95UQPd4Ls57XnkxMVpVJ9v3U/j2ThOqNQL7atk21
        pfZrJjqPUhTrrBkxroRFwGUNOW4HK1ILARS71uLQZA==
X-Google-Smtp-Source: ABdhPJwTYBDH9MLG9PcH6cneZ9d3Ga2u8rCYEs5cyo45CDONOb6eSNua6P42B8byPlDbRgDbRbwuiTCQOMWYNyyCb8E=
X-Received: by 2002:ac2:4438:: with SMTP id w24mr20583194lfl.73.1624904453291;
 Mon, 28 Jun 2021 11:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210622183858.2962637-1-ndesaulniers@google.com>
 <20210622201822.ayavok3d2fw3u2pl@google.com> <CAKwvOdki=HZh4TYwqwDSo4BWtbGHp6pM_2akA+D3K8JO+dMGoQ@mail.gmail.com>
In-Reply-To: <CAKwvOdki=HZh4TYwqwDSo4BWtbGHp6pM_2akA+D3K8JO+dMGoQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Jun 2021 11:20:41 -0700
Message-ID: <CAKwvOdnyzRk75+P1Uc=hs8e2aL3oMSDvjy-JeYwXwJwd_G7JRw@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: strip LTO suffixes from static functions
To:     Fangrui Song <maskray@google.com>
Cc:     Kees Cook <keescook@chromium.org>, "KE . LI" <like1@oppo.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miroslav Benes <mbenes@suse.cz>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 10:54 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jun 22, 2021 at 1:18 PM Fangrui Song <maskray@google.com> wrote:
> >
> > On 2021-06-22, 'Nick Desaulniers' via Clang Built Linux wrote:
> > >+/*
> > >+ * LLVM mangles static functions for full LTO so that two static functions with
> > >+ * the same identifier do not collide when all code is combined into one
> > >+ * module. The scheme used converts references to foo into
> > >+ * foo.llvm.974640843467629774, for example. This can break hooking of static
> > >+ * functions with kprobes.
> > >+ */
> >
> > The comment should say ThinLTO instead.
> >
> > The .llvm.123 suffix is for global scope promotion for local linkage
> > symbols. The scheme is ThinLTO specific. This ensures that a local
>
> Oh, boy. Indeed.  I had identified the mangling coming from
> getGlobalNameForLocal(), but looking at the call chain now I see:
>
> FunctionImportGlobalProcessing::processGlobalForThinLTO()
> -> FunctionImportGlobalProcessing::getPromotedName()
>   -> ModuleSummaryIndex::getGlobalNameForLocal()
>
> I'm not sure then how I figured it was specific to full LTO.
>
> Android recently switched from thin LTO to full LTO, which is what I
> assumed was the cause of the bug report. Rereading our internal bug
> report, it was tested against a prior version that did the symbol
> truncation for thinLTO. I then assumed this was full LTO specific for
> whatever reason, and modified the patch to only apply to full LTO.  I
> see via the above call chain that this patch is not correct.  Let me
> send my original patch as a v2. b/189560201 if you're interested.

I can even see the .llvm.<number> symbol names via `llvm-nm` on
vmlinux for thinLTO builds. No such symbols exist for full LTO.

-- 
Thanks,
~Nick Desaulniers
