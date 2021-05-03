Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575B83713FF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhECLJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 07:09:11 -0400
Received: from mx.mylinuxtime.de ([195.201.174.144]:49178 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbhECLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 07:09:08 -0400
Received: from leda (unknown [193.159.163.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 568FC12D2EE;
        Mon,  3 May 2021 13:08:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eworm.de; s=mail;
        t=1620040091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BIyy8WFqZaNsO4CjisDKSgKN7z8QxT2e2+nZebrK8gk=;
        b=Tv8aBb5ClF1MNwDQM2tPw/Rx1MVvI7AbuBqHOVds511aIw1XS/RjYuIB6NirvWuW9IoiHt
        Y+7eZdm2TvtTIPPGIzzYWrc/dDuJq9oaJmJ0GHEWII1pr6rfp+PAnlmf9+mBjF2bc1UpEs
        xbZDTED8qEOwTJm9G6cPUkVaH94uW+w=
Date:   Mon, 3 May 2021 13:08:03 +0200
From:   Christian Hesse <list@eworm.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: general protection fault in css_release_work_fn()
Message-ID: <20210503130803.715a4477@leda>
In-Reply-To: <20210419125508.647ce682@leda>
References: <20210302093415.7b463ddc@leda>
        <20210315141038.1cc59f54@leda>
        <20210412080546.2098-1-hdanton@sina.com>
        <20210419125508.647ce682@leda>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E6wfKIAJvZtkCg4pfPC6oSQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=list@eworm.de
X-Rspamd-Server: mx
X-Spam-Status: No, score=-6.87
X-Stat-Signature: ma8q5rtzxrtwzffbhgcbis4eif9zizq5
X-Rspamd-Queue-Id: 568FC12D2EE
X-Spamd-Result: default: False [-6.87 / 15.00];
         ARC_NA(0.00)[];
         URIBL_BLOCKED(0.00)[eworm.de:email,sina.com:email];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[sina.com];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         NEURAL_HAM_LONG(-3.03)[-1.009];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM_SHORT(-1.14)[-1.144];
         RCPT_COUNT_TWO(0.00)[2];
         FREEMAIL_TO(0.00)[sina.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:3320, ipnet:193.158.0.0/15, country:DE];
         BAYES_HAM(-3.00)[99.99%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/E6wfKIAJvZtkCg4pfPC6oSQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Christian Hesse <list@eworm.de> on Mon, 2021/04/19 12:55:
> Hillf Danton <hdanton@sina.com> on Mo, 2021/04/12 16:05:
> > Looks like double free or use after free based on 0xdead.
> > If possible, would you try the mainline with KASAN enabled, given the f=
ear
> > that few guys can find time for 5.10 this week? =20
>=20
> Currently running 5.11.13 with KASAN enabled for about a week. Either this
> has been fixed lately or I am suffering a race that does not happen with
> KASAN enabled.

Currently running  5.11.16 for about a week, looks stable now.
Still saw a crash with recent 5.10.x though... Looks like I have to build
that with KASAN.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/E6wfKIAJvZtkCg4pfPC6oSQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmCP2ZMACgkQiUUh18yA
9Hbu6QgAkYWp4SpglWH5TA5o85B6wmauDnXwZFH9FrHk15bfx+MkopSKAQ9roZm8
4XQ+GN52Q5TTrZ3eaLT6qjRNjbe+00WXDpPyzLKZmQp84Tq0LXPnYEDvk3+duSVi
/GD36jQYjvPecidGyAqmR2ASqrowh6Xgi6EHA/oHUEkUHJT/gbJ8ipaZ5R7uduF3
My+DkGUkNeiSgmeZogCt2Z7Fk5u6BZIX4BsytqiaWf84uZ3wfG9gpXo/I/X/OH2b
Jf4j7vNo3PlrqEchk3QZFaGzTnLTI4T3Ho+xy1JwG8OIIJP0mv5po6DtixsoQgDs
IzqGGBEK0/fMbhypIZFY7WW3FUWDog==
=uynm
-----END PGP SIGNATURE-----

--Sig_/E6wfKIAJvZtkCg4pfPC6oSQ--
