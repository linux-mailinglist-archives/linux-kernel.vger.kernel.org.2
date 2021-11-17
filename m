Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC234548FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbhKQOlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237969AbhKQOlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:41:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EE5F613AD;
        Wed, 17 Nov 2021 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637159918;
        bh=+sgGk1MAqqjZjV0T3zcDclmfwLLAWkR2iTA/ErTNlhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PgwUzmkVZnENX4tzSGFGDooaLrt5/UkyuxtbbZXKzWKo0sUbrnrJzzrJ9Gd7QmKQP
         J129HARnzukITzYfC79D7Kuf8LbMnjS2nm0f9rsxsfD5Szute22lWsgJqtZq3hh/Rx
         F+y9eIdpft/DFkGuuWwQ+TQ+LE2RUvVCfB9FFcfpp/9TrQb6QsBxv+u5btwPZPZSAJ
         CO7fJ6p6e0bIViBkz718wSTe8opN/sktvEjJ4+n8pZDLwx+oJi/oJjS8uieXdCPpHy
         t/AcawvxRT1ni+2IXBPMwF6tkr0OC45aYaivlXSIdUoXx7y+gWOAXKjg44x9dw2Qbd
         RdgkJlrGqJMnQ==
Date:   Wed, 17 Nov 2021 14:38:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Subject: Re: [PATCH v4 00/10] Add support for audio on SC7280 based targets
Message-ID: <YZUT6BQKz00jXov9@sirena.org.uk>
References: <1635838265-27346-1-git-send-email-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAN7bUExa5adGLjm"
Content-Disposition: inline
In-Reply-To: <1635838265-27346-1-git-send-email-srivasam@codeaurora.org>
X-Cookie: One Bell System - it sometimes works.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eAN7bUExa5adGLjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 02, 2021 at 01:00:55PM +0530, Srinivasa Rao Mandadapu wrote:

> This patch set depends on:
> 	-- https://patchwork.kernel.org/project/alsa-devel/list/?series=570161
> 	-- https://patchwork.kernel.org/project/alsa-devel/list/?series=572615
> 	-- https://patchwork.kernel.org/project/alsa-devel/list/?series=559677

None of those links seem to show any patches (or errors)?

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--eAN7bUExa5adGLjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGVE+cACgkQJNaLcl1U
h9As+wf7B+JAOPsfgU0nEW7ON59XP8K/aBZrQ0SjOCL5GE5Azb4/+FDOytGgwgae
HW9ZIlOn+bYqo4VUVSwVoEdL91UnVUBxdTPrHS5pu5ZtT+wa7xYMGKHlQnxv5t80
DUoPNFuQydEa0N51Xq13gUgvhrxnY9iFRx995WKowjXx51glDSuaT0+l4MhZbl29
2ZzgTGyKOJSO3PgjSajop8/zWrOrKfOeSgPpA+NJxZU6HPhjfyEFozTKEieUbjHO
/Ac2XgsD8whOKg/2FC4uycI2txWFGLGP+vuIMqeB/oNEcrVLzQN1eWFWO1YNLwXA
IsonKPo/U83HY4hEFtapz0na0ScuUg==
=NHdC
-----END PGP SIGNATURE-----

--eAN7bUExa5adGLjm--
