Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC4330F44
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhCHNdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:33:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229938AbhCHNdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:33:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 698D3651D3;
        Mon,  8 Mar 2021 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615210379;
        bh=9Oy8Kr7h1XrM7oHDvEf/k+4xnP3nO5tcMZHjgyT26ZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=foyho+2PTum7XJIDNKfVlg1/oSVzBU9+v8SQJVMjzXIh1zhnofnhNSYaZUK0mvq3s
         b4nHEeCj9XjD+H+zUGljNLo/9RLJNHJO8gkllDyy+a5TXVpu3DIbe7mKME5v1kja+t
         QBWfAG4M9CP135Ub06Bt1jMXtI8SKfBgnLn50dHSTL4L8p1yqpvq8ZwegyTTSEk+zJ
         8CE8aF4BxTJdVZbJl+tbQM84wy0ywKPG0rZ0uRZ8dnItsiCeI3/IUVV+pXj6VcqqtU
         nQNr0LzlTADP40qA1bTHrwzauEEktTlOvsZ2hVVeFKUR9zuzxLHVTzlJMjrhTzpK6S
         jC2FO3bTvMRFg==
Date:   Mon, 8 Mar 2021 13:31:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sangmoon Kim <sangmoon.kim@samsung.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, jordan.lim@samsung.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: traps: add tracepoints for unusal exception cases
Message-ID: <20210308133149.GA4656@sirena.org.uk>
References: <CGME20210305124537epcas1p1930302083680f1b1cf87e37630556460@epcas1p1.samsung.com>
 <20210305123635.27492-1-sangmoon.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20210305123635.27492-1-sangmoon.kim@samsung.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 05, 2021 at 09:36:30PM +0900, Sangmoon Kim wrote:

> When kernel panic occurs, a kernel module can use either the
> panic_notifier or die_notifier to obtain the debugging information.

> However, in case of these exceptions like do_undefinstr(), regs and
> esr data are not passed on. Although a module might be able to find
> those data in the console messages, parsing text messages is very
> expensive behavior for a module especially on mobile devices.

> These bare tracepoints allow a module to probe regs and esr information
> for debugging purpose. _tp suffix comes from bare tracepoints of
> sched/core.c

This use case sounds a lot like what the enterprise and Android people
do via pstore - it seems like it would be better for this to integrate
via the interfaces that other systems are using for similar purposes and
then ensure that whatever information is useful is getting passed
through in a format that makes sense.  That'd be more structured and
more readily usable by a wider range of systems than something that's
more of a building block, going via the trace infrastructure seems like
a bit of an indirection.

> @@ -832,6 +846,7 @@ void __noreturn arm64_serror_panic(struct pt_regs *re=
gs, u32 esr)
>  	if (regs)
>  		__show_regs(regs);
> =20
> +	trace_traps_serror_panic_tp(regs, esr);
>  	nmi_panic(regs, "Asynchronous SError Interrupt");

One of the concerns people have with adding tracepoints is that they can
end up defining ABI so if we *are* going to add any then we need to
think carefully about how they're defined.  As things currently stand
they'll pass in the full pt_regs struct which includes not only what's
defined by the hardware but also additional software defined information
we store along with it like the stackframe which would be even more of a
problem if it ends up getting used by someone in a way that ends up as
ABI.  These are defined as bare tracehooks which does mitigate against
things ending up getting used in ways that cause problems but people are
still going to worry about things ending up getting relied on one way or
another.

That said it's not clear to me that this will record anything beyond the
pointer directly in the trace buffer so the value might not be useful
for terribly long, that itself feels like it might not be as robust an
interface as it should be.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBGJ0QACgkQJNaLcl1U
h9DSHwf+KF0FUBNraZjSJH0LKhgVabREZDAIk49+0JDFJ3gxP3ZFmZvbYrzq3TtY
nf+q2IsxMY2GIBNfr5QcjbT6DRU4OCJHv5iel7NH0fyJlwvIKTDRziA5pydoMUn4
nP5x1FdGvHi4GO7cmi7FQ3uB43jencWcDGIi1Pwz1Hppe1wSnmcdffapBCZmkcEk
eS4kZmklNElayMTdVYSukcUwI+V4gJTkKQNfGkACSFc2dWq0yLqgb62kL7mmhdXp
5RhKBxz4snpjXwiNiBbkgU0wUwF77vSm5hs2eJQu10e9vul3d/1zFrIDPLWX09sr
0VWy+6st5LjE4F79ooXkzyyL97LFgw==
=wHoA
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
