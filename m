Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8328A420063
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhJCHCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 03:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJCHCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 03:02:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD8C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 00:00:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ba1so51571469edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 00:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IrffqWMw8ejrndFB+WPZ3D+EgTw2ScOMfT+zWzfsTtE=;
        b=MzLjF2IXqbcSg/4vrB3lBMxtBcIUAlyxOYg6GIZAIamXBubzxvSnz5C9XYrEDLB7zx
         NzJwm1UwOn0IBtsWe9Ue+SB2sW4mFOoKCKcAV4jfQValrd1Pnsbldkc1OzLfVEmJ+xqE
         SjLjaP5DkQFkRtZ6GW6obx+tjXTgo955RMORateiWSATE8sfkdn6M+/geTOIEJjti4/v
         nHbYlLI2neb918LtcrHGzHBqzJcG3t7hUFcqxzGXrujCyjA2vY4QYlmEldX3bzXsG05I
         JxgLweiUTXRUfKDDeqw5SYs8O1sQVMckXRgscNq67zHbVPg9tdUKmaSBRbUx6jP5qwe7
         UODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IrffqWMw8ejrndFB+WPZ3D+EgTw2ScOMfT+zWzfsTtE=;
        b=ZTRp/BgedZ8aA1czsFnvr17R7FzmevGIlzrAKN9jxUDOivVxUZ8QxhkuJx5hmkPpqW
         r7ZAHFD8Viq5iA/ukMFs9u+TSnhJj7/Z83BTCzlD6z8o0lHtg17urj5EBNVAVaMDFsUT
         +B7ERdbAmcxrZgPZMhLwljl/3IBWCNTP1NZD+DFpo8yj4CTADAcp2c77Iq9qsSFq0GTj
         clQguJm/PxuQx1rgWPVaMwUKxv/3lzHuuM8ISOriVQs8rs/jyv7M9of4U8ayw2DEDoA3
         ak75rbPosM75Hp1Z49Asay4K2nG45TPLHGA2jsQTSQFMJb95v4nnh6QI7K7m++g0zsqP
         iSNg==
X-Gm-Message-State: AOAM530CALX9VHhzDyxdXWpGNPn/NohKjypx+dLZnR0nXLDdWj9D8YVf
        wN1bhk/0vFbXJarFO8fBnX8=
X-Google-Smtp-Source: ABdhPJykjUlgXjYLrBmiILIn2FdAj4CY/taRo1fB8rDylARwKadrwlF92tI8q8HJT/umuGyMF3HMDw==
X-Received: by 2002:a50:9dcd:: with SMTP id l13mr9073188edk.90.1633244421487;
        Sun, 03 Oct 2021 00:00:21 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5sm4901865ejy.53.2021.10.03.00.00.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Oct 2021 00:00:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [RFC PATCH v1 0/1] ASoC: meson: aiu: HDMI codec control questions
 and issues
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <YVk77/SIxr8Vt8TQ@geday>
Date:   Sun, 3 Oct 2021 11:00:15 +0400
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        lgirdwood@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        tiwai@suse.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <494D4A30-F230-4B64-AFA9-319FFC4C69DA@gmail.com>
References: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
 <YVk77/SIxr8Vt8TQ@geday>
To:     Geraldo Nascimento <geraldogabriel@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 3 Oct 2021, at 9:13 am, Geraldo Nascimento =
<geraldogabriel@gmail.com> wrote:
>=20
> On Sun, Oct 03, 2021 at 01:43:12AM +0200, Martin Blumenstingl wrote:
>> Hello Jerome et al.,
>>=20
>> on Amlogic Meson SoCs which use the AIU audio controller we have the
>> so-called "machine gun noise" (MGN) issue, reproducible for example =
in
>> Kodi. So far nobody was able to identify the cause of this issue. My
>> idea was to at least narrow down the issue so we can categorize it. =
For
>> that I wanted to get the SPDIF output from AIU to the HDMI controller
>> working.
>>=20
>=20
> Hi, Martin,
>=20
> The MGN issue surely must be that one when using ALSA directly
> (no dmix, no JACK, no Pulseaudio, no Pipewire, no nothing) and
> when the track changes or we pause it, when it resumes we get=20
> noise instead of sound, correct?
>=20
> If so, thanks for trying to track this down!
>=20
> I bring it up because Googling it seems to head straight to a
> Neil Armstrong post to linux-amlogic about what works and what
> doesn't on linux-meson currently, and only if you dig deeper
> you find a couple of reports apparently by the same person
> about the "machine gun noise" thing.
>=20
> It doesn't sound like a machine gun noise to me :)
>=20
> More like brown noise, but anyway what I'd like to note to
> everyone involved is that this one is a major dealbreaker.
> Unless using JACK, Pulseaudio, Pipewire (?) or at least dmix
> audio will degrade at the second song or when the user first
> pauses and then resumes a stream, completely ruining the
> experience.


