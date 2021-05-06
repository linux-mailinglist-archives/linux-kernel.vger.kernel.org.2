Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3C5375531
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhEFN42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbhEFN4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:56:22 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861D5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 06:55:22 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id u200so1229495vku.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yZsywL9xa86CPjKBJlwXOtmXHsER4PQJgFJLL05xlMw=;
        b=F25BaohVxuDoVdNIi/HajMz93MwEOFHYpGCyb1ENiqmUEvEdb4BLUAlJyY4ppA8vjt
         1TNQfK7owjcqLfZPjdGuBbAt7bBtcaDr4MS6wWA5lzuGHN0V4YO8gcckjQ0FQt4YIgxf
         c+eqeU+iqK6Jfeq4LnF0bcKskk3M70MlR699KDblmCdE/MVm+5on8aQD9BmCqCmbsXER
         yN2Uy2bhF/W/IaEa84q6ll+QfpnL6WPZBZ1n/Y/M+qcUqT58FTkB8KLOZrmstkTCZPhT
         nzaKScKWy6gLrFM6F9zbLT5t9tfu6RcdqSWs7lUIRylFxZMw39AD9IWwId9fiPjJdwiM
         s/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yZsywL9xa86CPjKBJlwXOtmXHsER4PQJgFJLL05xlMw=;
        b=Pf6GhxNwUMHkJTwi2nCkPN7C/jZlowRSxK8dv6o8VRP1kaEnk9JEoW4oPl8TsOUFwk
         MLmOpJENoZlb/siFrExGNCNvCWbv+BfTsXwD7rpU8+VejJnpcmiroRhqorbhMc/qC6pg
         lKyS+U3dL3ByESUx6jeGJgOaviQzsWlhA+l1peOhkaDSn9NkYSllXMUhoa11pPlDPPQQ
         V1+ySk0cAgEpJjNnF7onqisJvIBDJbHsk0DEQJjlCKZOWA7w+0RfVXGybbm5Q/MxuSyx
         xytp6e71f7N+QwgedYHiV/jEBzkrSCEs/TK/VlYj7dxkAOWxwniEL9Ua7kk5koJrwBwB
         991Q==
X-Gm-Message-State: AOAM531yERIozimBiwhjnB4P5FFDvPkJQTm1tSUjwWQom2vz69nrA3N0
        Iu9KmpHBYKZDAw6NGiLn9W4ghAuE4BJBc+zpP1jt3Q==
X-Google-Smtp-Source: ABdhPJxkma4C2en27QnyR9Kzr7NF//iOxkOhkG3CycjoUIOFc2l94KCtVY0lqH+qGGnyVwLC1rMHCkKVaDgx9vZEd7Q=
X-Received: by 2002:a1f:5504:: with SMTP id j4mr2879603vkb.7.1620309321684;
 Thu, 06 May 2021 06:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CAPDyKFqvTgRZ0QEgBXJgbhbEmQvxBqzZuGh2MrZGS1mRyYz9mg@mail.gmail.com>
 <CWXP265MB26802E4E0F1AE7B6FE2836AAC4599@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CAPDyKFrAS8SP5AMX2fi_ZbsmGm49ZFo4YKcczwYZOmN-AnPn7A@mail.gmail.com> <CWXP265MB268017F74D102670845901AAC4589@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB268017F74D102670845901AAC4589@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 May 2021 15:54:45 +0200
Message-ID: <CAPDyKFqosf70-NcU1ZH39rGknHZQH9DmgmgOvqUcF83pC-_=XQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 at 10:34, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> Well I am definitely for keeping this bug as a feature
> and utilizing UHS with this patch ;)
> I have tried all SDSC cards I could get my hands on and
> have not seen any 'accidentally' reporting UHS support.

That sounds promising.

>
> I tested the patch with own custom cards.
> (Hyperstone, my employer, develops controllers for flash
> storage.)

I see, thanks for sharing!

>
> There you would have to make the same choice, disabling
> UHS support reporting for all SDSC cards, but as some
> hosts accept UHS (including voltage switch) without checking
> CCS, this would throttle performance.
> (One such host is e.g.
> 8564:4000 Transcend Information, Inc. microSD/SD/CF UHS-II Card Reader)
>
> It would be nice to have this in linux-mmc as arguably the most
> important SD native host.
> I'm sure the other manufacturers either do not disable UHS
> support for SDSC cards, or have at least been playing with the idea.

Assuming I don't find any issues when I am testing some of my older SD
cards, I am definitely open to change into what you propose in
$subject patch.

Although, I think it's important that we also state in the code with a
comment somewhere - that we deliberately have decided to deviate from
the SD spec for the reasons you have pointed out in our discussions.

Can you perhaps prepare and post a new version and possibly also work
a little bit on the commit message to make things a bit more clear?

In the meantime, I will test some SD cards at my side...

Kind regards
Uffe

