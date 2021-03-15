Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0127E33B35C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCONLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:11:09 -0400
Received: from mx.mylinuxtime.de ([195.201.174.144]:56250 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhCONKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:10:54 -0400
Received: from leda (p200300cf2f0F1c00625718FffE7f1598.dip0.t-ipconnect.de [IPv6:2003:cf:2f0f:1c00:6257:18ff:fe7f:1598])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 2CE7BF0475
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eworm.de; s=mail;
        t=1615813847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+JjB3C5EnbqEEUn9FoK830zvmw8J1g8qlj6xG4JtzdA=;
        b=yqPfuGWngotg9dHtW2h/0hPK4FtLpiC5NQ+2qOfoA4Au1e9Sd8rdUESn4xLxkykymBkx7r
        klbcj2hMxqUdxuUS6KBFbutQmcAIQvs/XxlbNAslfNG4T/4Gfe9DfGT5Tm8l7HGhchjLpf
        QyWvL0FhwKmcrnKXwIEuXqTN9pfd/r4=
Date:   Mon, 15 Mar 2021 14:10:38 +0100
From:   Christian Hesse <list@eworm.de>
To:     linux-kernel@vger.kernel.org
Subject: Re: general protection fault in css_release_work_fn()
Message-ID: <20210315141038.1cc59f54@leda>
In-Reply-To: <20210302093415.7b463ddc@leda>
References: <20210302093415.7b463ddc@leda>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tSZXW8o9ypWNiP4UA=YlcKr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=list@eworm.de
X-Rspamd-Server: mx
X-Spam-Status: No, score=-6.54
X-Stat-Signature: 1unaxzd37yu967nh3nman71a5e3gwsjg
X-Rspamd-Queue-Id: 2CE7BF0475
X-Spamd-Result: default: False [-6.54 / 15.00];
         ARC_NA(0.00)[];
         GENERIC_REPUTATION(0.00)[-0.76769436172035];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.02)[-1.006];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         TO_DN_NONE(0.00)[];
         RCPT_COUNT_ONE(0.00)[1];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM_SHORT(-0.82)[-0.819];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:3320, ipnet:2003::/19, country:DE];
         BAYES_HAM(-3.00)[99.99%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tSZXW8o9ypWNiP4UA=YlcKr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello everybody,

Christian Hesse <list@eworm.de> on Tue, 2021/03/02 09:34:
> I see this on a git server with lots of ssh logins. It happens every few
> hours to days. No idea how to reproduce, guess it's a race condition?
>=20
> general protection fault, probably for non-canonical address
> 0xdead000000000122: 0000 [#1] SMP NOPTI CPU: 3 PID: 2213757 Comm:
> kworker/3:2 Not tainted 5.10.18-1-lts #1

I've seen more crashes with 5.10.23-1-lts and 5.11.6-arch1-1. Looks like
5.11.2-arch1-1 is stable for now, but I did not test everything in between.

Anybody has an idea what commit could have caused this?
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/tSZXW8o9ypWNiP4UA=YlcKr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmBPXM8ACgkQiUUh18yA
9HZiZQgApoCzfqY26gnmS4cf0OkGhL8Yxp2RxmTj0Tze8nskxYLYq/vyWqQ22HUo
guKoKnm/IMPxBgPwt0Qqra83xKpFtcg1i49NYy5jXAnBuS+2TN5L2FMG1XJfTPFU
/OCDMH6URg8OPsUHXEcVVW9bjbHNmMQYSpy/8HP2uya6OtvHd1Bgvz+gbuPuPGIK
hYUBGZM8ogy3IgMRuCC4gb0bCziJRxoM+37Za/cHUM7Mai9+FdgLMPMgpBytKHuW
oZHX49D5IUAHrReJRcqdIHRTm+XuiCWlkjWW16I38UdJIOOUvzWnsDi/E6XSPWBw
uSmiTf7G93VJkqB66BV6DVQvuZHGow==
=A3uv
-----END PGP SIGNATURE-----

--Sig_/tSZXW8o9ypWNiP4UA=YlcKr--
