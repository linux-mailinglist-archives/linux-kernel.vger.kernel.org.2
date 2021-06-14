Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385CB3A5DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 09:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhFNH30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 03:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhFNH3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 03:29:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F08C061574;
        Mon, 14 Jun 2021 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=RFxOuHI4HohFWWV5SWYx/4jgD+FqKhoJgHZnSbUGbMM=; b=sFnSirnXkFYrG2487iuseueld5
        nRvFcqT0tB3TOO7gc6/O9vlq0hcj3PCQUR13cobQCAsOU1mDV1jj3WYpN9LtEYpsy+QihcHKbVn6e
        u0ilvYTfC+qtMyDccp4p5Y5+oTlDbyWQkI3fI/GIHBJTiCdltttUPVUUHEELAysmkTMthcN1W8MsN
        CzLiWTJiM23l9IUJUDZL1NhEOBk39y+igQqsUCwh7C+8nkGhPzs56uAnSbJ8uyl1Aqyn61r24F+8w
        mfz6/PE8PqT0KCPyE+BSQDifh6Q8e1AlcKS/qZs9z0Aa8VmwH9w9HtI+XfHUx5chneF58aqVQsnS1
        43Yz42aA==;
Received: from ip5f5ad4bb.dynamic.kabel-deutschland.de ([95.90.212.187] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsh05-00CsRd-QY; Mon, 14 Jun 2021 07:27:14 +0000
Date:   Mon, 14 Jun 2021 09:27:06 +0200
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <n@nfraprado.net>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>,
        ~lkcamp/patches@lists.sr.ht
Subject: Re: [RFC PATCH 1/2] docs: automarkup.py: Add literal markup of
 known constants
Message-ID: <20210614092706.341f8177@coco.lan>
In-Reply-To: <874ke1bbo6.fsf@meer.lwn.net>
References: <20210609014308.234027-1-n@nfraprado.net>
        <20210609014308.234027-2-n@nfraprado.net>
        <20210609101102.2a97b2dd@coco.lan>
        <874ke1bbo6.fsf@meer.lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 13 Jun 2021 17:13:45 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > It sounds a nightmare to maintain this by hand, as a list of used
> > constants will only grow. IMO, an explicit list should be kept only to
> > with the absolute minimum, e.g. for highly-used constants that aren't
> > error codes nor FOO_BAR. The only case that occurs to me that fits=20
> > on this rule is 'NULL'. =20
>=20
> This is my concern as well.  It seems to me like we would always have a
> situation where some constants are magically marked up and others
> aren't, and people will spend a lot of time trying to figure out why.

Yeah, people wasting their time trying to fix it doesn't sound
good.

>=20
> Might it not be better to just adopt the convention that these constants
> don't need to be marked up at all?  NULL is entirely understandable even
> when presented in a proportional font.  Seems like maybe the best of
> both worlds?

I doubt we'll have a consensus here. IMO it is a lot easier for the
reader to have constants displayed on a different way. I guess other
developers may have similar opinions, while others won't care or would
think otherwise ;-)

Granted, the ones who care could always explicitly add ``FOO`` at
the rst file (we do that on media, as this was imported from our
old docbooks - and we try to preserve it on newer symbols), but I bet
that people will still do things like: "FOO", 'FOO' or =E2=80=98FOO=E2=80=
=99 in order
to distinguish at least some of them.

So, if we want consistency, I can see only two alternatives:

- a treewide patchset manually replacing the conts;
- use automarkup.py.=20

IMO, the latter is better. We can also agree that there won't be
an agreement, and keep as is ;-)

-

Assuming that this would be addressed by automarkup.py, there are
3 cases that automarkup.py can identify without much efforts:

1. uppercases with underscore;
2. error codes: Easy to parse the errno files and get the codes at
   runtme;
3. NULL.

Dealing with the remaining cases, however, are a lot more complex, as
documents may have:

4. Simple uppercase texts:

	THIS README FILE IS PROVIDED BY ADAPTEC AND CONTRIBUTORS ``AS IS`` AND
	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, ANY
	...
	FILE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

	(this one is at Documentation/scsi/aic79xx.rst, but there are=20
         other variants of similar licensing style texts on other places)

5. uppercase acronyms, like DIMM, RAM, etc;

6. names of boards, manufacturers, etc;

7. syscalls, like:

	SIOCDEVPRIVATE
	SIOCETHTOOL
	SIOCGHWTSTAMP
	...

8. other constants

It should also be noticed that some files use uppercase letters for
variables like "A", "B" and "C". On those, using a different font
would make a lot easier for the readers.

It sounds to me that one size doesn't fit all. I can't see a
way to address it on a way that it would make easy to maintain
while keeping it fully transparent.

Maybe there's one alternative: automarkup could gain support to read
extra files with non-treewide regex rules.

For instance, a Documentation/foo/.automarkup could contain extra
regex rules for the files under Documentation/foo/.
Another possibility would be to have a ".. automarkup_file" tag.

This way, (1), (2) and (3) would be handled automatically,
treewide, but things like sockios.h (SIO* ioctls) would be there
only for network, for instance, using some file with the extra
regexes for automarkup stored under Documentation/networking.

Not sure how hard/easy would be to implement it, nor if one
directory can/should inherit extra regexes from its parent,
but, at a first glance, this seems to be a way to go.

Thanks,
Mauro
