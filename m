Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A220C44EE15
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 21:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhKLUrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 15:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbhKLUrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:47:12 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD2C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 12:44:21 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g14so42567692edz.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 12:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55PU7NCx+y3qp+yVH779Q0TOGJYQ+3HFYI6HIRyxT3U=;
        b=htlSI9PbweXay3zAqrSqMP+DpA1ClH8JSrIOkKm4ThM5VQWQeSQcQTuWqsEfU+IDbe
         QIUllEebtflPJL8Cv/ENnzIJTDRXjeJPxnccsg30WJ4yh/6GCPQx8bZfjt8NAF4Bh6Vd
         1rJPvM8EESgHfctOmZ+HPr1SV7NkIGVI9BqW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55PU7NCx+y3qp+yVH779Q0TOGJYQ+3HFYI6HIRyxT3U=;
        b=xT6dPxxg0jK8XrkWPEErcLUW/BoOUuA6fn0mIk1UKnNTlC5PUeyfTEyJsVKlFbbjXI
         lZKUT3tx3+sRXhfidxrDW6BxMioFuXcbqHeJpaVFj4BHYKe68SrOEU9jGbwbSmPFbUEQ
         AXft8M3wSi5E9mdAx6cQD5TlUl+KKMMTDvyt8BkSckroAVfFHzMRpTpXbZruSsWJbcUM
         DWc0WzC5BFqxLepdY3UkfReFUv0y7yyxFEH+Sf3/fDASDsmUxDaibRhqM0wBcemP29t0
         kCTZvbXifIJP1uzZYkLtX3Pr3iL9/Ak5VlrBCVHZyxqBEb//h0pR3iR9tRiHKA1Wab/e
         BDdQ==
X-Gm-Message-State: AOAM532YfpIXU5D/LsjAnDMXWhqXc7RquIPRczke/YhpfmtstnyP2OJt
        vgAHKCvPguf3y258/pY5TU0VsznHNpJIFvEI+bI=
X-Google-Smtp-Source: ABdhPJxrc0zo3BZ5xqNI5WF20hcb9Davm8VRqSp6om+oUq7MkIJ2bIu3uFPVJqBNHlkEn9XZT1KlUg==
X-Received: by 2002:a17:906:d1d1:: with SMTP id bs17mr22278580ejb.198.1636749859334;
        Fri, 12 Nov 2021 12:44:19 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id o12sm3438455edw.84.2021.11.12.12.44.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 12:44:18 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id b12so17684658wrh.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 12:44:17 -0800 (PST)
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr22056131wrm.229.1636749857666;
 Fri, 12 Nov 2021 12:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20211111163301.1930617-1-kuba@kernel.org> <163667214755.13198.7575893429746378949.pr-tracker-bot@kernel.org>
 <20211111174654.3d1f83e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <CAHk-=wiNEdrLirAbHwJvmp_s2Kjjd5eV680hTZnbBT2gXK4QbQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiNEdrLirAbHwJvmp_s2Kjjd5eV680hTZnbBT2gXK4QbQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Nov 2021 12:44:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=w9_TXkQF9P5KranoL_=ChVQyahjecMo1wzRTe0UtEg@mail.gmail.com>
Message-ID: <CAHk-=wi=w9_TXkQF9P5KranoL_=ChVQyahjecMo1wzRTe0UtEg@mail.gmail.com>
Subject: Re: 32bit x86 build broken (was: Re: [GIT PULL] Networking for 5.16-rc1)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 6:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>   +#include <linux/io-64-nonatomic-lo-hi.h>

I committed that fix just to have my tree build on x86-32.

If the driver later gets disabled entirely for non-64bit builds,
that's fine too, I guess. Presumably the hardware isn't relevant for
old 32-bit processors anyway.

                Linus
