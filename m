Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54A831E95A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhBRLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhBRKTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:19:01 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [IPv6:2a00:da80:fff0:2::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4380DC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 02:06:26 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EA20A1C0B7C; Thu, 18 Feb 2021 11:04:22 +0100 (CET)
Date:   Thu, 18 Feb 2021 11:04:22 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210218100422.GA28546@amd>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <YCzknUTDytY8gRA8@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

(Second attempt to reply, as first one is not in the archives?!)

> > So far the jury is still out for 5.10, are you willing to help with
> > this?  If not, why are you willing to hope that others are going to do
> > your work for you?  I am talking to some companies, but am not willing
> > to commit to anything in public just yet, because no one has committed
> > to me yet.
>=20
> Following up on this as I did not hear back from you.  Are you and/or
> your company willing to help out with the testing of 5.10 to ensure that
> it is a LTS kernel?  So far I have not had any companies agree to help
> out with this effort, which is sad to see as it seems that companies
> want 6 years of stable kernels, yet do not seem to be able to at the
> least, do a test-build/run of those kernels, which is quite odd...

We expect to maintain 5.10.X kernel for 10 years, which means you can
expect similar testing we do for 4.4 and 4.19 to happen for 5.10:

https://www.cip-project.org/blog/2020/12/02/cip-to-embark-on-kernel-5-10-de=
velopment-for-slts

If Broadcom (or anyone else) needs long-term support for 5.10 kernel,
they are welcome to explore/join the CIP project. That should happen
even if 5.10-stable is only mainained for 2 years.

More information can be found here:

https://wiki.linuxfoundation.org/civilinfrastructureplatform/start
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cip=
referencehardware

Best regards,
								Pavel
PS: Speaking for myself, but not saying anything not publicly known, I
believe :-). I believe I can get more official statements if someone
needs them.
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAuO6YACgkQMOfwapXb+vJcwQCfRPQz5lGgcMFcqrSusKSUQzR/
RgkAn36OQGbZR53Khh/c93zmYfegFSps
=uPaS
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
