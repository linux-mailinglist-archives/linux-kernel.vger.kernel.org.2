Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2593C6170
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhGLRGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:06:54 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47630
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235290AbhGLRGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:06:51 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 39F2E4049F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626109442;
        bh=j1yu8v62NE8hSzcaxcJyNnDW0H1HI2nT8P8t/J9krXw=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=Os3eNUkeHiDlRLg4rsDSA6tWSM19aylGZ3Yl1QECimek8PfI0bc3PJg1gFhnnaSF6
         s+a4//roWV6VRh273KKuk6aPH880hyv3ldv1rWGAHO3AarLQQeGEuQvyTetEQ1Q7qB
         J0nJuzvljezno9k3/OkuYmHvqM0tKqc8PPDoVCJ02AGItYEzSKmQkktbm18jXwqHOF
         PY8BWnPQCyi0PBbM4wXc5yawJ+VS/Du3txJFODunI11kExQEU1nz8mPeuBK4qYI9Qf
         RzKNX0I5nQH1j510ZIjM+ZalqIzxe2GoQC/5pgoE10iI42mUFcwqw9D46RSx9O3aTV
         1QOgv4X2nloYw==
Received: by mail-ej1-f72.google.com with SMTP id k1-20020a17090666c1b029041c273a883dso5258498ejp.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 10:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1yu8v62NE8hSzcaxcJyNnDW0H1HI2nT8P8t/J9krXw=;
        b=eKkyCgOkAi9GG51iAi2qPiv16ReIVShoIlMVYHTKbJxC6l57sxkd37Y1tO4dLeEAvP
         opYS1uC87RynjTKIE6ON/PfDa4NoKCX8uDtRFASiBezNXXTYeRooLl0fbDGgjpT//xGl
         U1dJRR4Es1YpwyN58+WQi8f0bdqQEoRCPYkaOJuvkZC9InJqCObTDoG55BqPt9EZsWMW
         kMKAdKccgYc3Cguo0JlYNpmB9e8VoBQlE2gYzSotlZhzxroO70JMTamnuqsgAYY8xOm/
         1D/BB88rWIT95vG38K7Hv5f7oNQKLUusfZlaJKEwVqm8V0uoayMj78Cxxrpj6uY3FI7r
         7Uig==
X-Gm-Message-State: AOAM530eVxs7vypJaaaRCnj0uAuI+F5IJRLHtZKDnQ3nAAETYrdw6RQU
        cnlylVIYKKm9BXNcs+DRfLcQijOw5d5IIgl45vgxc9n39WciwidSEtjMM6wS+aALUvv2jn4yIvN
        7AyfnNtkalt35ImF9mPYePudkw711E/vWQvIDkkPXHciSMc2cDaDJQIHARA==
X-Received: by 2002:a05:6402:951:: with SMTP id h17mr17003534edz.198.1626109441938;
        Mon, 12 Jul 2021 10:04:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTXI3cbaD/E41VefuWhkSUUfN0pYkjZ9tWnGXGbl3WaK94as6kUHXt4WHwvWlIazszQFq/5FWfVVnTWcpdZZI=
X-Received: by 2002:a05:6402:951:: with SMTP id h17mr17003516edz.198.1626109441738;
 Mon, 12 Jul 2021 10:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <b8db79e6857c41dab4ef08bdf826ea7c47e3bafc.1615947283.git.josef@toxicpanda.com>
 <CAAd53p5Vh_+tUeEQx3xf_aLiCiKP1u5Y3VgYCUzZ82Kgtr-iYw@mail.gmail.com>
 <bebcaffc-d485-912d-0c42-c0781f9c7603@toxicpanda.com> <CAAd53p7eJk9EtMTLjB5i7RdoKA3WS1W4TRjQs08adi7iAux_jQ@mail.gmail.com>
 <78dfcd55-442d-dcc0-c37f-5576f65f91b5@toxicpanda.com> <CAAd53p6Lp8+S0yjWi=MikQJ_zywiWamUS5p19oKoqB6uYW8jzg@mail.gmail.com>
 <0cd8b39e-3feb-87b8-e172-70b07692b82a@toxicpanda.com> <CAAd53p6=dGwtTVBcQuO+Rvt0nZ2Ck_OXtR=um=S2p=OjNXnH8w@mail.gmail.com>
In-Reply-To: <CAAd53p6=dGwtTVBcQuO+Rvt0nZ2Ck_OXtR=um=S2p=OjNXnH8w@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 13 Jul 2021 01:03:49 +0800
Message-ID: <CAAd53p6E8rMDHDRRmvZKyt7YJ_b5m3RPQH312RU0d7-tbXu6VA@mail.gmail.com>
Subject: Re: [PATCH][RESEND] Revert "PM: ACPI: reboot: Use S5 for reboot"
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 12:23 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Fri, Mar 19, 2021 at 3:02 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On 3/18/21 1:42 AM, Kai-Heng Feng wrote:
> > > On Thu, Mar 18, 2021 at 1:25 AM Josef Bacik <josef@toxicpanda.com> wrote:
> > > [snipped]
> > >> "shutdown now" works fine with and without your patch.  Thanks,
> > >
> > > Rafael,
> > > Please revert the patch while we are working on it.
> > >
> > > Josef,
> > > Can you please test the following patch:
> > >
> >
> > That made it work fine.  Thanks,
>
> So there are things depend on reboot or shutdown to carry out
> different behaviors.
> Can you please find whether there is any code path uses SYSTEM_RESTART
> or SYSTEM_POWER_OFF that leads to different behavior? Most likely
> happen in a driver's .shutdown callback.

A gentle ping...

>
> Kai-Heng
>
> >
> > Josef
