Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F320B44BD91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhKJJH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhKJJHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:07:55 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EDEC061764;
        Wed, 10 Nov 2021 01:05:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f4so7568025edx.12;
        Wed, 10 Nov 2021 01:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hIFQMP97lXgcfF/c8vV0niSbjCH1d4Of4vsIHv9JKyo=;
        b=G01fsO/wDgLA6L+2gBeDX3tSg3SBeWZm+rL7R4Qpg18CyPeoEk4UckOOri+qGWUU/o
         lo+LdKZreHWiwpw8a6287qnZvRycxfcOC1L5HgqhlFfQ4gR84oFSvQPAvmh1PWePnnre
         qDTS6iY7W7a/0xP1b4URyTBLwvrxHpEmEpXEwHkPgKBZ5PKEEaEnao2mrrB3cTy8NFNM
         hREyjbkebudx4O02g/OveCIHbao8Okhy1do0/+fXD6/Jsg2FHFyK4W3HfDW3ZnxWFX8J
         AgterQiO1nrWLKbZvHvfnmveZg4j2o2on74zI1tBQmCmj+3zXhIcE0F01o3PdYLa45S9
         0lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hIFQMP97lXgcfF/c8vV0niSbjCH1d4Of4vsIHv9JKyo=;
        b=nzw14t25P9/1/4IbLyATxaEx3tKCmNWyBUVgQYndPKlXstn3oYbPVmIncWaAvBWfYV
         NM9GQuasPZ1yXySipJQm96lgdh7jsQhYUeXluF8FiLyW9I4fLNn6OSLbDXmJqamMUEs/
         2OjFyL1gfxyCVz+WCdk7JGgRzfU7HBqnngaze1M8g5jWJX7hN456gE6fNVi07bsAdJii
         E0QISeRgT5nDz1Gkt4yROSPDIM3VbusEyCwy0be08YtuFkizBTWP9Vjlq5aoVGmS5nDV
         q1H119a4SnHVTAq82powpr564kbzVpH9/zh7Jp+23ZmaBEwb32ZxbxZ4PwwJz44FtStN
         9aEw==
X-Gm-Message-State: AOAM530DQ+o0dxp7VfiGnI0+ZBFYk8FvH2DS3n8JqzG/QsXQ+AIHhHT1
        i92vxAVdUcvwuljDBzoFbh1JZNMedkR+oeJVIXk/8I9a9iBr6g==
X-Google-Smtp-Source: ABdhPJxPnCtP0Gi7FXft3hNhtYdID7QFXnaTineAVYD0OAEfwrCPbrQW/UM3+bjEnyIVgok+c8SwcucP314wg/u0T+Y=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr17872542ejq.567.1636535106048;
 Wed, 10 Nov 2021 01:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com> <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
 <YYpNOMtp7Kwf0fho@kroah.com> <CAHifhD4f676jiQ52siiKQTjUFXFm6Sto8pQjF07w5y+gqrUvFQ@mail.gmail.com>
 <YYpsq/umygfTb8mM@kroah.com> <CAHifhD6K5hbpHS-X+2L=pfUe+7OpyTbB7uyh8WGbdaeBMwoYPg@mail.gmail.com>
 <CAHp75VfbYsyC=7Ncnex1f_jiwrZhExDF7iy4oSGZgS1cHmsN0Q@mail.gmail.com> <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
In-Reply-To: <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 10 Nov 2021 11:04:21 +0200
Message-ID: <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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

On Wed, Nov 10, 2021 at 10:37 AM Hans-Gert Dahmen
<hans-gert.dahmen@immu.ne> wrote:
> Am Mi., 10. Nov. 2021 um 07:35 Uhr schrieb Andy Shevchenko
> <andy.shevchenko@gmail.com>:
> > On Tuesday, November 9, 2021, Hans-Gert Dahmen <hans-gert.dahmen@immu.n=
e> wrote:
> >> Am Di., 9. Nov. 2021 um 13:42 Uhr schrieb Greg KH <gregkh@linuxfoundat=
ion.org>:

> >> > Do you have a pointer to these complex and buggy drivers anywhere?
> >>
> >> I am talking about the linux-mtd intel-spi driver for example, but I
> >> feel that this gets the discussion in the wrong direction.
> >
> > This is the driver that covers all BIOSes on modern x86\64. What=E2=80=
=99s wrong with it? Why do you need this?!
> >
> > If it=E2=80=99s buggy, where is the bug reports from you or somebody el=
se?
>
> Please see Mauro's mail in this thread from yesterday below:

I didn't get this. What's wrong with the response from the author of
intel-spi (since we are speaking about it, let me add him to the
thread)?
What you are trying to do is to sneak around with ugly hack behind the
proper subsystem's back.

NAK as I already said.

--=20
With Best Regards,
Andy Shevchenko
