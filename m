Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520663B0532
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhFVMxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFVMxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:53:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81DDB61352;
        Tue, 22 Jun 2021 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624366248;
        bh=igf/oBppr25pGo4fdiyflW9vzPNgg5t2IWKA7sOBX5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfyhEaCRkPRLW4Zcr+mN3NwwAQ3WAPAjBLrgRAlm49UsCoF4zszPh1G1+jils9Pjl
         vj/0p048h2x2PkCvGwiXdrGdaLT1la8KZ9p9N6nnp+IqdMXSxfnjKN28rMnsX6bgLI
         6Ql1tvCmm2ZtV84L7uepZjuiy7p8ZSpKqV5l9jdO0k8myA1PH0kNNGzwfs2YRtIeH4
         9aOAQcmKf0HkkgMzJNcLKOk439gf3La82ejlazahNnmRSCl3AkHwFMf/zpR8xmOo3Y
         jpcNplXU5S+vL1BhFHgentdE42U+0weUyMa39/zt0R0YKMCMc0WJPazjtpf8vMZAQC
         fBlTX+q1wbcQw==
Date:   Tue, 22 Jun 2021 13:50:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: da9052: Simplify checking DVC controlled
 regulators
Message-ID: <20210622125024.GC4574@sirena.org.uk>
References: <20210618141412.4014912-1-axel.lin@ingics.com>
 <20210618141412.4014912-2-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <20210618141412.4014912-2-axel.lin@ingics.com>
X-Cookie: fortune: not found
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 18, 2021 at 10:14:12PM +0800, Axel Lin wrote:

> Only DVC controlled regulators have activate_bit set, so just check
> activate_bit we can know if the regulator is DVC controlled.

This feels a bit icky - what if the activate_bit for some variant were
bit 0?  I'm not sure we're likely to see new variants but even so the
fact that 0 is a potentially valid value for the bit feels wrong.

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDR3JAACgkQJNaLcl1U
h9B1fAf/ZzA7ucWP1tj3V1aeaRcIuo7Z6/5wu9swp0/58zXaLwywwW5v5y3aBkve
qDliFTfe+vE8G0EJaXMt6u69fFqhhJcCvU/eZciw9f3Tq7adLWH7+3PneLBWcxir
XN0DUE9LIZOCpxBj1ETPDeTBsWF0owekbxiWg138PZGcQ/4DO7dq21BwhzrVHhc+
bRutgvkojpjwp9RGCLo4BvflQQLSm65bpTbPjklohLctqwxpbQavR6PGOlqFXNYB
qS8sak/dKEnsrP4GK3DSnTS4DckAOZFWYoZ90eqR8JbqgxS4lgDt+SGLnJhysp1N
UfS5MB9c+nGqDUfzUNHqpGx8lZXlwA==
=deo4
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
