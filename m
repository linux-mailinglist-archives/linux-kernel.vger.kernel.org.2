Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5E387875
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244447AbhERMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235289AbhERMIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:08:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F75F6113C;
        Tue, 18 May 2021 12:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621339644;
        bh=g+86oE/vGU5LeRgoHJ3GvrwTHfyS5Gv7wFXM34AQlag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNQJNWu4tbanjqQUGNNEMeQTLnCJMGyaz1U2rsQHydpS0aYw9kqo2+HE9jG+VVi6I
         dneXiaXxo/P2fnntYlqqNZHfPmyTdjIAiVuJZ9Mt1e0swfZ03y0btpmrX45+vA114Y
         FS7MuYi0fYr4t3rRt0zxvMWgjxYkqQZiz/m1BMZo7dXGdbOQtasM4lNuMzItzNbTrH
         TVnHqpqXrYDiZlJAmh8cKCJDPDVFfvZgtPp3StSRAqR2AxFA06Ai4sljwgabfGVq5r
         qaM+LTahjWfSnNPDS6k6GQHS7NLNlN3byxc/DTfExcksS4puVCoyDAyxIB1ld2vqKp
         KoeAmrJmoc/bQ==
Date:   Tue, 18 May 2021 13:06:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH 1/1] regmap-irq: Introduce inverted status registers
 support
Message-ID: <20210518120640.GB4358@sirena.org.uk>
References: <20210518094441.142547-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20210518094441.142547-1-fido_max@inbox.ru>
X-Cookie: Radioactive cats have 18 half-lives.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 18, 2021 at 12:44:41PM +0300, Maxim Kochetkov wrote:

> +	if (chip->status_invert)
> +		for (i = 0; i < data->chip->num_regs; i++)
> +			data->status_buf[i] = ~data->status_buf[i];
> +

This is the only active change so this only affects readback meaning
that if both read and write are inverted this won't do what's expected,
breaking acks.  I'm guessing your device either mixes things or is clear
on read?

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCjrc8ACgkQJNaLcl1U
h9Cg7Af9GI0Qpxu+fNYrN9Ywk0dCoF6MPMU2Ql34iejMYBLoz9IaLaCxqDmFG5KC
DVZduRncKGj7x5fBORYyR0TldNZrRN4Lv2DkaP205ufTAdv+i2vC1LMFWO0ZV6q4
huxHWqDKS1P8XGO4ITMENfGqSXCESEl41uSs7YQjE31DZH+LkzsrzqZYOVOSvPZi
mV9jqLM2mfVuM+Ngh7dxlXTNgC8wOCgUNPlWnijosHwMpGBUQZOho7QWg8x9pSSt
QShEqnlY6EhtiizvshpGqJ3gCL8yvxohG1depb5MMco/pTzjvAn48fxNIGyW2M+r
sKteP4je96+EugNNCvA5A+olnw/FBw==
=oEM3
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
