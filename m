Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E6244BDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhKJJ2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhKJJ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:28:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D832C061764;
        Wed, 10 Nov 2021 01:25:48 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w1so7830613edd.10;
        Wed, 10 Nov 2021 01:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6kyZciTW9bi6mrN/uzi/RzN2x7VmknhS78EcO/wa5NY=;
        b=FAD21DgrPSVeaW7OU2zyIFFlWwOnx4xYWW9G7LxXtLCiN+rILU8Z8WOCP19voZ2UGM
         TPZCd1q+IcUasWHy+wqSy/N21L+jyVtryvtVLaF1Zw+McwO73kd/QzzyysujShiz1EbF
         VghnZyxb+a2hwD53nvxcjUyXfLOX2DExzOMiSAhET44c1mbtCuL/rK3o3jZDEfVLI03N
         BYCdEpdJI1XbrnUoTWFTSJJm+dQ5JQS22RTqYKxZzdVVjKygt1DGxLKMj1+sAMMH/2b4
         mZq8HcCV39+c6dZWd63eBNQrzvK7oMjmmx4nPpE35UdmyfVeO4+qJSLont9l2N2eaD76
         KNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6kyZciTW9bi6mrN/uzi/RzN2x7VmknhS78EcO/wa5NY=;
        b=jfzot6zFjygfoW/jFaBouXzSifO9B0LM617j/pFYgKOXj9U5r8noAeNq9Cxu0kCaRA
         aO8oqKTL6kRuXh13RCvfjr9m9Sqa+mn/ru5xHBBWK5FQsJOjLKAY63xYXEnZxwlO28O+
         2pQbfZmKRjXqh0fypN9bojhZECAiBgbJiXxMZAM/32/lZ9GvUS4qSxnT6eb2KnqHkMSI
         i+tVLDbJgIU5SKGbjQWD/qpdNk2hDZf589jLm44lkw4iSa060cBnGX5NH7OTxegYac7R
         SiEQXfVnburZ0sJ5K7bsKmxx6WofLXAode8QSg8WU1qh5Cft5p+epjF77jS5cKGUirRI
         kKyg==
X-Gm-Message-State: AOAM533hYkuVgDZQEies+RRjX+XjdDIBWCRGQHIdJn4r/wAy38pW/Ck8
        MHPAV5lvjb/yX1gBpFpqsnAf2/YEjD9jBFaJPc198Rbj0yj9g8BV
X-Google-Smtp-Source: ABdhPJyJ6fnfK8vWTPCFgNSV/ECERf+apG9Vvkxn/LFaH4LlU/VD8dZokakTIMl8tSiRI0/03q1f7dtzLEZyPRfuBL4=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr18098997ejb.377.1636536346753;
 Wed, 10 Nov 2021 01:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com> <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
 <YYpNOMtp7Kwf0fho@kroah.com> <CAHifhD4f676jiQ52siiKQTjUFXFm6Sto8pQjF07w5y+gqrUvFQ@mail.gmail.com>
 <YYpsq/umygfTb8mM@kroah.com> <CAHifhD6K5hbpHS-X+2L=pfUe+7OpyTbB7uyh8WGbdaeBMwoYPg@mail.gmail.com>
 <CAHp75VfbYsyC=7Ncnex1f_jiwrZhExDF7iy4oSGZgS1cHmsN0Q@mail.gmail.com>
 <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
 <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com> <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
In-Reply-To: <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 10 Nov 2021 11:25:02 +0200
Message-ID: <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
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

On Wed, Nov 10, 2021 at 11:17 AM Hans-Gert Dahmen
<hans-gert.dahmen@immu.ne> wrote:
> Am Mi., 10. Nov. 2021 um 10:05 Uhr schrieb Andy Shevchenko
> <andy.shevchenko@gmail.com>:
> > On Wed, Nov 10, 2021 at 10:37 AM Hans-Gert Dahmen
> > <hans-gert.dahmen@immu.ne> wrote:
> > > Am Mi., 10. Nov. 2021 um 07:35 Uhr schrieb Andy Shevchenko
> > > <andy.shevchenko@gmail.com>:
> > > > On Tuesday, November 9, 2021, Hans-Gert Dahmen <hans-gert.dahmen@im=
mu.ne> wrote:
> > > >> Am Di., 9. Nov. 2021 um 13:42 Uhr schrieb Greg KH <gregkh@linuxfou=
ndation.org>:
> >
> > > >> > Do you have a pointer to these complex and buggy drivers anywher=
e?
> > > >>
> > > >> I am talking about the linux-mtd intel-spi driver for example, but=
 I
> > > >> feel that this gets the discussion in the wrong direction.
> > > >
> > > > This is the driver that covers all BIOSes on modern x86\64. What=E2=
=80=99s wrong with it? Why do you need this?!
> > > >
> > > > If it=E2=80=99s buggy, where is the bug reports from you or somebod=
y else?
> > >
> > > Please see Mauro's mail in this thread from yesterday below:
> >
> > I didn't get this. What's wrong with the response from the author of
> > intel-spi (since we are speaking about it, let me add him to the
> > thread)?
> > What you are trying to do is to sneak around with ugly hack behind the
> > proper subsystem's back.
> >
> > NAK as I already said.
>
> There is nothing wrong with the response. Also we are not trying to
> sneak anything into the kernel. This just is no mtd or spi driver, it
> is not even a driver. What this does is it opens back up a portion of
> memory that can not be read anymore through /dev/mem on locked down
> systems with SecureBoot enabled. This portion of memory is actively
> being used by userspace programs. We, 9elements, Eclypsium, fwudp and
> immune are among those who rely upon this to improve the security of
> x86_64 linux devices.

I appreciate this.

x86_64 starting from long time ago has more or less standard hardware
interface for BIOS chip, i.e. SPI NOR. PCH usually has a separate host
controller and we have the driver in the kernel for that (coverage of
the systems may not be 100%, but close enough). Now you are trying to
repeat something that is _already_ provided by the kernel. Correct?

> Now what happens is that more distros start to
> lock down their kernels and require signed modules. With the mtd
> driver not working on those machine to read the bios binary, you are
> effectively forcing users into less secure system configurations (i.e.
> opening up the whole /dev/mem and/or disabling SecureBoot) just to be
> able to run fwupd or other tools to assess firmware information. The
> issue of being able to assess and compare the bios binary to the one
> publicly available from the vendors is increasingly getting important
> in the wake of recent CVEs about supply-chain attacks where UEFI
> malware was pre-installed. So we are not even doing anything new here,
> you are just making life harder for everybody.

Why me? As far as I got it from above the bottleneck is the distros
which do not enable the driver. So why not go and work with them?

--=20
With Best Regards,
Andy Shevchenko
