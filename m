Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7F42A330
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbhJLL1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236129AbhJLL1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:27:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B978C60F11;
        Tue, 12 Oct 2021 11:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634037910;
        bh=qnqPDkW3PEuRHrH7fEFlwj1INa9JZghbCmyes7XDZtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zra4gQuG/UTWpwnl9rH1pLCnKl+1SHvoyjxNBszC96etvTcWQIgWJRIhV/y/P9uaS
         ndGwytiCrrBgq4S05SPN8ZM7EXc7cjzrsevWXuH/pLatNUmbEtwE+uq2R/bDpD7RnL
         beDQ698aGTzyvSFnE4MpbDRxnlLhfgbAudAzd6Cfhb3UltUHd2DMwrpIygoGavKCIj
         s4ESe4MP1ZP1G95uWg5ozLHN9TwgPHT9aCcvubtqsUy2EfrjZdAPU/330vuVbiahqA
         o8o+NKSFip7d6PvNALTSrPifquECuuBuk3ycixg/KpkkpcqoOmkf1EmL+MJS/YZPOr
         bR7kVXA5Qy75Q==
Date:   Tue, 12 Oct 2021 12:25:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] ASoC: wm8960: Fix clock configuration on slave
 mode
Message-ID: <YWVwk1kqyF+gzEC0@sirena.org.uk>
References: <1634036070-2671-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xmS7fg8H5aUGfp6g"
Content-Disposition: inline
In-Reply-To: <1634036070-2671-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Swim at your own risk.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xmS7fg8H5aUGfp6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 12, 2021 at 06:54:30PM +0800, Shengjiu Wang wrote:
> There is a noise issue for 8kHz sample rate on slave mode.
> Compared with master mode, the difference is the DACDIV
> setting, after correcting the DACDIV, the noise is gone.

Charles suggested some updates to the patch to improve the error
reporting here which you don't seem to have addressed.

--xmS7fg8H5aUGfp6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFlcJIACgkQJNaLcl1U
h9Bj7Af6AoUC0r7+IN4MGFP2D+GI8ETZVSb6+NtZHAxw+TaFmQLwIhjzcEcDRtjf
hwLaEhsJNeks7PautGeGBzCpzO87FXDMcTh98x53l0nZDPX+OOYqPgicrRsPgPZ1
g1SdtDg4dlJCyj0Iymr0l8Famw7s2HlnLhufqrGigzdAT/ZDTL/tIc+G0YJR+p1q
Bmn2P1TVWvtIBBwVoVczqD9foLpX79Bz9l9PjFCQ3CG9HcAeceXI2mxc/xBaP00B
Eh7CU+QDvDe73E66/+9dTnZpoffnxK7bu5TwnXvLJ2RlDlwBAnF/f0G/1A82VVnB
2fuvTTKz2aFZG9lBtIvl0O3PhPI1MQ==
=F7Y8
-----END PGP SIGNATURE-----

--xmS7fg8H5aUGfp6g--
