Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06743157AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 21:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhBIUZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 15:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbhBISYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:24:41 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6287AC0617A9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 10:09:58 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id b16so7892203lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 10:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QlrUv98m3txRxRypr42z/6B1CjH59DrwYQO+A25z6Ck=;
        b=MZqRHNGl5UVD3LNyPZVDCWmVu1CVaaT0SkbucSwyAjEe/Mgs3FAaaz/CYo1niXBBcy
         KBQ/fl3O67N55M3ZI10bmnNoKdTzh9GaIddvF4dOrNaknRSt0e+Hsy8KYXW86Rpx9Fq7
         2DGJBLtxqcfaiS+z3Sgrzd8OZZGTIGps112zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QlrUv98m3txRxRypr42z/6B1CjH59DrwYQO+A25z6Ck=;
        b=Olcynn2FjkSg24WjeGr0r0qlyFdln6MqLCDxbhiDESlAoS00J5Xi9LMRzmqtJhX6Kk
         VWIADcdY3+E8MH10o/ZbH5qXV/kL+C/LitJt6F6Q/Cn0VauwTpDI+ZGtfi0joThsNfiP
         wElJco6vXyrrpwjpEzEzpS5094zAIH4I96lqke00w9Q618P0+c/xldyAoVsYqbjgCsNn
         5aDVE8RxFz8nmDbg0weXnoz9X4+G/1Y8c2z1Oxu6oRhET6nvMDBSzrlXDpcoSU9xYEN3
         kHn0b6J/bB5GufzII7Wa4CcOO3MoFD9kk5IPvlquahstFCqfXty/lkVrGukXWlTw7+9R
         dCZA==
X-Gm-Message-State: AOAM531r9vruUm0F0pExVp1mGRro34q7GvVu0H83OhlkiLEfJCAgQfvZ
        4dzikJLVs5dWMB8za7rZPbZAECe3eiJ2MQ==
X-Google-Smtp-Source: ABdhPJzdm4f3TyNtMsrAXY7+W06YMAgPVo+yIkgmRu7SGPnf9oXzR1gg54D0eLHkvWFvlvnYP9o/gw==
X-Received: by 2002:a2e:9b12:: with SMTP id u18mr14666434lji.163.1612894196307;
        Tue, 09 Feb 2021 10:09:56 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id m9sm2643646lfl.63.2021.02.09.10.09.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 10:09:55 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id a22so7878420ljp.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 10:09:54 -0800 (PST)
X-Received: by 2002:a2e:720d:: with SMTP id n13mr15733268ljc.220.1612894193564;
 Tue, 09 Feb 2021 10:09:53 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQK-qdE6mHUogeaQo9Av_58cLptosmfUVmdMzW7gJn5UVw@mail.gmail.com>
 <73175691-4AE1-496D-80D1-DC85AE1E9C27@amacapital.net>
In-Reply-To: <73175691-4AE1-496D-80D1-DC85AE1E9C27@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Feb 2021 10:09:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNXnmxjm+kK1ufjHfQPOBbuD5w3CTkSe0azF3NNWEHHQ@mail.gmail.com>
Message-ID: <CAHk-=wgNXnmxjm+kK1ufjHfQPOBbuD5w3CTkSe0azF3NNWEHHQ@mail.gmail.com>
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

On Tue, Feb 9, 2021 at 8:55 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> Or we hack up #CP to handle this case. I don=E2=80=99t quite know how I f=
eel about this.

I think that's the sane model - if we've replaced the instruction with
'int3', and we end up getting #CP due to that, just do the #BP
handling.

Anything else would just be insanely complicated, I feel.

             Linus
