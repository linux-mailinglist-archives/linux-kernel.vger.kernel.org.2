Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F5442029
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 19:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhKASlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 14:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231822AbhKASlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 14:41:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A50360C40;
        Mon,  1 Nov 2021 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635791912;
        bh=W/465Gonb/T0JqYrNNmIPOX1fgL6mxL95dFICGRyvTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHLRDNtGoZE27FcSIAI/F13Fhr3dTzeSEvPxV1cJAkTaQACBsohjM6/6WpXuFQlfi
         ZBX5BMqlqZpfQ7jiSBVGWlY9uR0M7Z9G/hAHH0av3jmJS7ELm+l8c3ifbCQokC411U
         r3WkuXu9R2OLFTOmcGGnt66mQjJNaG5Bu5KqdInjni788VbqPGdYwEECNttkMD5ofd
         ZhLJLOHGGpC13Z4rhXZx8mTcn36r9aOzOI48LeM6lio2Dlp7Dsy7pyUAYxYIlrzy57
         0Mc/qZLnrCLpaSKIZ7gm0eVlJKhZzXGbT6kEUlbpZcfc6mJ51gWYpTt+Pu1TX6/CR0
         Odu/nYYmg8zWg==
Date:   Mon, 1 Nov 2021 18:38:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     YC Hung <yc.hung@mediatek.com>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, matthias.bgg@gmail.com,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>, trevor.wu@mediatek.com,
        allen-kh.cheng@mediatek.com,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 1/2] ASoC: SOF: mediatek: Add mt8195 dsp clock support
Message-ID: <YYA0IgOPGIt0TT0O@sirena.org.uk>
References: <20211028135737.8625-1-yc.hung@mediatek.com>
 <20211028135737.8625-2-yc.hung@mediatek.com>
 <YXwoB7FtRw0AzgcD@sirena.org.uk>
 <CAEnQRZCQHxctG+3L72Xx3083shytF478ONGGpZf0A-6-+nFE=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t3purBc6q6T2VLLY"
Content-Disposition: inline
In-Reply-To: <CAEnQRZCQHxctG+3L72Xx3083shytF478ONGGpZf0A-6-+nFE=w@mail.gmail.com>
X-Cookie: Don't Worry, Be Happy.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t3purBc6q6T2VLLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 01, 2021 at 07:56:04PM +0200, Daniel Baluta wrote:
> On Fri, Oct 29, 2021 at 8:00 PM Mark Brown <broonie@kernel.org> wrote:

> > This doesn't apply against current code, there's no such file upstream.
> > Please check and resend.

> This patch was sent only to get an Ack-by for 2/2 from Rob Herring.
> The patch will go first to SOF tree and then I will
> send you a patch based on your for-next branch.

> YC sorry for not being more explicit. I think the right way was to
> mark this patch series as [RFC PATCH].

Please don't send me anything that's not targetted for mainline.

--t3purBc6q6T2VLLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGANCEACgkQJNaLcl1U
h9C5XAf/ZnMi0VtMydTyjyAMioMHmBfWGL4fveMkiZQPSYLoiblCk0AaGzHUCyBq
PrT7qz+dVzaKjttBR/Y+Ljc6tecBjX722HXPGXJ0Cu5i4w2nuQqgrGiXAcj34LeD
wnV+C8IJBtALNo8yWJfg1bnUtHalkpRetQsT20T8t8UIvylou9wmtm1xOyAKD5o/
BYLXHVkYW6vhX3sZ7CHXIGhy1YNk8sE+oeyAnBlyVL+x9H93aTOz4FKGywsnnN1F
VFaf1vTMXMfLow7XHsAWFIDohc7mWNMnlZYPY7g3UrjT0aQtE8ZbBUVoxGL4O06h
BnhMWg1Wy2bhz5/KfjPbTSh6Udv3gg==
=Wieg
-----END PGP SIGNATURE-----

--t3purBc6q6T2VLLY--
