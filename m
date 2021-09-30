Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0748541D204
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 05:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347828AbhI3D5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 23:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhI3D5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 23:57:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D81C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 20:55:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i25so19509375lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 20:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJPS6zsrbHWsNjyLPU/ZEz8loyvWlYIAC7D3Kjus4wI=;
        b=YjPebZ0q5PidpdWfeNvzuH2+99nPTXGOHWRkng7FrDkiDsyBNwr72s82v4vvSRe4xx
         rv0m4mHhjIx9cgbvVrjzns/0edl/WBkZxLfPjKf1BFLYavvrcEtZnvrov4nuEx4/7JEH
         IBK45AImTIdDV0VLpanEItUN2rTX8mIq9uTDcH/YuEeVb4NN6UB8caxg46kYAVocdvd/
         QTQBTktNNoxoGnBXZVfyDXR1CAxVlmXJplsiRClkXp5cCTpsDX5/sRc34RkJH4+bJc9b
         79jc4Uz8oQkwhtrPqUYTrJuO/1RhGptjALTBIos5Wqtc0sDOPFof9eFvR9neXZCoWWLE
         cqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJPS6zsrbHWsNjyLPU/ZEz8loyvWlYIAC7D3Kjus4wI=;
        b=FvRtgydAnfmdBdO+a1dwfXeh4An0dDxwwmpxIPBXyoGu3A8TvJgaEmZSriIwkWZkep
         nxqH0TclArgUGDru2fNDGEExdqWDg+lUlDczBTtHcjY7qpnBXE6xUaW5JeXyfMekozTU
         68nrKOgpQRL9ZMCNP1ZCNfBuKzmZbvb7vfzO0fqrH8QqDx4JMKjROUsXP0KmvRJbon5S
         X9rntGWtf9C20ha3+PsTzVcgJ7S2fy20qhM0weZrXsNh0QliJqtl4QwerVY2Jq4l2uLb
         AdVfJzrQBv6myTQJjJxvCsoKs1MHKUWRoh8G3+9Ws/+pglKfnLNUJEPL+nQr6I7LwUCq
         M2Eg==
X-Gm-Message-State: AOAM5302fBPCHNCdG3w4CJnU0CfEItxEQsiaIk2XZKnp/2Sg2fu2tYvG
        JamFEICgOWeW9gy7BbiB95zlNORKSGF2l2swYlSkbg==
X-Google-Smtp-Source: ABdhPJzQpUwHrNZI+47+bpMwucbwQyrcr9cEb2tHbF6fwCa0fLlhSCubtfIoDhoT5JCiMiJc7npB8YSsvil7o96dPnw=
X-Received: by 2002:a19:f515:: with SMTP id j21mr3373622lfb.125.1632974132348;
 Wed, 29 Sep 2021 20:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-9-pasha.tatashin@soleen.com> <20210929123513.GC21631@willie-the-truck>
In-Reply-To: <20210929123513.GC21631@willie-the-truck>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 29 Sep 2021 23:54:55 -0400
Message-ID: <CA+CK2bDw3A7FkZoQbB-AQWHj89Azqjrm12WFQVcfQjS+2Tmgyg@mail.gmail.com>
Subject: Re: [PATCH v17 08/15] arm64: kexec: configure EL2 vectors for kexec
To:     Will Deacon <will@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/* Allocates pages for kexec page table */
> > +static void *kexec_page_alloc(void *arg)
> > +{
> > +     struct kimage *kimage = (struct kimage *)arg;
> > +     struct page *page = kimage_alloc_control_pages(kimage, 0);
> > +
> > +     if (!page)
> > +             return NULL;
> > +
> > +     memset(page_address(page), 0, PAGE_SIZE);
>
> Hmm, I think we might be missing barriers here to ensure that the zeroes
> are visible to the page-table walker before we plumb the page into the
> page-table.
>
> Usually, that's taken care of by the smp_wmb() in __pXX_alloc() but I
> can't see that here. Is it hiding?

Based on the comment in __pte_alloc() that smp_wmb() is needed in
order to synchronize pte setup with other cpus prior to making it
visible to them. This is not needed here. First, by the time these
page tables are used the other cpus are offlined (kexec reboot code is
single threaded). Second, we never insert any entry into a page table
that is actively used by any cpu.

Pasha
