Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A220442EEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhKBNQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:16:26 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:30825 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhKBNQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635858795;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=NDxaeULcD+myLBhUj1L/NV8BkGrM/ANcyR6xBtxG5ag=;
    b=Wx8on7qDbbv2eVqypmEBn50uKn8Tb8TUZMdarglwwJaN1Y/uF8NTtzLsyfK83fyleO
    tUOHuOXafgY6dvlzRZockEdXz0JOX0mh81NQG6AnNLpUA6EEXg1t5HeitUY2APJ+gMNG
    gsSMsvO+EEE6g5k1Syx49BLps7bPAPfRkEUyligFKVuScfbw1D2sc2BlxLFyCquVSsaR
    qc0BkqAD/wXRbjjSVyEW7NelOg2/gHW9LCDQvsgOhJa71f3WkXwFqvgbpmSKe/q67X2S
    nMpsriqop2IemmW6gTJpmBRgS3U3pwoXhYALEanSAafIYSa1HA667RtfHSWgZ84bfK4Y
    7e7A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDOvmhs="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id d01d1fxA2DDENa1
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 2 Nov 2021 14:13:14 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC v2 0/2] mmc_fixup_device
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <65944054.TfMWBj6dXo@pc-42>
Date:   Tue, 2 Nov 2021 14:13:13 +0100
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>,
        =?utf-8?Q?Gra=C5=BEvydas_Ignotas?= <notasas@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B797E225-B589-4AB5-B62A-6EF8BCADE9B1@goldelico.com>
References: <cover.1635759337.git.hns@goldelico.com>
 <65944054.TfMWBj6dXo@pc-42>
To:     =?utf-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

> Am 02.11.2021 um 12:14 schrieb J=C3=A9r=C3=B4me Pouiller =
<jerome.pouiller@silabs.com>:
>=20
> Hello Nikolaus,
>=20
> On Monday 1 November 2021 10:39:10 CET H. Nikolaus Schaller wrote:
>>=20
>> RFC V2 2021-11-01 10:24:26:
>> * reworked to not misuse mmc_select_card() but add a call to
>>  mmc_fixup_device() right after where host->ops->init_card
>>  was called before to apply the wl1251 specific quirks.
>>  Device tree matching is done by a new table passed to =
mmc_fixup_device().
>>  suggested by: ulf.hansson@linaro.org
>>  based on patches by: jerome.pouiller@silabs.com
>=20
> To make review easier, I think you can include these patches
> in this series (BTW, I have no time to care of them until end
> of next week. So, it will probably go faster if you take over
> these patches).

Ok, no problem.

Now as I understand how it should be set up I could even propose
some new macro for discussion.

>=20
> (I also suggest to add a title to your series to make your work
> easier to track.)

Yes... I didn't notice before I received my copy of this mail.
There is a missing if(strlen(subject) =3D=3D 0) reject; in my helper
tool...

BR and thanks,
Nikolaus

