Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B7B35BA14
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 08:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhDLGVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 02:21:25 -0400
Received: from mx.mylinuxtime.de ([195.201.174.144]:52332 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhDLGVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:21:24 -0400
Received: from leda (p200300cF2f0f1c00b4BC9bd7B4bE3241.dip0.t-ipconnect.de [IPv6:2003:cf:2f0f:1c00:b4bc:9bd7:b4be:3241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 34249169EAC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:21:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eworm.de; s=mail;
        t=1618208461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0FTARNgxAEo3oxBw+igkhxnKjjiL+6G6HLpEUuc7vso=;
        b=K4LBxvpzK3NLbjqwFAlP1eA7vXUjHkLmW8mY7DnyIUEOJ0Ew5/cPItP9wm/Ec23ajh9/PT
        QiRijgyy7UnxQjmTaL2GtA/8Q2BDajxaZ0olxWwNjuLBzEVGwvDny4tmx4VpLKo/7tN/VL
        epcxgeqXT+OqS6Twnqrhn5y7dXGYpXk=
Date:   Mon, 12 Apr 2021 08:20:52 +0200
From:   Christian Hesse <list@eworm.de>
To:     linux-kernel@vger.kernel.org
Subject: Re: general protection fault in css_release_work_fn()
Message-ID: <20210412082052.3954917e@leda>
In-Reply-To: <20210315141038.1cc59f54@leda>
References: <20210302093415.7b463ddc@leda>
        <20210315141038.1cc59f54@leda>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//ie5M.m3KG+Txlhl58zCXB8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=list@eworm.de
X-Rspamd-Server: mx
X-Spam-Status: No, score=-6.40
X-Stat-Signature: hsqdwx16e3a65sdstajuwypznzkqwj57
X-Rspamd-Queue-Id: 34249169EAC
X-Spamd-Result: default: False [-6.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-2.94)[-0.979];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         TO_DN_NONE(0.00)[];
         RCPT_COUNT_ONE(0.00)[1];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM_SHORT(-0.76)[-0.764];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:3320, ipnet:2003::/19, country:DE];
         BAYES_HAM(-3.00)[99.99%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//ie5M.m3KG+Txlhl58zCXB8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Christian Hesse <list@eworm.de> on Mo, 2021/03/15 14:10:
> Hello everybody,
>=20
> Christian Hesse <list@eworm.de> on Tue, 2021/03/02 09:34:
> > I see this on a git server with lots of ssh logins. It happens every few
> > hours to days. No idea how to reproduce, guess it's a race condition?
> >=20
> > general protection fault, probably for non-canonical address
> > 0xdead000000000122: 0000 [#1] SMP NOPTI CPU: 3 PID: 2213757 Comm:
> > kworker/3:2 Not tainted 5.10.18-1-lts #1 =20
>=20
> I've seen more crashes with 5.10.23-1-lts and 5.11.6-arch1-1. Looks like
> 5.11.2-arch1-1 is stable for now, but I did not test everything in betwee=
n.

Had several more crashes, latest with 5.10.29-1-lts. So... Anybody has an
idea what commit could have caused this?
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_//ie5M.m3KG+Txlhl58zCXB8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmBz5sQACgkQiUUh18yA
9HYdFwf/a2hSSVc9EYh+EOHoedVqr9XCpo/3WxqbXaTV7OPa3R0OXhQ9imAxLjvy
vBVkjYowy52LLHQ7c7FKatx+PKBqqO7K0Xi1F+p2kEbKIP0fFPeV6rLyLvcEPJ1x
PezPOqj9cLNVznSzkok7q5qwqA3dcn/LgJ+GAfgq6ttXmIDuqvfkaKsp2xEKC8KW
Kc+gZAk3gPER7e6pszkpGUaT652X7snf3uO/cdy9M8EUp938FjQu5PRAbL5mS1zJ
dR3Lw0VRcLGX+DOF/Ep7bGdrWQOykXrk4cE476+kGh1FsPrQEpvx2KR+voWPY78r
OPOwZFBkD2wmS9K0Plg39HUlMKmnxg==
=gXqj
-----END PGP SIGNATURE-----

--Sig_//ie5M.m3KG+Txlhl58zCXB8--
