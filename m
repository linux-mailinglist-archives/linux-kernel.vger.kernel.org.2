Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C27137B57F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 07:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhELFeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 01:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230017AbhELFem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 01:34:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C386D613C2;
        Wed, 12 May 2021 05:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620797615;
        bh=USzfXL7rhbiNnC/UNNFOQgAUDuwKT0jR8zKV7J6vvp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tY80cvzTIrxVZ/KlZkv4hTSQ0d6QMpNymy43XFKK4Nl4pg5jBiKiaaVe96lBT3sne
         elPv0NK/sEy6D8KvvT99q6vd09rylQLChwFHrA2dxkbosxTt9iza8zPCXcL3RVUcpz
         tR8QQCigsZGcNbYKbyHoeYgo0opjKqs/VqdoafsgvJbHpUP/UAg2CV4dThNi57rHlz
         lWQwpz2czPHlvszx5g7ovXvuxtzhYuWaX2v4SjxSx0ijOrwd+Qe8pcNkbKEfiC5CAG
         7HoXNA8R+NWu01QvHBNz2VZrcmewfLAv4NZ9AsNZ9f/uzMGEAlDGYHjQSsPW6nyDRR
         iqp5x1wXGHYsQ==
Date:   Wed, 12 May 2021 07:33:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] docs: hwmon: tmp103.rst: fix bad usage of UTF-8
 chars
Message-ID: <20210512073330.2b48e81a@coco.lan>
In-Reply-To: <a4d0e1cf-20f1-d87c-0af6-b39f45afae5f@roeck-us.net>
References: <cover.1620744606.git.mchehab+huawei@kernel.org>
        <73b3c7c1eef5c12ddc941624d23689313bd56529.1620744606.git.mchehab+huawei@kernel.org>
        <a4d0e1cf-20f1-d87c-0af6-b39f45afae5f@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Em Tue, 11 May 2021 11:55:53 -0700
Guenter Roeck <linux@roeck-us.net> escreveu:

> On 5/11/21 8:01 AM, Mauro Carvalho Chehab wrote:
> > While UTF-8 characters can be used at the Linux documentation,
> > the best is to use them only when ASCII doesn't offer a good replacemen=
t.
> > So, replace the occurences of the following UTF-8 characters:
> >=20
> > 	- U+2013 ('=E2=80=93'): EN DASH
> >=20
> > In this specific case, EN DASH was used instead of a minus
> > sign. So, replace it by a single hyphen.
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org> =20
>=20
> Confused. Is that supposed to replace the earlier patch (docs: hwmon:
> avoid using UTF-8 chars) ? I thought that was more comprehensive
> and just as valid. Anyway, should I drop that patch ?

If you applied already the previous patch, that's OK. Just ignore this
one.

It is just that, after some discussions around EM/EN DASH on
patch 00/53[1], I opted to split the changes on three parts:

	- UTF-8 fixes;
	- non DASH UTF-8 replacements;
	- EM/EN DASH.

in order to make easier for reviewers to discuss EM/EN DASH if needed.

-

[1] You can see the full thread at:

	https://lore.kernel.org/lkml/cover.1620641727.git.mchehab+huawei@kernel.or=
g/

    In summary, my original patchset were replacing both
    EM/EN DASH to a single hyphen.

    Yet, several maintainers seem to prefer using "--" for EN DASH
    and either "--" or "---" for EM DASH.

    Neither -- nor --- would make any sense on tmp103.rst, as here it
    means a minus sign.
   =20

>=20
> Guenter
>=20
> > ---
> >   Documentation/hwmon/tmp103.rst | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/hwmon/tmp103.rst b/Documentation/hwmon/tmp10=
3.rst
> > index e195a7d14309..b3ef81475cf8 100644
> > --- a/Documentation/hwmon/tmp103.rst
> > +++ b/Documentation/hwmon/tmp103.rst
> > @@ -21,10 +21,10 @@ Description
> >   The TMP103 is a digital output temperature sensor in a four-ball
> >   wafer chip-scale package (WCSP). The TMP103 is capable of reading
> >   temperatures to a resolution of 1=C2=B0C. The TMP103 is specified for
> > -operation over a temperature range of =E2=80=9340=C2=B0C to +125=C2=B0=
C.
> > +operation over a temperature range of -40=C2=B0C to +125=C2=B0C.
> >  =20
> >   Resolution: 8 Bits
> > -Accuracy: =C2=B11=C2=B0C Typ (=E2=80=9310=C2=B0C to +100=C2=B0C)
> > +Accuracy: =C2=B11=C2=B0C Typ (-10=C2=B0C to +100=C2=B0C)
> >  =20
> >   The driver provides the common sysfs-interface for temperatures (see
> >   Documentation/hwmon/sysfs-interface.rst under Temperatures).
> >  =20
>=20



Thanks,
Mauro
