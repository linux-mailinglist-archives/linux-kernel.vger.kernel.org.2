Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59AA422323
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhJEKOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhJEKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:14:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34987C061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 03:12:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y15so18337460lfk.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fd2bVG3T2aDLLsUGg65DNy9VZxuxLh/QslDXMizwJK8=;
        b=Ez5mYoeEnxP72wgv6au1eWbZZvt7siRLWpI9GsKBKBLepayHvuXHhoBFqZfseuORyY
         h1HA3jABRlKS8tuWaG2UUN4XzRb4Jizd3n+k9ryDkBNUpWyPDxOui77+S9ZqKc3aD0eI
         IhRttz3xOc3IW3LwIjPPFZxivXeffhFA5txSbttH+iOS9g7NO3HrB8pvutVsiiQaPsIG
         1ySZ3kqO9o7Bd1T6MoTMLAQEKlN8iKHV+m5My4Owt13LGlpQFTv1OWpU6AdxUVVKm/bP
         7UXovG3irUPeGNxrJ6iwxCqh0qKa2utVcRhWtScOoJ2MkJj+6XNlVCKFmGij7agmbAVh
         KBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fd2bVG3T2aDLLsUGg65DNy9VZxuxLh/QslDXMizwJK8=;
        b=DDCfB0W1oKF4o0kOF7xE9RvuhqKy6gm0TABJZ9icWbzilhU29yrULq67db7kDHbrRv
         f3+pr3A0N+93QYjUXwl6OY+aCb3zK+aIuwfG14UE3HDtdRjgiTFOS2oicG/jvSOxWCT8
         PdLSLOS5epoF1vcOFsNPaScUXXy0wYdxRDd6wfvV9CYSgYAmHQcdO1if+xHEI6AUI3sm
         2sgg4Bx8kqmXnLciRkLSuxdgdKSw2wjviS3hgTA30ZSUo5G/jiJogD0xb47Qc1/0lkcM
         vXsqtwyBWLyKK9FwRt5ekqA2WsdQLTE4xe7bV77MivkLGB+pIdCe2UV0IusbJT4SnjCz
         NuJw==
X-Gm-Message-State: AOAM532VlsciScJaTYNWn3LClYMktQnVF8r02ICZLJR14fu+55InDtyR
        HF3409hnptfN1QMenreVeHAMSQdjV8327RQRU+BpVA==
X-Google-Smtp-Source: ABdhPJweYgnhJ9wfwnhC1naOEgjt465iKJfu5aOyclroBOPqShbw0RGuw1NZisfc1hj6jMsbtIvWVkehVRtpOKozveQ=
X-Received: by 2002:a2e:b8cd:: with SMTP id s13mr21300509ljp.44.1633428736539;
 Tue, 05 Oct 2021 03:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210920124141.1166544-1-pan@semihalf.com> <20210920124141.1166544-4-pan@semihalf.com>
 <ce254cc123f2809976c2f2404941a9074c458309.camel@pengutronix.de>
In-Reply-To: <ce254cc123f2809976c2f2404941a9074c458309.camel@pengutronix.de>
From:   =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Date:   Tue, 5 Oct 2021 13:12:05 +0200
Message-ID: <CAF9_jYQVpG8imn3zjAGKeZqZqDPtWRYWLQjNSXi2SXjjzAKvfA@mail.gmail.com>
Subject: Re: [PATCH 3/3] reset: socfpga: add empty driver allowing consumers
 to probe
To:     Philipp Zabel <p.zabel@pengutronix.de>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, dinguyen@kernel.org
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tomasz Nowicki <tn@semihalf.com>,
        Konrad Adamczyk <ka@semihalf.com>,
        Jacek Majkowski <jam@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 11:34 AM Philipp Zabel <p.zabel@pengutronix.de> wrot=
e:
>
> Hi Pawe=C5=82,
>
> On Mon, 2021-09-20 at 14:41 +0200, Pawe=C5=82 Anikiel wrote:
> > The early reset driver doesn't ever probe, which causes consuming
> > devices to be unable to probe. Add an empty driver to set this device
> > as available, allowing consumers to probe.
> >
> > Signed-off-by: Pawe=C5=82 Anikiel <pan@semihalf.com>
> > ---
> >  drivers/reset/reset-socfpga.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpg=
a.c
> > index 2a72f861f798..8c6492e5693c 100644
> > --- a/drivers/reset/reset-socfpga.c
> > +++ b/drivers/reset/reset-socfpga.c
> > @@ -92,3 +92,29 @@ void __init socfpga_reset_init(void)
> >       for_each_matching_node(np, socfpga_early_reset_dt_ids)
> >               a10_reset_init(np);
> >  }
> > +
> > +/*
> > + * The early driver is problematic, because it doesn't register
> > + * itself as a driver. This causes certain device links to prevent
> > + * consumer devices from probing. The hacky solution is to register
> > + * an empty driver, whose only job is to attach itself to the reset
> > + * manager and call probe.
> > + */
> > +static const struct of_device_id socfpga_reset_dt_ids[] =3D {
> > +     { .compatible =3D "altr,rst-mgr", },
> > +     { /* sentinel */ },
> > +};
> > +
> > +static int reset_simple_probe(struct platform_device *pdev)
> > +{
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver reset_socfpga_driver =3D {
> > +     .probe  =3D reset_simple_probe,
> > +     .driver =3D {
> > +             .name           =3D "socfpga-reset",
> > +             .of_match_table =3D socfpga_reset_dt_ids,
> > +     },
> > +};
> > +builtin_platform_driver(reset_socfpga_driver);
>
> If we can just let devlink delay all consumers until the empty driver is
> probed, does the reset controller have to be registered early at all?
>
> regards
> Philipp

I asked Dinh if the reset controller code needs to be called early:

>That's correct. It's for one of the SP timers.
>
>On 9/16/21 6:13 AM, Pawe=C5=82 Anikiel wrote:
>> Hi,
>>
>> I would like to ask you about the following commit:
>>> commit b3ca9888f35fa6919569cf27c929dc0ac49e9716
>>> Author: Dinh Nguyen <dinguyen@kernel.org>
>>> Date:   Tue Nov 13 12:50:48 2018 -0600
>>>
>>>      reset: socfpga: add an early reset driver for SoCFPGA
>>>
>>>      Create a separate reset driver that uses the reset operations in
>>>      reset-simple. The reset driver for the SoCFPGA platform needs to
>>>      register early in order to be able bring online timers that needed
>>>      early in the kernel bootup.
>>>      [...]
>> Which online timers is this commit message referring to? I couldn't find
>> any information about this. Without this patch the kernel seems to work
>> fine on an Arria 10 (with Mercury AA1 module). What's the exact reason
>> a regular platform driver isn't sufficient?
>>
>> Best regards,
>> Pawe=C5=82
>>
