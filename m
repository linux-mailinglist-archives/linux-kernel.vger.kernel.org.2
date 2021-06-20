Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF073ADE3B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 13:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhFTLwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 07:52:30 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36438 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhFTLwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 07:52:25 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 80B532000AC;
        Sun, 20 Jun 2021 11:50:09 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 7F28E804D5; Sun, 20 Jun 2021 13:49:55 +0200 (CEST)
Date:   Sun, 20 Jun 2021 13:49:55 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
Message-ID: <YM8rY5hi+zuAekg+@owl.dominikbrodowski.net>
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
 <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Jun 20, 2021 at 02:19:44PM +0300 schrieb Andy Shevchenko:
> On Sun, Jun 20, 2021 at 11:36 AM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> > Over a month ago, Andy Shevchenko reported and fixed a NULL pointer
> > dereference issue introduced by commit
> >         42e59982917a ("mfd: core: Add support for software nodes")
> > in v5.13-rc1:
> >         https://lore.kernel.org/lkml/20210510141552.57045-1-andriy.shevchenko@linux.intel.com/
> >
> > A bisect shows that it is indeed commit 42e59982917a which causes boot to
> > fail due to a NULL pointer dereference on my work laptop,
> 
> Can you, please, be more specific? E.g. where may I find the ACPI dump
> of your laptop, along with other information?
> What you may prepare is (all run under root user)
> 1. `acpidump -o laptop-$MODEL.dat` (the *.dat file)
> 2. `grep -H 15 /sys/bus/acpi/devices/*/status`
> 3. `dmesg`
> 4. `cat /proc/iomem /proc/ioport`
> 5. `lspci -nk -vv`
> 
> (#2 and #3 are interesting to have in working and non-working cases)
> 
> Perhaps a bug on the kernel bugzilla would be a good container for all these.
> 
> Also it's not clear what exactly an Oops you have (I don't believe
> it's the same).

Thanks for taking a look at this issue. As it's actually a panic during
boot which triggers before initramfs is ready, I can only provide the data
for the "working case", i.e. with the patch causing the regression already
reverted:

	https://bugzilla.kernel.org/show_bug.cgi?id=213511

With commit 42e59982917a reverted, the system works just fine.

> > In my opinion, it is unfortunate that although it has been known for over a
> > month that commit 42e59982917a is broken, the bugfix (though probably not
> > far-reaching enough) has not yet progressed upstream.
> 
> Which sounds like a narrow scope of the issue and supports the theory
> of buggy tables. It may also be possible that some driver

... still, it's a regression, with a clear "git bisect" result :-(

Thanks,
	Dominik
