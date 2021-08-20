Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5DF3F2D20
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhHTNaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 09:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHTNaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:30:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709CEC061575;
        Fri, 20 Aug 2021 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Date:MIME-Version:Content-Type:References:
        In-Reply-To:Cc:To:From:Subject:Message-ID:Content-Transfer-Encoding:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=AEd0XQ9RV977QFN7MmkxbrXSUtIMTPRefdXmVxcnKMA=;
        t=1629466170; x=1630675770; b=cpn6ZX2Y/T66vti/wTpEEOtQG2Y6tm9xBPEnx+8A/d8PnOt
        CDXk+XVLG82KZp+6Y4nH5pjA5mfMwxwsCLI2XTu4aTg+5LEmww9NCFjZImyvO+upLpvAmS6J2nsZc
        cHs2DNUCBDvicA5phVFk18hnmz0hRX1B5mqTV88bhm2j/YhkCdPyD2GLSypBNQZdZl8Ter0UqWa0B
        Uz77QVYzjbUxxTAOjsi/o/FONtADaSxxOAfEfy2JLmSgP7AtNBU0vz5Y8w4xjqG9/15xOJVgGnfWj
        A/ra924l9WneBA1TKnjw5DgvlY3VBEoEwoaHTLZ1UibTcXJqQkwC8vKKR3V6H3zQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mH4aC-00Dbvs-48; Fri, 20 Aug 2021 15:29:16 +0200
Message-ID: <077990d1e354777c4c6a33866a0916bed6a97ed5.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] UCSI race condition resulting in wrong port state
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ian Turner <vectro@vectro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <YR+nwZtz9CQuyTn+@lorien.valinor.li>
References: <20201009144047.505957-1-benjamin@sipsolutions.net>
         <20201028091043.GC1947336@kroah.com> <20201106104725.GC2785199@kroah.com>
         <YR+nwZtz9CQuyTn+@lorien.valinor.li>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-oi0AClpVchYyY1jsi55/"
MIME-Version: 1.0
Date:   Fri, 20 Aug 2021 15:29:11 +0200
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
X-malware-bazaar: not-scanned
X-malware-bazaar-2: OK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oi0AClpVchYyY1jsi55/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2021-08-20 at 15:01 +0200, Salvatore Bonaccorso wrote:
> Hi Greg,
>=20
> On Fri, Nov 06, 2020 at 11:47:25AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Oct 28, 2020 at 10:10:43AM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Oct 09, 2020 at 04:40:45PM +0200, Benjamin Berg wrote:
> > > > From: Benjamin Berg <bberg@redhat.com>
> > > >=20
> > > > Hi all,
> > > >=20
> > > > so, I kept running in an issue where the UCSI port information was =
saying
> > > > that power was being delivered (online: 1), while no cable was atta=
ched.
> > > >=20
> > > > The core of the problem is that there are scenarios where UCSI chan=
ge
> > > > notifications are lost. This happens because querying the changes t=
hat
> > > > happened is done using the GET_CONNECTOR_STATUS command while clear=
ing the
> > > > bitfield happens from the separate ACK command. Any change in betwe=
en will
> > > > be lost.
> > > >=20
> > > > Note that the problem may be almost invisible in the UI as e.g. GNO=
ME will
> > > > still show the battery as discharging. But some policies like autom=
atic
> > > > suspend may be applied incorrectly.
> > > >=20
> > > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > >=20
> > > > Benjamin Berg (2):
> > > >   usb: typec: ucsi: acpi: Always decode connector change informatio=
n
> > > >   usb: typec: ucsi: Work around PPM losing change information
> > >=20
> > > Do these need to be backported to stable kernel releases?  If so, how
> > > far back?
> >=20
> > Due to the lack of response, I guess they don't need to go to any stabl=
e
> > kernel, so will queue them up for 5.11-rc1.
>=20
> At least one user in Debian (https://bugs.debian.org/992004) would be
> happy to have those backported as well to the 5.10.y series (which we
> will pick up).
>=20
> So if Benjamin ack's this, this would be great to have in 5.10.y.

Sure, it is reasonable to pull it into 5.10. At the time it just seemed
to me that it was enough of a corner case to not bother.

Note that there was a somewhat related fix later on (for Qualcomm UCSI
firmware), which probably makes sense to pull in too then.

Including Bjorn into the CC list for that.

commit 8c9b3caab3ac26db1da00b8117901640c55a69dd
Author: Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Sat May 15 21:09:53 2021 -0700

    usb: typec: ucsi: Clear pending after acking connector change
=20
Benjamin

--=-oi0AClpVchYyY1jsi55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmEfrh4ACgkQq6ZWhpmF
Y3BGgRAAuhBeIqTGGQZaM9yl5QUOWseVvsfkKblORliZd/E7yl/yJO8eIFDxoY1m
xCPWqfqvEmKoBuTYoD6GJZkcyBO6hGaO12GUffE/x+iGekCWc6CaHsRupj1HQwPF
YU7cgmLU15qbREdezFKsJvQ2alulq6XsmjDKIFpVxlgKdiFjeT9l3cllgnTmWCxV
VeN1EA22cJmZFPA+PodkMyz/hnyF/RBSt4aB3a8TZ0vQvwronkapunndZwzBWVod
MV64snUKU/TaLuw7vlLd4807yoCc1Qrr4zTE6JhJspMtZUT582Np0HDyeBsBe20A
zxoDefym/uxNaAOr9nNz3CcbqbNA6Zw90FLoccPDk4hMpfPMjrep1EyU6S9OQp5M
cs5VvFb4T74HyM/zOGMrdiylXVcxhxiCJk5xywxWb1GgVzQt7CDE+7sqDDKhwcCj
SRgPo9Nd0COvIf9VoOvqx04jOTG6TPtEeh5AFJKlAW76K6jvOvoXq4CVrWtPxAWI
HUmJH5aXg/N+6j+DsiepHMdMfmlo1ogsuJpYFd1i0hxp3ARq6PP36170tEt7fbeO
6EoVzS2LUejraAcsgxM7nOmqfl2pbtPrCbR2gOThYx5tzw4UPrLVcHAGuMFVktWQ
Pmu/y2FFydZhJZByP74f9k/ibTn4xDZlBaGrWg5/b28gAsJOXns=
=i5Lb
-----END PGP SIGNATURE-----

--=-oi0AClpVchYyY1jsi55/--

