Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD03ADE26
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 13:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhFTLWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 07:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFTLWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 07:22:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C36C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 04:20:20 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso8518583pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6Jin+oRoPzWqmnMdtDjz2qXrxn1uIUsQeJZkd8zSLY=;
        b=iYfV60Ankpmvmb5migldwlyEp8txyMoTq0+7KSQgkqccj4AwU7Kgn3KGtR6osF/nS/
         z2wp/0UCHdjUH32D2LMrx62ty8Ts4bUQTc76UIrPkaosCeJiq2OsMqm4KvreaGQwsfBV
         8Ot5B8hTNOgvWbeJ+JJ0s1vOvzxzQEqf7zB4f+nVCJVttnphuu+aRPkfL6FEfn6nUJsM
         3E62N3kExqIC0abjZJuLtXOLW1qoTGhH6vriGzaOMk0OuvW1/QUlSyGQQzRIHxYP9RQy
         m1WA4TaQc5BVVoYQzCbAF3bjkOOPYcsXclum9Pjd6QyEl/lzhFaAJnR4TtlXoP8fN4oc
         Cs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6Jin+oRoPzWqmnMdtDjz2qXrxn1uIUsQeJZkd8zSLY=;
        b=iN0HJ1rmabv66ijTIdj75yjC5xBhSGbW0bua6uOuKsDUjxScwIDgjDRLE/oqXOG8b+
         S8PUcc78JTTdzH4EeQxSi/BPNCwN5SoEXVj0As7t0e3S4zBghDbgUI+2bWRA40cgC4FC
         SCz4Gtaw58iY8cvy/xmifsnUAoABZeg3fI1NgPRQmCr/B3bh6ZG/TqNukbTESY2aqcWr
         qrJI2/6WawGPVhWO1wBvBcVTxukEr4xbGpEzHX3a4yQCy1cS5iOH6JcKYHldwXU64P5B
         uKRl57jTao4nY8MMbrYMgRU6H+Woor34XJfgyrp8VQJE7NAwDmekYOIr1GOAs5FA21Ma
         UTXQ==
X-Gm-Message-State: AOAM531VL4Cj6zKQiuAJMA/41QI9Y+vUvgRjkASd5J3QrAiep6M08dKK
        qlOoJfFryWIu0pm8ts5zIG432fotv1PmmdZ6U74=
X-Google-Smtp-Source: ABdhPJwR4yL6qLFrcdv4b1gVNkoKK2N25cLT91N+3RRilFosno2nLqLCjJnk3lix+OEJXUupKd3yG7eASebXJPO2LPw=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr32726301pja.181.1624188020256;
 Sun, 20 Jun 2021 04:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
In-Reply-To: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 20 Jun 2021 14:19:44 +0300
Message-ID: <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 11:36 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Over a month ago, Andy Shevchenko reported and fixed a NULL pointer
> dereference issue introduced by commit
>         42e59982917a ("mfd: core: Add support for software nodes")
> in v5.13-rc1:
>         https://lore.kernel.org/lkml/20210510141552.57045-1-andriy.shevchenko@linux.intel.com/
>
> A bisect shows that it is indeed commit 42e59982917a which causes boot to
> fail due to a NULL pointer dereference on my work laptop,

Can you, please, be more specific? E.g. where may I find the ACPI dump
of your laptop, along with other information?
What you may prepare is (all run under root user)
1. `acpidump -o laptop-$MODEL.dat` (the *.dat file)
2. `grep -H 15 /sys/bus/acpi/devices/*/status`
3. `dmesg`
4. `cat /proc/iomem /proc/ioport`
5. `lspci -nk -vv`

(#2 and #3 are interesting to have in working and non-working cases)

Perhaps a bug on the kernel bugzilla would be a good container for all these.

Also it's not clear what exactly an Oops you have (I don't believe
it's the same).

> where "intel-lpss"
> is bound to
>         00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 (rev 21)
> and fails to bind to INT3446:

Yeah, this is confusing (see above for additional information needed).

> [    6.048087] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> [    6.050625] idma64 idma64.0: Found Intel integrated DMA 64-bit
> [    6.109112] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> [    6.111348] idma64 idma64.1: Found Intel integrated DMA 64-bit
> [    6.172229] intel-lpss 0000:00:15.2: enabling device (0000 -> 0002)
> [    6.174353] idma64 idma64.2: Found Intel integrated DMA 64-bit
> [    6.231865] intel-lpss 0000:00:15.3: enabling device (0000 -> 0002)
> [    6.233845] idma64 idma64.3: Found Intel integrated DMA 64-bit
> [    6.287492] ACPI Warning: SystemMemory range 0x00000000FE028000-0x00000000FE0281FF conflicts with OpRegion 0x00000000FE028000-0x00000000FE028207 (\_SB.PCI0.GEXP.BAR0) (20210331/utaddress-204)
> [    6.287704] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> [    6.289760] intel-lpss: probe of INT3446:00 failed with error -16
>
> Unfortunately, the patch by Andy Shevchenko (applied on top of Linus' tree)
> does not fix the issue. A complete revert, however, does fix the issue, and
> allows my laptop to boot again.

The problem my patch fixed (besides logical issues) was to work around
_buggy_ ACPI table. If anything, I guess the firmware is to blame for
this, but let's see the actual data before judging and getting the
right course of action.

> In my opinion, it is unfortunate that although it has been known for over a
> month that commit 42e59982917a is broken, the bugfix (though probably not
> far-reaching enough) has not yet progressed upstream.

Which sounds like a narrow scope of the issue and supports the theory
of buggy tables. It may also be possible that some driver

-- 
With Best Regards,
Andy Shevchenko
