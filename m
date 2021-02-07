Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6035B3126C5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 19:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBGSlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 13:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhBGSlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 13:41:19 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5721AC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 10:40:39 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m22so18874519lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 10:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c02vozesVICThimYMoVWUbqmQGVyvpyJgeGdYKbjc10=;
        b=cyXy0jjgdW5l6NbPrNn+CEdkegkl0qo4uL1N9bxEhmsBzOQx1mNeT7+dgcj7s2UOCV
         3cs58Sf77lLZA3LwCkMJq7RGQhBSrv2SPxQFW0JlGGZf8IGPzCmsgYi0Y0FauZiJjwLh
         AbJ4PfzEgMFiao5ZJ4fOi00dPtM/TK0Kf0Pag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c02vozesVICThimYMoVWUbqmQGVyvpyJgeGdYKbjc10=;
        b=a5eWEVQC3IjPXonx89SlLCTy2uE8L8VyVwmFH3mVG/gk5zalYzvXTAviNE/mtzhivN
         BJ4Qf03QhhltFAonqCoYmU9YNiimZkHAKcTzS1zTDiRrrg0OPYZWOclOUF3i7Lj2W8Wu
         NzEg+Zs1lwa/6xT0uRDvfEHBB3/cIe8pG9IfXxs+TvQHV8uiudCUwP3MHi8q/LEhZIX3
         uOO85Ueu0iz7RnfhEfMhamsaGvAihdhaMAwkeki/L6eVGyS40bl1tlUgyZIZr2Eb292l
         FGG7Byr1eC6BKbvR/+VgfA+LEEUncVoYFfuRjY4my/UcLdIV3qCfjVesvdszvGFacK6z
         SUhQ==
X-Gm-Message-State: AOAM533xEuNn/zDwXRddVNh3wjmewHp+KJ7lU0mX4wK6hEDo9WhIPIcW
        cp5WFqWhgk1jRFNDXO41LtQep9nWEMT3Uw==
X-Google-Smtp-Source: ABdhPJx41BGRbDKxG/ZK2/ywR/s278W5CVqWm+sBmI6Ojj5yWljLRXAh4Gn9UuV9O2jbFXiYAkJueA==
X-Received: by 2002:ac2:5ccb:: with SMTP id f11mr8559227lfq.410.1612723237583;
        Sun, 07 Feb 2021 10:40:37 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id z2sm1784298lfc.62.2021.02.07.10.40.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 10:40:36 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id m22so18874446lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 10:40:35 -0800 (PST)
X-Received: by 2002:a19:c14c:: with SMTP id r73mr7956825lff.201.1612723235473;
 Sun, 07 Feb 2021 10:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20210207104022.GA32127@zn.tnic> <CAHk-=widXSyJ8W3vRrqO-zNP12A+odxg2J2_-oOUskz33wtfqA@mail.gmail.com>
 <20210207175814.GF32127@zn.tnic> <CAHk-=wi5z9S7x94SKYNj6qSHBqz+OD76GW=MDzo-KN2Fzm-V4Q@mail.gmail.com>
 <541146c6-d809-1041-7417-547d7248e3cd@intel.com>
In-Reply-To: <541146c6-d809-1041-7417-547d7248e3cd@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Feb 2021 10:40:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSYia4kRUpwSBrKoZzd_pJpWqt-UF_oQdcjcU2+pxmQA@mail.gmail.com>
Message-ID: <CAHk-=wiSYia4kRUpwSBrKoZzd_pJpWqt-UF_oQdcjcU2+pxmQA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc7
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 10:32 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> My understanding is that AMD has documented support for Shadow Stacks:
>
>         https://www.amd.com/system/files/TechDocs/24592.pdf
>
> But has not yet released any documentation about IBT.  IBT seems to be
> Intel-only, at least in the short term.  There may be more, but the
> "Tiger Lake" CPUs are the only ones I know of off the top of my head
> that are in the wild:

Ahh, ok. I clearly didn't look at the details, just the overview of
"supports CET".

           Linus
