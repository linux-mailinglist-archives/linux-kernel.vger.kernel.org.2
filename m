Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B28315828
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 22:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhBIUzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 15:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbhBISvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:51:37 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A93C0617A9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 10:40:18 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id f2so23710824ljp.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yrqlWhEmS7qOnCD+PpBqDD/vJX8INiaqiRYekgJQZPQ=;
        b=Xv5BjgLYcmU0KX+yKZtjtFg1EszFEgfnsx23ypgGzZdhfjQ2uhx0rMeCFUeL5XrtRL
         YO09vC7QZcYwTcu/8akG7OpWlzFlemPQkHkOCvwrfIRlH4mPHf1PL9T0mqlq5zyi1BdM
         8b2RY8cyGJDx1EnZISySmVhjkPFLhbEhEex5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yrqlWhEmS7qOnCD+PpBqDD/vJX8INiaqiRYekgJQZPQ=;
        b=dyzJBayIuepVrv27I/SwTaNCgAV3L6E9wt4gHg8b5qjT13xk1UezzIsIj2iinxnY9k
         HZQdCpNwVfoKcoHZVQX0YpdnFVkSJ+9cONierXmVUmBp7oIgeGY+kNCOZdChgODneQYC
         dSXmqeIscYC1r/MLxYhnwG009lHMp58vBiXAb9KH5ZqIxQUe9gHBYbIt6KnVBgO9l+0F
         OxPJP/7PvUk1HWtutTH1YLsIyIYjwkvKifg1W9NFglvyBlUwv3VH0AyQXngWYKxsHdTA
         Ck5HORS7KwA9DlfzMot1QGendL8oqAx23dF/TL6883SbTl/K7oLhOXLYi0+Whpp81chb
         y1Zg==
X-Gm-Message-State: AOAM532Su6u9i0W2ZbhEGlftYul3Y5ycAudoVHVuN9yDNlyTv1f4DmCP
        eTTccJPOMYKAvLK3pbW4IFsD2hco+YKUYw==
X-Google-Smtp-Source: ABdhPJwJP+3y8hFX+saTf30ixefXliKSRn8XjPpbu+sczQW/1JUvBJJjGf6Wo/AnYNId2YpltLoFQQ==
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr15319654ljj.273.1612896016843;
        Tue, 09 Feb 2021 10:40:16 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id p16sm2647674lfc.97.2021.02.09.10.40.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 10:40:15 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id f8so14029505ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 10:40:15 -0800 (PST)
X-Received: by 2002:a2e:b70b:: with SMTP id j11mr14786681ljo.61.1612896014711;
 Tue, 09 Feb 2021 10:40:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgNXnmxjm+kK1ufjHfQPOBbuD5w3CTkSe0azF3NNWEHHQ@mail.gmail.com>
 <3C17D187-8691-4521-9B64-F42A0B514F13@amacapital.net>
In-Reply-To: <3C17D187-8691-4521-9B64-F42A0B514F13@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Feb 2021 10:39:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5132yO6AV=uQkNO=aGukfzE8Ji6AFuSxpdNto4ukAbw@mail.gmail.com>
Message-ID: <CAHk-=wg5132yO6AV=uQkNO=aGukfzE8Ji6AFuSxpdNto4ukAbw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc7
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 10:26 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
> >
> > Anything else would just be insanely complicated, I feel.
>
> The other model is =E2=80=9Cdon=E2=80=99t do that then.=E2=80=9D

Hmm. I guess all the code that does int3 patching could just be taught
to always go to the next instruction instead.

I don't think advancing the rewriting is an option for the asm
alternative() logic or the static call infrastructure, but those
should never be about endbr anyway, so presumably that's not an issue.

So if it ends up being _only_ about kprobes, then the "don't do that
then" might work fine.

                 Linus
