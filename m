Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A923BA0A4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhGBMqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:46:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232171AbhGBMqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:46:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 757BB6113B;
        Fri,  2 Jul 2021 12:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625229808;
        bh=eeTaXEl8JLC6LW37q6WvarXAnfmtO7n6q0kweXuJzyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geSxiF4osfBKoZnwadMbuQc6heJPXfutDZKoPjBGhpzJGO9kC4u7OXdQ4yYX0pS2b
         Mm32eF9EAD5k4FEB/K2Lr2uR/UokKf4DoCjJwoKqFRAf7JI/fNm6Os4f5YsO5M2nn3
         NWTwlTEvODrOfxRTFcIrap76JDRKAfPPZBF/5pBa59MGY4vjGrANZLoNGaLyuSZmdR
         c5ro0x6DxfULpKCGsTHguGQJpJUiSfsd0v61WJ10OBE5vJnmKbF6YzFj7W3ZIL9bdy
         VX5N4MQx3Z+dNQNzw0fnVIgcvy3kjHhj0C4d9B8Y1wflJVQEwnAds5Q1Jo5MQU0vOY
         LdBC+RB/GZBZA==
Date:   Fri, 2 Jul 2021 13:42:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Axel Lin <axel.lin@ingics.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v11 4/8] staging: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <20210702124258.GB4416@sirena.org.uk>
References: <cover.1625211021.git.mchehab+huawei@kernel.org>
 <e90ea5dec3aa07a45ead915e01058ddb2b2901e3.1625211021.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <e90ea5dec3aa07a45ead915e01058ddb2b2901e3.1625211021.git.mchehab+huawei@kernel.org>
X-Cookie: What!?  Me worry?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 02, 2021 at 09:37:19AM +0200, Mauro Carvalho Chehab wrote:
> There are lots of fields at struct hi6421_spmi_pmic that aren't
> used. In a matter of fact, only regmap is needed.

Acked-by: Mark Brown <broonie@kernel.org>

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDfCdEACgkQJNaLcl1U
h9DQuAf+N2/fZMARJjolBx+ZowvLRR5qIMWrUPYjxU62MNItV/WuteaS63TcBM9w
rE+OWGo3GzHcGYBRY4pGmyYwqNBd6I+rFvc78Huidzi91AHktUGENDe/kttwst7T
0gS/tecn9PjGHPSNbSyW762sSlgrO0iQUICFdUPbyAgBFc65I4ZNnfwRLoIcAZAx
2WNimhUrG3+VTyW/4BdXac8iuzn4AOgva+q8FqcnFDk/nm5KrTKjDdhKnGDZDypV
EFHa4flw1aJJSAy25/lAS7IC+xcc5rENj5B0Hg4VA47gCqNtIT+naD4rE4Eqzcgv
DGrZiFyOBnn9pqJDUCP66kkrkVEanw==
=w5er
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
