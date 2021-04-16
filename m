Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DD7362ABA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhDPWFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:05:52 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40634 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbhDPWFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:05:48 -0400
Received: by mail-ed1-f48.google.com with SMTP id o20so7706341edc.7;
        Fri, 16 Apr 2021 15:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pE+1y3kVswoYX2AiLRaqMZxwYcgmWgUuY2qO0xxCCr0=;
        b=Nup7K2rty/zHBA4NVd53qG5OC4JdYw7FeAV4rQTzvBnZUBldcZnQTnEcbSEHwrl+yE
         sTYCT+yYoeIkBAqF8yGh5LQpZHlpoyrYr0lQoum5Up5wA2fh74aohKYr/4BApPk37cNq
         XDvrSdLZv5gDpgvfaekMlivlr1S9eQlGjyr3agDPahDZYOLuD8ynDFRSVGKrd145kaq0
         pFU1KWmXWe4PqZee0qt7GlNVNDRadQovErl/4A7vI7gHfICLOIS4/pJY6gdnngvvizOZ
         Ep2vk6+662Bu71XPNRi+6/XyoNTcbKwjwSQL7PlVh3LzxbJecrQMhPCSBSg5jbpcoJTt
         0jwQ==
X-Gm-Message-State: AOAM533sJk586pd0zIQmCxayPlX7lIwEsRlGNuC4I9kCsyS1qM/31CEO
        zhTmJ/3WUkTtIHU2ZNfr0ntiJCtkX9PJuL9C4KI=
X-Google-Smtp-Source: ABdhPJyoUO+HJ3qMNcryPvKppffY+ChU86bnFi8SAvERKyhwOEbczCIePADySBwPpz3QZH93R58c6wfdllohe6bgSsE=
X-Received: by 2002:aa7:cb97:: with SMTP id r23mr12279313edt.106.1618610722450;
 Fri, 16 Apr 2021 15:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <20210413034346.GA22861@1wt.eu> <CAJvTdKmLth==ZPv7ygLs0jFX7JRPVhVT82ZDoT4xcQRABEVTvQ@mail.gmail.com>
 <20210414095804.GB10709@zn.tnic> <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
 <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu> <20210415054713.GB6318@zn.tnic>
In-Reply-To: <20210415054713.GB6318@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 16 Apr 2021 18:05:10 -0400
Message-ID: <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Borislav Petkov <bp@alien8.de>
Cc:     Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 1:47 AM Borislav Petkov <bp@alien8.de> wrote:

> What I'd like to see is 0-overhead for current use cases and only
> overhead for those who want to use it. If that can't be done
> automagically, then users should request it explicitly. So basically you
> blow up the xsave buffer only for processes which want to do AMX.

Indeed, expanding the xsave buffer happens only for tasks that touch
AMX TILE registers.

> And this brings the question about libraries which, if they start using
> AMX by default - which doesn't sound like they will want to because AMX
> reportedly will have only a limited? set of users - if libraries start
> using it by default, then it better be worth the handling of the 8kb
> buffer per process.

I'm not aware of any intent to transparently use AMX for bcopy, like
what happened
with AVX-512.  (didn't they undo that mistake?)

> If not, this should also be requestable per process so that a simple
> pipe in Linux:
>
> <process> | grep | awk | sed ...
>
> and so on is not penalized to allocate and handle by default 8kb for
> *each* process' buffer in that pipe just because each is linking against
> glibc which has detected AMX support in CPUID and is using it too for
> some weird reason like some microbenchmark saying so.

Tasks are created without an 8KB AMX buffer.
Tasks have to actually touch the AMX TILE registers for us to allocate
one for them.

> But my initial question was on the "establishing" part and was asking
> where we have established anything wrt AMX.

The patch set on LKML establishes working AMX Linux support in public.
I am thankful for your and other public review and feedback on that series.
I can think of 3 actual bugs that were found in the process.

thanks,
Len Brown Intel Open Source Technology Center
