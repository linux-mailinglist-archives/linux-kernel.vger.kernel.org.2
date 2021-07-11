Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAEF3C39E9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 04:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhGKC54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 22:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhGKC5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 22:57:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF53EC0613DD;
        Sat, 10 Jul 2021 19:55:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cu14so2700419pjb.0;
        Sat, 10 Jul 2021 19:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+fo5rtCVg2JVaaUh1Eytyg0nyYP7UQqVCXOja4tj4Q=;
        b=Ypc/HBQZyxeC0FoL/xaUxN2tF/hKgOQCMXsJtbY2gn1vSoSspaXtLpmFYIpJ+MV2TJ
         8c3w0u3woQGbzr1j4/nupxjNTh3DjIDGL6RtZ7Apf1KQ4MC4bsJ1Hyf5ok1ObmmFaysc
         B/2u3dABxqVW9DzkS50K1t2slqqJbOvhlDAKMRdbO4zeolqePgnJaSvCK6JvGXexn72U
         CeEqGpXBBhLtcihbr4Rujnc90NqO1Df9GdQ0T9j0atBqLgPOx1EDE1VGzL3LRyAkxtII
         t4zV9c3UpvBPRUvz52nTEjKM/wISGGu0moIk1g1SFB3ImNzagaSapZUlspW4zsHZYVHq
         3wXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+fo5rtCVg2JVaaUh1Eytyg0nyYP7UQqVCXOja4tj4Q=;
        b=Rb/VQaOiFZemp5GlR39jq3bTM0x+NTPh6/UYjOkPbtcZ6IPMAhEmpdyeSpI9/zinzZ
         3QCWhWrlMOnCtsnn7ZMPPlD+bcXRWt+F2z5V1q/MggbnCMRyIpY2JRl0FQj7z1+SI8BL
         Y/3UDgopH5blB+TB7k8Pb0dbge5CR+8ZX9wXWflULYcra/Mr7ysg1pXL8kGTCpXicDy6
         X1bj0GtuYJfvYocbZOnHBVbMblTefS/LrCQQob9EeHWKcjnh9Zd/blfMwTM9noEpHQh7
         7l20k043jq2B8gGkdq3WTDvs18gDHWDtgulCiiqZAlD4c/zWVTPJM61BQrLDLj9U/Po+
         Es0A==
X-Gm-Message-State: AOAM531zry1SkM+gNq85kGJTqXKiQtiXf4uBvQ1sMZYX4hH3exrP3K+F
        /wklAGNorKRlXGun9NMsrBvCM0s9e9VymE7/2Dg=
X-Google-Smtp-Source: ABdhPJzMB39T86EW5KUVAUxqWmN3o8hbDKeIMgzNl0aKvh8jWliABf93RAQttj92GwBj2MQHYUOgbw==
X-Received: by 2002:a17:903:230b:b029:12a:d8db:cd27 with SMTP id d11-20020a170903230bb029012ad8dbcd27mr10629391plh.42.1625972105978;
        Sat, 10 Jul 2021 19:55:05 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id s20sm17557169pjn.23.2021.07.10.19.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 19:55:05 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id BF6EC900050;
        Sun, 11 Jul 2021 02:55:02 +0000 (GMT)
Date:   Sun, 11 Jul 2021 02:55:02 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH v3 2/3] hwmon: da9063: HWMON driver
Message-ID: <20210711025502.347af8ff@gmail.com>
In-Reply-To: <20210710160813.GA3560663@roeck-us.net>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
        <2c24ef5953401e80d92c907704bffeff1d024de0.1625662290.git.plr.vincent@gmail.com>
        <20210710160813.GA3560663@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks a lot for this new review (and sorry for the previous
very-incomplete send, unfortunate keyboard shortcut and sleepy fingers).

On Sat, 10 Jul 2021 09:08:13 -0700, Guenter Roeck <linux@roeck-us.net> wrot=
e:
> Unnecessary include.
[...]
> I don't immediately see where this include is needed. Is this a
> leftover ?
[...]
> Same here.

Are there ways to systematically tell which includes are useless
besides commenting them out all and uncommenting until it compiles ?
(if that is even a good idea)

> > +enum da9063_adc {
> > +	DA9063_CHAN_VSYS =3D DA9063_ADC_MUX_VSYS,
> > +	DA9063_CHAN_ADCIN1 =3D DA9063_ADC_MUX_ADCIN1,
> > +	DA9063_CHAN_ADCIN2 =3D DA9063_ADC_MUX_ADCIN2,
> > +	DA9063_CHAN_ADCIN3 =3D DA9063_ADC_MUX_ADCIN3,
> > +	DA9063_CHAN_TJUNC =3D DA9063_ADC_MUX_T_SENSE,
> > +	DA9063_CHAN_VBBAT =3D DA9063_ADC_MUX_VBBAT,
> > +	DA9063_CHAN_LDO_G1 =3D DA9063_ADC_MUX_LDO_G1,
> > +	DA9063_CHAN_LDO_G2 =3D DA9063_ADC_MUX_LDO_G2,
> > +	DA9063_CHAN_LDO_G3 =3D DA9063_ADC_MUX_LDO_G3 =20
>=20
> Many of the above defines are not used. Do you plan a follow-up commit
> to use them ? Otherwise please drop unused defines.

I'm not sure (would like to, but for this I think I need to add
devicetree controls, and I am not sure how this should look like), so in
doubt I will drop them from this patch set.

