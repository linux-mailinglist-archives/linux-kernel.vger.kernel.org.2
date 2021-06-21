Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0803AEC60
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFUPcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFUPcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:32:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA90C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:29:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t8so3668467pfe.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gds6tYovSOr86cZquT2aU8c5nyspROJziSCZyLOf3K0=;
        b=fkQiKOBfr5BOlLxAnkKK8hOr9+4enjduv6V7fLB6+8JqwHndcgMV7M0mhhANGGDn9x
         ZrNosHhtlgsPYLKEapknsgMmoqHmswZgIZLhR+y3Uochz7jzfOTCpD45eO1kRqEt1gOO
         MWwERIRdNlJ5lmcvKExVsvqEQgVKfy6f2jW/Y1ZxyLqKe2rZvvm1ZYF4AMluw61/3PT+
         WqTS5FO0nIMamyZmQMwA5Rqa9HfdQhBQ7O6x2AEmQXkMbuD3R6UO2h0B637/iuhws59/
         wJKxLuNXyYE7NAn8AQVQ3KU2MzkzmpfiNCCK8xEJ6RywtwoIkT5UbeQZundk46rvC6q0
         xASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gds6tYovSOr86cZquT2aU8c5nyspROJziSCZyLOf3K0=;
        b=BdRYPlLp2G6Fod/tMxr3iAUbAzf30LVaXJM7R3TGiS7c+TccMmgIdLNwKEIz/e0XmE
         NwhNF+/rZkl00pVr+sfoHx95m/SPlsmM8qHBtJYXzFi165sJyNyzF/6v1/0DtPt15k3M
         IHojkPUiXd42SGF99JO0dI5oMwfPr5oPA0TbsOBEM6ekID/XEYpkpj43ImgTel0NOC3w
         M9vObQ70722cQY9flGxy4zT/PVDRBnlyfCcoSMv5qcH6SK7+um62Bqv1l9N2znRD9wvR
         6pnUyM7zQpyqeM9Wzb5sRNV2pa75tLgzNQqpefcU1cUoz0xzXX5Y4TqjbXNIDQ0lZwjq
         HgfA==
X-Gm-Message-State: AOAM530RR6JmfvV6PWyos0DVytY3YIvNBwi70uUCsmYmQP9CRmi8Zxl7
        rHgknMBN6pg/q0hlwkjnMKyXUcH3ugIHUKQi5GXzUL2mXepCBA==
X-Google-Smtp-Source: ABdhPJyg4gpN465wP9upTbg8ssR/8d9GrlE0teDXQX2kLTcbJ5SYz990V3YQHM0VgsZxbA088KJNmZsr5bZNpGtp7s0=
X-Received: by 2002:a63:5d65:: with SMTP id o37mr24320310pgm.79.1624289395377;
 Mon, 21 Jun 2021 08:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAGRSmLvaZ7av7ne-XKfZGrij1x9i5v1aH=t0ufL=Ad1193G0vA@mail.gmail.com>
 <99e0ef5a-156f-c8e5-cfc3-7c50e5e15a98@metux.net>
In-Reply-To: <99e0ef5a-156f-c8e5-cfc3-7c50e5e15a98@metux.net>
From:   "David F." <df7729@gmail.com>
Date:   Mon, 21 Jun 2021 08:29:44 -0700
Message-ID: <CAGRSmLuoP79dkE5_NgF+wiuotsYc6sV=fk=qzBVcEsjq0by5CQ@mail.gmail.com>
Subject: Re: LockDown that allows read of /dev/mem ?
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdown required by secure boot and shim signing (prevent acpi
patching), root because it's main use is a utility boot disk.   If
lockdown could be forced when secure boot active but not when not
active, that be best, but I'm not seeing that option.  The other
option maybe to modify open_port on mem.c to do the secure boot check.
However searching EFI_SECURE_BOOT doesn't exist in 5.10.x as in
efi_enabled(EFI_SECURE_BOOT) - It appears that is some other patch
that is not applied to the base, I do see struct boot_params has a
secure_boot field set, but can I access that from mem.c?  If not, is
efi_get_secureboot() function available when /drivers/char/mem.c may
be used?

On Mon, Jun 21, 2021 at 3:27 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 20.06.21 01:55, David F. wrote:
>
> > I'm finding that LockDown Integrity prevents blocks things like mdadm,
> > Xvesa, and a couple of my specialized tools.    There should be an
> > option to allow /dev/mem read access.  Is there?  There are no secrets
> > to the boot disk booted environment it's all root.
>
> Looks like conflict of goals. lockdown is used in scenarios where one
> really doesn't take any chance that code running w/ root privileges can
> do such things (there's a lot of security critical information one can
> learn from reading the raw memory).
>
> I wonder what your actual use case is.
>
> * why are you using lockdown and also running everything as root ?
> * why are you still using the old Xvesa instead of using KMS or
>   framebuffer device ?
> * why does mdadm want to access /dev/mem ?
>
>
>
> --mtx
>
> --
> ---
> Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt u=
nd manipuliert
> werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schl=C3=BCssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
