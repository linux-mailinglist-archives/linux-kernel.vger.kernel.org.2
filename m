Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24CD424A20
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbhJFWue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:50:34 -0400
Received: from woodpecker.gentoo.org ([140.211.166.183]:44872 "EHLO
        smtp.gentoo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhJFWub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:50:31 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 39A5C3433D6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 22:48:36 +0000 (UTC)
Received: (qmail 11571 invoked by uid 10000); 6 Oct 2021 22:48:35 -0000
Date:   Wed, 6 Oct 2021 22:48:35 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rjohnson@digitalocean.com, Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/2] tracing: show size of requested buffer
Message-ID: <robbat2-20211006T224617-864445788Z@orbis-terrarum.net>
References: <20210831043723.13481-1-robbat2@gentoo.org>
 <20211006182652.6c11ce1b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l77RIbjW34pLUj0y"
Content-Disposition: inline
In-Reply-To: <20211006182652.6c11ce1b@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l77RIbjW34pLUj0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 06, 2021 at 06:26:52PM -0400, Steven Rostedt wrote:
> On Mon, 30 Aug 2021 21:37:22 -0700
> "Robin H. Johnson" <robbat2@gentoo.org> wrote:
>=20
> Sorry for the late reply, I was on holiday when this was sent, and I'm ju=
st
> getting to looking at this email now (as my OoO email should have suggest=
ed ;-)
>=20
> Anyway, this needs to be reviewed by the Perf maintainers (Cc'd)
>=20
> (Lore link for patch 2:=20
>   https://lore.kernel.org/all/20210831043723.13481-2-robbat2@gentoo.org/ )

You already CC'd them on Sept 7th, no response yet.

Does MAINTAINERS need an update for kernel/trace/trace_event_perf.c?
It points to Ingo & yourself for that directory, and not to the Perf
maintainers.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--l77RIbjW34pLUj0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmFeJ8JfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQjqxAAnToFaWPySjpH52cWIYMdysTsuq4l0ZRgXEHGzyPEwO4kcOFCVC/IFUNF
VkTMXlmYTmHaEU4FfB36BgOfgQezF2WFpITomH8h7M6qVNoO3w/LF0b3/Og0Zbnh
BaagI6In23XHBIxnnnbf9lW2o8iHrPh6w2U8rVfDiFV89eExPD/XU3OZXvDDJm2s
G2KMXjOlEzN+6ypT0c4nCBz2FNb5f+/1EpxiMeJbQKxla0wqVCQzlIbVPhrXIyNT
01JIyZGEsxgRIioBV3Y2WsUG84CGygt4jqbPp9qbvT16UniCoykLuqancX2PEgp8
/SIwSc9b3LthNb0wcdzGn7xWnnduQZ6eYfYK/SJayHGBEUNLhh30GnU4F/WdeQ66
DzaPCClYSDi5SQ90PaqQpvuz+VRIoCOKIcdBGUYKVv8ffNxeAgXIsBUwVM9a4v9F
IhZ1DGWVUXXWO/MwP2QuTLPI2TuubS0DhDhsEFit5a35vX9x8Sai/nCl6iSLiKpU
cyjtQM1qBZ+Bpln+DDI+xRZ/QfuPQlA5OAz05Fa5mUXr/Pu6GlUIajIUdIAj4+jy
sAVNingHYZznoXqpg0zDRhNlGyJtWDxjJVqNsmSuREnZqFDzzxB78W9UQuzVz4xj
JUk7qqjR7z4Q7O9b3gDjvKwSdTDS0LrVmxvAfZfCbfk7EXbiIbo=
=d39r
-----END PGP SIGNATURE-----

--l77RIbjW34pLUj0y--
