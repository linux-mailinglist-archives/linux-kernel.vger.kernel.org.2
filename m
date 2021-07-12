Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457EA3C5C86
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 14:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhGLMps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 08:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233685AbhGLMpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 08:45:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 027E36101E;
        Mon, 12 Jul 2021 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626093778;
        bh=ZLUQlbYl3sNIYsakvpyyvP24BJXkLmZ1qwg3VR1I4aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKnsxXNS2n/2DGBJvyCY4Qy55w+leeUb5zJNlDaVXvdx14qKf24rKzdnUiQJC63M+
         a0PdLdRZF72/09jk9CXPZ7AmnG9KRjN1jzUBSXeNZe38ivRtH43Nrc1excWqFbk1l1
         p1DbbuCBO3jezX2tpSSshsswWgQILpQcOnorshcyv0erxpGYzjti7klOndYrXeEiD6
         39cLodf/Y8kFELEygEG5/6kI8abRRji3B+w5pgzx3b74/HrBRQcHThNYv1iC5qhZJw
         yqu4irEG79TEC3KyZofPTEUbWINZmkF7Nc4f/unExZqQeEpVBQ8SYeStx/4WO7FuCn
         BlrOwpx3G01Xw==
Date:   Mon, 12 Jul 2021 13:42:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, hdegoede@redhat.com,
        mgross@linux.intel.com, luzmaximilian@gmail.com,
        lgirdwood@gmail.com, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <20210712124223.GB4435@sirena.org.uk>
References: <20210708224226.457224-1-djrscally@gmail.com>
 <20210709170426.GC4112@sirena.org.uk>
 <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
X-Cookie: Hailing frequencies open, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 11, 2021 at 12:37:03PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 9, 2021 at 8:05 PM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Jul 08, 2021 at 11:42:24PM +0100, Daniel Scally wrote:

> > What is a software node and why would we want to use one here?

> Software node is a representation of (missed and / or quirked)
> firmware nodes in the code.

> > Why are we not just using board files, what does this new abstraction
> > solve?

> Software node _is_ a board file part. The idea behind that is that the
> driver, which requires any additional / necessary property that has
> been missed in the firmware nodes, wouldn't need special treatment if
> that property comes from a board file rather than firmware.

This doesn't seem to correspond with what these patches are doing,
they're creating something which bears no relation to any firmware
interface and the code is specifically looking for swnodes.

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDsOK4ACgkQJNaLcl1U
h9CgZgf/awL7UyQNHdgqbZR+gMkAr4D2ldjhbOFFPWziSR5jV6YsiUJFxNEfHg1E
BwEyHB1b/AjuSY0b8wDY8qpizohjZZCZh8pyWtXGgwbOp2PAucCyrHfviehRMO1D
cdvVJCi3Z9CaWdSBscKYhji4uAhzn8RPzd82Brfph1wsIeQZSwcr0RqraJje8JQo
0dL5L5RJUNaU5ws/vbR61QNOMLKeqvaTPkuqGEWWOYzmHm8eFk+uUXVHn0C1a7Mt
j+p15phNwxCL6lAHJrlkXFvvAt+awwFteMSJscyWACU2IctwqBCrgNSoCm2BcfKR
Rx7qz92J2prvzLYIWFdh4Grfdvyfug==
=KgX4
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
