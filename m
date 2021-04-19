Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B374A363FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 12:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhDSKzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 06:55:51 -0400
Received: from mx.mylinuxtime.de ([195.201.174.144]:34846 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDSKzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 06:55:49 -0400
Received: from leda (p200300cF2F1f7b001DB16a9281fCA8b0.dip0.t-ipconnect.de [IPv6:2003:cf:2f1f:7b00:1db1:6a92:81fc:a8b0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 5A8058AE5D;
        Mon, 19 Apr 2021 12:55:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eworm.de; s=mail;
        t=1618829711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vbeak/5WtY/ha1FyVnqKaghNL4ZTaabrbeHHEQ0dqL4=;
        b=p5G+nIHd/ELo1ElwgraDPKPzxSZJM2slB0V48VCQobXzIS1clSyCYmXQLOxHmj26eCE4rX
        5om6cRD2H7md0ka6TqevC1xLs5+Kn4crAdft+pPOyxgvZLMgKy2yVhDgkAx1Kglo8laMJu
        nUqmv9Gim6k6hDbc5Pg2fItZHYtfCd4=
Date:   Mon, 19 Apr 2021 12:55:08 +0200
From:   Christian Hesse <list@eworm.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: general protection fault in css_release_work_fn()
Message-ID: <20210419125508.647ce682@leda>
In-Reply-To: <20210412080546.2098-1-hdanton@sina.com>
References: <20210302093415.7b463ddc@leda>
        <20210315141038.1cc59f54@leda>
        <20210412080546.2098-1-hdanton@sina.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ttWvFP+FPlBXhox_yNNBNDy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=list@eworm.de
X-Rspamd-Server: mx
X-Spam-Status: No, score=-6.40
X-Stat-Signature: xxn5ui1yfj6r8kiydhx7cjaifdxw5jw6
X-Rspamd-Queue-Id: 5A8058AE5D
X-Spamd-Result: default: False [-6.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[sina.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         NEURAL_HAM_LONG(-3.03)[-1.011];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM_SHORT(-0.67)[-0.674];
         RCPT_COUNT_TWO(0.00)[2];
         FREEMAIL_TO(0.00)[sina.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:3320, ipnet:2003::/19, country:DE];
         BAYES_HAM(-3.00)[99.98%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ttWvFP+FPlBXhox_yNNBNDy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hillf Danton <hdanton@sina.com> on Mo, 2021/04/12 16:05:
> Looks like double free or use after free based on 0xdead.
> If possible, would you try the mainline with KASAN enabled, given the fear
> that few guys can find time for 5.10 this week?

Currently running 5.11.13 with KASAN enabled for about a week. Either this
has been fixed lately or I am suffering a race that does not happen with
KASAN enabled.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/ttWvFP+FPlBXhox_yNNBNDy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmB9YY0ACgkQiUUh18yA
9HayWAgAz5oFDTFm/MraFgIQR7b+OjRJWZAFMt4mE/oj1b8H8nYv4NQVr6LKDMOQ
VKDT1byWsJZaiwLXsVVj0ad6AmpzfP2CSDEHemPqtYGddDV8nnDQJtA+zbx8UnAT
mzuXX8oXP6P66DCNUbcyU2lf/ewmahUlzA18Us1oAyL7JMBsPx0+vtJVCLOncR2/
zmU/a3/wVatcMU+RmY6AuEqFcSEAZ9OGwfmO65X+ZypTxiz4d/NVWWHT6ev6qBqx
Rx+46Rt02f0mpew8BMSTsjs7lleGVxwvIaYEgK75mge4f7ZKgBt20RrtbhOU+yXp
HRzaRQeTi/jnyjGnmN4I5izYncjkUw==
=zYn7
-----END PGP SIGNATURE-----

--Sig_/ttWvFP+FPlBXhox_yNNBNDy--
