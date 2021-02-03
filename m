Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5564130E3EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhBCUPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBCUPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:15:17 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD0AC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 12:14:36 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id q2so1212828edi.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 12:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2hDbD4PDQVFgTXBhK6cZuq3KTChV4iUeX+GCdlkcsVo=;
        b=XyAHweTp37C+EKfCxzZquJAoX/8UODLSgZQsKWoS8cxMrw6vkdSfj6gz8LGEircV3M
         wsRjuBx3Fx1GwDXXvEF/jiWkGv+Kf8tFwkxQzKCHbFve67beVy0rp6cSd4EW+nOHDYhu
         gPQ/4+33Z9CFWCHHrzWorqjvdkQxk5bfe/+EnsbH0GziORj00vgJQ/kkhk3XqlcN60gy
         n2FS/SjfZTF40tJm+gPaMWTL0UxFsjCWh2w8fqtZEVo7asmCN63QeX8tR34nM8ORSrIy
         swtWQJpn+tHpvsLl2JXKnY6Uw4Fj9ZpK4wfqKoP/FsoldYvdAopI6iwVnkhY+EXR1oiQ
         PTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2hDbD4PDQVFgTXBhK6cZuq3KTChV4iUeX+GCdlkcsVo=;
        b=OqyAlcmT+VQS2MHpZUSDXR7cJbeF4wB3NS1Eh6iJRxxZKZzvUk+3/cpW7n4uEhb8R8
         EokDGHdqwDz/YVk8m9ZHcL79iwyEzaScdjTho0d3trZK7Aart+ksz7Dx8WTUNd8QUIJo
         yXpdZ9mAElha3280DOrUAXgGACC8xV6Y4L0hxx6u4uyBc8rvEGY+orSyXIS4pdV5Fm0e
         Sluwp+3fMsI2AJgOO6REGousQ8fx9C/ievVkp9ZsvBbvaZudZ35YqvDypfMkjD0rFCUU
         dXJ3HS0C/tQ9OtILtrJyNvyhAMoohhl8oYpvqk30Haw7b0Demrx78jJjLyDn+V28mcrC
         ng3w==
X-Gm-Message-State: AOAM532HIV8z07a9c/g1oCjiDdhfYvECBXM3tVQpFfc0g06uCbp6R9b7
        ji1OMwS2ITs4VOvlPvo7E/af9/j5dVDPta3Vqf3KUg==
X-Google-Smtp-Source: ABdhPJzHKNnpuH6SH78OJ5c/I+5+dMOTfxA08qqDrkDJdGxsYCX2K2HmAKR+6KuQylNP68O+z51XJdgMgtiA0ebQHGU=
X-Received: by 2002:aa7:d4d2:: with SMTP id t18mr5021635edr.238.1612383275531;
 Wed, 03 Feb 2021 12:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20210203193949.GI13819@zn.tnic> <88AA1DD6-615B-4049-B335-F2F40F85EF08@amacapital.net>
 <20210203200729.GL13819@zn.tnic>
In-Reply-To: <20210203200729.GL13819@zn.tnic>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 3 Feb 2021 12:14:24 -0800
Message-ID: <CALCETrU_LTyc5oKPtO2pkKjRdPV4Pdzw4_TmcuyVUfTGfkB6jA@mail.gmail.com>
Subject: Re: [PATCH 09/11] x86/fault: Rename no_context() to kernelmode_fixup_or_oops()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 12:07 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Feb 03, 2021 at 11:53:03AM -0800, Andy Lutomirski wrote:
> > I feel like that would be more obfuscated =E2=80=94 then the function w=
ould
> > return without fixing anything for usermode faults, return after
> > fixing it for kernel mode faults, or oops.
>
> You practically pretty much have it already with the WARN_ON_ONCE. And
> you can make the thing return 1 to denote it was in user_mode() and 0
> otherwise. IINMSO, something like this:

Hmm.  I'm not convinced this is really much better.  Maybe it is.  Let
me think about it.  I feel like it's somehow too close to the previous
tangle where too many functions did too many different things.
