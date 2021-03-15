Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EBB33B038
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCOKrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:47:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:51318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCOKqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:46:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF52DAE27;
        Mon, 15 Mar 2021 10:46:42 +0000 (UTC)
Message-ID: <dd4b1b389faf7b0219e1dccf48e17126887b3c70.camel@suse.de>
Subject: Re: [PATCH] nvmem: rmem: fix undefined reference to memremap
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        srini@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Date:   Mon, 15 Mar 2021 11:46:41 +0100
In-Reply-To: <20210315104457.18140-1-srinivas.kandagatla@linaro.org>
References: <20210315104457.18140-1-srinivas.kandagatla@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-58uzgCmbgFLfwrFmaC37"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-58uzgCmbgFLfwrFmaC37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-03-15 at 10:44 +0000, Srinivas Kandagatla wrote:
> Fix below error reporte by kernel test robot
> rmem.c:(.text+0x14e): undefined reference to memremap
> s390x-linux-gnu-ld: rmem.c:(.text+0x1b6): undefined reference to memunmap
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!

> =C2=A0drivers/nvmem/Kconfig | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 642ddc699fd1..dd2019006838 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -272,6 +272,7 @@ config SPRD_EFUSE
> =C2=A0
>=20
> =C2=A0config NVMEM_RMEM
> =C2=A0	tristate "Reserved Memory Based Driver Support"
> +	depends on HAS_IOMEM
> =C2=A0	help
> =C2=A0	  This driver maps reserved memory into an nvmem device. It might =
be
> =C2=A0	  useful to expose information left by firmware in memory.



--=-58uzgCmbgFLfwrFmaC37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBPOxEACgkQlfZmHno8
x/4qXwgAqmm+HrNXedFFnusOcJgYULeeKztgYoglxSMCRMa+0HTBxj+FD30tyoqH
4pMINpUpZhtqUvCgSwcexqM/DVCy0Hqbl9ulDcIRfSkGnQeyCZszFtVVeV2ICq3F
yrUreLAv3gDQDlvE8qeoTlJbj9VYSPuWnUjc2oX8vlzwKAv+ZOhem+LcBROGxrrm
kZ4HvJ1NG5w4u7p1Ey4FYXJSuO64Bqkpn3lhZF/txKZIgOjhaIusDhd1hDeMdVbp
tfZgEKk0akOYmzVazrS41AJTp17rsdSOyujQnYDrYB8EZhMcU6if71x5Rh4QPS9t
lgL2DgR20UfnsSeQ15vius/zZAwU2Q==
=6T0Z
-----END PGP SIGNATURE-----

--=-58uzgCmbgFLfwrFmaC37--

