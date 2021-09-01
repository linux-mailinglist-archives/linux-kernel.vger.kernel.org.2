Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBF53FE0FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344491AbhIAROS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbhIAROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:14:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D945CC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 10:13:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q21so232170ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E81fTpfhvdQhs7o5EeruKcQgTCUULkQJwVStLDOHNhg=;
        b=clPcl9wqRuzf80MbOahGx6iQRPt39K+Z+KkIC+3gmCt8oUZqVJ17PWvioGOEcoQAVA
         wLW7GD3Y+FMIZR2RKBWV0PXDZ+Ibv7Ve54FalJuzeiX45gBmhB7QkPIKgf5hNB11IWG0
         ceYp9dKioNO9ARg5LejrNNYbGdU54JDCST3LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E81fTpfhvdQhs7o5EeruKcQgTCUULkQJwVStLDOHNhg=;
        b=O6NxncySimCv3H++0ObgP4Vc4dCiVBbc+Z+jRjTPkuvdS5kdGbm+R0rW4NUE7jRkuU
         Oq9tvIOhoZ2frm2fuauUhCkX88aTqVB3Qmywa1znIHuoVKOr/pVVVdF6uTVsgufmK78w
         bw9l8dFQzkM+5OHt95khHmvnGZ+lsr/u/6jDQbIGJEQYlBvj3P1HU+iEoYRJABx14FFi
         YX+33jze40AKCbSYIOIAd3aUnB4hl5DKwYx3YvY38SdqyErf/x6y1SmtsCXSlKKVh/pf
         xyTlDHcTt+e/rsp8jqrs3Pvi+0ItKzUZBVlH1fGFNULgTq+DHOkRguaSszmR5SHAPD8o
         TSNw==
X-Gm-Message-State: AOAM532IW6I9B7heyLjSK1Us67Zry9g8OukBKbBCIOmXtfOk9OD3n/Pm
        sbG/YmQ7KPeCec22lPeEzEpxKCvqWjktyywa
X-Google-Smtp-Source: ABdhPJy8OvqMEgm5okEqH67yvrX3TjYDsVtfuAyf18FkQlOe2YPxRHxsWGJXhMTHJTU3nFBB/ncjTA==
X-Received: by 2002:a2e:bd81:: with SMTP id o1mr582208ljq.506.1630516396041;
        Wed, 01 Sep 2021 10:13:16 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j28sm6230lfp.307.2021.09.01.10.13.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 10:13:14 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id i28so219663ljm.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 10:13:14 -0700 (PDT)
X-Received: by 2002:a05:651c:908:: with SMTP id e8mr580738ljq.507.1630516394382;
 Wed, 01 Sep 2021 10:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210901021510.1561219-1-nathan@kernel.org> <20210901160700.2941506-1-nathan@kernel.org>
In-Reply-To: <20210901160700.2941506-1-nathan@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Sep 2021 10:12:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4QPSb-4c1gpSUhgMfffKLKvvaAy6uiKM4RwxWyEYV2w@mail.gmail.com>
Message-ID: <CAHk-=wg4QPSb-4c1gpSUhgMfffKLKvvaAy6uiKM4RwxWyEYV2w@mail.gmail.com>
Subject: Re: [PATCH v2] x86/setup: Explicitly include acpi.h
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maurizio Lombardi <mlombard@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 9:09 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> After commit 342f43af70db ("iscsi_ibft: fix crash due to KASLR physical
> memory remapping") x86_64_defconfig shows the following errors:

Strange. I wonder why I didn't see that - not even in my smaller config builds.

> acpi.h was being implicitly included from iscsi_ibft.h in this
> configuration so the removal of that header means these functions have
> no definition or declaration. Add acpi.h explicitly so there is no more
> error.

The patch is clearly ok, I wonder what way _my_ config included acpi.h
ended up coming in..

[ Goes off and looks. Oh, because I got it from <linux/tboot.h> and
had CONFIG_INTEL_TXT enabled. ]

> Linus, would you mind taking this directly?

Will do.

           Linus
