Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C83446B38
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 00:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhKEX3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 19:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhKEX3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 19:29:21 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B90C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 16:26:40 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id e10so19983044uab.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=keith-pro.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DDm1Gl41ZNtTKaM+qpehqkgZKvcUPdtW3sUncsgoqtQ=;
        b=jwZIkkREp8XKMk9lrzVf72deTNly5CgzMkBkkmL/q/s+fQ62Fjhvs6WhnIt9xDBFNF
         Jh8r7JAA6S3R8uEVOgGjt2Gh5dP0aSDkfbniB9vOu43TV+eWrXly9+XX7/6tJIRG0B3c
         ifPxyA8qCvKXyycHLGN68ZrS4H1lWZpvCndwOdRWwaTbjDKvwo6vjOfmwX1cL6yVRFfe
         aw/AX4w48PzNL88rEGxGdRXNg7dkVATTBLstWYOn/Wi4BEpxGKNvCl0DDeFfXqmP8hYa
         DfePeiaCBuJOOoybNYuluRvx8azFM+AS3PNwU5/kNh7ZhxHTN5OiGfYJDi6O/g2IvTdv
         /R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DDm1Gl41ZNtTKaM+qpehqkgZKvcUPdtW3sUncsgoqtQ=;
        b=wLTJKobbuUPk1NWxv4HTGyWsNWsUZwWC+JhUnWXFpKUI+d+XVihZJLLQgcotZhue/p
         m8Xd5s2NEdFCcYspO4spq74K3XwEwXO8CwEtshk0RmmEFIsniEYd/88J3Tp4w8PCss/i
         d1iUOW2UqdAy99cjSMii3uTHw6mIgWyBU6a+h4LJWLYt01jbQjUI3ZKB70LSdk/NFSAR
         R02nB9FTVEz8b9vREzqlGvFpzK/lIzRHcIwRbpgK3nrgXTB7KEQTBWDoXB8JQGndq5kP
         w4eXGVaMMVzkUHqNwy5ReekZb9T7gUFfKAdKvmo6kAMJgH2diJOki6SLpu89VcL6ZrgA
         RLdw==
X-Gm-Message-State: AOAM533lgI6sf9ZmvvKvz5mt60EfFcwHEJduAgp6OgLEHBH5t1JJ8xae
        pHBWL1TwglqSFA2OU6HKTBmyxIYVSvaH/8EQPiSsl6hzKEKfzQ==
X-Google-Smtp-Source: ABdhPJzkF0FANQ2rZqhLawXbS3S/qnBzaCxWz9HaVzrBHdhLTH9Ks2L7E0FVesU3IpxxdTp4A7gMSPa/2PilI9u8/Fk=
X-Received: by 2002:ab0:7044:: with SMTP id v4mr70801324ual.76.1636154799906;
 Fri, 05 Nov 2021 16:26:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:a3a8:0:b0:238:a19b:849f with HTTP; Fri, 5 Nov 2021
 16:26:39 -0700 (PDT)
X-Originating-IP: [76.178.140.121]
In-Reply-To: <CALGQo4Yw7Ptm5faXjyAewW9Xe5=QKC_m9=QMy4Rb0N2p-a3VuQ@mail.gmail.com>
References: <CALGQo4Yw7Ptm5faXjyAewW9Xe5=QKC_m9=QMy4Rb0N2p-a3VuQ@mail.gmail.com>
From:   Keith Cancel <admin@keith.pro>
Date:   Fri, 5 Nov 2021 23:26:39 +0000
Message-ID: <CALGQo4aMFOrRW4EkDyjwNxGO6jayQsxzmwh3PSmjZv+Vi3jvzQ@mail.gmail.com>
Subject: Re: Intel Alder Lake Question (Scheduler)
To:     linux-kernel@vger.kernel.org
Cc:     gayatri.kammela@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gayatri,

So I was searching through the mailing list looking at various
patches. I don't see any for alder lake regarding what I was
mentioning. Is there something I am overlooking? I did see you were on
multiple email chains for adding alder so maybe you have a better
idea.

Thanks,
Keith Cancel



On Fri, Nov 5, 2021 at 7:51 AM Keith Cancel <admin@keith.pro> wrote:
>
> Hello,
>
> So Alder lake was supposed to have AVX-512 disabled/fused off. So it
> looks like that was not the case. For example see this news article:
> https://www.anandtech.com/show/17047/the-intel-12th-gen-core-i912900k-review-hybrid-performance-brings-hybrid-complexity/2
>
> This issue I noticed it seems to be the possibility that a bios could
> allow someone to enable both AVX-512 and and E-Cores (efficiency
> cores). How on earth would the scheduler handle this? I could imagine
> the scheduler switching a process/thread using AVX-512 to an
> efficiency core. Now suddenly the core the thread/process is running
> no longer has AVX-512 instructions... This sounds like a headache.
>
> I suppose the kernel could handle the trap and then from on only
> schedule such a process on performance cores. This issue I see here
> though is userland process could then intentionally trigger such a
> trap to then only be scheduled on a performance core. Even if it does
> not use AVX-512 otherwise.
>
> Thanks,
> Keith Cancel
