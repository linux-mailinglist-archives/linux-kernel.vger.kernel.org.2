Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C045F30CC2C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbhBBTqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239998AbhBBTov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:44:51 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE66C061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 11:44:10 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e12so3875459pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 11:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=be7aBeIY/8GVSevF3q1F/dqUWCcQlFIIlaYYOVflylo=;
        b=sdNBl36acOZEVoIf9GpSfHHlHwntB72XtuUKJhldfLmaYNcslLPkajfu93vSPFEa02
         nL6lt8tMT27Fa9S8KDIVWVenltIyVKMZcCh8N79IjNDz1rvM8ZoJLVRAOn/jvHMibObh
         J5XsmUTm2FpHJczthvW3mwhO2DH72u32qnCr7SPWnYSS/a9Erlb5D2wrXbOrPpVMy135
         i+lqTR24UiEODyseZYNe+zIyL/Qz4fxMx/j7sMQs1/GqNuzryXJsRVCQPZrNZ9/1M2nG
         x4GU7Q8f8kw7C3VhYweFsf2ktxHD9erANuA2g/Cuj8sm+KLdl7/RmA5vKnIu+Bm6qT11
         BE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=be7aBeIY/8GVSevF3q1F/dqUWCcQlFIIlaYYOVflylo=;
        b=TBB8fK8HevkZFMsPISSgXOVpeux7y4ZH2wD9vEmxus5KcCmCkSZLPXIPQ5lMow+vi9
         hOyHlYVazE6+gsd7eIqUOYlgtKUJ15cdY9EaK/2NyvENZ4fLTPLFLTGAuu6UX8cXDT3o
         w4gT84w3PORJtfDrFGgXBtcvCm1sik2DAQeXehPKkSbEciSmTNhYjd7FxaVZdz0EK6lR
         BtBWgNpTflHVNZZ48REhwd/mA6pNSZuZR0f+kA053kMY460C1AmTQL0Y+N2yOOZgaesv
         RZRT1P1QD4L02vCZzeyk+elNdCtRXzNYw326dT2+6H3oDsiSHiCASxZgXJN3lAznrKOM
         4Q+w==
X-Gm-Message-State: AOAM531RLG0kVCRc4usfbbDKUZ2iKOk8aEStAreDk1V90zkQopuSK9iC
        M8cVlt48tzzHiFBbRYPbo/YEwQ==
X-Google-Smtp-Source: ABdhPJx1/aUcWTdTWq0Qh9m8KnI3edPhARgNztAGZ/DGRuijGaT4Qj6RIGSY7bSAYZiJB6f1Y+erFg==
X-Received: by 2002:a17:90a:4611:: with SMTP id w17mr6042809pjg.18.1612295049928;
        Tue, 02 Feb 2021 11:44:09 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id r22sm23075435pgu.68.2021.02.02.11.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 11:44:08 -0800 (PST)
Date:   Tue, 2 Feb 2021 11:44:03 -0800
From:   Benson Leung <bleung@google.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: Fix call to
 typec_partner_set_pd_revision
Message-ID: <YBmrg+hxqNQkUUPg@google.com>
References: <20210202164531.3982778-1-bleung@chromium.org>
 <YBmFo5L1eeUwCJ9B@kroah.com>
 <CANLzEkuFgLK9saqHhHdrKhOjsiG001d1N9EYXsnohoMPHsAPGg@mail.gmail.com>
 <YBmaLi5hhEj1zy8J@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2wqZXJn6hDALmgK+"
Content-Disposition: inline
In-Reply-To: <YBmaLi5hhEj1zy8J@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2wqZXJn6hDALmgK+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2021 at 07:30:06PM +0100, Greg KH wrote:
> On Tue, Feb 02, 2021 at 09:52:13AM -0800, Benson Leung wrote:
> > Hi Greg,
> >=20
> > On Tue, Feb 2, 2021 at 9:02 AM Greg KH <gregkh@linuxfoundation.org> wro=
te:
> > >
> > > On Tue, Feb 02, 2021 at 08:45:31AM -0800, Benson Leung wrote:
> > > > typec_partner_set_pd_revision returns void now.
> > > >
> > > > Fixes: cefc011f8daf ("platform/chrome: cros_ec_typec: Set Partner P=
D revision from status")
> > > > Signed-off-by: Benson Leung <bleung@chromium.org>
> > > > ---
> > > >  drivers/platform/chrome/cros_ec_typec.c | 6 +-----
> > > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > What changed from "v1"?
> > >
> >=20
> > Just the "Fixes" line in the commit message.
>=20
> That should always go below the --- line, remember, some of us deal with
> hundreds of patches a day :)
>=20
> I'll go take this...

Thanks so much, Greg!

Benson

>=20
> thanks,
>=20
> greg k-h

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--2wqZXJn6hDALmgK+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYBmrgwAKCRBzbaomhzOw
wrbtAP0cTRnK7uxA4/uovfcaIbD41XJv7FBIOjtwyY7s75QBlAEA0Zb3xNXFZNp2
fFkEELg2P2sRLhCj2T69DXlKTPm9IwM=
=geEL
-----END PGP SIGNATURE-----

--2wqZXJn6hDALmgK+--
