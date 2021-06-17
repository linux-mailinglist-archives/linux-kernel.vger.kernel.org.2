Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BA33AB988
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhFQQ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 12:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232519AbhFQQ04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:26:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B70B613B9;
        Thu, 17 Jun 2021 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623947088;
        bh=INq4nssCgYsIEKzYkC0Op/vH8B8aE187QI5AyGhlWxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtPaz8GQTTMVVgSDQIOJ+S+7TxupFal78/odxYuTkiSTyDWOtO9O73BHhefzoqrJB
         VfailCngQHg8/m/NNIvvS+L3dfcVVEvXhNsz+jPmILsuEZspNOtPc7/MW+U1psbjzT
         oLXqRwNwJ9DyoQdS8tSxnYjdSjWzUlTpaUA/mljCDV6mZNlUCeZIJw4inR3hTrhIRr
         DOzlUfyLd4cu5tCrkNBUgeHBUQ45h4fikdS3ZmGnfYTOz7FBOS3f+2rUJSijUwD0dw
         aNnF00p0XOEclfzSMbrEDAeHL0I6RBy+sd9NJ5SeJwAhvYaFgnLvrqthn9PGYKcyfr
         60KVvSVaNxZDg==
Date:   Thu, 17 Jun 2021 17:24:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     cy_huang <u0084500@gmail.com>, lgirdwood@gmail.com,
        matthias.bgg@gmail.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        cy_huang@richtek.com, gene.chen.richtek@gmail.com
Subject: Re: [PATCH 1/2] regulator: mt6360: Add optional
 mediatek.power-off-sequence in bindings document
Message-ID: <20210617162428.GG5067@sirena.org.uk>
References: <1622616875-22740-1-git-send-email-u0084500@gmail.com>
 <20210611201643.GA1583875@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2E/hm+v6kSLEYT3h"
Content-Disposition: inline
In-Reply-To: <20210611201643.GA1583875@robh.at.kernel.org>
X-Cookie: But it does move!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2E/hm+v6kSLEYT3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 11, 2021 at 02:16:43PM -0600, Rob Herring wrote:
> On Wed, Jun 02, 2021 at 02:54:34PM +0800, cy_huang wrote:

> > Originally, we think it must write in platform dependent code like as b=
ootloader.
> > But after the evaluation, it must write only when system normal HALT or=
 POWER_OFF.
> > For the other cases, just follow HW immediate off by default.

> Wouldn't this be handled by PSCI implementation?

Ideally I think...

> > +  mediatek,power-off-sequence:
> > +    description: |
> > +      Power off sequence time selection for BUCK1/BUCK2/LDO7/LDO6, res=
petively.
> > +      Cause these regulators are all default-on power. Each value from=
 0 to 63,
> > +      and step is 1. Each step means 2 millisecond delay.
> > +      Therefore, the power off sequence delay time range is from 0ms t=
o 126ms.
> > +    $ref: "/schemas/types.yaml#/definitions/uint8-array"
> > +    minItems: 4
> > +    maxItems: 4

> So this is the delay between BUCK1 and BUCK2, then BUCK2 to LDO7, etcc?=
=20
> If we wanted to express this in DT, we'd made this generic which would=20
> need to be more flexible. A poweroff delay in each regulator (similar to=
=20
> the existing power on delay) would be sufficient for what you need I=20
> think.

It's not exactly a delay that's being described there - it's a series of
timeslots, each regulator getting assigned to a timeslot.  You could
possibly do a general binding by specifying a delay from the start of
the power off sequence and then (for this device) having the driver work
out a mapping of those times to timeslots.  That feels genericish, you
might also have things like mode changes but it'd cover a lot of the
cases.

On the other hand this is the sort of thing that is often just not
configurable and where people often make weird and inflexible hardware
so things that do implement it are likely to end up wanting to add a
bunch of constraints which might be a lot of hassle.

--2E/hm+v6kSLEYT3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDLdzsACgkQJNaLcl1U
h9Cy9wf/ROgBTEBrrxZAUNZNi+NXNQw980J3z3LZGhLX5EOkMxzPPXdy0EuF0ek6
NJuBOiyrmSj8i1YDSY9CVcR5TSDjqL8oJGzCo5KBtfW6dXEOxHfAhlQNhIlKBgVI
YLd6Zg+D7L1EfCNx4yf98DBXaqqZuVHe4aOLP8HmjR6+8QoJBlYso0DeM7CqLKo2
jpe6mV/ihm73qeSa0WMQ9/lEln/DZ1q/xivNbYjmLqchXIp8/KilF0vw6yuVLlJY
QY2I012mnmGL/MtWmJohwU7aWZaTK+J8PMpKjglre25GCf2i/29PL68q9xwwwB4r
5VVzFXJo0iqqEAShFU6/dgitjQRSGw==
=eGjM
-----END PGP SIGNATURE-----

--2E/hm+v6kSLEYT3h--
