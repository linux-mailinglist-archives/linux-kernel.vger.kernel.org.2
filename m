Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F04306C05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhA1EO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:14:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:60150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhA1EOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:14:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA45EACE1;
        Thu, 28 Jan 2021 03:58:10 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Date:   Thu, 28 Jan 2021 14:58:04 +1100
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] docs: path-lookup: Update pathlookup docs
In-Reply-To: <20210126072443.33066-1-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
Message-ID: <87zh0tg1bn.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Jan 26 2021, Fox Chen wrote:

> The Path lookup is a very complex subject in VFS. The path-lookup
> document provides a very detailed guidance to help people understand
> how path lookup works in the kernel.This document was originally
> written based on three lwn articles five years ago. As times goes by,
> some of the content was outdated. This patchset is intended to update
> the document to make it more relevant to current codebase.
>
>
> Fox Chen (12):
>   docs: path-lookup: update follow_managed() part
>   docs: path-lookup: update path_to_nameidata() parth
>   docs: path-lookup: update path_mountpoint() part
>   docs: path-lookup: update do_last() part
>   docs: path-lookup: remove filename_mountpoint
>   docs: path-lookup: Add macro name to symlink limit description
>   docs: path-lookup: i_op->follow_link replaced with i_op->get_link
>   docs: path-lookup: update i_op->put_link and cookie description
>   docs: path-lookup: no get_link()
>   docs: path-lookup: update WALK_GET, WALK_PUT desc
>   docs: path-lookup: update get_link() ->follow_link description
>   docs: path-lookup: update symlink description
>

Thanks for doing this.  I've responded individually to several of the
patches.  As you can see from my comments, there is often more to it
than just changing function names.  In some places you have capture the
more general nature of the change fairly well.  In other places the
result is incoherent or confusion.
Making small updates to this sort of documentation is not easy.  You
need to step have and see the "big picture", to overall story-arc.
Sometimes you can fit changes into that arc, sometimes you might need to
restructure or re-tell the story.

This is part of why I haven't put much effort into the document -
re-telling a story can be a lot of work.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmASNk0OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmNDA/+MSLmQTkUen1OKdCYdHDhCMLRtNAhfqRGocz6
XIo9x6yPou79C2tRfIRefkS7JtlSbayQW0O4K829xYPWs3TbHuZt/FC1gwVfnocz
9a89EZVH6tnw5ORgWCGu7fBsg0MiUgo+Y/udrZZ/WH6e0MZCri8RHAnNbadk8vlk
1FJJTvdyK79X7Xzbxzg73T18VRryNEq8X48ZMYx+WJg7ghQVpZOEKD+07T5knwuo
lek8G9h2/9hlkcNsMJdvqpa1DhXfzOZM200PvNd9wk0MZWFC/jSb//zPsaI+EsBk
UNWBHhAck6Pa3mCMOksaUYWS8h6prjaMnZH58yiceVYX+8DJvErIf/jxkhmUdPAk
UzyOqECZce1e5Bh7yhWY2lfmGUEbnxiO7o2NuSHeFN9XrjQXaxj80vHIRZ+nCvqJ
s2R0qI8DHKcI2NUdPVoUSA3OI1hSpCnnZ5s/4b/JXxSoxfPJWHkDKf445MCGH/8/
c9wKR/rYJSpxPfOA9nNc62IX/vltH+LB6VO7YXs5aS368FE19bkch8QI+NtKDf/9
iDbwe6OzgQDZQUsoMEGyW4/7uIT4UoMQ8rEwUP5CJNn2hiCsELlzNM4MZi6Z+c1t
9EtHPidJwQE/i7hPVqhoWqKQlRitD731tTAb3OUDMPeWOpR8D57YmolwLodYb2wS
SqD7Efc=
=/mOn
-----END PGP SIGNATURE-----
--=-=-=--
