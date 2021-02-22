Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D51D321337
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhBVJgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:36:53 -0500
Received: from mout01.posteo.de ([185.67.36.65]:33184 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhBVJgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:36:31 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 9FDA1160063
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 10:35:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1613986530; bh=VPHrBPyLWdSROwekyI2lxigDlO6mhV3Y1pk0vkdayCs=;
        h=Date:From:To:Cc:Subject:From;
        b=qrD0gdkeKCP5FiQbuP5EF4YpxR2sONuHqXB2z2ddKvno1JgWf1VK6LRZ3OHIMPh3a
         rx7Wuq1Me/AOI1GLIgywjXsjM/rK01Rs/qp772S4+xPc/fgv80mg+j8oJKdhXygqxP
         likGuez7xHrrPGWshef54ywO7PfVFNkCJ2oy+r8QT514Nzgr7CCTwfkERbbxZrbhCS
         WY348x0gnOMuwooJ27rrxghsv4n+gDVAF4YyeqhxdrOE+8qVfZnmKunbiGEo0w2UMd
         WT39ntn0RwwUQ6U0Fp+1kEqOfonrnPN9o6VGo9JWriA+Tt7fIWA5k8GA4SdntTAW1r
         JDDr/Cm5LKtpw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DkcVP5xZcz6tml;
        Mon, 22 Feb 2021 10:35:25 +0100 (CET)
Date:   Mon, 22 Feb 2021 10:35:25 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Ajay Patil <pajay@qti.qualcomm.com>, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v7 23/23] [DO NOT MERGE] arm64: Cope with CPUs stuck in
 VHE mode
Message-ID: <YDN6BtDhzmF5OtBO@latitude>
References: <20210208095732.3267263-1-maz@kernel.org>
 <20210208095732.3267263-24-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b/B7fiZwBVN17PG/"
Content-Disposition: inline
In-Reply-To: <20210208095732.3267263-24-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b/B7fiZwBVN17PG/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 08, 2021 at 09:57:32AM +0000, Marc Zyngier wrote:
> It seems that the CPU known as Apple M1 has the terrible habit
> of being stuck with HCR_EL2.E2H=3D=3D1, in violation of the architecture.

Minor nitpick from the sideline: The M1 SoC has two kinds of CPU in it
(Icestorm and Firestorm), which makes "CPU known as Apple M1" a bit
imprecise.

In practicality it seems unlikely though, that Icestorm and Firestorm
act differently with regards to the code in this patch.


Best regards,
Jonathan Neusch=C3=A4fer

>=20
> Try and work around this deplorable state of affairs by detecting
> the stuck bit early and short-circuit the nVHE dance. It is still
> unknown whether there are many more such nuggets to be found...
>=20
> Reported-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kernel/head.S     | 33 ++++++++++++++++++++++++++++++---
>  arch/arm64/kernel/hyp-stub.S | 28 ++++++++++++++++++++++++----
>  2 files changed, 54 insertions(+), 7 deletions(-)
[...]

--b/B7fiZwBVN17PG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmAzet0ACgkQCDBEmo7z
X9vfWRAAgmO7sXidDBGjzOX7cP0Tb4rOOlQY06r6tQhTtim1xJkOSpzsGJTepdaD
9hZXErHxdvCEZY/QrxZW0VpZ1W4IEDXZBvGXcfvxL7JPvbbt+mZ4QD9zZa4ue8ZJ
9LKcRSFfjsKh0+Llu+PFyqe09XqAjtRDEv0QWsyC7HYRNHmVy2lMop8IiMLcVrM3
8t3UUsflQpMQr4nFRBqgvOxK5ydrDSP8R1v6HBOVEp3FH4X/FOPO8Mbo/zcXHSMX
LOvj0dCmQt9Rnm7wPkp1xbVTTD7MngQO5Df1DRm1o1lx9mxGQcIDerAoI1GRRNiA
WHXO3EqxEaZAkMa08bAZzBMGARpVk9YukqQOAwiWVzpH5/YRuSGDqufzV5e2Z37J
00e1wX501ZgcduRiO+MlDD88PBPAF8ok8zm3ZwvXSs5FQr88kLGGmmiGlIe2VMNF
MYt0P3j6g/Fnv7bXd8PlXohjIPVd5w0pIUm/AYqBVTmgSchP3he1CfJzQy5ICQlh
+svzK/vxqI19FibpUjZ3t8qsiLmlyHoeA1KwQwbueMbxs76QqDMA0ZuvVN6Xt3ot
BBAP/EcFvrFw55KxIMEPhxYsPT/OoG78RFhq0hVe7ht/8q0UF6gcFvUFla0T39oK
JmKkQSqicoo79PtzMMcKUigpmrkt3NgSgNy4o+70oYnFRVpm2g4=
=mdQE
-----END PGP SIGNATURE-----

--b/B7fiZwBVN17PG/--
