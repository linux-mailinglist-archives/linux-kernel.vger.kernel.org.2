Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599DC3686CB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhDVSyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236459AbhDVSyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619117621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+rX/FJ1CDJVreYloKsn0zKd5LczBbShRS23GAExdU0Y=;
        b=NizJxFolpDaan7R48ywMcwBVwYpaa5Wykm86jCyZJcRISBszqx99sZxYMhhDJMV2Q9cMSP
        dQuwrUecFSlw1lqG+y/BfTxSNFOSOfXE/RQREe85AZe7CoxVvxrkiznzRK+oxHfAXNdsTJ
        9IoFyM1uu0DNME1yXrR5efpP7msrWM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-HUScw1rdNaGWFwPWPsjkLQ-1; Thu, 22 Apr 2021 14:53:36 -0400
X-MC-Unique: HUScw1rdNaGWFwPWPsjkLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66BC6817475;
        Thu, 22 Apr 2021 18:53:33 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (unknown [10.10.110.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CCC45D9C6;
        Thu, 22 Apr 2021 18:53:27 +0000 (UTC)
Message-ID: <18edc472a95f1d4efe3ef40cc9b8d2611d4ab990.camel@redhat.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <jikos@kernel.org>, Will Deacon <will@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Date:   Thu, 22 Apr 2021 14:53:12 -0400
In-Reply-To: <20210421180155.GA2287172@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
         <20210421180155.GA2287172@nvidia.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-iNLbDOESuPoHPAfxFi+q"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iNLbDOESuPoHPAfxFi+q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-04-21 at 15:01 -0300, Jason Gunthorpe wrote:
> On Wed, Apr 21, 2021 at 02:57:55PM +0200, Greg Kroah-Hartman wrote:
> > I have been meaning to do this for a while, but recent events have
> > finally forced me to do so.
> >=20
> > Commits from @umn.edu addresses have been found to be submitted in
> > "bad
> > faith" to try to test the kernel community's ability to review
> > "known
> > malicious" changes.=C2=A0 The result of these submissions can be found =
in
> > a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu
> > (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
>=20
> I noted in the paper it says:
>=20
> =C2=A0 A. Ethical Considerations
>=20
> =C2=A0 Ensuring the safety of the experiment. In the experiment, we aim t=
o
> =C2=A0 demonstrate the practicality of stealthily introducing
> vulnerabilities
> =C2=A0 through hypocrite commits. Our goal is not to introduce
> =C2=A0 vulnerabilities to harm OSS. Therefore, we safely conduct the
> =C2=A0 experiment to make sure that the introduced UAF bugs will not be
> =C2=A0 merged into the actual Linux code
>=20
> So, this revert is based on not trusting the authors to carry out
> their work in the manner they explained?
>=20
> From what I've reviewed, and general sentiment of other people's
> reviews I've read, I am concerned this giant revert will degrade
> kernel quality more than the experimenters did - especially if they
> followed their stated methodology.

I have to agree with Jason.  This seems like trying to push a thumbtack
into a bulletin board using a pyle driver.  Unless the researchers are
lying (which I've not seen a clear indication of), the 190 patches you
have selected here are nothing more than collateral damage while you are
completely missing the supposed patch submission addresses from which
the malicious patches were sent!

This all really sounds like a knee-jerk reaction to thier posting.  I
have to say, I think it's the wrong reaction to have.  Remember, these
guys are the ones explaining how things can be done and exposing the
tricks.  That puts them in the white-hat hacker camp, not the black-hat
hacker camp.  You shouldn't be banning them, you should be listening to
them and seeing if they found any constructive ways to improve and
harden the maintenance process against these sorts of things.

--=20
Doug Ledford <dledford@redhat.com>
=C2=A0=C2=A0=C2=A0=C2=A0GPG KeyID: B826A3330E572FDD
=C2=A0=C2=A0=C2=A0=C2=A0Fingerprint =3D AE6B 1BDA 122B 23B4 265B=C2=A0=C2=
=A01274 B826 A333 0E57 2FDD

--=-iNLbDOESuPoHPAfxFi+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAmCBxhgACgkQuCajMw5X
L91tOw/+MfnmUlIWWZ53FdwvP+IiNm81Mh7yZAiARQHRf2LX6ww8C0AZRZGSFOF7
S7CrEQZuYjGOHPjivX9BN9li0slviE2Xdl2Nm9xjkI3p3pZftUplXyrACrMObh1v
0cPZxAtcKk6f0Ow+b+jmUd1aKQBIh/WrQVKIh44Fk4eyIL4Zp2fzFNpiQlWsPhbm
D74o2GklQi295L7cLPNUEyMaq+KwtUTGKyJgWL2LdzSg7LVCwNVRr3hCv97wBXtJ
wBesh2Vzsl8Icp1eX7cImDhMOV1smzcbJBTUzzEjU2NjD9nZrCb1XkBC7JmvzzRN
uN7k6kGQ2pmTlwhoRRMb17ENg7k5RKmrBB7eaz8PVxVEdwbPEzh1d2WeU5gGAwMK
k7mKh9rjcfJdktv3X77/SK0FASnavjrr9XM+1Gi/QSauGg9cBGQUavOp1Tj3rrMb
DdLVnc3va8F1xJUWhX3ggn8AZ6gTtc/xTT6ytH/yLeGD+BqZkNnr3x4qDA1x8nZT
A/wTCJl0NsqcOQDNrq7mBRASZ25HEElJ+Tv/085TAsxLuwJDJtEy9UfY7H5EUakn
kGJrFkcuAOn7/K+YKdaddx4iGlSSaeXmTgkk7N90+LBvnVBpcDausQ9dKZV7yy+w
lLC5rX4EPAEMKobWWZ3fu7bLWjauFVf6B32N2kkvkW8VWOge2kQ=
=EokO
-----END PGP SIGNATURE-----

--=-iNLbDOESuPoHPAfxFi+q--

