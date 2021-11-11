Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1E344D60A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhKKLtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhKKLtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:49:43 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D17BC061766;
        Thu, 11 Nov 2021 03:46:54 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bu18so13620343lfb.0;
        Thu, 11 Nov 2021 03:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tM59iHxbjBy1nj5+saeMd6teAXT6q3TU+sgxUry514=;
        b=CIUmnieQoR1hCQLeHpZ5ND64jwPZyhb9sw95MlDQ5eOLhYH6rLx8k/XO4GZaU5pC0J
         yntni+AKB7XU+Yrs5cvLym76/9dofICQFBblyVecCUXdcxGO0PIrx2BL9b/Qnb/JTKaJ
         PtoteIt5y1jDyAdXRMudJGTFpcc0IXrx+CjgYQIC2ETL1asJE9BPI+1wLncFb3LtQbLl
         yOobghDPOAc0D1PSD4bCiJS13CitRo/gUVcLsRo8yTyV6cUMargeKtyVTgdVbQpYgt7O
         KNnswWufIic9guBst16ge/hh8eLlpQ7+QCfjGpW4e748WSXxPMSjzdkTCvPD2xHqou2V
         LAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tM59iHxbjBy1nj5+saeMd6teAXT6q3TU+sgxUry514=;
        b=4rvdfdte7VoJ4OfG5v3NpA9vdrdxqsUT71EhOM5aMxQKHkbI0LgqvH0B2KxzopRuYc
         0ZrCXuTZUjHfNvWLbG1BUVCowAtDM7azaxy/0q5OGvtcqQX8Ej7/xmwmkvvnx8Y3RUKq
         uRlrHUNKSEIZLl+WSmHUIfIOGCPvK9k/y7wJ6xftNfOLdMD5N1q6HdaNRrQJrj57l9H3
         a40u5Oih4KooAEVGsnM0h2B4a7uMAkFes1k7fm5XeNsCDdFcN3FWAoWrmcswvpou4M5i
         wFRavkDPMSwtoxAlF6tunXcBgS4/DtSpW51pILNYRkwBztVhvZji6+KnJ4OCofslxuWf
         E5tw==
X-Gm-Message-State: AOAM530p+HAGnD5oHYPRZqMd6PM3KpUEZdzI2p37P4XNxd+uPhQkF9xt
        SaDBfuh0kv7Ar3mXc7t0OygHw06NJ/ZfKZCjxXUQDylkRc0=
X-Google-Smtp-Source: ABdhPJxtFSfBVWazykokLpoBlAsxF3sPUki/hnXcuN7tS/9f15DbmBvhRTrjP6XvBP35W2yEZ5p4suuvkrTDTYHvC9g=
X-Received: by 2002:a19:740a:: with SMTP id v10mr6081459lfe.179.1636631212426;
 Thu, 11 Nov 2021 03:46:52 -0800 (PST)
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
 <YYzxWPIWFAV04LRU@lahna>
In-Reply-To: <YYzxWPIWFAV04LRU@lahna>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Thu, 11 Nov 2021 11:46:39 +0000
Message-ID: <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Thu, 11 Nov 2021 at 10:33, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> OK, I see from your patch that it uses the direct mapped read-only
> region to read this data.

Sorry for the delay in replying here. What I like about Hans-Gert's
patch is that it's always going to work on x64 -- if the system
firmware isn't available at that offset then the platform just isn't
going to boot. It's super simple, and means we can read out the hugely
complex UEFI blob without asking the user to turn off kernel lockdown
and secure boot so we can run the security verification tools. At the
moment we're in this strange situation where we ask the user to
cripple their platform security to run the platform security tools.

> Do we know what information exactly fwupd needs? I mean exposing all of
> this might not be good idea from security perspective (but I'm not an
> expert).

Ideally, fwupd needs the entire IFD partition which contains all the
EFI File Volumes. We already parse these when the user is booting
without secure boot using the Intel SPI controller and doing *evil*
hacks to make the PCI device visible. The reason we want to parse the
BIOS can be explained pretty easily; at startup we look at the TPM
PCRs and we know very quickly and easily if the system firmware event
has changed. If the checksum changed, then the firmware was modified
in some way. However, saying to the user that "checksum changed" isn't
useful at all. What we want to do is say something like "an EFI binary
called RootKitz.efi was added" or "the AmiTcgPlatformPeiAfterMem.efi
binary changed" and actually report what was done. At the moment we
can do this, but not if /dev/mem cannot be used.

> However, we can perhaps expose some of it through intel-spi,
> and make that work so that distros can enable it safely.

I think, if we're being honest, that Intel has no plans to make
intel-spi available as a RO interface of any sort. There's some sort
of hardware errata or misdesign that nobody can mention that makes the
RO access unsafe. I think it's probably more than missing arbitration.

Richard
