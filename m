Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1367444D6C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhKKMts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 07:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhKKMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:49:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E9AC061766;
        Thu, 11 Nov 2021 04:46:56 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g14so23756615edz.2;
        Thu, 11 Nov 2021 04:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rmYbMDi9X6r+8cr3nDRypgiDDT92VNxHsOWoaavVZTE=;
        b=MotrSybExBfUW/MIKUe2sajkzYlRGgw3a31f7o6XhtC9oty5DMndYTKJvgisK/y680
         jJleFoSazfg0JsaT0BZE4GueDNuSw40VwMOogfzvXvk3aT8k/sH0moOFcwJ6tSPyBzBu
         K6ZK6PBPZq9ZxM7YVkU8faSF7/a7wUYAPYJrf+lsaA+Ju6ppbvl3A/jbEYOBlkHM1zrz
         r02FVb8W8aduUA7/cT8XeTeo+as/2SGXpFwzPhswPlq1tRuTVQLJMEACd/EA6Z+pj8p9
         F2lu3aXO+e0qdXyQnAN175M3XkGmy8ytZ7IO8MNkGeX8xuOcMFXHLkqMND6QoVDTohGF
         BmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rmYbMDi9X6r+8cr3nDRypgiDDT92VNxHsOWoaavVZTE=;
        b=CsBqMEht8iP0JG6M2LwW0HIACAXST1z8DDlexvm0vVgYBSlQ+oPzhv4e8u+p9kLhRb
         GHpHBm378Qo506DQET+jGpLCxiZxa8XBGbAiLOFYHPUPWmVKKknAgA0cisO4bBFYDxo6
         tHQi8Tpw4a2PEwmP4KGdhLxFUbxGnotp9p7XjGzQtLW3grsytqRKSK82pYQfL/6KTOM7
         S1Mo5Zfh4N9aToUykpcyJRxEKwPQBDPDcUTvBvxx9YAuF+FLue530gBFEQBzXYsSgSg+
         Zu0b5lKdfz+vMfq+/VHFs1ON/6/Tnjk94qCutMN4IWgWJw/YyWL/lVZviElXHFS9qKQV
         41MA==
X-Gm-Message-State: AOAM531v1XHJ+z+jMknN6NEIP/JbPuQW1xC2YlulO51X8hu9gjyW8yA0
        7ibYHTIIVmmJlbX0VkmedaeMb2JVda2J+ceUPG0=
X-Google-Smtp-Source: ABdhPJwoOXqdX/osTzOMBxsKHW0vU01IY360A/EsL0XRDhTLLcFUL19x7sqimmocmsHBHAdmRXdaFPUM+A/l84UAOuc=
X-Received: by 2002:a05:6402:1801:: with SMTP id g1mr9532440edy.107.1636634814997;
 Thu, 11 Nov 2021 04:46:54 -0800 (PST)
MIME-Version: 1.0
References: <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
 <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
 <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
 <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna> <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna> <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
In-Reply-To: <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Nov 2021 14:46:10 +0200
Message-ID: <CAHp75Vcp=hC1oL5FBQDDFe8EBxWB9Po4FKNS9ZGtD3q-yQPtAw@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Richard Hughes <hughsient@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 1:46 PM Richard Hughes <hughsient@gmail.com> wrote:
> On Thu, 11 Nov 2021 at 10:33, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:

> it's always going to work on x64 -- if the system firmware isn't available at that offset then the platform just isn't going to boot.

Well, it's _usual_ case, but in general the assumption is simply
incorrect. Btw, have you checked it on Coreboot enabled platforms?
What about bare metal configurations where the bootloader provides
services to the OS?

> Ideally, fwupd needs the entire IFD partition which contains all the
> EFI File Volumes.

Well, can't it be part of the EFI subsystem in the kernel then? (+Ard)

> We already parse these when the user is booting
> without secure boot using the Intel SPI controller and doing *evil*
> hacks to make the PCI device visible. The reason we want to parse the
> BIOS can be explained pretty easily; at startup we look at the TPM
> PCRs and we know very quickly and easily if the system firmware event
> has changed. If the checksum changed, then the firmware was modified
> in some way. However, saying to the user that "checksum changed" isn't
> useful at all. What we want to do is say something like "an EFI binary
> called RootKitz.efi was added" or "the AmiTcgPlatformPeiAfterMem.efi
> binary changed" and actually report what was done. At the moment we
> can do this, but not if /dev/mem cannot be used.
>
> > However, we can perhaps expose some of it through intel-spi,
> > and make that work so that distros can enable it safely.
>
> I think, if we're being honest, that Intel has no plans to make
> intel-spi available as a RO interface of any sort. There's some sort
> of hardware errata or misdesign that nobody can mention that makes the
> RO access unsafe. I think it's probably more than missing arbitration.



-- 
With Best Regards,
Andy Shevchenko
