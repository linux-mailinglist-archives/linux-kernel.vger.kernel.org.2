Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4E31A369
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhBLRSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:18:05 -0500
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21351 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhBLRSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:18:03 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1613150235; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=dhppv5YRKrOiIY9ShjAPv0FL6PtAawegCZUNQ+9w1ed81nzIeF4B+WNw6FHtApDV3V62TXq0PGmtQGI3rYSuxSilRMSzdULSh7K2m+iEM0Bdl8fcNPUt0V4xuom/Cw4a5T2Z/QO27xTIkerxoSfjX43cGy0pkBoOKLLwg9zUE8E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1613150235; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=U4ErNhDeAwMqPKmHkfMnsR+tSrT1hZl5AXxcsRpJu8I=; 
        b=dZBX19dAcfzOwJFwNksZYc9uayX8wjh9fMUiRMa9QsXcUD4Q+rhs/b8ol7/W5Pt/HvFpzBfCAySWH+Uun12xQwobyzjgID2xrYV1TZ5tiWBAEEi19EokwiUwGQabTDWMiguOt+BhEYTNmt+Lm2B0KsCS9MGdjFUr71ImkwDv/og=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1613150235;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Message-ID:Subject:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        bh=U4ErNhDeAwMqPKmHkfMnsR+tSrT1hZl5AXxcsRpJu8I=;
        b=OnSHuoo0b4jcpl/TCTjidFq8VU+g2saU3BhaUDVRVsTOq2+cJd7YCg3k9VH1byAG
        MNbbHpbn3B2BKpm/uxkyAdYrOaKulNeGoz95XqrzoSOTZ5iAOGbP4SdzgHVorJwbxSi
        vYmNZLlx0oFI/FQ2PrGvEegHMluKy3uCJsAR3CiA=
Received: from anirudhrb.com (106.51.104.65 [106.51.104.65]) by mx.zohomail.com
        with SMTPS id 1613150230624196.03993421440634; Fri, 12 Feb 2021 09:17:10 -0800 (PST)
Date:   Fri, 12 Feb 2021 22:47:04 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, colin.king@canonical.com,
        kuba@kernel.org, johannes@sipsolutions.net, lee.jones@linaro.org
Message-ID: <YCa4EBQHw02BeQ4B@anirudhrb.com>
Subject: Re: [PATCH] staging: wimax/i2400m: fix some byte order issues found
 by sparse
References: <20210211202908.4604-1-mail@anirudhrb.com>
 <YCWVD34rU5Lu71/S@kroah.com>
 <YCaRAYjiz0TJH+4L@anirudhrb.com>
 <YCaT/qLci4ap1grf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YCaT/qLci4ap1grf@kroah.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 03:43:10PM +0100, Greg KH wrote:
> On Fri, Feb 12, 2021 at 08:00:25PM +0530, Anirudh Rayabharam wrote:
> > On Thu, Feb 11, 2021 at 09:35:27PM +0100, Greg KH wrote:
> > > On Fri, Feb 12, 2021 at 01:59:08AM +0530, Anirudh Rayabharam wrote:
> > > > Fix sparse byte-order warnings in the i2400m_bm_cmd_prepare()
> > > > function:
> > > >=20
> > > > wimax/i2400m/fw.c:194:36: warning: restricted __le32 degrades to in=
teger
> > > > wimax/i2400m/fw.c:195:34: warning: invalid assignment: +=3D
> > > > wimax/i2400m/fw.c:195:34:    left side has type unsigned int
> > > > wimax/i2400m/fw.c:195:34:    right side has type restricted __le32
> > > > wimax/i2400m/fw.c:196:32: warning: restricted __le32 degrades to in=
teger
> > > > wimax/i2400m/fw.c:196:47: warning: restricted __le32 degrades to in=
teger
> > > > wimax/i2400m/fw.c:196:66: warning: restricted __le32 degrades to in=
teger
> > > >=20
> > > > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > > > ---
> > > >  drivers/staging/wimax/i2400m/fw.c | 14 +++++++++-----
> > > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/drivers/staging/wimax/i2400m/fw.c b/drivers/staging/wi=
max/i2400m/fw.c
> > > > index b2fd4bd2c5f9..bce651a6b543 100644
> > > > --- a/drivers/staging/wimax/i2400m/fw.c
> > > > +++ b/drivers/staging/wimax/i2400m/fw.c
> > > > @@ -189,12 +189,16 @@ void i2400m_bm_cmd_prepare(struct i2400m_boot=
rom_header *cmd)
> > > >  {
> > > >  =09if (i2400m_brh_get_use_checksum(cmd)) {
> > > >  =09=09int i;
> > > > -=09=09u32 checksum =3D 0;
> > > > +=09=09__le32 checksum =3D 0;
> > >=20
> > > __le32 is only for when the data crosses the kernel/user boundry, jus=
t
> > > use le32 in the kernel for stuff like this.
> > >=20
> > But that throws a compile error.
>=20
> What error?

drivers/staging/wimax/i2400m/fw.c:192:3: error: unknown type name
=E2=80=98le32=E2=80=99; did you mean =E2=80=98__le32=E2=80=99?

=09- Anirudh

