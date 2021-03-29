Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D2734D132
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhC2NcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:32:12 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:40650 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhC2Nbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:31:40 -0400
Received: by mail-ej1-f54.google.com with SMTP id u9so19460390ejj.7;
        Mon, 29 Mar 2021 06:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KytxCMPWowD4rik3dQfwPYa5nzVpGWTaHqOIiMrFA+g=;
        b=kuqPKtuhHfuYrJS/R3dkx8XMpToTOb8T57yjI+/gr/e2EVStSpaRJxsVBemx8pE2iW
         4pQrepGTmDQ1ujQBc4N5XKVqpirWlLzbItl1mIemeoSQz9OvrykUySE1tQAvJIYE3KVS
         hObVR5oMAivMBDO+Lkg6q8nm5mAFcJ+qWO4ckBoauLhRZJuylE+PtiwmT7fXdkOGaSDt
         e7jVg0VV/0PCnchudTrxZ3tJpkOl26OjKfTxZsrQFmZcVJMiY6jhDZVixc9helz7tvO9
         VAKxWAoy92yXXxu5LqEx3if42HfQiUTgzl3/MVqlAEPkm3BAmLzZ3SoYNsWEGSIkxzix
         ZC5Q==
X-Gm-Message-State: AOAM530P5IXTau65K2mdPsClPrtwChPAWP0OY8SsdnLNKlmYRdR/3hZU
        IQxN3fcfl/7Pl1bSoAJvFUWxCCW4eMSVGQIgBu+VI9BF
X-Google-Smtp-Source: ABdhPJwF4ZWWoE8xAKqU0qrM/UkqqYjBcHhQlub0SOHqzAntJ28k3gIPtNZJjGOoePm8EyYlHKkGXAo0sRZ5ifCjXMs=
X-Received: by 2002:a17:906:4055:: with SMTP id y21mr28073275ejj.507.1617024699011;
 Mon, 29 Mar 2021 06:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de>
 <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com>
 <CALCETrWOc7wwW=KY2dGJGy9k5Ag=KhkdGGTDZMvgRHgyQ5fDjQ@mail.gmail.com>
 <CAJvTdK=OGALDso0H+asjgkjD_VaPNZzm+LpV+msM_i5aVUm_qw@mail.gmail.com>
 <CALCETrXky0RuA5WeQ0Mxjs+e4ywk1A7vmpBxqCo=PTSBzUsz-g@mail.gmail.com>
 <CAJvTdK=_G11phL6=9Ri41fJQvhRNopok_oktgvRjTM0v6ojcbg@mail.gmail.com>
 <CALCETrX-34QqeVLjX39ZAD+4Y6XkZ3=bPEtEPxTi0YHvLgBKig@mail.gmail.com>
 <CAJvTdKmdMfD4BddMJs4iwvHWRSv4PV7Dh2vxjM57UJ3pw5UJDQ@mail.gmail.com> <87r1k0ck7o.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87r1k0ck7o.ffs@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 29 Mar 2021 09:31:27 -0400
Message-ID: <CAJvTdKkOED6p0ox83A0qcspi5UZ-UbZAkJeyOJ6AChb-qnZGwQ@mail.gmail.com>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to
 control state component support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 6:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:

> What's the actual downside of issuing TILERELEASE conditionally
> depending on prev->AMX INIT=0? Is it slooooow or what's the real
> problem here?

TILERELEASE is fast, so there should be no down-side to execute it.
Indeed, checking whether you need to execute it or not will probably take
longer than executing TILERELEASE.  My point (perhaps academic)
is that Linux should not have to know about TILERELEASE, or execute it.

Re: running in the kernel with AMX INIT=0

AMX INIT=0 will prevent c6 on that core.  I don't expect to see this
in the syscall path, though if a user wanted to neglect to issue TILERELEASE,
there is nothing forcing them to do so.

It can certainly happen on the interrupt path, but on the interrupt patch
I don't know if we can end up requesting c6 -- perhaps on a forced
task migration?

Re:  frequency credits in the kernel with AMX INIT=0.

It works exactly the same way as AMX INIT=1.
That is to say, the frequency credits don't key off of AMX INIT,
they key off of the actual use of the AMX execution unit, and
the credits free up several orders of magnitude faster
(both for AVX-512 and AMX) on this hardware as in previous generations.

As a result, if we interrupt an AMX program, and run for an extended
period of time in the kernel without XRESTOR to clear out his AMX INIT=0 state,
that will not have any impact on the frequency we run inside the kernel any more
than if he had AMX INIT=1 state.

thanks,
Len Brown, Intel Open Source Technology Center
