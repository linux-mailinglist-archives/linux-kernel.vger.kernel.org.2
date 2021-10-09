Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A9442749E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 02:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbhJIAXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 20:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbhJIAX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 20:23:29 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A881C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 17:21:33 -0700 (PDT)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 233063430EF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 00:21:30 +0000 (UTC)
Received: (qmail 561 invoked by uid 10000); 9 Oct 2021 00:21:29 -0000
Date:   Sat, 9 Oct 2021 00:21:29 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rjohnson@digitalocean.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] tracing: show size of requested buffer
Message-ID: <robbat2-20211009T000917-463381491Z@orbis-terrarum.net>
References: <20210831043723.13481-1-robbat2@gentoo.org>
 <20210907212426.73ed81d1@rorschach.local.home>
 <20211007071151.GL174703@worktop.programming.kicks-ass.net>
 <20211007092358.65152792@gandalf.local.home>
 <robbat2-20211007T172058-955036195Z@orbis-terrarum.net>
 <20211008181348.4c2488b7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kfJPulgMX8wmlwUv"
Content-Disposition: inline
In-Reply-To: <20211008181348.4c2488b7@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kfJPulgMX8wmlwUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 08, 2021 at 06:13:48PM -0400, Steven Rostedt wrote:
> On Thu, 7 Oct 2021 17:26:04 +0000
> "Robin H. Johnson" <robbat2@gentoo.org> wrote:
>=20
> > I was trying to think further what would make sense for the constant.
> > - What are the negative impacts of a too-large value?
> > - Is there demand for more reconfigurability?=20
> > - Should PERF_MAX_TRACE_SIZE be a knob in Kconfig?
>=20
> One thing you haven't discussed was, have you hit this warning, and if so,
> what were you doing?
Ah, I covered that in patch 2/2 in the original series, which discussed
why I was raising the limit, and how I came to the 8K value for
PERF_MAX_TRACE_SIZE.
https://lore.kernel.org/all/20210831043723.13481-2-robbat2@gentoo.org/

To summarize here:
$work requires that all employees run endpoint security software from
SentinalOne [1]. I can see that it uses trace/perf stuff to dig deeply
into what's taking place on the system.

Something in my personal setup/configuration, leads to SentinelOne
getting large perf backlogs during heavy workloads, primarily when I'm
doing deep things with containers (esp with tun devices inside
containers). I haven't been able to narrow it down much more than that,
and I don't have the source to SentinelOne at all.

It does feel like SentinelOne either has a leak of some sort, or gets a
backlog of work that takes a noticible amount of time to clean up.

[1] https://www.sentinelone.com/

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--kfJPulgMX8wmlwUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmFg4IhfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQkxg/9FGbga4N7gVcD8JEyxEfYtKNreVCaoc8FuLNZeDXb7c76pngLj/B55uYK
ztbA4pR+jY4LnyC7xNRWQZ9H5EcqU8Q8WibS7ULKFk6W0Y3DwL7WOMZe5PFeJVkQ
krwN5qlkTNeTDmKlvTMVRK/reRmz+Z2XjXAJCiYGAdXyb3H6dQKIlNgLbTpeUYA9
kZwAaZrZzkHlbF4kbhaKSFFXSeyoQvc8O6W8TzSXB2WmsO38a0Y/N33sUayHq2du
PC/Xcd3QISHIsLt7LkL7QfWyLRDsTVdQXlvgK+wMa/HOwEyezjzZuDI3pWKVCBQJ
T7gNJphwiz9a71mVZe5f5JEO8gk5cjFNOa28CtM/AKSUDwhRb62esZSzGwB0trne
TfhJnymCg2MKimeEVUAbDp7LxyrjQckcr+O4/0bb5ivkns6QXRftFojsDLUPx4B2
whRW+ul0sYnl4DqgOdb6o2GXdf5xJdFo2DiJ9XQs8BZAPKBsjJLGjp6B6OOL6ZRp
tNEbwyJn/hh7eibyhawwbPL+bPWHCg4vX2Qag7hJ7g8P0eGU/idil30SrBDD+sfY
fk0SYGFWXKWGkiSHn09BkRUWrC6huDY5blPwj57YrQ1w2U5sE3pGD/gnlrxjNuu8
VVPp6rbU638MRBWgcTRky4v8CqrXp0/iGx8VEOnUV3bdedmfgRs=
=G1v3
-----END PGP SIGNATURE-----

--kfJPulgMX8wmlwUv--
