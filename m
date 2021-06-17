Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5322B3ABEEE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhFQWd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:33:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46646 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFQWd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:33:56 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D18A11FD68;
        Thu, 17 Jun 2021 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623969106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dK3fjfH9N1woOF6AH4a8cuhg64qyn4DF5VZ3L9cV8V8=;
        b=tAOwU/Jlj1bTXAA+q5Lf5ZgUhRoXrGXC1epmtJk3dFzm+AJsoak6pOAAk1FXtbIXYnoAOX
        2QicE4Hs7JXCGojG5f9UBcOsNen/tbE0dQIlKF8QgfP/R4RWH4MnG/MKV1i9K4hzVH7cvT
        ohAfnEFFqQOZL1qO09X85SgU+p/Kd2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623969106;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dK3fjfH9N1woOF6AH4a8cuhg64qyn4DF5VZ3L9cV8V8=;
        b=LVLejE1ZXKWyb9LCy4H52emR0TykmqwY32Yk1byHToLdZiG7V0+ZUegsMZ/8KUf7VXwwmJ
        ZHy+mgoZic/pjSBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BAA21118DD;
        Thu, 17 Jun 2021 22:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623969106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dK3fjfH9N1woOF6AH4a8cuhg64qyn4DF5VZ3L9cV8V8=;
        b=tAOwU/Jlj1bTXAA+q5Lf5ZgUhRoXrGXC1epmtJk3dFzm+AJsoak6pOAAk1FXtbIXYnoAOX
        2QicE4Hs7JXCGojG5f9UBcOsNen/tbE0dQIlKF8QgfP/R4RWH4MnG/MKV1i9K4hzVH7cvT
        ohAfnEFFqQOZL1qO09X85SgU+p/Kd2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623969106;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dK3fjfH9N1woOF6AH4a8cuhg64qyn4DF5VZ3L9cV8V8=;
        b=LVLejE1ZXKWyb9LCy4H52emR0TykmqwY32Yk1byHToLdZiG7V0+ZUegsMZ/8KUf7VXwwmJ
        ZHy+mgoZic/pjSBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id C4dKG0/Ny2CmOQAALh3uQQ
        (envelope-from <neilb@suse.de>); Thu, 17 Jun 2021 22:31:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Fox Chen" <foxhlchen@gmail.com>
Cc:     "Fox Chen" <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 10/13] docs: path-lookup: update WALK_GET, WALK_PUT desc
In-reply-to: <20210527091618.287093-11-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>,
 <20210527091618.287093-11-foxhlchen@gmail.com>
Date:   Fri, 18 Jun 2021 08:31:40 +1000
Message-id: <162396910045.29912.16061031990304843868@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021, Fox Chen wrote:
> WALK_GET is changed to WALK_TRAILING with a different meaning.
> Here it should be WALK_NOFOLLOW. WALK_PUT dosn't exist, we have
> WALK_MORE.
>=20
> WALK_PUT =3D=3D !WALK_MORE
>=20
> And there is not should_follow_link().
>=20
> Related commits:
> commit 8c4efe22e7c4 ("namei: invert the meaning of WALK_FOLLOW")
> commit 1c4ff1a87e46 ("namei: invert WALK_PUT logics")
>=20
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/filesystems/path-lookup.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/file=
systems/path-lookup.rst
> index 0a125673a8fe..08e6306af5b1 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -1123,13 +1123,13 @@ stack in ``walk_component()`` immediately when the =
symlink is found;
>  old symlink as it walks that last component.  So it is quite
>  convenient for ``walk_component()`` to release the old symlink and pop
>  the references just before pushing the reference information for the
> -new symlink.  It is guided in this by two flags; ``WALK_GET``, which
> -gives it permission to follow a symlink if it finds one, and
> -``WALK_PUT``, which tells it to release the current symlink after it has b=
een
> -followed.  ``WALK_PUT`` is tested first, leading to a call to
> -``put_link()``.  ``WALK_GET`` is tested subsequently (by
> -``should_follow_link()``) leading to a call to ``pick_link()`` which sets
> -up the stack frame.
> +new symlink.  It is guided in this by three flags: ``WALK_NOFOLLOW`` which
> +forbits it from following a symlink if it finds one, ``WALK_MORE``

"forbids"

> +which indicates that it is yet too early to release the
> +current symlink, and ``WALK_TRAILING`` which predicates that it is on the =
final

"predicates" isn't quite the right word to use here.  "indicates" is
better, but we've already used that word in the sentence, and repetition
feels clumsy (I wonder if anyone else listened to "My Word" on the BBC -
no hesitation, repetition, or deviation).=20
Maybe "reports"?  Or maybe out chief editor can make a suggestion.

NeilBrown

> +component of the lookup, so we will check userspace flag ``LOOKUP_FOLLOW``=
 to
> +decide whether follow it when it is a symlink and call ``may_follow_link()=
`` to
> +check if we have privilege to follow it.
> =20
>  Symlinks with no final component
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --=20
> 2.31.1
>=20
>=20
