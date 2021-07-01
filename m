Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E443B94CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhGAQoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 12:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhGAQoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 12:44:05 -0400
Received: from mail-out-1.itc.rwth-aachen.de (mail-out-1.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2646CC061764;
        Thu,  1 Jul 2021 09:41:33 -0700 (PDT)
IronPort-SDR: odB3g+RU3IH2RLqLKfzXgbP2VWd9rKntlQjm+X0O3/IFZ7ylLkiQvvOCazVA6Zzzw8+1geo+5B
 7UfZRo40egFg==
X-IPAS-Result: =?us-ascii?q?A2BTBQC+791g/5wagoZagQmDLIInlyaQVox5CwEBAQEBA?=
 =?us-ascii?q?QEBAQQEAT8CBAEBhFICgnMCJTgTAgQBAQEBAwIDAQEBAQUBAQYBAQEBAQEFB?=
 =?us-ascii?q?IEEhS9GhkUBAQEBAgF5BQsLGAklDwFHBg6Cd4JmIQGoFXiBNIEBikIQCQGBM?=
 =?us-ascii?q?IFThCOHdCeCKYEVgnUvPoo/BINXgXiBQpRTAYpInVMHgX2BJ55NEJUVkHy6Y?=
 =?us-ascii?q?QIEAgQFAhaCPoF9cYM5TxcCDo4oGRWOGUBpAgYBCQEBAwlYJIp5AQE?=
IronPort-HdrOrdr: A9a23:wN6WBaopHbSmywuwTiolrGUaV5oueYIsimQD101hICG8cqSj+/
 xG/c5rsCMc5wx+ZJhNo7q90ey7IU80lqQFg7X5X43CYOCOggLBR72Kr7GSoAEIcxeOktK1vp
 0OT0ERMrDN5Q8Qt7ed3ODuKadG/OW6
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,315,1616454000"; 
   d="asc'?scan'208";a="150304595"
Received: from rwthex-w1-a.rwth-ad.de ([134.130.26.156])
  by mail-in-1.itc.rwth-aachen.de with ESMTP; 01 Jul 2021 18:41:32 +0200
Received: from pebbles.localnet (2a01:c22:b5df:f100:8632:645c:3e39:ad8f) by
 rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.12; Thu, 1 Jul 2021 18:41:31 +0200
From:   Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To:     Johan Hovold <johan@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Daniele Palmas <dnlplm@gmail.com>,
        =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH v2] USB: serial: qcserial: Support for SDX55 based Sierra Wireless 5G modules
Date:   Thu, 1 Jul 2021 18:41:26 +0200
Message-ID: <3614092.7mX7SIBJgt@pebbles>
In-Reply-To: <YNQ0O0vhtpStp0n/@hovoldconsulting.com>
References: <20210611134507.8780-1-stefan.bruens@rwth-aachen.de> <20210611135842.14415-1-stefan.bruens@rwth-aachen.de> <YNQ0O0vhtpStp0n/@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16585872.0GYKUT4djp";
        micalg=pgp-sha1; protocol="application/pgp-signature"
X-Originating-IP: [2a01:c22:b5df:f100:8632:645c:3e39:ad8f]
X-ClientProxiedBy: rwthex-s1-a.rwth-ad.de (2a00:8a60:1:e500::26:152) To
 rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart16585872.0GYKUT4djp
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>, =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH v2] USB: serial: qcserial: Support for SDX55 based Sierra Wireless 5G modules
Date: Thu, 01 Jul 2021 18:41:26 +0200
Message-ID: <3614092.7mX7SIBJgt@pebbles>
In-Reply-To: <YNQ0O0vhtpStp0n/@hovoldconsulting.com>
References: <20210611134507.8780-1-stefan.bruens@rwth-aachen.de> <20210611135842.14415-1-stefan.bruens@rwth-aachen.de> <YNQ0O0vhtpStp0n/@hovoldconsulting.com>

On Donnerstag, 24. Juni 2021 09:28:59 CEST Johan Hovold wrote:
> [ +CC: Daniele and Bj=F8rn ]
>=20
> On Fri, Jun 11, 2021 at 03:58:41PM +0200, Stefan Br=FCns wrote:
> > The devices exposes two different interface compositions:
> > - QDL mode, single interface
> > - MBIM mode, MBIM class compliant plus AT/DM(/ADB)
> >=20
> > Current firmware versions (up to 01.07.19) do not expose an NMEA port.
>=20
> We already have at least one SDX55 based modem (FN980) supported by the
> option driver. Any particular reason why you chose to add it to qcserial
> instead of option?
>=20
Support for qualcomm based modems are spread over option and qcserial. All=
=20
other Sierra devices are supported by qcserial.
=20
> Note that the FN980 also needs the ZLP flag set in QDL (flashing) mode,
> I'd assume this one needs it too.

It depends if you implement the Firehose protocol in accordance to the=20
specification or not. 80-NG319-1 (Firehose specification) explicitly states=
 to=20
pad any XML command packet which is an exact multiple of 512 bytes with an=
=20
extra newline or other whitespace character.

Regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart16585872.0GYKUT4djp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCYN3wNgAKCRBvf0o9jP6q
U+TBAJ0QV69j/+RbvDCsiyexV8sI0ngz5ACffbHYfFMNzDVGim05566P0eAQLjk=
=Uihm
-----END PGP SIGNATURE-----

--nextPart16585872.0GYKUT4djp--
