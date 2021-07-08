Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B323BFAAE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhGHMzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:55:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51297 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhGHMzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:55:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GLGQt6BFkz9s5R;
        Thu,  8 Jul 2021 22:52:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1625748743;
        bh=S8ucLp7nedvIAiNyMX/aoAvCTHpW3Mv2oduRMPGocQw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N2kqwd0kwaD3xi7U4djjpjnyMBWIErwGSqc+s3wLTFHu91RBPz4tJiiK0WLqBGHXF
         8XzT9A0dvYFxJLKM8P/HIXCoywfGNo7lwo9j7CtRHgEWvZPVx2G6B1ZD0RuXst2Qnz
         oUf7EL70QbZF+d5Jh4vZCG22Vm8UNO4U3EUu1krnXsO2xSjy0VkoijqX0qHbhaVQH8
         8dl2SdGBq8kmO5m9/ELMA4HWFgCsCOy8vJIMWQz5Uq1CWlo20nouIg/H2iTdt3to3g
         K2DGBppf6phZD2QPyJWNCOhIhHYZl45DbPyqwGMyCcFdwlPIzDyHIbAwez/0No4a5G
         qbW/IvTzFeAJw==
Date:   Thu, 8 Jul 2021 22:52:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jan Kara <jack@suse.cz>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [GIT PULL] f2fs for 5.14-rc1
Message-ID: <20210708225221.30f1100b@canb.auug.org.au>
In-Reply-To: <20210708095217.GA32434@quack2.suse.cz>
References: <YOYHejl3CgABOnhP@google.com>
        <20210708094647.7c0d3060@canb.auug.org.au>
        <20210708095217.GA32434@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.o7QYyeDvI95PXfHejQuDb4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.o7QYyeDvI95PXfHejQuDb4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Thu, 8 Jul 2021 11:52:17 +0200 Jan Kara <jack@suse.cz> wrote:
>
> Whether that particular series causing the conflict will be merged by Lin=
us
> in this merge window is uncertain - Linus didn't like how filemap_fault()
> unconditionally acquired the lock. I've created an optimization patch to =
avoid
> that but review is pending... At this point I'm leaning towards the varia=
nt
> that series won't go in during the merge window. In that case I'll
> probably rebase on top of rc1 and force-push everything.

No worries, thanks for the reply.
--=20
Cheers,
Stephen Rothwell

--Sig_/.o7QYyeDvI95PXfHejQuDb4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmDm9QUACgkQAVBC80lX
0Gw65wf7BYY2Q+2LzBOx+CnC0fGEpBEXWBilTo/z5vdX9KxtDswQf3Xk4YDRcIsJ
QjTiDAVneeytbS24VqMIXZShTjtodXt5UNX4PhutGlz0jTTU3am4+11YT+cSJd51
Z5+V8fsZPIdwFJ1F7JGByrmWgjYrcjjLzSvUVzL98YVqB20EXmPoPHumLpXH2VHp
jLgFfrKtjsGdkcayDq/ofcAOssi0KP4rL5gtiVX7HvfCzZRmHTDcTHf1tANxz4aC
L+jHIVwqPOdtbIKmWmr7RCNu5z7zlFJBe4ORwpDuvr/xWDZPP3jLxQ5F89RZ2BbU
w6wqeHbAcG8FXeXFV+/wz08yZSs2UA==
=BWRJ
-----END PGP SIGNATURE-----

--Sig_/.o7QYyeDvI95PXfHejQuDb4--
