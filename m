Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7093D3382
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 06:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhGWDgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 23:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhGWDgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 23:36:19 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D98FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 21:16:53 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id w193so139466vkw.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 21:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NnYz1iNIJhzHIpHY3i7AC/PL1h4WWIN/9Zu2pseyMM=;
        b=AZJdFW+r1qJWaIOq18g5RGslCbMDM6EDd2J24goRI0W5EwPTWWDQMFpDWIpLbGDQlE
         t7W45Vl8JvT7haAvXnmOJ3TFJVBZ+MkNDdRgej0HPb5BMaZth8X3TpUEH6CQI0isBYnU
         4RoYAsgVDjzpK/aRqTgkea65g9lGsbDdq4gQ/IyAR98RQ74Zjv/dsVZ9AWgf3IKwQA5J
         TMFgQYFd3O9i85QsokNRL6dHUQaXwwbbsPu3N23LXOAUcjzHKoxB8qr2pTfahfvPbuwW
         bQD2Q71jeGPlhPgyvn2J/SMnMcoJOMTuQTDQOiLh6HAriI4AVRKhWte7N1uULoqTf8vZ
         hdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NnYz1iNIJhzHIpHY3i7AC/PL1h4WWIN/9Zu2pseyMM=;
        b=Tc4VQ0YJojRmHRcdQsnMblkiHLM98HEIZHRb8xWsJP31tPBbu6axluVHcvaKis8K8p
         J94tdc1bMg7n3csGvkV3+psSEaLZzlwZJlwxSW8FPKLOEBPPkizUVaOto6tP2Rn5wsvy
         bykVz58bCOOpwyRJIKSK5Hpk8ckWI1R9OXabPzb/0hbngz5IzuCc0ARA8/QC8bRAIENx
         g4VOE6q5xKuxAu6mrs12miXGyESsFjmR9bklPlFEtZXzg0F1qc9t4OfYOZYSX7qxSkJs
         XRB0Sx43cR/8YGUBM6X+Y3tFHCpuaCLoq40jDwory6pNRuQ/3661CBKIe0K1C+1Hpnsw
         AkSg==
X-Gm-Message-State: AOAM530oZ01qTpVRY8vEmF+guJopDyIlqMjhkNDB0SA0EdSiIj9FNNZB
        rMgHfrTdpY2i0/FKGPIsiBOOwsXEuySH/YQWc4pGvQ==
X-Google-Smtp-Source: ABdhPJwZNrd//Qm6E0WasD+fHTkPxy6ahCgH393B/+gnefLb0a3vT8t4ESyooIGyde+hTp9vUvp/oVq8kMcTfQhewAM=
X-Received: by 2002:a1f:7309:: with SMTP id o9mr2625176vkc.19.1627013811893;
 Thu, 22 Jul 2021 21:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcxDJ7YsnYtyzSmgfBj-rmALkjigKx2ODB=SCYCzY8FJYg4iA@mail.gmail.com>
 <20210722151930.GA1453521@agluck-desk2.amr.corp.intel.com>
 <CAPcxDJ6bB7GEhTq9fkHuT4chRTUk_s-crci=nh+COCwAzMP8Yw@mail.gmail.com>
 <20210723001436.GA1460637@agluck-desk2.amr.corp.intel.com>
 <CAPcxDJ4Liv1_zASzRxdGKu7MmjRQ9inXPfhPMQdEZrEjL0U=zw@mail.gmail.com> <0e39ef0e1b6d4532a09ad2d6e0b28310@intel.com>
In-Reply-To: <0e39ef0e1b6d4532a09ad2d6e0b28310@intel.com>
From:   Jue Wang <juew@google.com>
Date:   Thu, 22 Jul 2021 21:16:40 -0700
Message-ID: <CAPcxDJ7=UsAkDwVuoQcTt2B2UA4RWjs_o_=Fnk4Hfuqj+V8hAA@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user recovery
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "dinghui@sangfor.com.cn" <dinghui@sangfor.com.cn>,
        "huangcun@sangfor.com.cn" <huangcun@sangfor.com.cn>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 9:01 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> >> I'm not aware of, nor expecting to find, places where the kernel
> >> tries to access user address A and hits poison, and then tries to
> >> access user address B (without returrning to user between access
> >> A and access B).
> >This seems a reasonablely easy scenario.
> >
> > A user space app allocates a buffer of xyz KB/MB/GB.
> >
> > Unfortunately the dimms are bad and multiple cache lines have
> > uncorrectable errors in them on different pages.
> >
> > Then the user space app tries to write the content of the buffer into some
> > file via write(2) from the entire buffer in one go.
>
> Before this patch Linux gets into an infinite loop taking machine
> checks on the first of the poison addresses in the buffer.
>
> With this patch (and also patch 3/3 in this series). There are
> a few machine checks on the first poison address (I think the number
> depends on the alignment of the poison within a page ... but I'm
> not sure). My test code shows 4 machine checks at the same
> address. Then Linux returns a short byte count to the user
> showing how many bytes were actually written to the file.
>
> The fast that there are many more poison lines in the buffer
> beyond the place where the write stopped on the first one is
> irrelevant.
In our test, the application memory was anon.
With 1 UC error injected, the test always passes with the error
recovered and a SIGBUS delivered to user space.

When there are >1 UC errors in buffer, then indefinite mce loop.
>
> [Well, if the second poisoned line is immediately after the first
> you may hit h/w prefetch issues and h/w may signal a fatal
> machine check ... but that's a different problem that s/w could
> only solve with painful LFENCE operations between each 64-bytes
> of the copy]
>
> -Tony