I=E2=80=99m the origin of most reports that Google will eventually =
discover. I was told elsewhere that this is known as MGN so I=E2=80=99ve =
described it as such, but that could be wrong. For clarity this is the =
noise (triggered, and with AVR volume deliberately right down) followed =
by some navigation in the Kodi GUI to change output:

https://chewitt.libreelec.tv/testing/wp2_audio_noise.mov

In the LibreELEC images I work on where this occurs it=E2=80=99s not =
something I associate with play/pause (although I can=E2=80=99t =
definitively rule it out) or second or third songs (not something that =
happens that often or predictably) but more when there=E2=80=99s a hard =
transition like starting or stopping playback. I hit it most with simple =
scrolling around in the Kodi GUI, although that could be because (due to =
this issue) I limit media playback testing on AIU devices. It=E2=80=99s =
particularly simple to trigger from the Kodi Settings > System > Audio =
page, just scroll around it for 10-30 seconds, which is handy because =
the only way to stop the noise is switching audio source (from anything =
to anything) on the same page.

CH.

>> On Amlogic Meson GXBB/GXL/GXM SoCs a DesignWare HDMI TX controller is
>> used. This has an SPDIF input but there's currently not driver for =
it.
>> On Meson8/8b/8m2 SoCs I am working on a HDMI driver for the =
TransSwitch
>> HDMI controller which - just like DesignWare HDMI TX - supports SPDIF
>> and I2S inputs.
>> I decided to add SPDIF support to the latter since the code from the
>> vendor driver is much easier.
>>=20
>> It took me a while to figure out why I would not get any audio output
>> from AIU SPDIF to the HDMI controller - or from there to the sink.
>> The "fix" for this issue is the RFC patch which is part of this =
series.
>> Any feedback would be great as I am still new to the ASoC subsystem.
>>=20
>> Another part I am still struggling with is the audio "routing" (due =
to
>> lack of a better term - please correct me if this is not the right =
word
>> to use for this case). I have the following description in my .dts:
>> 	sound {
>> 		compatible =3D "amlogic,gx-sound-card";
>> 		model =3D "M8B-ODROID-C1";
>>=20
>> 		assigned-clocks =3D <&clkc CLKID_MPLL0>,
>> 				  <&clkc CLKID_MPLL1>;
>> 		assigned-clock-rates =3D <294912000>,
>> 				       <270950400>;
>> 		dai-link-0 {
>> 			sound-dai =3D <&aiu AIU_CPU CPU_I2S_FIFO>;
>> 		};
>>=20
>> 		dai-link-1 {
>> 			sound-dai =3D <&aiu AIU_CPU CPU_SPDIF_FIFO>;
>> 		};
>>=20
>> 		dai-link-2 {
>> 			sound-dai =3D <&aiu AIU_CPU CPU_I2S_ENCODER>;
>> 			dai-format =3D "i2s";
>> 			mclk-fs =3D <256>;
>>=20
>> 			codec-0 {
>> 				sound-dai =3D <&aiu AIU_HDMI CTRL_I2S>;
>> 			};
>> 		};
>>=20
>> 		dai-link-3 {
>> 			sound-dai =3D <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
>>=20
>> 			codec-0 {
>> 				sound-dai =3D <&aiu AIU_HDMI CTRL_PCM>;
>> 			};
>> 		};
>>=20
>> 		dai-link-4 {
>> 			sound-dai =3D <&aiu AIU_HDMI CTRL_OUT>;
>>=20
>> 			codec-0 {
>> 				sound-dai =3D <&hdmi_tx>;
>> 			};
>> 		};
>> 	};
>> The driver for &hdmi_tx defines:
>> 	struct hdmi_codec_pdata pdata =3D {
>> 		.ops			=3D &txc_48352_hdmi_codec_ops,
>> 		.i2s			=3D 1,
>> 		.spdif			=3D 1,
>> 		.max_i2s_channels	=3D 8,
>> 		.data			=3D priv,
>> 	};
>> In hdmi_codec_ops.hw_params I always get fmt->fmt HDMI_I2S unless I
>> remove all I2S references from the .dts snipped above (only then
>> HDMI_SPDIF is detected). Based on the selection of the "HDMI Source"
>> enum in aiu-codec-ctrl I was expecting the format to update as well.
>> That unfortunately doesn't happen and I don't know how that can be
>> achieved.
>>=20
>=20
> Hm, that sounds weird. I hope you get the answers you are looking for.
>=20
> Thanks,
> Geraldo Nascimento
>=20
>>=20
>> Best regards,
>> Martin
>>=20
>>=20
>> Martin Blumenstingl (1):
>>  ASoC: meson: aiu: Fix HDMI codec control selection
>>=20
>> sound/soc/meson/aiu-codec-ctrl.c  | 108 =
++++++++++++++++++++++--------
>> sound/soc/meson/aiu-encoder-i2s.c |   6 --
>> 2 files changed, 80 insertions(+), 34 deletions(-)
>>=20
>> --=20
>> 2.33.0
>>=20
>=20

