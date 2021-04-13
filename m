Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FE635E751
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbhDMTwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:52:25 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42623 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhDMTwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:52:23 -0400
Received: by mail-ed1-f49.google.com with SMTP id d21so709993edv.9;
        Tue, 13 Apr 2021 12:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKPJ/sPO22gfiF94hxW9McaKDO7hAr85uineOjYitIE=;
        b=EsqP/vO9ZbAGLtAvwCIwrZp+lcSc9fGHvQ6IPAvh6ShjOh7DNeSXG2gu2VKx7WpdJN
         QgXikBxoaIZZqpOH+dPkgA4cnSbDdxjm3YMM4yOG7X1SPmLHWK0rw9XP4CIbqu3CLujl
         hjaGZqHq+8h5k7B4BxF09zySU7f2xjQYL2b5XxipGmhVDAhC9AKT1XRfIVveHQYbCx1N
         k8fZWTrzInTGFgsr/bP5oa6NeXFQLmMkYWv9jbm3fz/7kq+K+QxkhZ1A8Fdzi5qCkaVs
         hPMHw7Rd3O7z/ck5Y7SQRg8mrLJKi3e4X9Q3hDfjEqXLrJHEHT9JFDXEExTQTJUaT286
         wvig==
X-Gm-Message-State: AOAM533oFfH6WbPYxnCbYugN424/1zZEr6tPKXFYWKt5fmdYWTYYEcYA
        cmdWGLmK88iT20EP1JVSnD0whpY2DmEE3sPV2eU=
X-Google-Smtp-Source: ABdhPJzEqOYPwZS3m7LJ3+5X1Ra00fK1HTMUfkVcy19u7Iebm2WDwBUgomgbirKpn5+pkzU5Lh/OVVibfti7SdBzq0g=
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr36783451edc.94.1618343522468;
 Tue, 13 Apr 2021 12:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com> <20210413034346.GA22861@1wt.eu>
In-Reply-To: <20210413034346.GA22861@1wt.eu>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 13 Apr 2021 15:51:50 -0400
Message-ID: <CAJvTdKmLth==ZPv7ygLs0jFX7JRPVhVT82ZDoT4xcQRABEVTvQ@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Willy Tarreau <w@1wt.eu>
Cc:     Andy Lutomirski <luto@kernel.org>,
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

Thanks for sharing your perspective, Willy.

I agree that if your application is so sensitive that you need to hand-code
your own memcmp, then linking with (any) new version of (any) dynamic library
is a risk you must consider carefully.

AMX does the type of matrix multiplication that AI algorithms use.
In the unlikely event that you or one of the libraries you call are
doing the same,
then you will be very happy with AMX.  Otherwise, you'll probably not use it.

I acknowledge the issue with the toolchain transparently using AVX-512
for copying data, and how that approach impacted systems with
a poor AVX-512 hardware implementation.  FWIW. I'm not aware of any
plans to implicitly use AMX this way, and I'm not aware of any non-Xeon
AMX implementations in the near future.

cheers,
Len Brown, Intel Open Source Technology Center
