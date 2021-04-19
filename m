Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115EA3645C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbhDSOPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:15:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53770 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237765AbhDSOP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:15:29 -0400
Received: from zn.tnic (p200300ec2f078100afa224062884c679.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8100:afa2:2406:2884:c679])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 908A91EC03A0;
        Mon, 19 Apr 2021 16:14:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618841698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xYer5YJmlFMgyX1gFaAIU9JdbMZm0L97+s4VR7XbJfA=;
        b=C1Qht14qU6fl4YF08sxDKkyN12IL2huAGrGrdEwzWJ3MokzicBoijBRQgqYtQw36Qckuqd
        Nz+JV3yiF6celQeYJfOk+EbbOT7sqYBLa3CyBDv7V3E7wk7rSnVQUyELLWRjZNeDyYsOrM
        O7xg+U3yeltDHb/s2XhkH4yTneYxqOQ=
Date:   Mon, 19 Apr 2021 16:14:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <20210419141454.GE9093@zn.tnic>
References: <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <20210413034346.GA22861@1wt.eu>
 <CAJvTdKmLth==ZPv7ygLs0jFX7JRPVhVT82ZDoT4xcQRABEVTvQ@mail.gmail.com>
 <20210414095804.GB10709@zn.tnic>
 <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
 <20210415044258.GA6318@zn.tnic>
 <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic>
 <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 06:05:10PM -0400, Len Brown wrote:
> I'm not aware of any intent to transparently use AMX for bcopy, like
> what happened
> with AVX-512.  (didn't they undo that mistake?)

No clue, did they?

> Tasks are created without an 8KB AMX buffer.
> Tasks have to actually touch the AMX TILE registers for us to allocate
> one for them.

When tasks do that it doesn't matter too much - for the library it does!

If the library does that by default and the processes which comprise
of that pipe I mentioned earlier, get all 8K buffers because the
underlying library decided so and swinging those buffers around when
saving/restoring contexts turns out to be a performance penalty, then we
have lost.

Lost because if that thing goes upstream in this way of use of AMX is
allowed implicitly, there ain't fixing it anymore once it becomes an
ABI.

So, that library should ask the kernel whether it supports AMX and only
use it if has gotten a positive answer. And by default that answer
should be "no" because the majority of processes - that same pipe I keep
mentioning - don't need it.

I have no good idea yet how granulary that should be - per process, per
thread, whatever, but there should be a way for the kernel to control
whether the library uses AMX, AVX512 or whatever fat state is out there
available.

Then, if a process wants the library to use AMX on its behalf, then it
can say so and the library can do that but only after having asked for
explicitly.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
