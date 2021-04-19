Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811A73648E6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbhDSRPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbhDSRPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:15:39 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB56C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 10:15:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f41so33775050lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Bmo507F/5bu9hlmYhlWeaouTUfAlwfQadzbAaH/r4I=;
        b=gcayjzMAFQp9NqJ1mxkmW9p7qdxplYx4g8F2nepPWLeSSv7PVAVP4lSvgwF3EZpGC8
         N0jUmMcI3Othw/Kf5/A+/diKhWa9czIi630LzNUbnjlAZtqOIKDcBf+1HY8yYOvY6gHU
         fg/517SMW0BITGzRRuGmitMhGwyf/Tg4Y0ATw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Bmo507F/5bu9hlmYhlWeaouTUfAlwfQadzbAaH/r4I=;
        b=cAOJduvjwSGwgFVF4Fmaq7Dz2kFNBdAWyqohuiZZuyefps4qffdE0wEMcGbXN3zK/M
         Jpi+zZHRjOOm7CRXNhFa/ryRa0DpKQpmbajQQZIRdLTVSBednpXmhrgaDa3NlgaA69qS
         fSLQk/No62B8ZPOAZMzNLyvBKCsM3pl52p84J5ATFqhKMepedGHtyrkD8mmPEL1gSDax
         v2ijXm+SCHllh2c/1R0JUKjpp3a25oYQKVNF72x3zJ5LOdA205bMjRcU44rvIxiVmn2i
         lK9C7+YW5XNK9J2I8DJVA4GNiZq97rKMStmFJSwIzCa9NSoUU6lToR/whCSScszuI5bT
         iBRA==
X-Gm-Message-State: AOAM530/SycQnEKvji7HgdLneY4lOZySP88iPlUUhkCVVvwkhIZ39+1z
        3IndFkwkg3Ke5NFhbuQityby7v2kf5Y/nD8M
X-Google-Smtp-Source: ABdhPJzAIAQyHelHr2pyv7iJEJU8+Xw0FJDSR8wiCzVJ9ITqrLFUrRLWRe1hPijDJEtTw13btDSTcA==
X-Received: by 2002:a19:520b:: with SMTP id m11mr3654414lfb.157.1618852507752;
        Mon, 19 Apr 2021 10:15:07 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id d11sm1884427lfs.291.2021.04.19.10.15.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 10:15:06 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id j4so17652044lfp.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 10:15:05 -0700 (PDT)
X-Received: by 2002:a05:6512:1286:: with SMTP id u6mr12627687lfs.377.1618852505431;
 Mon, 19 Apr 2021 10:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <YHiMyE4E1ViDcVPi@hirez.programming.kicks-ass.net>
 <YHj02M3jMSweoP4l@google.com> <YHk4DZE1ZWTiBB1f@hirez.programming.kicks-ass.net>
 <aa6e44ab-e223-73aa-279e-8103732460ac@redhat.com> <YH0yCTgL0raKrmYg@hirez.programming.kicks-ass.net>
 <7287eac3-f492-bab1-9ea8-b89ceceed560@redhat.com> <YH0+0VQ1XC8+rv20@hirez.programming.kicks-ass.net>
 <3a874b15-5c21-9ed9-e5c3-995f915cba79@redhat.com> <YH1PGfC1qSjKB6Ho@hirez.programming.kicks-ass.net>
In-Reply-To: <YH1PGfC1qSjKB6Ho@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Apr 2021 10:14:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSrOcA0567rpn1PbYkGEgnw_sOmZ13JX87isrMq1dL-Q@mail.gmail.com>
Message-ID: <CAHk-=wjSrOcA0567rpn1PbYkGEgnw_sOmZ13JX87isrMq1dL-Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] [RFC] Rust support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wedson Almeida Filho <wedsonaf@google.com>, ojeda@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 2:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I also don't see how this is better than seq_cst.
>
> But yes, not broken, but also very much not optimal.

I continue to feel like kernel people should just entirely ignore the
C++ memory ordering standard.

It's inferior to what we already have, and simply not helpful. It
doesn't actually solve any problems as far as the kernel is concerned,
and it generates its own set of issues (ie assuming that the compiler
supports it, and assuming the compiler gets it right).

The really subtle cases that it could have been helpful for (eg RCU,
or the load-store control dependencies) were _too_ subtle for the
standard.

And I do not believe Rust changes _any_ of that.

Any kernel Rust code will simply have to follow the LKMM rules, and
use the kernel model for the interfaces. Things like the C++ memory
model is simply not _relevant_ to the kernel.

         Linus
