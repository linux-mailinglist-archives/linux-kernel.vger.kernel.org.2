Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF6C366FA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241633AbhDUQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbhDUQDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:03:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF366C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:02:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0DEFE1F41EF9
Received: by earth.universe (Postfix, from userid 1000)
        id 2CD463C0C96; Wed, 21 Apr 2021 18:02:48 +0200 (CEST)
Date:   Wed, 21 Apr 2021 18:02:48 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 092/190] Revert "power: charger-manager: fix a potential
 NULL pointer dereference"
Message-ID: <20210421160248.fveahtwspxa53fft@earth.universe>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-93-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sk2sus5fq2i26mdz"
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-93-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sk2sus5fq2i26mdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 21, 2021 at 02:59:27PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 75cf4f5aa903604e1bd7bec2c0988d643c6fb946.
>=20
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>=20
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>=20
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Doing another review:

create_freezable_workqueue can return NULL when allocations fails
and it is the first call in late init call, so it's fine to just
exit with -ENOMEM.

I suggest to drop the revert.

-- Sebastian

>  drivers/power/supply/charger-manager.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index 4dea8ecd70bc..f34c07ffcfe6 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1749,9 +1749,6 @@ static struct platform_driver charger_manager_drive=
r =3D {
>  static int __init charger_manager_init(void)
>  {
>  	cm_wq =3D create_freezable_workqueue("charger_manager");
> -	if (unlikely(!cm_wq))
> -		return -ENOMEM;
> -
>  	INIT_DELAYED_WORK(&cm_monitor_work, cm_monitor_poller);
> =20
>  	return platform_driver_register(&charger_manager_driver);
> --=20
> 2.31.1
>=20

--sk2sus5fq2i26mdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCATJ8ACgkQ2O7X88g7
+poxrBAAgYJBOi6VDcxiDF++/eI/Eooun3oXyFwzD7NNS6IU4F8laGH/ovy1wwGG
17i1jZfok3kAaWuEPtfaFYym8tDbAvzpCtum1w98+yOu7iIICOPP951YjSZ1YE9N
09FatXOowFlV2X9vSDwiYIToWr1x+XERDFMOm5RxVkcqUdSFoNSuHT99i3yqktfC
1gI/2l/H5we1CW6gM3c2vzcnpylfVcQiR+G8Kg0tVhBJO0IqK5LomSE/78NZkZKK
Almy+FtnDi3E2vrciRTGlkx9dMuCta2lOdaxeOq7HaLsJ20EdmMmBUEw2Mr7iKP7
vslbGysdZ5B2O8unPzLfFB8jPqC1fKNmE6abUtcoLOyUg3qdv2TAGto4Be1L8t/s
jetg7fIB+mCcG8pLEkDOaX/6KKUvMGgoIDgU7MA1r7FRHP0bE2pjjwOZDsSjLOfC
+zGKhH4FBb3u+uV13liLH915vWYDPGbGyIM4Lxfx2HTon77JfM9xWlv/Rr6Knk+H
LVqMaSJb2zCIADPKXFeFRMmmAVvZaJbxKG6TFRyo0jQ++MMEysdzgz+EeK9Wc4vR
gET2+aYmyIBdIeIv8ERh1fjroN87GVYl/k8w+WfPgjhcJCyIhA8OuQZ5aGqH0eTp
04iEKpqLAY0FgKzs2RzUCEy8N6PDZMzCFkvYS2t2VF/Ob+1BPmc=
=sn7L
-----END PGP SIGNATURE-----

--sk2sus5fq2i26mdz--
