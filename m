Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA77B31B3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 02:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhBOA6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 19:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhBOA4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 19:56:21 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D64C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 16:55:41 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v3so3894730qtw.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 16:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=DmXO8urGBGXKWgbwPOPHslxHIcQKJ4XGI0OA1QXvVs8=;
        b=NExpD+bAA7wNpdGZd2PjqmKNRar6hMaGbwvnjp++qxJFN05P6hrJpXQlCciUW35LkI
         +G5KwTCl0aG4TDQCVrES3M2CfQdA2WDCdijWDivj3qs5nJtMZTr0Lk4vOz1BqCblWZcH
         A6IJH5ZKcjPWZnILfSJW3ZvqFY/K+szrfbQP6ycWRqZMAcPvON5pamInbVD8NyjmFwUT
         /Khb8PdedyFbpYPgHNt0ZDrmSREFmgpCIAZu9tISnmRoEwcxQzjGHeA4OK3aNvkgPU8W
         3YQ+MteqCioVazKPbSrxqKaLNlF5gGsdn744iNNuFbOR7X1ubL7u1K8sOI+Fbq8Aibut
         9veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=DmXO8urGBGXKWgbwPOPHslxHIcQKJ4XGI0OA1QXvVs8=;
        b=O+C5N49ziUOhkGNDoOuVW6POA/V83X5JPhrsawqBpwxwLrxmMGsX7UUKPmDBsXlo71
         0nDSMXpxVb+e8apn/ZW62P90JXGVMp1YL3+zKrszwmXqrooJxzBhIRj21RPlQPuz2+w9
         CnsRmfufM9kpAW+IO0PECT2+hQUlTHg5ZtnP8DrncE7XpfVwASaafrBNBOeflTWG1XSZ
         6XF3pTBj6Cac2i54EBFV4zijF6r8P8APlfl+hh8fHAXpNBKDK8Pn3pkhRXwpMdi16xku
         4MlBsQMA6HKwXLilOxW2ODTnQJZFzUuXwZ/phSp7fc5t8HzGzutTjWBtk0pupb+LWJKG
         i2wQ==
X-Gm-Message-State: AOAM533Z+b4F7Ya8s2tWURn1A8NN7kHs3AXoVwiksseVe812OdOZBfpD
        J0r3M+ZxgWHQKf/Q08Y5JXQZcWg6pB54fQ==
X-Google-Smtp-Source: ABdhPJyLE9ZKtHVKrfgDbDqmcnh/ujCnQDo9LNBlzrkCj6PYO7z+trzEUA4TWxUxcuaJ/0fCR3PbGQ==
X-Received: by 2002:aed:2d45:: with SMTP id h63mr12059007qtd.239.1613350540388;
        Sun, 14 Feb 2021 16:55:40 -0800 (PST)
Received: from OpenSuse ([138.199.10.7])
        by smtp.gmail.com with ESMTPSA id g13sm3768615qtp.23.2021.02.14.16.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:55:39 -0800 (PST)
Date:   Mon, 15 Feb 2021 06:25:33 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11
Message-ID: <YCnGhWm2qLl0v/+q@OpenSuse>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wg8LpRi9+P2_V+ehJ2_EoJifNh2QmVf47aLXfkCd-1UAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vbYI1gYA5RfZZPVb"
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8LpRi9+P2_V+ehJ2_EoJifNh2QmVf47aLXfkCd-1UAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vbYI1gYA5RfZZPVb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:45 Sun 14 Feb 2021, Linus Torvalds wrote:
>Nothing unexpected or particularly scary happened this week, so here
>we are - with 5.11 tagged and pushed out.
>
>In fact, it's a smaller-than-average set of commits from rc7 to final,
>which makes me happy. And I already have several pull requests lined
>up for tomorrow, so we're all set for the merge window to start.
>
>But in the meantime - and yes, I know it's Valentine's Day here in the
>US - maybe give this release a good testing before you go back and
>play with development kernels. All right? Because I'm sure your SO
>will understand.
>

Here we go ....... :)

bhaskar@OpenSuse_06:22:58_Mon Feb 15:~> rc-kernel-pull-build-boot.sh
We have new RC kernel
remote: Enumerating objects: 6, done.
remote: Counting objects: 100% (6/6), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 4 (delta 2), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (4/4), 868 bytes | 289.00 KiB/s, done.
 From https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
    28a173387388..f40ddce88593  master     -> origin/master
     * [new tag]                   v5.11      -> v5.11
     Updating 28a173387388..f40ddce88593
     Fast-forward
      Makefile | 4 ++--
       1 file changed, 2 insertions(+), 2 deletions(-)
       We are fine ..pls proceed..



~Bhaskar

--vbYI1gYA5RfZZPVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmApxoUACgkQsjqdtxFL
KRVyLwgAzyWx4g5Nnwx5sQekCvTquWreN/3AnSswnDizVstgR/jC9gvu3/i3cSg+
yOyQ7OrFjzQE+Rp37iXuQls/ErR4STjvlCHjbRpIt2tkzmPLev+aHV2W491XatC1
XtpGYope7QQhhbbb3FxmRgPK2mg4l9VVOhhyKe/x6qtspi7eJZye0J5FvYJJm1Kv
6wrs2pGRX7e3mPR2PDgL/HkqF8ZuGb3dnZAQCA6X/w14ZWS45uQbNxpzgds829sJ
FgKdHdIK6da5XzvV36IX0IHwgotdjOo+gR9p/QwkOlyANU2VWuaUZkBN+ZP04Q+2
p5Z9nLbMqPjvNVN0cnHl73Q5xV/Z5w==
=skxD
-----END PGP SIGNATURE-----

--vbYI1gYA5RfZZPVb--
