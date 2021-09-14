Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392A040BB93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhINWdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbhINWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:32:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97652C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:31:27 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s3so1431304ljp.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/NVWJihw8+mxkblMeUMKWZHa5HcW57V47+/ryRA4f4g=;
        b=qgFutAKEGpZf/SKejV/Bi2NvnFIej9XU7ZBF5Rsx7JkwnAFyYg3lckowPNJ17rk4mk
         DV3q6AswIVnkJ/uQDSz3gsB946gSRsqJcBwHVi8iqbvUqaSIU04Vgj90096Fmxf+GWdy
         I8Hd6on20wzkR5xl0kJGh5nQw44HLi/F6vtULV3QuN8FIByAMCEvwqyldqODg+2+vVjj
         DOcdlURnGyYkSEVHXi7yl7y9pR9foHVBUJunF6gGn+NLicmzott3wMS8dDUM42YY9UEk
         /LuBflX18x1HOIDjgpG3Svi7P8/2W+Ra1wC0LZa3Lbn8T6PyYcN9w8le+LW0PGIhBRd5
         4Eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/NVWJihw8+mxkblMeUMKWZHa5HcW57V47+/ryRA4f4g=;
        b=leQ8rlu2WlHp6RbDbeoGxspQa4LMDKGRODfFjgSRXyWwOJt8InhVUXMSNeSYvXSAJI
         8kDzcsuhp90ljAIGzLJO/8HZE9RGjq4LqMhzYuAC8ZLC1GUMpVk3AxSPfnqjARNvneko
         zSmWUhdgtUt5RR2AsgtnjL+booHD2DKX1cLWWAVI2onOyCOOhaEPX1tlT8PuROdB+t+G
         IveIohDYeYhx3zUD5opxneW8l38hI0YoDzgbHobvvFkVMm/JttJgrA/mcmqNaLkkuhsr
         ILq6TK81OMftVoX4N7X9NSrmO4kSQa+oIWNrJyE/doXHZ0e6q/dIXeJnlbP7KATdzgug
         U6vQ==
X-Gm-Message-State: AOAM532j8h7yDMXPLvRnl0VMa4yXUC1SzBbcVerdNp+HDZICLYIAZLeB
        XHSL0hKbUwc7DehSkt3yOqFccyHgcajxcyrDUib3Rg==
X-Google-Smtp-Source: ABdhPJzfSMfk3cB0ZCvwLiGPWOn8ZNgyMxOydEvYDNoBwhQ3myvaaomRVN0JfSKn3Mu8Vcacbr1v4PNVRcOKeKSEf0Q=
X-Received: by 2002:a2e:b551:: with SMTP id a17mr17253096ljn.128.1631658685761;
 Tue, 14 Sep 2021 15:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-12-samitolvanen@google.com> <CAKwvOd=OvR8iZogXhMxkbt5qT7jbhaARgk5NsCzhpkjoZ7yy5Q@mail.gmail.com>
 <CABCJKudRDcwfkSK205Pb__hzLWQPUFhbjUtFPbctdPAycSOKQw@mail.gmail.com>
In-Reply-To: <CABCJKudRDcwfkSK205Pb__hzLWQPUFhbjUtFPbctdPAycSOKQw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 15:31:14 -0700
Message-ID: <CAKwvOd=q1xhn9OEyowWyMeDW8CbWW4=nRmdE1tHggjCZKr7xrA@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] x86/purgatory: Disable CFI
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 1:30 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Tue, Sep 14, 2021 at 1:02 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Sep 14, 2021 at 12:11 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.
> > >
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> >
> > I kind of prefer the existing convention that has explicit guards on
> > specific configs (ie. CONFIG_FUNCTION_TRACER, CONFIG_STACKPROTECTOR,
> > CONFIG_STACKPROTECTOR_STRONG, CONFIG_RETPOLINE); it's more obvious
> > which configs may introduce which flags that are problematic. This
> > patch is ok as is, but it kind of makes this Makefile more
> > inconsistent.  I would prefer we had the explicit checks.
>
> The Makefile does already use DISABLE_STACKLEAK_PLUGIN in a similar
> way, but I don't have a strong preference here.

mmm...DISABLE_STACKLEAK_PLUGIN adds to PURGATORY_CFLAGS. This patch
adds to PURGATORY_CFLAGS_REMOVE.

> I can move this into
> an ifdef if it makes things cleaner.
>
> > Does CFI actually do any instrumentation in these object files? I
> > guess issues in purgatory cause silent/hard to debug kexec failures?
>
> The compiler shouldn't add any actual CFI instrumentation here right
> now, but I would prefer to avoid issues in future.

Ok, good to know.
-- 
Thanks,
~Nick Desaulniers
