Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D03E30DB04
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhBCNWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhBCNWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:22:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 362F864E38;
        Wed,  3 Feb 2021 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612358499;
        bh=Da4M1bnf1Wqx12eiTUgDdPCdruKdDYCPyv3ytTn0Apk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtcpod9ME1FXG3N24V04PY+nY2vROgeKptqjMgrKti7aX957Ip/v3YdTpvJ00yNjq
         nBOLzSyyCh2P1ugeIJgKeXGK8iydKO6UEiic5I3j1xi3mAxqe2cnGZtBCyXI/dFcp6
         jrfveRwAYmW6TLrEdhnXMk2HNOZkveYa+9TWUrOPs/cv2PEncnBW5NvuBOSCRg0csq
         8AQfaQ0q0bL/+t4p2DM6y9dZgxvzXIf/ahDi1Sh5JjWMHQh3JMjvlxXfnFlGUILQ5+
         lAWbazIcoLd0mCEMhXtrkIPIhgncPxyiRGLQswOj6N3vju/SgRqvJ1GRV2Fe5TVXJT
         PHeM32wXPna2w==
Date:   Wed, 3 Feb 2021 13:20:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Argus Lin <argus.lin@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Arnd Bergmann <arnd@arndb.de>, Jack Yu <jack.yu@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Dan Murphy <dmurphy@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiaxin Yu =?utf-8?B?KOS/nuWutumRqyk=?= <Jiaxin.Yu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Shane Chien =?utf-8?B?KOewoeS9kei7kik=?= 
        <Shane.Chien@mediatek.com>,
        ChiPeng Chang =?utf-8?B?KOW8teeQpuaciyk=?= 
        <chipeng.chang@mediatek.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 0/2] Add mediatek MT6359 accdet driver
Message-ID: <20210203132051.GC4880@sirena.org.uk>
References: <1609935546-11722-1-git-send-email-argus.lin@mediatek.com>
 <1612335462.9202.1.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <1612335462.9202.1.camel@mtkswgap22>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2021 at 02:57:42PM +0800, Argus Lin wrote:
> Dear maintainers:
> Can you reply to me if any opinion?
> thanks

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

IIRC I did review this...

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAaozIACgkQJNaLcl1U
h9CrKQf/acfnUSuQONwN1RT/hy5GX9WSF9RkgE8dip0te22amV9V/s7zWzNqGtcA
4CaPqT8pSNN975HVcr388zMgdi/wa7g3n6nnGYWcIlFwVncCuxcGiUqxMzqqKk8p
xAPDqZibzPj5RWoFkNdJo9QLiKi04GGNPliTcHRYxrvFtr5m8MZRLQI7yRIUjOT9
pxe+CscoJ8p3Gadbi4ZH95aRDIqy//hStJKHn2YRW5vXlCNJkbXKRE78iWJo4//4
Ll2vLjZeS3fBxflFSkk8Tqcl6LhN5zp1Le/6qE1oHVWmRiKTqPc1irYFKs1iBZI/
1ioNJnhOryevfmraD/TUdCB+xN3z3Q==
=Hlk7
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
