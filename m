Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F5136B8BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhDZSL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhDZSLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:11:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4A3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:11:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c22so3182028edn.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bq7CSKZ9T2LREHJxwDv0Jrf8jiSNKHfregCyvqEFUoE=;
        b=mPJAXaa5GNvtyb3WjwatyvSw/gIyyUKgxQTjjZXDeysxM7fWvZriR45W4nnGLVdCRC
         gWW7D30iX/sgbfsi5ZFgp97yLCqulXhQozm/nPKd1PDzzH8sRGUzncF5Z1hXQjsTwr8l
         jkuy17ZB6Rf7ycB97qySCouQRhpbq7FTHv6l3CfpCx01qPfzAkJVMJfjaX2hTugTnTQG
         bH87NjYN3pE6r7Yy9/EKrxAAnyAwo+dIP+iOuyKlX88kaEzPOJwipKqr4x8CFP67XQ92
         2JY9q6740cBty5jwvuDCxiqrWssX3e2Lx3zrRos+KIwNqFUv4czXXXDjNRqOiFXyRW6y
         KBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bq7CSKZ9T2LREHJxwDv0Jrf8jiSNKHfregCyvqEFUoE=;
        b=jILTyUsshuM38BDZp0M6EWjDwiqsQhW165/6OMtUa1cumdCXNZET9ByI64aJR35ouI
         WYbQ5aKlaw2dJFoA4xdx4m96axVhO1s5iqg9EGH7recvp1dbmyxpkE7JLs306Ad7OA9o
         Yay71ViSFrZ4LMoeaH/UFJp9pvnwLeF2Ae+d6mwgaOITC6kk4lAHs5j/GqboB6on3GnF
         ptSGaox28Sb6lyLOCdr3HCZnYU5COq9fa3PrZnf0HL2zhUhbK2I3amnPCBRCHFSGNSCZ
         l8w5eU+NvoQ+SBnaQHjpRQBV6jm0eMht5nHlS1x9mzLNfBxdBLYGE7TPIu6LBVnB+y/B
         P0Sw==
X-Gm-Message-State: AOAM5329WbKb+fxah+5jpLKHeVJwQigCJtfyL614yGM7P3Fa4ZB9Mknx
        x3nxX+7VNVK6BmWJXXDSRZu4AfRRlno62w6EVvwacQ==
X-Google-Smtp-Source: ABdhPJwevv7s8lGCriHDC4DEeZ+Rs5cSIUwmVQCTe4erRKPSnBod5FK0z9GfDRrvWRszqVhN0TTXTi+drIav7DCXXSE=
X-Received: by 2002:a05:6402:1d26:: with SMTP id dh6mr22771301edb.341.1619460666326;
 Mon, 26 Apr 2021 11:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
 <20210408040537.2703241-4-pasha.tatashin@soleen.com> <480272f8fb3e46d24a0ee1418fb85809@kernel.org>
 <CA+CK2bDc+9EsH_TLTgg9Pqv_-rZfZfPohdZEfsYjT8ss+8skjg@mail.gmail.com>
 <87v98wom5n.wl-maz@kernel.org> <CA+CK2bB9M05UKfvu66_wMK1u_HBvRws4R0KxPgTu4vPdKuGy9w@mail.gmail.com>
In-Reply-To: <CA+CK2bB9M05UKfvu66_wMK1u_HBvRws4R0KxPgTu4vPdKuGy9w@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 26 Apr 2021 14:10:30 -0400
Message-ID: <CA+CK2bADNkoX-Q3tNyjJ7fo6-f4sBPkAVYLiQh-rxFOcHzbJGw@mail.gmail.com>
Subject: Re: [PATCH v13 03/18] arm64: hyp-stub: Move el1_sync into the vectors
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

Are you planning to send more review comments, or should I send the new version?

Thanks,
Pasha

On Thu, Apr 8, 2021 at 12:28 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > > Thank you for noticing this. Not sure how this missmerge happened. I
> > > have added the missing case, and VHE is initialized correctly during
> > > boot.
> > > [   14.698175] kvm [1]: VHE mode initialized successfully
> > >
> > > During normal boot, kexec reboot, and kdump reboot. I will respin the
> > > series and send the version 14 soon.
> >
> > Please give people a chance to review this lot first. This isn't code
> > that is easy to digest, and immediate re-spinning does more harm than
> > good (this isn't targeting 5.13, I would assume).
> >
>
> There are people who are testing this series, this is why I wanted to
> respin. But, I will wait for review comments before sending the next
> version. In the meantime I will send a fixed version of this patch as
> a reply to this thread instead.
>
> Thanks,
> Pasha