>
> Regards,
> Christian
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Wednesday, May 5, 2021 4:20 PM
> To: Christian L=C3=B6hle <CLoehle@hyperstone.com>
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-mm=
c@vger.kernel.org <linux-mmc@vger.kernel.org>; pali@kernel.org <pali@kernel=
.org>; huyue2@yulong.com <huyue2@yulong.com>; tiantao6@hisilicon.com <tiant=
ao6@hisilicon.com>
> Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
>
> On Wed, 5 May 2021 at 14:13, Christian L=C3=B6hle <CLoehle@hyperstone.com=
> wrote:
> >
> > So two cards that advertise UHS:
> > https://www.euric.de/de/flash-speicher/sd-microsd/sd/
> > Model SDI790
> > and
> > https://na.industrial.panasonic.com/products/storage-media/industrial-s=
d-cards/lineup/industrial-grade-2d-nand/series/71695
>
> Thanks for the links!
>
> Are these the ones that you have been using for testing?
>
> > Hopefully that suffices as a couple, otherwise I would buy some
> > that do not advertise it and actually check if they support it anyway.
> > But 2GB SLC listings are kind of rare these days, so it's not as
> > easy to find many that are still sold and available.
>
> Right. I have a whole bunch of old SD cards that I can test. I will
> let you know when I have got some time to test some of them.
>
> The main worry (but I may be wrong) I have with the patch is that it
> could cause problems for other older SDSC cards, which happens to
> incorrectly set the S18A bit. I mean, before UHS-I was introduced in
> the SD spec, this bit was just being reserved and potentially it could
> have *any* value by the card manufacturer. As I said, let me do some
> tests of my older SD cards.
>
> >
> > My point about deviating from the standard was that these cards
> > are already initialized as UHS, they just don't do the voltage switch.
> > So anything reserved for UHS-I (e.g. CMD23 )is already being done
> > by the host with the current linux-mmc,
> > so the standard deviation is already there.
> > Just the voltage switch is missing.
>
> Ah, yes you are right!
>
> We call mmc_sd_init_uhs_card() no matter whether the CCS bit is set.
> Certainly this is a bug. Both the card and host aren't designed to
> work under these conditions/timings.
>
> >
> > Regards,
> > Christian
> >
>
> Kind regards
> Uffe
>
> >
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Wednesday, May 5, 2021 12:09 PM
> > To: Christian L=C3=B6hle <CLoehle@hyperstone.com>
> > Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if support=
ed
> >
> > On Thu, 22 Apr 2021 at 15:18, Christian L=C3=B6hle <CLoehle@hyperstone.=
com> wrote:
> > >
> > > Ignore the reported capacity if the card otherwise reports UHS suppor=
t.
> > >
> > > Currently SDSC cards reporting UHS support except for the CCS do not =
run
> > > through the voltage switch.
> > > While strictly speaking a SDSC card cannot support UHS in compliance
> > > with the standard, there is no good reason to throttle them that way.
> >
> > Maybe not, but I think the code just tries to conform to the SD spec.
> >
> > > Especially for pSLCs in practice such cards benefit greatly by this p=
atch,
> > > as they can be new and UHS supporting, but must not lie about their C=
CS.
> >
> > Can you provide some concrete examples of SDSC cards that support UHS-I=
?
> >
> > > The behaviour of linux-mmc for SDSC is deviating from the standard an=
yway
> > > in such a case, as the card is treated as UHS card not supporting the
> > > voltage switch in general.
> > > Such a card will come up as
> > > mmc0: new ultra high speed SDR25 SD card at address 0001.
> > > Thus the subsystem will support CMD23 and others to the card.
> > > But if we deviate from the standard anyway, then we might as well
> > > not throttle SDSC to 25MB/s.
> >
> > Not sure I understand this correctly? Can you elaborate a bit more, so
> > I understand how we deviate from the SD spec here?
> >
> > As far as I understand the spec, SDSC cards shouldn't support UHS-I.
> > If we decide to deviate from the spec to support this anyway, at least
> > we need to know about a couple of cards that actually supports this.
> >
> > Kind regards
> > Uffe
> >
> > >
> > > Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> > > ---
> > >  drivers/mmc/core/sd.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > > index 6fa51a6ed058..281ca2da8e0b 100644
> > > --- a/drivers/mmc/core/sd.c
> > > +++ b/drivers/mmc/core/sd.c
> > > @@ -841,11 +841,10 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 o=
cr, u32 *cid, u32 *rocr)
> > >                 return err;
> > >
> > >         /*
> > > -        * In case CCS and S18A in the response is set, start Signal =
Voltage
> > > -        * Switch procedure. SPI mode doesn't support CMD11.
> > > +        * In case S18A in the response is set, start Signal Voltage =
Switch
> > > +        * procedure. SPI mode doesn't support CMD11.
> > >          */
> > > -       if (!mmc_host_is_spi(host) && rocr &&
> > > -          ((*rocr & 0x41000000) =3D=3D 0x41000000)) {
> > > +       if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
> > >                 err =3D mmc_set_uhs_voltage(host, pocr);
> > >                 if (err =3D=3D -EAGAIN) {
> > >                         retries--;
> > > --
> > > 2.31.1
> > >
> > > Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> > > Managing Directors: Dr. Jan Peter Berns.
> > > Commercial register of local courts: Freiburg HRB381782
> > >
> >
> > Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> > Managing Directors: Dr. Jan Peter Berns.
> > Commercial register of local courts: Freiburg HRB381782
> >
>
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
