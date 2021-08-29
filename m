Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA363FAEEB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 00:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbhH2WYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 18:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbhH2WYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 18:24:04 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9E5C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 15:23:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GySdT3JDbz9sRf;
        Mon, 30 Aug 2021 08:23:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1630275790;
        bh=w52mmyAw0pCyePwhvBMaQ5okadNuOVKqKoPVEPrVa1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RLvrV5K/iYIxUs9llbO68YWtqBm7Bt8ujpgQUiIrsgPGHYcWVCTMwoQEa1gYMBLqz
         PrGtbBTxIeS+9vUkhleLub75g92LzRLRKU9nyWGmYtZ0LykMRo1DVrzkhPoOmwZTQk
         I8fLYgHiL15WLaBBcuNg+f9WQljyYV0Iz2i2RKTdX0sC3P6egH8wL4kiTzBVyAkAee
         jFX30rI9S/8Et13StLuRs8HuYIW9rqX5Grq6rz9dXp2k13j2567SX022OmuT/+yJcU
         IIR5JL4LtQCRVyZ+LaZcHzw3fOqki3ebg4gX+lfkP+E2VWoEl7vi8Q3vzo2IzAzVkV
         uQjQ2UbU3UZCg==
Date:   Mon, 30 Aug 2021 08:23:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Ntfs3 git repo in github should not back merge
Message-ID: <20210830082308.649f2026@canb.auug.org.au>
In-Reply-To: <20210825192746.ryi2vzn5gz4myxri@kari-VirtualBox>
References: <20210825192746.ryi2vzn5gz4myxri@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TRsi1qC31IpCGEQ/serF0R6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TRsi1qC31IpCGEQ/serF0R6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Konstantin,

On Wed, 25 Aug 2021 22:27:46 +0300 Kari Argillander <kari.argillander@gmail=
.com> wrote:
>
> I notice that you have made back-merge in ntfs3 git repo in github.
> This should not be done without good reason and there is none in this
> case. If there is reason you should also write good merge commit for it.

This is correct, but in this case with an initial submission, Linus is
likely to be a bit easier on you.  Just explain that you realise that
you probably should not have done the back merge.  Also, if you are
going to merge another branch you should not use the github web
interface to do it.  It does not allow you to produce a useful commit
message for the merge commit.  Linus has expressed this recently about
another tree that is maintained on github (unfortunately in a private
message, so it is not archived anywhere).

> Here is link which you can read about back-merges. If you have any
> questions you can always ask.
>=20
> 01.org/linuxgraphics/gfx-docs/drm/maintainer/rebasing-and-merging.html#me=
rging-from-sibling-or-upstream-trees

Also available in the kernel tree at Documentation/maintainer/...

> You could also go check some other trees how they do it. Usually there
> is next/master/main/for-next which will be repo which will contain stuff
> for next-merge window. This is usually based on rc1, rc2, rc3 depending
> when you put first patches to next merge window. As you based your
> branch top of the rc5.

Again with an initial submission this should not be a problem.  And, in
any case, varies among maintainer quite a bit.  But -rc1/2 is usually a
good place to start your next round of development.

> Because your master branch is  for next you could have rebased your
> branch top of the rc7 if you want to but that is kinda pointless. You
> could always fix little mistakes in next branch with rebase, but you
> should propably info this action to ntfs3 mailing list.

Do *not* rebase a published branch except in exceptional circumstances.
All branches included in linux-next should be considered published.

> The idea is that this repo has very clean history always when it get
> merged to Linus tree. Also developers who work with ntfs3 can see
> everything in one eye.
>=20
> Example take a look Ext4 dev (for-next) branch
> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=3Dd=
ev
> You see that this is based on rc2. Theodore will create pull-request
> based on this when he creates pull-request. Very clean history and no
> back-merges.

Also no rebasing (that I can remember).

--=20
Cheers,
Stephen Rothwell

--Sig_/TRsi1qC31IpCGEQ/serF0R6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmEsCMwACgkQAVBC80lX
0Gyzuwf/QfXftzQytSL4L+HYtK3drBCW+hFcxcp6nie1tJvQckTntVEWbpj70qr9
k+aJmtpL9TuGyhs4qZKTOQYgNDaiItS51VKgRvdyh05OF2bAgIwfDLlDKkhO4T0E
NHvLUJFAXjMhqW7ADe6yK/eeHI2M5sLpBF78ZGvKpxgUug9hkY9iR10zd37oACT0
+0ol84935bAU24iBwaGM2ZdrZXvcBlu+USxXtSWpIXvgi8azG4zjfbCR44OQey8R
FjSMcrE2dvoRwnSbF/xm/4X5pqON7FHlJB1FxbpQ9pkdS13gNLxNGxHJP+9V/Yo2
iwLrx3cvajPi0tL0L79o9XYxSfvAJQ==
=OcAe
-----END PGP SIGNATURE-----

--Sig_/TRsi1qC31IpCGEQ/serF0R6--
