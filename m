Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F2E3B49F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhFYVLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFYVLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:11:22 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A925C061767
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:09:00 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id l16so1273887qkp.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VLdRoc7Vi4IM7D6gRwT1nkjvCtkNEeCVWYhPl933Vi8=;
        b=zAzQQv0ICPE04oLtdKaTL0S7BzZmMRVFYbUN9B78/VHOQ0uVFTXu7ES2DzCrD0FeOv
         KCPu+AkqdaBO/tdT+uJoPHSQljVkLKP57DHiH0wSUuGx8JTMjmJ5RuCec9o0eI1ONbZN
         MDLVvikhWmf5vTPSfm5BUhHQRVyPJ3E7rf86/l40TpdiTVJ5bdR8Xg3f5H/BteSghjGr
         EFfB00opYK1mVVQdz0z0dNiW8P7OwD9wJ9DlgqPxCc1Nd/t9QHepOiq1A3fmlR/9zzwY
         6bKQ3jJzdAPz5+9m640Bq1RayXhj/g65+5gil7R0WXm06im0f/p643j1Cah4RrUnt3np
         QkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VLdRoc7Vi4IM7D6gRwT1nkjvCtkNEeCVWYhPl933Vi8=;
        b=o3DdwJNCJfgrsoER9dKqPyLs1sbZFL+iFmNSKPkL/GI3TI6H75EjSKfu+kYAJ1om59
         iSap5JmVW29KbSGgsRbc99W6tu8xV91Vnbj11LWqEamhZv6tNMRRQ77GDmO14y1HESTU
         /DfBjfRyK8j/KeboBwGJb9YDRoLiPdv+/ygSEi3I1wTAnDwcP+1loRJXz0NgbKMYSDNA
         t8CAM+ffgf4vD2YMZGONtqwjJb07c4MOMPHU4FbyX/h7qmhWx0O6D8eAJKQKpcCYcrmI
         6IkzczMzvTou0tnNNiyWE3RDWa7daAPVmXJcYQVJNNDM7goUMku/zsSHt2BCmzeq36fH
         3Ymw==
X-Gm-Message-State: AOAM533MkXmNOvIObjm9waNeIsAa4V2a3cVLe/9QL+ES6XNvnZdvYMD0
        yDvApSIVPAmrUEM6otZ4cuteS4Z8ltZsMP8c1RrJYw==
X-Google-Smtp-Source: ABdhPJz8RXmAmiUSRCqk8ZuTiMA1aejnIwARA3yjPDjW1KEL3FTV/5h1khu/4jvBNS/zmARNAv0bmhgACYCS+wwOK58=
X-Received: by 2002:a05:620a:209b:: with SMTP id e27mr2603499qka.300.1624655339214;
 Fri, 25 Jun 2021 14:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210624082911.5d013e8c@canb.auug.org.au> <CAPv3WKfiL+sR+iK_BjGKDhtNgjoxKEPv49bU1X9_7+v+ytdR1w@mail.gmail.com>
 <YNPt91bfjrgSt8G3@Ryzen-9-3900X.localdomain> <CA+G9fYtb07aySOpB6=wc4ip_9S4Rr2UUYNgEOG6i76g--uPryQ@mail.gmail.com>
 <20210624185430.692d4b60@canb.auug.org.au> <CAPv3WKf6HguRC_2ckau99d4iWG-FV71kn8wiX9r5wuK335EEFw@mail.gmail.com>
 <20210625084114.4126dd02@canb.auug.org.au>
In-Reply-To: <20210625084114.4126dd02@canb.auug.org.au>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 25 Jun 2021 23:08:47 +0200
Message-ID: <CAPv3WKdDmQ-n9cT_f-PacQ78FmogZyUKFgAh86ye-vaPDz_oNQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

pt., 25 cze 2021 o 00:41 Stephen Rothwell <sfr@canb.auug.org.au> napisa=C5=
=82(a):
>
> Hi Marcin,
>
> On Thu, 24 Jun 2021 16:25:57 +0200 Marcin Wojtas <mw@semihalf.com> wrote:
> >
> > Just to understand correctly - you reverted merge from the local
> > branch (I still see the commits on Dave M's net-next/master). I see a
>
> Yes, I reverted the merge in linux-next only.

Would it be possible to re-integrate 'marvell-mdio-ACPI' branch along
with the 2 fixes that resolve the reported depmod issue?
c88c192dc3ea - net: mdiobus: fix fwnode_mdbiobus_register() fallback case
ac53c26433b5 - net: mdiobus: withdraw fwnode_mdbiobus_register

The first one is needed to apply the second without conflicts.

Best regards,
Marcin

>
> > quick solution, but I'm wondering how I should proceed. Submit a
> > correction patch to the mailing lists against the net-next? Or the
> > branch is going to be reverted and I should resubmit everything as v4?
>
> I see others have answered this.
>
