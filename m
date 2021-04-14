Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6073535F68D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351939AbhDNOrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351910AbhDNOrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:47:23 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F92C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:47:02 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id i2so4432863vka.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWUmXHvIRv1Q6+KLmMzqs8rZ1xX3xtlUCsE3QMY698k=;
        b=We+Ts2hHSHOHxeChgK8+e5GvO1bOhyJG3e8alHuvmBYg1sjXMvJXsRkvFie9C1LZ5Y
         EYo/ZdeYgWsiQFijZBgILNIU+zp8sKNqeJuFd7RLh6wkDWCLVDkeBArt+EZ90dBvcAMD
         z8E2Fb37ftMCoXc3LzC48d9ItTfC9IHb1XC+pQIc4C7xpTMO9sB3aQzRMvmw2G+F3khG
         gxN9STH6BjecBbxq5JPWFNKu+xCCEaRNnQUFeDTADBoVPs3rVB9MzQBNvup8p+CotXyO
         BabKwOG4lSUmSnjq4ge+yH4IVeMwCAUSnnwieSHf1c0AMTYpjtpzUnYZOgNv68oRG+gK
         kIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWUmXHvIRv1Q6+KLmMzqs8rZ1xX3xtlUCsE3QMY698k=;
        b=jOuiFafETxpSuZau7vR0HOeVL3kw9eIgmO58wvb77CyfrZjtVzX/X0bDuVmxDBWCSr
         980LVa3ViZb4KbHrr8yhRwr8/8pHhNO7pdy8g3MR+OevDY7Ao+mRj78MIdnra0uB05Iy
         270Sj9CVO/AcT/8SRd/J5G9S330NhPbuwuxf90KXEiK/A6h6f7kvwK9HMEPtkEYW1+Vu
         lPDrIs17CCcFYI80HU3tV5kI+TIlAF546kzvl/y6YDkev+bUL1pu/dWZ9a2j0O0Jb5QS
         LTzf9xNB80hcB0s/3BdUuP+/tR2RO92ZTlq3GHrom17rT//MJ/Kp6OVTuFmXHyw8WYmg
         bGpA==
X-Gm-Message-State: AOAM533RUFn43pI/QcM8JTlV2hq6ZE0Um6x8IACw3w+3EQVTtM4VsZMb
        2YDtbEPrM6G4hrv3HofnfG3Nub7syO5+4uqdAKIw0kufnRA=
X-Google-Smtp-Source: ABdhPJwMrqNfz/lL+mK0ZpoZqN/GaAVzoGMZ87EZV+WRQ+6NAX5jX91VGJjGg83awOurqZcMIyAgLFQiNtbr23HeAAk=
X-Received: by 2002:a1f:53c7:: with SMTP id h190mr28473405vkb.19.1618411620871;
 Wed, 14 Apr 2021 07:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcxDJ6xx00Gjn6DxoMpdJ7UjNeJUp2613jqGRm7ZZeuMNeSjQ@mail.gmail.com>
 <20210414131018.GG10709@zn.tnic>
In-Reply-To: <20210414131018.GG10709@zn.tnic>
From:   Jue Wang <juew@google.com>
Date:   Wed, 14 Apr 2021 07:46:49 -0700
Message-ID: <CAPcxDJ5q8=pwqsNV4ydSPJWp35f886n1TB7dWOx9cst=cb2myA@mail.gmail.com>
Subject: Re: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, "Luck, Tony" <tony.luck@intel.com>,
        x86 <x86@kernel.org>, yaoaili@kingsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 6:10 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Apr 13, 2021 at 10:47:21PM -0700, Jue Wang wrote:
> > This path is when EPT #PF finds accesses to a hwpoisoned page and
> > sends SIGBUS to user space (KVM exits into user space) with the same
> > semantic as if regular #PF found access to a hwpoisoned page.
> >
> > The KVM_X86_SET_MCE ioctl actually injects a machine check into the guest.
> >
> > We are in process to launch a product with MCE recovery capability in
> > a KVM based virtualization product and plan to expand the scope of the
> > application of it in the near future.
>
> Any pointers to code or is this all non-public? Any text on what that
> product does with the MCEs?

These are non-public at this point.

User-facing docs and blog post are expected to be released towards the
launch (i.e., in 3-4 months from now).
>
> > The in-memory database and analytical domain are definitely using it.
> > A couple examples:
> > SAP HANA - as we've tested and planned to launch as a strategic
> > enterprise use case with MCE recovery capability in our product
> > SQL server - https://support.microsoft.com/en-us/help/2967651/inf-sql-server-may-display-memory-corruption-and-recovery-errors
>
> Aha, so they register callbacks for the processes to exec on a memory
> error. Good to know, thanks for those.
My other 2 cents:

I can see this is useful in other types of domains, e.g., on multi-tenant cloud
servers where many VMs are collocated on the same host,
with proper recovery + live migration, a single MCE would only affect a single
VM at most.

Another type of generic use case may be services that can tolerate
abrupt crash,
i.e., they periodically save checkpoints to persistent storage or are stateless
services in nature and are managed by some process manager to automatically
restart and resume from where the work was left at when crashed.

Thanks,
-Jue
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
