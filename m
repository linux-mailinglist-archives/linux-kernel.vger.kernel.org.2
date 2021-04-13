Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AC235E46C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345664AbhDMQ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232449AbhDMQ4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:56:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FE5F61369;
        Tue, 13 Apr 2021 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618332980;
        bh=BMzJR4VJ6S1chDRuLo9fNI6baCLetujlMTgG9T1hBTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1+F6QWKSDbw99N9oHLwneBEHm7z2DLMLXAPn+TicXytB6qyUrMKJTzH/1BOi1Kjm
         q0FSLD/sX3Y0PXgIrqaIngI6mOcmUVsfkjK/2x2RfHhW0GFQ6gwldtvXNWyshYcwDx
         F8kQc+lf9kN1CJuq/CXgy38FmRkYBwnsW48PxFrcyTJ8UoDYNg42/qK++/stJwStJ+
         OW7V9M7WPAw/EKI3N5X9ysBAJdGLrn3WuSsVMDLbacrCWTA5q96+ep+lYJSZOm096l
         +85NzGjWUtucRFaxt6R/ci4pFFM+8wKJITk+XEXbDowX+0nH2uefjWmOL65rbRMcl0
         cGNq9OGI9h8Ow==
Date:   Tue, 13 Apr 2021 17:55:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        patches@opensource.cirrus.com, kernel-janitors@vger.kernel.org,
        tiwai@suse.com, james.schulman@cirrus.com, david.rhodes@cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs35l35: Fix an error handling path in
 'cs35l35_i2c_probe()'
Message-ID: <20210413165558.GH5586@sirena.org.uk>
References: <15720439769ba94ffb65c90217392b0758b08f61.1618145369.git.christophe.jaillet@wanadoo.fr>
 <20210413124323.GD5586@sirena.org.uk>
 <3f276ab6-1704-84ed-3681-d639ba1e0010@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Content-Disposition: inline
In-Reply-To: <3f276ab6-1704-84ed-3681-d639ba1e0010@wanadoo.fr>
X-Cookie: Shake well before using.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cW+P/jduATWpL925
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 13, 2021 at 04:02:21PM +0200, Christophe JAILLET wrote:

> What do you prefer:
>   - you fix the subject?
>   - I send a v2 with a new subject?
>   - we leave it as-is as this patch is a no-op in the real world? So it
> doesn't really mater.

It's fine, I already queued it - more a note for the future.

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB1zR0ACgkQJNaLcl1U
h9BJwgf9G8n6zatxyWi95NrgjszQW2bkdnOdAhkOym0X/xyrH6kURNsAR7zrPGkT
LEv2oUZTXBFc11NJy2/g/W7+MMOTA9+E4vYmqJUZQbZ6uinJZFGxgvIlgUsKy4d/
26uCsV8bnzRYmeH0iw9G+tE41Zm+cA/TF6DSGowoyvg1OoLROp6/0aHhCjQwEnW4
Wj263Eb88PcVN3XpXCIAbRCHJ9TnO8asSUzyMXTadQnJNxdCvg8I5fVahDLekp+U
mAsyyd9VyL2lAgAjfjGvfglXwOLWjMNKi+ySQJhysOGZqIJ7JYxdIMY1lZNQWeJ/
TQmnbD4Jigu7mg0wyoNNLOQ7bepCPA==
=XUD+
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--
