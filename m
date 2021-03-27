Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972A334B940
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 21:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhC0UDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 16:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhC0UC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 16:02:58 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE61C0613B2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 13:02:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f16so11366115ljm.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AljBoJA9xVm8rnN8JL9ob4rBdSbgIwseVpUSWxovQ5s=;
        b=Og7yjEHRu96oePIWfeiKgpoHBhc4DaBFsFyDdJinqzTz6GAK9EtqacAhGC1kUQEi/8
         nMLKtgevmk2Nlgjfk58PF4tfRRjflNaUXRdiP62VsBHnCzl/kwQxyLt+hRNvuoDo6kLP
         1rsf/31GDZQ/+WzSvI7IJRVEHjDEb8cjj0p70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AljBoJA9xVm8rnN8JL9ob4rBdSbgIwseVpUSWxovQ5s=;
        b=MTIIlWwFW0Vv2HQIvKpVhDcDJMfQ7Zalv9bIEwa2Ym8pUbKpXJP9ApowNQWE/THlLt
         I3w7tVh6wQAN5Vgx/KxG1hMbnb1A5o9kQVpC8hROTp9nYihiJ5Z4TFqyWKExWPmhwDLv
         k8z5jdAvXKqga7KCWkpTmqqtHHDAy970dHZjDsrkDI/grb84vUAt0jQl2G1jCnudJ0tn
         7Bo9P1nlBx6IDHm26PQn/WMpqTSIipUYUVhRhEyQoWgfs5Uy3k2shcxiI/duDFNiE5Oc
         l08sHQA/jcIbr6iDcFTdvDXnQj9TyNNXdFrKx+fEHlcflbfCyjqCsXbWR0E8CALQVSpF
         NfOQ==
X-Gm-Message-State: AOAM530xrhIfJOUWLgaohslwS50JeUXn+G08Ggg6is5BPp7k8dYFCjcJ
        aCvQ5kKez3iFQspJJODwmbIHSSHwzfhPDg==
X-Google-Smtp-Source: ABdhPJzXRN/aDOwwEU/UfMMEOCKFoOgihWZDwhBMHi3CF8H0C/hf0zHhvAmx4fOGZeLCT2upTFJHiQ==
X-Received: by 2002:a2e:b544:: with SMTP id a4mr12912206ljn.504.1616875376559;
        Sat, 27 Mar 2021 13:02:56 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id v9sm1284058lfd.195.2021.03.27.13.02.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 13:02:55 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 184so11290261ljf.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 13:02:55 -0700 (PDT)
X-Received: by 2002:a2e:b6c6:: with SMTP id m6mr12646352ljo.411.1616875375067;
 Sat, 27 Mar 2021 13:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic> <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic> <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
 <20210313132927.GF16144@zn.tnic> <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
 <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com>
 <YE+i/VWITCCb37tD@hirez.programming.kicks-ass.net> <CA+icZUWQ1kH6muAQbNuVAPj4Cn=8ssDAJfYLKht8ezAgJKWApA@mail.gmail.com>
 <YE/cMeO+oC/5JEC6@hirez.programming.kicks-ass.net> <CA+icZUXko_Nxh-9_qgjMYyGsh8E1rj2cWmQh0OHjuZECMZxp6Q@mail.gmail.com>
 <CA+icZUXu7ZNdrv6gTFCRri1ReF2e_87mX5D3Sex7tN+0GBpJ1Q@mail.gmail.com>
In-Reply-To: <CA+icZUXu7ZNdrv6gTFCRri1ReF2e_87mX5D3Sex7tN+0GBpJ1Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Sat, 27 Mar 2021 13:02:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXAvCnjCBj=p4-xvEojQ1iy=dA9VjWtAhMwG4MLK_6jw@mail.gmail.com>
Message-ID: <CAHk-=whXAvCnjCBj=p4-xvEojQ1iy=dA9VjWtAhMwG4MLK_6jw@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 5:08 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> debian-5.10.19 as host-kernel:
> 11655.755564957 seconds time elapsed
>
> dileks-5.12-rc3 plus x86-nops as host-kernel:
> 11941.439350080 seconds time elapsed

That's 2.5% - a huge difference. Particularly since kernel build times
shouldn't even be that kernel-intensive.

I think there's something else going on than the nops. Same config?
There are likely many other differences between 5.10.19 and 5.12-rc3.

So can you check just plain 5.12-rc3 and then 5.12-rc3 plus x86-nops,
with otherwise identical configuration?

               Linus
