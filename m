Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2683AB290
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhFQLax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:30:53 -0400
Received: from gimli.rothwell.id.au ([103.230.158.156]:36815 "EHLO
        gimli.rothwell.id.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhFQLaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:30:52 -0400
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4G5KYp6B7rzyNc;
        Thu, 17 Jun 2021 21:28:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rothwell.id.au;
        s=201702; t=1623929313;
        bh=Ehrvqd9Y00b/N1Kep2o7tgU3IrmuKv5IjdIFBhghzWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rlrVfqJ9B4fh7Z95BYqHn9EDBdKZIfoxVmBokcmNpXWkmRUyHJUXi4mam9SubIrPy
         iq7j93YJbWFCWFCDvCG35pW2YbUe4sxpMnJol1GPExy8/bwNRVtmUaPqykeZDyXqGN
         2tH7lSEB2TGUbpFS8N930ZcwGMDU9/qQExXwJwkJGLWmRGMsA8GAvmgAQHE1u2ahbE
         jzdeOdWvXq9JpwNqTRCUGvEGuG2/7X5gEAriTGJeTKuJSoXycarN+hWIo2QIk5gcSU
         uuWc7Uqi2MdnBk4sxS6I5ZKQea8qJWJEsENiGnB8ykSguxnzAV6GKIlS0YBRY2xwgx
         D/sT69pvZGvfg==
Date:   Thu, 17 Jun 2021 21:28:29 +1000
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v4 0/2] introduce printk cpu lock
Message-ID: <20210617212829.33032350@elm.ozlabs.ibm.com>
In-Reply-To: <YMswqJ7sV5RCxNim@alley>
References: <20210617095051.4808-1-john.ogness@linutronix.de>
        <YMswqJ7sV5RCxNim@alley>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f=RK7xnOIhHTNY7mAr9sOE/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f=RK7xnOIhHTNY7mAr9sOE/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 17 Jun 2021 13:23:20 +0200 Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2021-06-17 11:56:49, John Ogness wrote:
> >=20
> > This series is against next-20210616.
>=20
> The patchset is ready for linux-next from my POV. We are getting close
> to the merge window so I am going to push it tomorrow. We could always
> remove it when anyone has comments the following week.

Unless this patch series is going to be part of Andrew Morton's
post-next patch series, it must not be based on the whole of linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/f=RK7xnOIhHTNY7mAr9sOE/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmDLMd0ACgkQAVBC80lX
0GxTiQgAg9bpYLcrRlgFZHYBTJDrT2JIZfEoOtwcaoKxj4iBrQXrdWLMXTXxHp3B
RFd/9/gKDYjPpTTWFNNocBtew5kOzlIKHKN40k59jY73sU//rdb5MAp0Z387jc/s
qua9ycVGmUiS/0qtalJHIasURJ7G71DhHmA6bPPtaEd30Ghu/x3S5TblbGLmZAxD
Fkma7zC0QvEaGyJNMyWTQ6bW4bLB3fXqfVZ+cbhFbHDe68rkf6+mGm5nXhK1RMUo
uLRNkLfyj0QMaVu8HRthEeTRMa7+n7J5ghAXIEg3+u17fxzA4v2t16RHTAXceSIh
zRtdGnJYEHqYRgK/wgMU+iNWjVOqdQ==
=hLaM
-----END PGP SIGNATURE-----

--Sig_/f=RK7xnOIhHTNY7mAr9sOE/--
