Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36EB3601E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhDOFro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhDOFrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:47:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE2BC061574;
        Wed, 14 Apr 2021 22:47:17 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ace003285750f1ad285f1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ce00:3285:750f:1ad2:85f1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 62EF31EC0322;
        Thu, 15 Apr 2021 07:47:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618465636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wdr7LJCygRJ/a6U3yaUWITRLN12K19Ev9wrVZWngGzM=;
        b=KItbQuAnijFRSRQSQ67gsJp8hpYQd+gd35x1Ty3gJcunReRbsvItW0xOWrhbS6mUGVIl3U
        rv/MwCs/sJWOnqpcM1HPST8wNOsTvS2yg5BcVwfhRN7VeDnKqhCOwJU5ERG0r1StRKQuFO
        sSh/x4eNy740vgiiVWBhSFZUAsLskzc=
Date:   Thu, 15 Apr 2021 07:47:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <20210415054713.GB6318@zn.tnic>
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com>
 <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <20210413034346.GA22861@1wt.eu>
 <CAJvTdKmLth==ZPv7ygLs0jFX7JRPVhVT82ZDoT4xcQRABEVTvQ@mail.gmail.com>
 <20210414095804.GB10709@zn.tnic>
 <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
 <20210415044258.GA6318@zn.tnic>
 <20210415052938.GA2325@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210415052938.GA2325@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 07:29:38AM +0200, Willy Tarreau wrote:
> What Len is saying is that not being interested in a feature is not an
> argument for rejecting its adoption,

Oh, I'm not rejecting its adoption - no, don't mean that.

> which I'm perfectly fine with. But conversely not being interested in
> a feature is also an argument for insisting that its adoption doesn't
> harm other use cases (generally speaking, not this specific case
> here).

Pretty much.

What I'd like to see is 0-overhead for current use cases and only
overhead for those who want to use it. If that can't be done
automagically, then users should request it explicitly. So basically you
blow up the xsave buffer only for processes which want to do AMX.

And this brings the question about libraries which, if they start using
AMX by default - which doesn't sound like they will want to because AMX
reportedly will have only a limited? set of users - if libraries start
using it by default, then it better be worth the handling of the 8kb
buffer per process.

If not, this should also be requestable per process so that a simple
pipe in Linux:

<process> | grep | awk | sed ...

and so on is not penalized to allocate and handle by default 8kb for
*each* process' buffer in that pipe just because each is linking against
glibc which has detected AMX support in CPUID and is using it too for
some weird reason like some microbenchmark saying so.

All AFAIU, ofc.

But my initial question was on the "establishing" part and was asking
where we have established anything wrt AMX.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
