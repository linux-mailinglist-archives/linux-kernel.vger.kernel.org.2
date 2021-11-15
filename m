Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D754644FD69
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 04:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhKODUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 22:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbhKODUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 22:20:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E8AC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 19:17:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HsvWM3n4nz4xbs;
        Mon, 15 Nov 2021 14:17:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1636946239;
        bh=C0W33s36xReKxtd1UyDe4WdTNeZsHfdLOz9riv7/2ho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p7CsxrWKqYr73EXiMpeFrMvLcVX6TmQn0Qz+rfawcmY1lqcGCbj67/uWtHtYBy+sn
         oZFso392NjyyXd1t+wqTUGkj/9cSNllpESg3swyfw12hyd+ptt1FH4/p2je31JOUzc
         P567QLozIzMkh74CZJv9g4ygIKLLtwxQgIGNH00RrA1qWt6Bb1vzN579cX7Jr9JeEC
         6m+JPHxweaJ9fDMSzRpRmyCSsNNnAE96dQNsSAUCVM4+kbZdazCoxmf/+aQPKdMTTq
         uONZUb169TYo6hJ0EESkdwkyB2xsNgxE6tZT/gse1EHgV9ANYq8uw/zl4R3L6IO9BT
         vXmK4l2uvrgOA==
Date:   Mon, 15 Nov 2021 14:17:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 5.16-rc1)
Message-ID: <20211115141718.0ce3947d@canb.auug.org.au>
In-Reply-To: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NmVhArFsqvdL09YfV63tL=v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NmVhArFsqvdL09YfV63tL=v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20211101 was the first linux-next after
the merge window opened.)

Commits in v5.16-rc1 (relative to v5.15):          12319
Commits in next-20211101:                          11753
Commits with the same SHA1:                        10811
Commits with the same patch_id:                      475 (1)
Commits with the same subject line:                   43 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20211101:     11329 91%

Some breakdown of the list of extra commits (relative to next-20211101)
in -rc1:

Top ten first word of commit summary:

     87 perf
     68 drm
     67 net
     31 mfd
     30 pci
     29 dt-bindings
     27 selftests
     27 kvm
     21 nfs
     21 alsa

Top ten authors:

     45 miquel.raynal@bootlin.com
     41 irogers@google.com
     19 acme@redhat.com
     16 mcgrof@kernel.org
     15 ming.lei@redhat.com
     15 kuba@kernel.org
     15 anna.schumaker@netapp.com
     13 axboe@kernel.dk
     13 alexandre.belloni@bootlin.com
     12 trond.myklebust@hammerspace.com

Top ten commiters:

     99 davem@davemloft.net
     92 acme@redhat.com
     64 axboe@kernel.dk
     51 alexander.deucher@amd.com
     50 lee.jones@linaro.org
     40 trond.myklebust@hammerspace.com
     36 stfrench@microsoft.com
     30 pbonzini@redhat.com
     29 daniel@iogearbox.net
     25 kuba@kernel.org

There are also 424 commits in next-20211101 that didn't make it into
v5.16-rc1.

Top ten first word of commit summary:

     53 bluetooth
     37 tools
     23 rcu
     21 drm
     18 arm
     17 iio
     13 soc
     13 mm
     10 h8300
      9 unicode

Top ten authors:

     47 paulmck@kernel.org
     16 yury.norov@gmail.com
     15 ojeda@kernel.org
     14 luiz.von.dentz@intel.com
     14 hch@lst.de
     14 frederic@kernel.org
     14 arnd@arndb.de
     14 akpm@linux-foundation.org
     13 brian.gix@intel.com
     11 ysato@users.sourceforge.jp

Some of Andrew's patches are fixes for other patches in his tree (and
have been merged into those).

Top ten commiters:

     74 paulmck@kernel.org
     71 sfr@canb.auug.org.au
     53 marcel@holtmann.org
     17 jonathan.cameron@huawei.com
     16 yury.norov@gmail.com
     16 ysato@users.sourceforge.jp
     16 ojeda@kernel.org
     15 treding@nvidia.com
     13 dhowells@redhat.com
     11 nsaenz@kernel.org

Those commits by me are from Andrew's mmotm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/NmVhArFsqvdL09YfV63tL=v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGR0T4ACgkQAVBC80lX
0GwECQf6AhnfZ/lnVjsPNik3j7FDaYEPN5oBG0zaGTdx0dWtmvBGF4dKSZiJqS0G
sXq6EgkYAYa2/G8zOlN+Fq5X4qPEavnb9yMYZpNwMHWuCxr5hmB+Hw5Xq4F5jhrr
JIVFW3YtyKdutiQqq5XaTYyk8Nl/MMAX+8FaV7RhiW5r22Hdu/OwA4z3Icpxznp3
3FBbJsSUYR4rMrYcKtcFV93lS2h1Qlws3ruJs9eYCtX99FysCSLi+9QIO57gRw+e
FI75ears+5ABP3unqS7JcJzNChhHfaAwJhWvsTnZqT89Hk2auBHlbgM9bHo9J94P
n900XjWefbj+XjmMpjF36lawIvPJ8w==
=EnqU
-----END PGP SIGNATURE-----

--Sig_/NmVhArFsqvdL09YfV63tL=v--
