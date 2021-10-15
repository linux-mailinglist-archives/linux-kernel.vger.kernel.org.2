Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F142F8B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbhJOQxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241650AbhJOQxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:53:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC8C5610E5;
        Fri, 15 Oct 2021 16:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634316699;
        bh=+YAhqqeg31opM/FErwfeSfZchusHTV/GnvHk3C8Fg2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFAVa8q6kq5NnsKviR1mANImu7ygaf7VRXTJJ7LiNVEY3z7OB4HTOUIz309aRLWvs
         IH6UU7vlhuMuGAz2CMbqTDLGf5r9g8v7t5eeN+Gyv88f7lj4ARPuaNoOHIDEIdiy6y
         NttS3hSfveC4q317TDkoQ4/7HiZk3dzolpMUYrBZkf1OHMJY9bXRnVfY2VTHu1gdP/
         ycVfmYldvUN+lzZ5d7C9CuM2fOBKrYLzuAlze5bDlHxP9cZJee7iosTQjm7ugdPDc1
         SN+o3uB6aHzkRqE+fsYRiTo2Xxmqve2BODIXiq0iL5fwg4Ykx69vG0hiMyIh4XtBNs
         rWM6CSh3utxow==
Date:   Fri, 15 Oct 2021 17:51:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     George Song <george.song@maximintegrated.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, george.song@analog.com,
        ryans.lee@maximintegrated.com, steves.lee@maximintegrated.com
Subject: Re: [v2 2/2] ASoC: max98520: modified alignment and blank
Message-ID: <YWmxmBh7J1x2SaXi@sirena.org.uk>
References: <20211015072709.3167-1-george.song@maximintegrated.com>
 <20211015072709.3167-2-george.song@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c6F6S5RFH6FoFZXx"
Content-Disposition: inline
In-Reply-To: <20211015072709.3167-2-george.song@maximintegrated.com>
X-Cookie: 1: No code table for op: ++post
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c6F6S5RFH6FoFZXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 15, 2021 at 04:27:09PM +0900, George Song wrote:
> fixed all CHECK and WARNING for checkpatch --strict result
> removed MODULE_AUTHOR to make one maintainer.
>=20
> Signed-off-by: George Song <george.song@maximintegrated.com>
> ---
>  sound/soc/codecs/Kconfig    |   7 +++
>  sound/soc/codecs/max98520.c | 121 +++++++++++++++++-------------------
>  2 files changed, 64 insertions(+), 64 deletions(-)

Looks like the same issue here - squash the fixes into your original
patch and then resend that as your version 2.

--c6F6S5RFH6FoFZXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFpsZcACgkQJNaLcl1U
h9BxhAf/ZP7AuNZwTFb2d6XyaWTWhMHambCrYCcXRNyDiOYGeSxvatyPzp29PjPb
jqWT+gpcKI76X6j5Yl+viwb4nn7Udlp52Pj7bGnc2vT+pegPv4dqUAs5ulKnHmO+
oeJQC9IK1mpLhJ+unt0WhzjZ7n6VT71yVVVeSfulyj5MB0/tflzkg6NPfxxHJYgH
NwvgIHMOfX0mUdQrHA9Tsyu1kmkPnbVgNcaiU4kNtVoFKiOzc5fkZJgqhe5o9kkU
q/cFRdalfv9HqYhpxNAmIU7G/Nnm23HKEsfcYsW3YEudVTbfODpsD9EYhgre/trF
IiwgiTPGI0txoXEWtbSWr6w0tBDyqw==
=dZtG
-----END PGP SIGNATURE-----

--c6F6S5RFH6FoFZXx--
