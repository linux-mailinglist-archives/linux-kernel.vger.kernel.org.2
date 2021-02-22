Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255613219BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhBVOGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:06:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43932 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhBVNNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:13:33 -0500
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 787F020B57A1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:12:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 787F020B57A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613999566;
        bh=nPUkWMtEqtt3EdWh4OMmYqe+dbCvxFMStlcejHtdICw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UxPW1VUI1TbVfJCsYJj4ZKEZLxJc7ePq5mGY54YzIz1eeNaqpCoW33sZzVoKJNdJD
         2FG+Tplv3PG2lBWC8wtZ3rgwF2mgSPfS4aGXPCSsWlTNRPiJ9f9iMjYDJfdZQzKZoB
         iiUN+nAzLkChBO8gSfIQQdKDiI+bUsAOdncwbkxo=
Received: by mail-pg1-f182.google.com with SMTP id t11so10181121pgu.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:12:46 -0800 (PST)
X-Gm-Message-State: AOAM532HsxLk0JiFyGfqEm03QUS3RZvAUd3KCkLCTyHquZJOAqFWjOPJ
        PMH7Jqc2dhyTb1AWJNK1a4CYahH3t1og5vp4GRo=
X-Google-Smtp-Source: ABdhPJzuWzL2Na+RYT/5s+nUYI1G1s9IrFVcAoklprIrtkLTw7NO98lkFde5Dz230MjrWHwEWuLS68UlMNSj3LY4vkk=
X-Received: by 2002:a62:5a43:0:b029:1ed:263a:b05c with SMTP id
 o64-20020a625a430000b02901ed263ab05cmr17087161pfb.16.1613999565998; Mon, 22
 Feb 2021 05:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20201110202746.9690-1-mcroce@linux.microsoft.com> <20210222100325.GA14587@amd>
In-Reply-To: <20210222100325.GA14587@amd>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Mon, 22 Feb 2021 14:12:10 +0100
X-Gmail-Original-Message-ID: <CAFnufp1Gu7MV03hADAm2gvveHaeR7X_td2EmyEpxto1oW3sZvg@mail.gmail.com>
Message-ID: <CAFnufp1Gu7MV03hADAm2gvveHaeR7X_td2EmyEpxto1oW3sZvg@mail.gmail.com>
Subject: Re: [PATCH v4] reboot: allow to specify reboot mode via sysfs
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 11:03 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Tue 2020-11-10 21:27:46, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > The kernel cmdline reboot= option offers some sort of control
> > on how the reboot is issued.
> > Add handles in sysfs to allow setting these reboot options, so they
> > can be changed when the system is booted, other than at boot time.
>
> We already have a reboot syscall, do we need sysfs interface, too?
>
>
> > +What:                /sys/kernel/reboot/mode
> > +Date:                November 2020
> > +KernelVersion:       5.11
> > +Contact:     Matteo Croce <mcroce@microsoft.com>
> > +Description: Reboot mode. Valid values are: cold warm hard soft gpio
>
>
> > +What:                /sys/kernel/reboot/type
> > +Date:                November 2020
> > +KernelVersion:       5.11
> > +Contact:     Matteo Croce <mcroce@microsoft.com>
> > +Description: Reboot type. Valid values are: bios acpi kbd triple efi pci
>
> what is difference between mode and type? What is difference between
> cold and hard for example? WTF is gpio?
>
> > +What:                /sys/kernel/reboot/cpu
> > +Date:                November 2020
> > +KernelVersion:       5.11
> > +Contact:     Matteo Croce <mcroce@microsoft.com>
> > +Description: CPU number to use to reboot.
>
> Why should user care about this?
>

Mode is the reboot mode (soft, warm, cold, gpio), and type is an x86
specific type, (bios, acpi, uefi, etc.).
I never used GPIO reboot but it's used by some ARM devices.

I didn't invent anything from scratch, I just transposed the settings
available from the kernel command line (see
Documentation/admin-guide/kernel-parameters.txt) to sysfs.
Everithing was already tunable before, like the CPU used during reboot.

-- 
per aspera ad upstream
