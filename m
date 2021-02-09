Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27407315BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhBJBH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:07:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234548AbhBIWbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:31:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F26A64DCF;
        Tue,  9 Feb 2021 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612909845;
        bh=aElboiqUnwR60IIieAwxZ0/UogaCICdYpqt/BDC5xaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKFMhqjRdwMrFoFFLkOj2yPtqpuqDT/GMWk+myP7cSptzE+Er4bomoT8tCrcpQCfk
         uHtrZFcQYPbUh4e649w5HEj9scECzBRpVwwqEcylAxQorsP39a76Th42S/+9wtbrYT
         sX/dgfaYhvMT1fW/ay7NRhiqzmKc235luf6B+ocqTQ9qNuoJZb54vmJ1kG792QuYEH
         z0V8030k94Ht4PSKt96eINydx2ReggFZT2PxWEo0rMwcAbhpPFV6ZhzkH2wtY9+f6G
         04LNghwVNW/tjlGCktHNoj3g80Moh7fyFzpZeSyY4X661b4tpC+v4Md3fu75wB+PDR
         wyw3Iy2cgtwOQ==
Date:   Tue, 9 Feb 2021 22:29:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 2/7] ASoC: fsl_rpmsg: Add CPU DAI driver for audio
 base on rpmsg
Message-ID: <20210209222953.GF4916@sirena.org.uk>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com>
 <20210208115112.GD8645@sirena.org.uk>
 <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
In-Reply-To: <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com>
X-Cookie: Put your trust in those who are worthy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 09, 2021 at 05:16:16PM +0800, Shengjiu Wang wrote:
> On Mon, Feb 8, 2021 at 7:53 PM Mark Brown <broonie@kernel.org> wrote:

> > hw_params() can be called multiple times and there's no need for it to
> > be balanced with hw_free(), I'd move this to a different callback (DAPM
> > should work well).

> Which callback should I use? Is there an example?

Like I say I'd actually recommend moving this control to DAPM.

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAjDOAACgkQJNaLcl1U
h9BfxAf/fm751rk1InZcdQUy/P0JjMUL41sYCGQ90Gg1k2R3RCuWuoeTeCO0a0Yb
l474cbyVRak4jHTNNgBjRryRcKW9r/NvV+WOdVVUKdVRJ+PpL3VzFLu0nSll9vDg
aF/J74dcRx2+yj/+Ey8kDwbANEmjGKHdYd9NuJcPcPk+owkE9h0h48n4DpuFucQj
O7anqyPPxnh1mW/gKSE1Sn0f8MhSWelw+xdX5PlWrMw/gbuW+OyAhwt1DyOMgakW
xooN5vm0ALYQtVOM1RnKsKta5TDZjlRkI6Zkv4mojbihSKV/rxTju0sLoblIQ/Ju
0jO/4lAwVhqvokUPYs1HmRwF9Sat4A==
=1sE+
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
