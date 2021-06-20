Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA083ADF60
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFTQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhFTQjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 12:39:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89271C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 09:37:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m2so12155490pgk.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIkqdX5qDYRm2dY070GPvz04fF0I4MWj7fsh0bVpBSc=;
        b=WcOdK46qlF9zh6lXvUJKZ/S8nhWyMv/TZhgk6MCUIbhPtoRhhzT5aW7gfV9tB5abx+
         eTPMVYnsL5krMwN0QhdheuvcdRVAswVYK2nAu3n/8VDNfNFhX6BBg4XqtSfyo3WUd8BN
         1jYL3ahMtfJvlEPFoKwPE3vUkDbxC4eK58sLPG5wGwcZdR1ClV5z5bQ1J0CtjkcZ8WPj
         qnIFA1AQCY1r7TeGGgRalXvo8BviZoYU6o6a8Zw1Xe3wrmR7we296Q04MLbtIewrp+mN
         x/VC6T1JR7QcH8cFn1xxgHMRXNRc6p8uPP47MpT6h6dzifHA9w9mFLRuYxf5lprdgqU7
         EtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIkqdX5qDYRm2dY070GPvz04fF0I4MWj7fsh0bVpBSc=;
        b=rRqQ0AzTEMSXfmO25u0d5YQVMOFa6ot0RLlZZkwPjX6oWf4zaUEOZ9LhB/K3DJAlwQ
         l6juYEWwuQQGbFm8tiqvlzLgBjL8X6AK68yHzD2i9jpjkUiku/k2DA2DA3YkmLHZ0R0K
         rTnUJamSuGjST4a3J9H/3bcOJHiiMPSSgqSuTLkmZuysqSk67BIfvhKgbZjIiDA8IGCq
         J3Wx3J1J+TwzWbIxnf2SW3sqra5xXHmtktCpDHaw1eQSoiPlY8dQireuTkbPC9xICpcS
         cC8haL1S5zDuz/Knvp69PdeAUxtBApOC8mX1qCCNsv2WFrS12iJqxZyNQioRWYIrINEH
         msBg==
X-Gm-Message-State: AOAM530Iz1oam61PiuO2PIyoTxWp0ih4qTrhGW9sGUYGGe2Sn4/1kmX+
        KqfEA0kCCAejZ4pGMEaAPypRSB+L6Wf+9tMRuZNB88bNgU0p/Q==
X-Google-Smtp-Source: ABdhPJznDdZespmj0+7/F35IDXlN7/DBZSlUiIfIDRJdCX2CSZbd3uj/sd6HH/j5C5uluj5FOT4oezdVZ2ad6od9j7Y=
X-Received: by 2002:a63:f10b:: with SMTP id f11mr19696397pgi.203.1624207038975;
 Sun, 20 Jun 2021 09:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net> <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
 <YM8rY5hi+zuAekg+@owl.dominikbrodowski.net>
In-Reply-To: <YM8rY5hi+zuAekg+@owl.dominikbrodowski.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 20 Jun 2021 19:36:42 +0300
Message-ID: <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
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

On Sun, Jun 20, 2021 at 2:50 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Am Sun, Jun 20, 2021 at 02:19:44PM +0300 schrieb Andy Shevchenko:
> > On Sun, Jun 20, 2021 at 11:36 AM Dominik Brodowski
> > <linux@dominikbrodowski.net> wrote:
> > >
> > > Over a month ago, Andy Shevchenko reported and fixed a NULL pointer
> > > dereference issue introduced by commit
> > >         42e59982917a ("mfd: core: Add support for software nodes")
> > > in v5.13-rc1:
> > >         https://lore.kernel.org/lkml/20210510141552.57045-1-andriy.shevchenko@linux.intel.com/
> > >
> > > A bisect shows that it is indeed commit 42e59982917a which causes boot to
> > > fail due to a NULL pointer dereference on my work laptop,
> >
> > Can you, please, be more specific? E.g. where may I find the ACPI dump
> > of your laptop, along with other information?
> > What you may prepare is (all run under root user)
> > 1. `acpidump -o laptop-$MODEL.dat` (the *.dat file)
> > 2. `grep -H 15 /sys/bus/acpi/devices/*/status`
> > 3. `dmesg`
> > 4. `cat /proc/iomem /proc/ioport`
> > 5. `lspci -nk -vv`
> >
> > (#2 and #3 are interesting to have in working and non-working cases)
> >
> > Perhaps a bug on the kernel bugzilla would be a good container for all these.
> >
> > Also it's not clear what exactly an Oops you have (I don't believe
> > it's the same).
>
> Thanks for taking a look at this issue. As it's actually a panic during
> boot which triggers before initramfs is ready, I can only provide the data
> for the "working case", i.e. with the patch causing the regression already
> reverted:
>
>         https://bugzilla.kernel.org/show_bug.cgi?id=213511
>
> With commit 42e59982917a reverted, the system works just fine.

Is it possible to have any traces of the panic to be logged / photoed / etc?

> > > In my opinion, it is unfortunate that although it has been known for over a
> > > month that commit 42e59982917a is broken, the bugfix (though probably not
> > > far-reaching enough) has not yet progressed upstream.
> >
> > Which sounds like a narrow scope of the issue and supports the theory
> > of buggy tables. It may also be possible that some driver
>
> ... still, it's a regression, with a clear "git bisect" result :-(

I understand and I'm looking at this...

-- 
With Best Regards,
Andy Shevchenko
