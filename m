Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49368425963
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbhJGR2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbhJGR2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:28:03 -0400
X-Greylist: delayed 67051 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Oct 2021 10:26:09 PDT
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAEDC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 10:26:09 -0700 (PDT)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 5B8DB342A9A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 17:26:05 +0000 (UTC)
Received: (qmail 11475 invoked by uid 10000); 7 Oct 2021 17:26:04 -0000
Date:   Thu, 7 Oct 2021 17:26:04 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rjohnson@digitalocean.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] tracing: show size of requested buffer
Message-ID: <robbat2-20211007T172058-955036195Z@orbis-terrarum.net>
References: <20210831043723.13481-1-robbat2@gentoo.org>
 <20210907212426.73ed81d1@rorschach.local.home>
 <20211007071151.GL174703@worktop.programming.kicks-ass.net>
 <20211007092358.65152792@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x8iEuWIzMNV+pbH2"
Content-Disposition: inline
In-Reply-To: <20211007092358.65152792@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x8iEuWIzMNV+pbH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 07, 2021 at 09:23:58AM -0400, Steven Rostedt wrote:
> On Thu, 7 Oct 2021 09:11:51 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> > > > +++ b/kernel/trace/trace_event_perf.c
> > > > @@ -400,7 +400,8 @@ void *perf_trace_buf_alloc(int size, struct pt_=
regs **regs, int *rctxp)
> > > >  	BUILD_BUG_ON(PERF_MAX_TRACE_SIZE % sizeof(unsigned long));
> > > > =20
> > > >  	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE,
> > > > -		      "perf buffer not large enough"))
> > > > +		      "perf buffer not large enough, wanted %d, have %d",
> > > > +		      size, PERF_MAX_TRACE_SIZE)) =20
> >=20
> > Priting a constant seems daft.. why is any of this important in any way?
>=20
> I see your point, but it can be useful if you changed it, and want to know
> if you are running the kernel with the change or not.
>=20
> I've done daft things were I changed a const and was running a kernel
> without the change and couldn't understand why it wasn't working ;-)
Yes, my initial internal versions of this series only bumped the
constant, and then I was running a few different kernels, and being able
to compare which value was in use became a problem.

I was trying to think further what would make sense for the constant.
- What are the negative impacts of a too-large value?
- Is there demand for more reconfigurability?=20
- Should PERF_MAX_TRACE_SIZE be a knob in Kconfig?

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--x8iEuWIzMNV+pbH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmFfLatfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsSADQ/7BIT543vVll06kQgmdZnFMztBrT2IoNv7YUMD/xGoqKaWDOdhsqN1E2IT
8Q2qwPB/E+Gi5/awV58qd00Xt5JNkIOYvI0rJJVTxyWQJjywpIHISYRtdSwQ7mEX
WGBB4Y8W8EQTXhijERO8zcqJ6jz3ERTdLDUN3bo07Vxw93IEQBR1OynhZMz3NB+4
jqp0DjlyCisJQ2MuyMJpP79PZlGWosT6Y6SVOXXQ1uTjWTiX2BedJsGElOUFvehX
7uMkZj0Ol/ZaSB3WyQn7+PriW8Lt2nIgjdfb3Xvtj0UXia+EHSzNqYcNHRe0jjOa
4VyGjYJQ4AT/1Sud4nKs/ivYhsnBEDrAMN3pPqWq0KXilCC4EGGzgfsTUSxUb7HG
jx6TT1XQz/D+Ei4aY5AjaMrJh74ekEtlCDC/VoZjjYYTOTmR9WChIWe+jl5SB/YZ
JoKvqhFXvzW9/xBatpduuKtZLtAHAGhUp6OjRITsrj+SL7HdljGLqueYhmD+KeGd
k+uwtiyxfjFH/x2hTEnZ9lnzaDnDdz1lmhMHb2aDV07PC5N4UKqY1v/ayMYfkJtx
XFyiEhzSV1jDaCxbTrV1jFNhdruPgYReup1IBA+IGfma44dykRwujJAjvdzJkXpl
NP3YTNyEcibrBEuV4RwPW/2XeuxVGhKi0hlnLjXiGJnioiN6990=
=NL8u
-----END PGP SIGNATURE-----

--x8iEuWIzMNV+pbH2--
