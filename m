Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE8E44BDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhKJJUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKJJUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:20:35 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A5AC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:17:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u18so2776622wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e5uPGu5JzblEAS1CcLzSNYL6amBlYkoXrgQLEnIQBlQ=;
        b=dNzF2SoFT5SicH1bCUA5VXaKFFl6M3/wlIQzHtyJnz0J+k+ubM8YU/mlR5ML+2+eIJ
         RcpJrZH+JNVLiPVjRdTjme4NqoyTtMJAhc651nZpokD18Jcs0F/5Hn0hXn+0Nt2mSHKt
         8SX0ZeFp2cXNEP5tCG7h6rqw1xflimRvd5XPR0Y5iN2jqI/TPVsa/q19dVsvtmyj8Fui
         h8WQa3fZGfr7D5MKZ8weFbR8b98Uw67aSFpZ2DB65Wy7q7Fl2Lay08KbLKF9TochA/t7
         61KqfXWP/R0K/4bO8gbCXpCXKJLHwjwBX136YPjHHTXyvugW0hINN0AvXFNDSs/iqLlR
         fhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e5uPGu5JzblEAS1CcLzSNYL6amBlYkoXrgQLEnIQBlQ=;
        b=B4LNmETFfW0DFZUiS0+2sN/kI+svhDsAWT+vBUU+0eEaauBZoEO6kzDQfk1H1F+Mt5
         V5XKtErYeOX6jOaY9U9lm9HLDlUJHeJUM+tUzhmFznFT+Vd2LBOQNobG72saghlTwsva
         kBs5Zg0vF9XB95H7tjuDR3Vj6pB/0E4WfukDAMcAeQCi74BKYbPICXz4qjoOm3ZnpIJn
         QE3MnkkF4rx5DvVB80VCQXYDKpKptPPML+T88d4IFCGzKAd2tmOVSoFNDIsCky6mRd1K
         Qsuri8jK9O4BvgumNWul/oldiziuAVcyj61AoBRSW8B12AF+WrMJu4LhnnlW/ukXYWDf
         J/2g==
X-Gm-Message-State: AOAM530iTKFKkyqX51koQ0/M7x0e0UvF0GT3DgEwcSTIaqeKEAKiGzst
        7VKul5eZZQeeCctU5jz1L8C/h6+T40kKxdP7ftKQFA==
X-Google-Smtp-Source: ABdhPJy3niOdnjU2ZgKZwX6eca/5QTPt9/8qG45pxxQT8NtDteI/2XjaBuEWfqM9wRneKGrgRuCGMGqb9+eXB4b47r4=
X-Received: by 2002:adf:eece:: with SMTP id a14mr17911724wrp.333.1636535866450;
 Wed, 10 Nov 2021 01:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com> <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
 <YYpNOMtp7Kwf0fho@kroah.com> <CAHifhD4f676jiQ52siiKQTjUFXFm6Sto8pQjF07w5y+gqrUvFQ@mail.gmail.com>
 <YYpsq/umygfTb8mM@kroah.com> <CAHifhD6K5hbpHS-X+2L=pfUe+7OpyTbB7uyh8WGbdaeBMwoYPg@mail.gmail.com>
 <CAHp75VfbYsyC=7Ncnex1f_jiwrZhExDF7iy4oSGZgS1cHmsN0Q@mail.gmail.com>
 <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com> <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
In-Reply-To: <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Wed, 10 Nov 2021 10:17:34 +0100
Message-ID: <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi., 10. Nov. 2021 um 10:05 Uhr schrieb Andy Shevchenko
<andy.shevchenko@gmail.com>:
>
> On Wed, Nov 10, 2021 at 10:37 AM Hans-Gert Dahmen
> <hans-gert.dahmen@immu.ne> wrote:
> > Am Mi., 10. Nov. 2021 um 07:35 Uhr schrieb Andy Shevchenko
> > <andy.shevchenko@gmail.com>:
> > > On Tuesday, November 9, 2021, Hans-Gert Dahmen <hans-gert.dahmen@immu=
.ne> wrote:
> > >> Am Di., 9. Nov. 2021 um 13:42 Uhr schrieb Greg KH <gregkh@linuxfound=
ation.org>:
>
> > >> > Do you have a pointer to these complex and buggy drivers anywhere?
> > >>
> > >> I am talking about the linux-mtd intel-spi driver for example, but I
> > >> feel that this gets the discussion in the wrong direction.
> > >
> > > This is the driver that covers all BIOSes on modern x86\64. What=E2=
=80=99s wrong with it? Why do you need this?!
> > >
> > > If it=E2=80=99s buggy, where is the bug reports from you or somebody =
else?
> >
> > Please see Mauro's mail in this thread from yesterday below:
>
> I didn't get this. What's wrong with the response from the author of
> intel-spi (since we are speaking about it, let me add him to the
> thread)?
> What you are trying to do is to sneak around with ugly hack behind the
> proper subsystem's back.
>
> NAK as I already said.

There is nothing wrong with the response. Also we are not trying to
sneak anything into the kernel. This just is no mtd or spi driver, it
is not even a driver. What this does is it opens back up a portion of
memory that can not be read anymore through /dev/mem on locked down
systems with SecureBoot enabled. This portion of memory is actively
being used by userspace programs. We, 9elements, Eclypsium, fwudp and
immune are among those who rely upon this to improve the security of
x86_64 linux devices. Now what happens is that more distros start to
lock down their kernels and require signed modules. With the mtd
driver not working on those machine to read the bios binary, you are
effectively forcing users into less secure system configurations (i.e.
opening up the whole /dev/mem and/or disabling SecureBoot) just to be
able to run fwupd or other tools to assess firmware information. The
issue of being able to assess and compare the bios binary to the one
publicly available from the vendors is increasingly getting important
in the wake of recent CVEs about supply-chain attacks where UEFI
malware was pre-installed. So we are not even doing anything new here,
you are just making life harder for everybody.

>
> --
> With Best Regards,
> Andy Shevchenko

Hans-Gert