There are also #defines in this patchset related to ADCIN channels,
which are hence unused. Should I also drop these ? In my (short)
experience, there seem to regularly be unused #defines in headers, so I
left them be.

> > +struct da9063_hwmon {
> > +	struct da9063 *da9063;
> > +	struct mutex hwmon_mutex;
> > +	struct completion adc_ready;
> > +	signed char tjunc_offset; =20
>=20
> I am curious: 'char' implies 'signed'. Any reason for using 'signed' ?

We are again getting into my "erring on the status-quo side" as this
comes from the original patchset. My reading of this is that using a
char for holding an integer is somewhat unusual (as opposed to a holding
character) and the non-essential "signed" would signal that there is
something maybe a bit unusual going on here.

But this all becomes moot with your next point:

> Also, note that on most architectures the resulting code is more complex
> when using 'char' instead of 'int'. This is seen easily by compiling the
> driver for arm64: Replacing the above 'signed char' with 'int' reduces
> code size by 32 bytes.

This is reaching outside of the parts of C that I am comfortable in:
what is the correct way to sign-extend an 8-bits value into an int ?

In regmap_read() fills "int *value" with the read bytes, not
sign-extended (which looks sane):
	ret =3D regmap_read(da9063->regmap, DA9063_REG_T_OFFSET, &tmp);
	dev_warn(&pdev->dev, "da9063_hwmon_probe offset=3D%d\n", tmp);
->
[Jul11 01:53] da9063-hwmon da9063-hwmon: da9063_hwmon_probe offset=3D247

My na=C3=AFve "(int)((char)tmp)" produces 247, instead of -9.
"(int)hwmon->tjunc_offset" does sign-extend, but going through an
intermediate variable looks overcomplex to me (for a tiny definition of
"overcomplex").
I see sign_extend*() functions but seeing their bitshift arguments I
feel these may not be intended for such no-shift-needed use.

> > +static int da9063_adc_manual_read(struct da9063_hwmon *hwmon, int chan=
nel)
[...]
> > +	ret =3D wait_for_completion_timeout(&hwmon->adc_ready,
> > +					  msecs_to_jiffies(100));
> > +	reinit_completion(&hwmon->adc_ready); =20
>=20
> This is unusual. Normally I see init_completion() or reinit_completion()
> ahead of calls to wait functions.
>=20
> If a request timed out and an interrupt happened after the timeout,
> the next request would return immediately with the previous result,
> since complete() would be called on the re-initialized completion
> handler. That doesn't seem to be correct to me.

To confirm my comprehension: the issue is that if somehow the irq
handler fires outside a conversion request, it will mark adf_ready as
completed, so wait_for_completion_timeout() will immediately return.
The follow-up consequences being that the ADC, having just been asked
to do a new conversion, will still be busy, leading to a spurious
ETIMEDOUT.
Is this correct ?

With this in mind, could the time from regmap_update_bits() to
{,re}init_completion() be longer than the time the IRQ could take to
trigger ? In which case adc_ready would be marked as completed, then it
would be cleared, and wait_for_completion_timeout() would reach its
timeout despite the conversion being already over.

> > +static int da9063_hwmon_probe(struct platform_device *pdev)
[...]
> > +	ret =3D regmap_read(da9063->regmap, DA9063_REG_T_OFFSET, &tmp);
> > +	if (ret < 0) {
> > +		tmp =3D 0;
> > +		dev_warn(&pdev->dev,
> > +			 "Temperature trimming value cannot be read (defaulting to 0)\n");
> > +	}
> > +	hwmon->tjunc_offset =3D (signed char) tmp; =20
>=20
> Nit: Unnecessary space after typecast (checkpatch --strict would tell you=
).
>=20
> Also, I am curious: The temperature offset is a standard hwmon attribute.
> Is it an oversight to not report it, or is it on purpose ?

It was an oversight, but now that I know about it I am not sure this
should be used: the offset is in chip-internal ADC units, so userland
cannot make use of it for temperature measurement unless the raw ADC
output is also exposed.
Is this attribute used to give an insight as to how the chip was
calibrated in-factory or otherwise good practice to expose ?

I can of course expose it and apply the same formula as for the
temperature attribute, to get the expected m=C2=B0C unit.

Regards,
--=20
Vincent Pelletier
GPG fingerprint 983A E8B7 3B91 1598 7A92 3845 CAC9 3691 4257 B0C1
