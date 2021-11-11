Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430A744D932
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhKKPeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbhKKPeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:34:18 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1DCC0613F5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 07:31:28 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id k83so2610391vke.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 07:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G3bu+PH6Yux9LvJiYt0Dv70QMkjE3dN3AsT/rb8XYAc=;
        b=VOh6c5T2eSrr3tQeaJDXu+94vpaP1ryfB4R3kU47DDiktzWv4TI4kHDXgP7d044BeD
         gmTU11iII/OPf2jsD3YiBrqz96rdKaMULH6FVgpfk0+wwNkEcXXW+Evi4flE88+R2bFH
         YhXMISkDz5tSBkz9DKMXEc1yfM288A/x+pmlYMTpaLa0JcUIcTwnhXtPZmMbXZxhDDbN
         vp3WzkRZXpmfBQEnS+V1ene4QG3u1TOj9l1RDrlKgr1lwD5D5lm3MuPyZTp827yJiCTi
         rDxnR6xW2zmrP7ZKsxD2ASzgBzxMTc8+K9br90G5O3ukjpzn0ieIpy3M7hJXSwOAVBv2
         aTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G3bu+PH6Yux9LvJiYt0Dv70QMkjE3dN3AsT/rb8XYAc=;
        b=N6sXUGBz73CtvPD1aNI8XJgbmiZW0WPaAtMqwRcPohtRw1COEteqI/iMjtkvBFexIR
         OhmAsXRZues9J1jBfgx9NRbNX1p81lZ4erHNwrjqlGtojK9aagB3lUfCwYrspgdsMruT
         4FW1eDvb1XOaQUU8NBJidWOumYmnpkESTMBq5DoeA8QTJiE6vb0yybAq/V+J641jzirL
         DfvzmqwZUzKwzEYN+S4Xr87Dc0knd75GBg+SYaLpXM2EyYeX0vWtd5+pqsAIoyRdfJNf
         SmDqr/AoR5+nsYyRIosY39np7tH+/IgPfzJfjJqmWLkXAecxPbAqQk5nXNE3Lu7sNIfx
         EQlw==
X-Gm-Message-State: AOAM531QxuQ5FLjY9BMqUVR7avXNeSa9SVep0v4UrIJlNKzEEu+uQkX0
        qaY+UPcY6SCBIpdtQ+ruQaoGtmnHOwhJwV233EN1KhmALm8=
X-Google-Smtp-Source: ABdhPJzoz1I9aOmFDH7fzZwUnI6BDXLSCK52gKv5ifJbGjUqjSq/lq6+d2sDBabF6YQmsZJaOrayu+3ILobqLKdci1c=
X-Received: by 2002:a05:6122:790:: with SMTP id k16mr12310963vkr.26.1636644687779;
 Thu, 11 Nov 2021 07:31:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna> <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna> <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
 <YY0UCHtf8SAvGHTY@lahna> <CAD2FfiF=7H7RuAdrSrrr57JF6YG=pb5jw2QMgBDQsAEwgasYLw@mail.gmail.com>
 <YY0b01g+z3lkO4w2@lahna> <CAArk9MOxZaK2WqsuPR4GbgdxSnUBqgO1KZ8OT=+siksYq+2PxQ@mail.gmail.com>
 <YY0xZjjGjNq+kUXi@lahna>
In-Reply-To: <YY0xZjjGjNq+kUXi@lahna>
From:   Mauro Lima <mauro.lima@eclypsium.com>
Date:   Thu, 11 Nov 2021 12:31:16 -0300
Message-ID: <CAArk9MMh575-JwrMrn=NF7hBk9t-mzjc7Uz1BwjWFZELsWtXXg@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
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

On Thu, Nov 11, 2021 at 12:06 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Thu, Nov 11, 2021 at 11:42:52AM -0300, Mauro Lima wrote:
> > > > > Having said that the hardware sequencer used in the recent CPUs should
> > > > > be much safer in that sense.
> > > >
> > > > FWIW, I'd be fine if we had RO access for HWSEQ flash access only. If
> > > > I understood correctly that's what Mauro proposed (with a patch) and
> > > > instead was told that it was being rewritten as a mtd driver
> > > > completion time unknown.
> > >
> > > I think Mauro proposed something different, basically exposing RO parts
> > > of the driver only.
> >
> > My patch was intended to move the read functionality of the spi chip
> > to be able to compile the driver with just that and then remove the
> > dangerous tag. So we can use that functionality to read the flash, I'm
> > missing what is different from the things being discussed here sorry.
>
> I'm hinting that we could make this "non-DANGEROUS" for hardware
> sequencer parts of the driver. Basically moving only the software
> sequencer bits as DANGEROUS or something like that. The hardware
> sequencer is much more safer because it does not allow to run random
> opcodes.

I'm aware about hw and sw sequencer diffs, my patch aimed to split
reading functionality because we thought that the issue was related
with write/erase ops plus the writable module param (this mixed with
the sw sequencer could be the bug?). I totally agree with the hw
sequencer path and I'm willing to help to make this happen.

> In case someone is unfamiliar with this, the Intel SPI hardware
> exposes two interfaces through the same controller. One that is called
> software sequencer and there is a register of "allowed" opcodes that
> software can use as it wishes. This register can be locked down but is
> not always. The second interface is the hardware sequencer that only
> exposes higher level commands like read, write and so on and internally
> then executes whatever opcode the controller got from the chip
> "supported opcodes table" (SFDP).  The recent Intel hardware, all
> big-cores, only provide hardware sequencer and the software one is not
> even available.
>
> Regardless of all this the driver needs to be converted from MTD to SPI
> (SPI MEM) before we can add any features. I'm planning to send v4 of
> that series next week.

Good luck with the patch.
