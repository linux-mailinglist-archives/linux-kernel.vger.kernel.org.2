Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D3C34FFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhCaMDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 08:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235386AbhCaMCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:02:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E256961998;
        Wed, 31 Mar 2021 12:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617192171;
        bh=ftBJKeSakF7XMeKo9EWSc1ghqWc3O5MDjEvFKjFi+3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uAoNjg5b951dWWlc12n04W3gXcNDMZ4PaavYsgkSRzDUsb2v6tuRZuBcSpBrr8B3W
         fydI57os6aO/jkq+3pFgKUbSkgNzvoFU8srGOS4G6cSG+kOfAjtWdMrJRBp+iyjXcU
         gz/L0ZnI+Oaqxqh+gJQDJobjHgNpmJec2vyRTDKHjncKWA+ZqUl1NNzJpGsuey+tub
         qvfs+qv96jluN2EoVK1l5EIHjsPkZTe5Z3XhVkWaPbPD0MdEpF+Bi0fR3h6jcDioUq
         uGlhqn3tFRdcwtQZDVmb/vQSIv7uGdXi4TdsSCK9taLHWes2Vy57LEnO2cOpi40j7P
         GNeMlDJHfYmaw==
Date:   Wed, 31 Mar 2021 13:02:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jack Yu <jack.yu@realtek.com>
Cc:     lgirdwood@gmail.com, robh@kernel.org, alsa-devel@alsa-project.org,
        lars@metafoo.de, flove@realtek.com, kenny_chen@realtek.com,
        kent_chen@realtek.com, oder_chiou@realtek.com,
        shumingf@realtek.com, derek.fang@realtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: sound: add address-cells and size-cells
 information
Message-ID: <20210331120238.GC4758@sirena.org.uk>
References: <20210331071046.12526-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <20210331071046.12526-1-jack.yu@realtek.com>
X-Cookie: You can't take damsel here now.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 31, 2021 at 03:10:46PM +0800, Jack Yu wrote:
> Add address-cells and size-cells information to fix warnings
> for rt1019.yaml.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBkZN0ACgkQJNaLcl1U
h9Az1Qf9EUsAnv1GNJ5Ggh+zxAswVpGZsiGdpMhjmCSiMwbU584ZI9XN8q05Fdzs
jRENfkjkwiZy7xkGg+6LY1pplZdKeWxVF1KF1ZJwJ93G6acTy6c0XS0a8rgWxXHP
nu9PvSiwB9ehWnUdTf9DLdgs91JjAWBGPfSC3TPPtooxS1nJAjFbqVmuqcd6bs5J
fo3y8OjgyJzn2x9Zoz4tHd7/sFX3tQisSzZgUPYNH6yQQrHnSelviP/i8ktOFgNg
tNT7aZnb2SxMmNoT7ZlWLyw5IANvThlT3cSfC6oXCRK4ylE+fK+vamKllPqAJmfy
oPBuSYAz+JNrTezUwpeQh1M4B5EVVw==
=63Oa
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
