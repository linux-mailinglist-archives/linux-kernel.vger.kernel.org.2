Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6BB31113B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhBERtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233393AbhBEPyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:54:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECCE6650CE;
        Fri,  5 Feb 2021 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612535166;
        bh=vz0EpXJayRiYNc5TflA7y0RwX1/hD5Z5cZtbGrJpFV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Us2R3OO+4Wcy6hSv5VXYsF1KTJF/+0jcxZVFjtlnH4Z2jMuj41U2+Nklg6BH+Gx3A
         uulzEKrbnFji+Fw/sUCqG571ha2Uew4bvTQT5RL/4G6H67Jpvs+g+SAlk4bvHwQVtE
         58nU8jYVraXqyC5f6wEWex0/cLQOWuJKUYafnXhBOyEXWNQgFq6mzMBjfo2kB5AIO9
         zG4tZc+WlhpuACHGrQLKhXRCiRb9vqOhzbnLEMg7TsN/UXyeicMwrBq2kN863+Tjjp
         fjzAhkE+LOvTGf6TAcnTItnT3Usc/qpztnZz2J04qniMkT1VQ44WnL0a4HOYh/dGMR
         bEfvshfep5Lcw==
Date:   Fri, 5 Feb 2021 14:25:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, linuxppc-dev@lists.ozlabs.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] ASoC: imx-audio-rpmsg: Add rpmsg_driver for audio
 channel
Message-ID: <20210205142516.GC4720@sirena.org.uk>
References: <1612508250-10586-1-git-send-email-shengjiu.wang@nxp.com>
 <1612508250-10586-5-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <1612508250-10586-5-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 05, 2021 at 02:57:27PM +0800, Shengjiu Wang wrote:

> +	/* TYPE C is notification from M core */
> +	if (r_msg->header.type == MSG_TYPE_C) {
> +		if (r_msg->header.cmd == TX_PERIOD_DONE) {

> +		} else if (r_msg->header.cmd == RX_PERIOD_DONE) {

A switch statement would be clearer and more extensible...

> +	/* TYPE B is response msg */
> +	if (r_msg->header.type == MSG_TYPE_B) {
> +		memcpy(&info->r_msg, r_msg, sizeof(struct rpmsg_r_msg));
> +		complete(&info->cmd_complete);
> +	}

...and make this flow clearer for example.  Do we need to warn on
unknown messages?

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAdVUsACgkQJNaLcl1U
h9C97Af/adbNIcFNxOngffC2op8D1lsnbPhhXftOmDlTLcbbbFG1hQeuCEHsljRt
50gewIr1JVY2DkjhAGhtO0GkX+0VpXHSqkwPYv33tOAFJTFcODtVao9i1csmyXu8
V7i4RUPJilR6VTJiFaKLZQPL3bNUeZ+/KfqNvf/jGSydI5OqKGuH2PiomH9lEOwR
xeteoRMiPCLSxtA2+AaKVDR85e1eJkxx3qVRWuccdOkNNjSZRbvh+ViytXoAkLQj
qM7JYdtZd/ZbDagmISJiZM57cVv+ql+5Rw+B4Wb1pzxcwCbKNB6qEUmRmuD2OO+W
aBb9j6QHazt7nhnsb/x34Dx2M/D1WQ==
=ULPb
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
