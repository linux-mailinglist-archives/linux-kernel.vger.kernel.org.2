Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907C0364A50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbhDSTQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237147AbhDSTQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:16:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D8C06174A;
        Mon, 19 Apr 2021 12:15:44 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07810057dd6a0ceac1c230.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8100:57dd:6a0c:eac1:c230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DAFDC1EC0493;
        Mon, 19 Apr 2021 21:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618859743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jEY6C/L0jIoOv0HatPgpX4fpZUlU9Zq+96RNJO/TRvA=;
        b=ZZtM2m0ICRlrP5bWXiF8Q2jyCHDJTCxMFGsEZPHgYYWGmQiV/PdQS2IFGzQkZbyPnexx9f
        9SUMQPOMTTQP5zaa4bmDK7vRyArQOidfkF1ovUibYvVaG8HNXMTQQym5+OedpCtIKZD1/S
        VDmUzP9mM6S8jl/psr1kY2lGfMgXnds=
Date:   Mon, 19 Apr 2021 21:15:39 +0200
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
Message-ID: <20210419191539.GH9093@zn.tnic>
References: <20210413034346.GA22861@1wt.eu>
 <CAJvTdKmLth==ZPv7ygLs0jFX7JRPVhVT82ZDoT4xcQRABEVTvQ@mail.gmail.com>
 <20210414095804.GB10709@zn.tnic>
 <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
 <20210415044258.GA6318@zn.tnic>
 <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic>
 <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic>
 <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 02:18:51PM -0400, Len Brown wrote:
> Yes, we could invent a new system call and mandate that it be called
> between #2 and #3. However, we'd still do #4 in response, so I don't
> see any value to that system call.

Lemme refresh your memory: there was a time when the kernel did lazy FPU
switching because tasks which really wanted to do that, would use FPU
insns and from the first use onwards, the kernel would shuffle an FPU
state buffer back'n'forth for the task, for the length of its lifetime.

Then glibc decided to use FPU in memcpy or whatever, leading up to
*every* task using the FPU which practically made us remove all that
lazy FPU switching logic and do eager FPU.

Back then that state was what, dunno, 1-2 KB tops.

Now imagine the same lazy => eager switch but with AVX or AMX or <insert
fat buffer feature here>.

All of a sudden you have *every* thread sporting a fat 8K buffer because
the library decided to use a fat buffer feature for it.

Nope, I don't want that to happen.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
