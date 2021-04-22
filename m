Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E5D367FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 13:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhDVLmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 07:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235977AbhDVLmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:42:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 851A760FE3;
        Thu, 22 Apr 2021 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619091728;
        bh=8Pasp4TTA3apAA496rhBw6QP+oz7qQDJCuqMfNBWTP8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=awS6u2a+GZbRqbH4LetCs1NvtFHuswOBwgY5/MPvLzpiuoX8qDrIVqxBTqggsuHIg
         ZOHgvB0/rdH6REr68UnhjUMwgxCO2pv8V92mgtt1aBxfkhzdDpKp2ceGf4JsX2iZ08
         rp/75of/zC/iLTABvPUxGQU3LOUq/Nwl0/NhxCa/QKd+Nzfl5MATd7HRmf4mZRwV9Q
         2LOiuPHb9CbDFWnrEfmUYdV53tQFGmFJObR6kQ1gefm1s1RZAQE9jL3tgy5KaPn9B/
         luovl6lwwAHjF9hJAgtA6qikk1Vw2p77/4/otZRnxEo7CJaiUPxFexZm3P3t2r3gap
         vk+1E6BUmsp9w==
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 026/190] Revert "usb: dwc3: pci: Fix reference count
 leak in dwc3_pci_resume_work"
In-Reply-To: <20210421130105.1226686-27-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-27-gregkh@linuxfoundation.org>
Date:   Thu, 22 Apr 2021 14:42:01 +0300
Message-ID: <87fszimtpy.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> This reverts commit 2655971ad4b34e97dd921df16bb0b08db9449df7.
>
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/dwc3/dwc3-pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
> index 4c5c6972124a..0c0619f7b1a7 100644
> --- a/drivers/usb/dwc3/dwc3-pci.c
> +++ b/drivers/usb/dwc3/dwc3-pci.c
> @@ -226,10 +226,8 @@ static void dwc3_pci_resume_work(struct work_struct =
*work)
>  	int ret;
>=20=20
>  	ret =3D pm_runtime_get_sync(&dwc3->dev);
> -	if (ret) {
> -		pm_runtime_put_sync_autosuspend(&dwc3->dev);
> +	if (ret)
>  		return;
> -	}

this was a valid fix. pm_runtime_get_sync() leaves an unbalanced get on
the runtime usage counter.

It's okay if you prefer to revert it and have a new review cycle for
this, though.


=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmCBYQkRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZwhg//SQjTJCiUgSHwS/TwZBriED8OUImOTbUi
6Sh/QkxL6qbNiK5/rINJbHu+CkQYi9rHKVXL+/1MfGrdawzVSu4T48wwD27DXLp2
q/xyNa0kdreVZ03FyA3stFR+Cx+z08Fp5Cda888MjTzTEjDW+lmtsNhjiTpEExJN
+WO1DHWj98BF3O+8RvhwOgfrakpQLgJl9vkKdZdiooDqKqJQH24JDjzlue8miEoP
rLJCQ6jyF6AQ5qlyQ/IvZWuqFwIVAhDd5wbwTdhBphy34jDDdO+OHaOxw+i5SSOf
D8gefvZI6DeK+6MF6QPqC1FGXF3W7Yl30twqcyovkMw4rQ1LxSKQKhbJuwXD3La4
YOh9oylJOGz4i6vwyeZi7MQh3nhUeNFtvXKH0xkva+fwsZ8voAABk4ctaQZPqP+F
YJMGCNkarXt6PoCBMyS4iSnc7J5iCy08pqq1TqNQPi93PkmWyd3r1vxXajt2ssD6
btcmNcqbJAYOxoS/J0JuO348IapBBm4SkEZzFIUiL3keCQ0+VePjSP9LjGgmxKwg
Q2frj/nJeErsj4hq95jcpRsW51BpdwyOTO0OYhvQH4LErt+PltaFxCGUzf5KYKKH
coibtZdTgJlRFQaxWPQgh2R39He3QX0R8NKOFPz9q7dw45bDmpnl7QMJp9aWoAvk
p++acc6oki0=
=fdMc
-----END PGP SIGNATURE-----
--=-=-=--
