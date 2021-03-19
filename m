Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD2342123
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCSPpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhCSPoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:44:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA960C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:44:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w18so11360078edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbNeqMDCYRPxfWnaeRCyIN8UcpB8VqGrLDUZuCK/oCs=;
        b=iOuCEE9mSaSzxXZGXsUGkQoetlJFz9L2u675UodaleHBYCFD/C6vo8Bf/y/hUPXdMu
         M8aRH9Mvgd/igWA7SKMqafyy5mmfL2jMQI+t6t5E9B6oOme5S9ar4EotCF2D1tKZJCxx
         eS4xPWk2l2W+kFcESG4+Akvpdeb1RoJ1ZOqt47ZAuTQGB8WMaLSlk3UK67amZ3EF7F6o
         j3lOa7G5IRw89fqBI/Qau3aI0772WshWLldCvjCQ1jhtBBwEyvRwQDrmMJMl+3QB6t4d
         6UL0kdpHz+v0zLUzHToNdybUxC8/7Ddx9rFTdteQ+qY67Q8M7lLzDYs4Ad0Spk765Kwi
         I+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbNeqMDCYRPxfWnaeRCyIN8UcpB8VqGrLDUZuCK/oCs=;
        b=FidkELxfnC4H0J6xR5EBPXnl4nFhCtad3XqBIGjSpE6qWuSrGgdXbv5zKUmrU+bzWd
         pSyYUI8oqJBRHkILr1iLibID5h63KOq8Znh/2zuMXs7vnfC+yhxV2T/KMtC5mY9AZNi4
         i6xKLQ0D+Nxch4VvdcKz19GBWMW7kZJPLYWnWln2e3i7MkR+orJW7GlxKcdiI8zezyud
         nOhJmc+1x9WsfxG3Tr0+QvO7/VbGD2BVMwPhZ+5K+eF7NIzlOZOFJJeFEaskInJVNyFT
         qZGuXVBVUcD3zaxndV2UllMwfWjBpZt+MoYJ2XSmxP+ok+nmzfcRlA+DqHznvbgOUc5G
         wnfA==
X-Gm-Message-State: AOAM533iK9jwWV7v1bn8u9XcmHoJqvz3euzHqTPad7qRz4zl/guVXT1G
        mgBDD/Qqh2hDis2BAoMgIjudlx2of6Hz/4A5tj6cWQ==
X-Google-Smtp-Source: ABdhPJzazdro9e8/p1d+gCVbc5pBiTN3vKkt0/GSWwh8fi5EnnIf7n0BBVEcf1xNLt/0jo3nFG42awZianWMAoR3oE8=
X-Received: by 2002:aa7:c1d0:: with SMTP id d16mr10127162edp.153.1616168663496;
 Fri, 19 Mar 2021 08:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210216150351.129018-1-pasha.tatashin@soleen.com>
 <20210216150351.129018-2-pasha.tatashin@soleen.com> <20210219191807.GB6683@willie-the-truck>
 <CA+CK2bB13G4wTm6P_hdkwi2cbu=774GnpwBV7giy77-fEHDKow@mail.gmail.com>
 <20210222122545.GA8847@willie-the-truck> <CA+CK2bB73ezoajLaK63+WWKjDxOBiPNPv9Akj8mtJuvBvhLOZQ@mail.gmail.com>
In-Reply-To: <CA+CK2bB73ezoajLaK63+WWKjDxOBiPNPv9Akj8mtJuvBvhLOZQ@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 19 Mar 2021 11:43:47 -0400
Message-ID: <CA+CK2bD-r_afUKXSOhFBUprazR=JKKu-dyFxF9X5bhDGWwctyQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] arm64: mm: correct the inside linear map range
 during hotplug check
To:     Will Deacon <will@kernel.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Could you please take this patch now that the dependencies landed in
the mainline?

Thank you,
Pasha

On Mon, Feb 22, 2021 at 9:17 AM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > Taking that won't help either though, because it will just explode when
> > it meets 'mm' in Linus's tree.
> >
> > So here's what I think we need to do:
> >
> >   - I'll apply your v3 at -rc1
> >   - You can send backports based on your -v2 for stable once the v3 has
> >     been merged upstream.
> >
> > Sound good?
>
> Sounds good, I will send backport once v3 lands in Linus's tree.
>
> Thanks,
> Pasha
>
> >
> > Will
