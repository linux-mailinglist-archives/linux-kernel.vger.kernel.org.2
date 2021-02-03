Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E8330DF2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhBCQG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:06:57 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:39204 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbhBCQGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:06:30 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3301B1C0B9C; Wed,  3 Feb 2021 17:05:44 +0100 (CET)
Date:   Wed, 3 Feb 2021 17:05:43 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: syzbot reporting less duplicates
Message-ID: <20210203160543.GA19512@duo.ucw.cz>
References: <CACT4Y+YytChe9Tv5etacBL4snEDu+A2fNzF4zKiKtfmH0C0roQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <CACT4Y+YytChe9Tv5etacBL4snEDu+A2fNzF4zKiKtfmH0C0roQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2021-02-01 11:52:12, Dmitry Vyukov wrote:
> Hi,
>=20
> FYI syzbot should report less duplicates now.
> A significant number of reported duplicates was one of common
> complaints. syzbot will now merge some slightly differently looking
> crashes together, for example, these 2 recently reported bugs will be
> merged into a single bug and reported once in future:
>=20
> KASAN: use-after-free Read in skb_segment
> KASAN: slab-out-of-bounds Read in skb_segment

Could we please get common prefix (like syzbot: KASAN:....) so that
the bulk of emails is easier to remove?

Thanks,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYBrJ1wAKCRAw5/Bqldv6
8uvoAJ0aFzRSxzaevdT8WSZ315m6KzDT1wCbBY3kMGwHiv+EmDnkJsm0dvzg/oA=
=uiZe
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
