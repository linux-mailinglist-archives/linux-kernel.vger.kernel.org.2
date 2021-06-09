Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF23A0DFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhFIHrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:47:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233136AbhFIHrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:47:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 478896135D;
        Wed,  9 Jun 2021 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623224742;
        bh=6LanqRJaulCMOLLjZLpKIZ5sO6VK9+eFCOZJAEWtfeg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uQdjGMsQSIo+pmyaG35Xq7AlgCaA65KgOIkBumMjSlU/aTrfhYMgF/mEzUFVC5GFz
         nZlKO5F4o5kxPyI3EawyLlC6H+VhYolDmWOuiWr9jCrBSfh+upIDpFg9MQbSFPdwhR
         ep0Rt3vVd0/eMrqWL5Bkencen7LqVsLd7Va2u9OPxlofuZY6u0/OJqSb2V+mR228n7
         RhFKSbDwbrS1XEdYoyR8OAtIsNDvqmHIYCD5/xyDzVsN6CUhW9qBk8mHxVNRFAQ+rb
         MVnqHSajhK0drEGCJfbtftMl9zJeM50tT69wmnJdGiTrr/zN0hPT3/g3DUq8ysz1E6
         2XkEHCATjg63A==
Date:   Wed, 9 Jun 2021 09:45:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <n@nfraprado.net>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>,
        ~lkcamp/patches@lists.sr.ht
Subject: Re: [RFC PATCH 0/2] docs: automarkup.py: Add literal markup of
 known constants
Message-ID: <20210609094535.7ed61991@coco.lan>
In-Reply-To: <20210609014308.234027-1-n@nfraprado.net>
References: <20210609014308.234027-1-n@nfraprado.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi N=C3=ADcolas,

Em Tue,  8 Jun 2021 22:43:06 -0300
N=C3=ADcolas F. R. A. Prado <n@nfraprado.net> escreveu:

> Hi,
>=20
> a while back Matthew suggested adding automatic markup of known constants=
, like
> NULL and error codes, as literals [1]. This is a great idea since those l=
iterals
> are very frequently used throughout the documentation and are fixed names=
, so we
> can easily match them without false positives and make the source files l=
ess
> cluttered.
>=20
> Patch 1 adds that feature to automarkup.py, while patch 2 removes the no =
longer
> needed markup from the xarray.rst file which was given as an example.
>=20
> Some things I'd like to discuss:
>=20
> * As a first draft I added the constants I found on xarray.rst plus all e=
rror
>   codes from errno-base.h and errno.h. We don't need to start with everyt=
hing,
>   but we can certainly do better than this. What are common constants that
>   should be added here? (Matthew mentioned ANSI C or POSIX, some referenc=
e to
>   the constants in those would be great, even more if they are easily par=
sable)
>=20
> * The Literals list added is already a bit big with just the error codes,=
 so
>   perhaps we should move them to a separate plain text file that is read =
on
>   startup?

If we're willing to keep a long list, they should be parsed from files,
instead of directly included. For things like errno-base.h/errno.h, the
better would be if automarkup would read them directly from the header
file, as otherwise there will be a maintainance burden.

Yet, a regex like "-E[A-Z\d]+\b" would likely get all cases, but this
will produce false positives, like EXAMPLE, EXAMPLES and some other
non-trivial exceptions.

With regards to NULL, I would just use a trivial regex like: "\bNULL\b"
(but see below my notes about using "\b").

> * There was also mention of automatically converting uppercase words to
>   literals. I'm not so sure about that one so I left it out for now.
>=20
>   The example given was XA_MARK_0, which is a #define in xarray.h. The way
>   to go here is certainly to first use kernel-doc to get it included in t=
he
>   documentation, and then cross-reference to it. FWICT at the moment kern=
el-doc
>   for defines should be done like for functions (but the parenthesis can =
be
>   omitted, although they show up in the output):
>=20
> 	/**
> 	  * XA_MARK_0 - Brief description.
> 	  *
> 	  * Description of the type.
> 	  */
>=20
>   At the current state, the cross-reference would then need to be done ei=
ther
>   through plain :c:macro:`XA_MARK_0`, or, by relying on automarkup, typed=
ef
>   XA_MARK_0 (which is not ideal since this isn't a typedef). Options for
>   improvements would be to add 'macro' as a possible prefix (so eg. macro
>   XA_MARK_0), or go all out and try to cross-reference on every uppercase=
 word
>   like suggested. We should strive for what is the most natural to write,=
 as
>   long as the regex isn't too broad.
>=20
>   Since automarkup.py is opt-out rather than opt-in, I think we should be=
 extra
>   careful not to make the regexes too broad, even if in this case it reli=
es on a
>   C symbol being present.
>=20
>   One other idea I had was that we could limit to all uppercase words as
>   long as it has an _ on it, since I don't expect we would get false posi=
tives
>   with that. The downside is that it might be very confusing to people wh=
y their
>   MACRONAME isn't being automatically cross-referenced to...

What it can be done would be to first check/apply cross-references. Only if=
 it
fails, then replace everything in uppercase to literals.

There is a drawback, tough: this would cause texts in uppercase. We used to
have lots of them before ReST conversion. I won't doubt that some files
would have kept a few of them. So, in this case, the regex would need to
require at least one _, e. g. something like:=20

	\b[\-]?[A-Z_][A-Z\d_]*_[A-Z\d_]*\b

Again, tests are needed in order to check if the regex won't get anything
that shouldn't be caught. So, I would grep the source codes in order to
check if the regexes won't bring false positives, e. g.:

	$ git grep -E "\b[\-]?[A-Z_][A-Z\d_]*_[A-Z\d_]*\b" Documentation/


Btw, the "\b" at the end won't actually work, due to things like:

	GLOBAL_GEN_STORAGE{0:3}
	GAUDI_ENGINE_ID_*

If you take a look at the scripts/get_abi.pl that I wrote, I faced
the same problem there with \b. So, I ended implementing my own set
of \b:
	=20
	my $start =3D qr {(^|\s|\() }x;
	my $bondary =3D qr { ([,.:;\)\s]|\z) }x;

Using the above replacements for \b, I would do something like this to
double-check if the regex won't be producing false-positives:

	$ for i in $(find Documentation/ -name '*.rst'); do perl -ne 'print "$1  \=
e[0;31m$2\e[0;37m  $3\n" if /(^|\s|\()([\-]?[A-Z_][A-Z\d_]*_[A-Z\d_]*)([,.:=
;\)\s]|\z)/' $i; done

Btw, on a quick look, this specific regex:

	(^|\s|\()([\-]?[A-Z_][A-Z\d_]*_[A-Z\d_]*)([,.:;\)\s]|\z)

Seems to be producing just one false positive: a sequence of _, e. g.:

	\b\_+\b

While we could make the regex more complex, I would just test if the second
match is '^\_+$', skipping it if found. On other words, a python-equivalent
to this:

	$ for i in $(find Documentation/ -name '*.rst'); do perl -ne 'print "$2\n"=
 if /(^|\s|\()([\-]?[A-Z_][A-Z\d_]*_[A-Z\d_]*)([,.:;\)\s]|\z)/' $i|grep -vE=
 "^\_+$"; done|sort|uniq

-

That's said, it is worth to also mention the false negatives:

	$ for i in $(find Documentation/ -name '*.rst'); do perl -ne 'print "$2\n"=
 if /(^|\s|\()([\-]?[A-Z_][A-Z\d_]*_[A-Z\d_]*)([,.:;\)\s]|\z)/' $i|grep -vE=
 "^\_+$"; done|sort|uniq >OK_list
	$ for i in $(find Documentation/ -name '*.rst'); do perl -ne 'print "$2\n"=
 if /(^|\s|\()([\-]?[A-Z_][A-Z\d_]*)([,.:;\)\s]|\z)/' $i|grep -vE " "; done=
|sort|uniq >FULL_list
	$ grep -v -f OK_list FULL_list >excluded_list
	$ wc -l OK_list FULL_list excluded_list=20
	  7398 OK_list
	 14487 FULL_list
	  7520 excluded_list
	 29405 total

There are a lot of constants that won't be parsed if we require at least
one '_'. Looking at the excluded_list, indeed there are things there
which should be excluded, like EXAMPLE, EXAMPLES, EXCEPTION, WITH, WITHIN,
WITHOUT..., but also there are a several matches that are constants,
like KERNELRELEASE, DISCONTIGMEM, SIOCGIFINDEX, SIGALRM, SETREGSET,
CDROMREADCOOKED, CDROMREADRAW, ...

I doubt that there would be an easy way to handle such cases, as
a file with a ~7000 constants would be a maintenance nightmare.

---

In summary, my suggestion is that we should stay out of having a big list
of constants. So, I would start with:

	1. a regex to get FOO_BAR cases, like:

		(^|\s|\()([\-]?[A-Z_][A-Z\d_]*_[A-Z\d_]*)([,.:;\)\s]|\z)

	   with a test to exclude this pattern:

		 ^\_+$

	2. a logic that will pick and use errno codes from the errno*.h
	   files;

	3. an specific handler handler for the NULL special case.

This would get 7000+ different constants, which seems a very good
start. If needed, later we could get a few other relevant constants
by checking the most-used ones with something like:

	for i in $(find Documentation/ -name '*.rst'); do perl -ne 'print "$2\n" i=
f /(^|\s|\()([\-]?[A-Z_][A-Z\d_]*)([,.:;\)\s]|\z)/' $i|grep -v "_"; done|so=
rt|uniq -c|sort -n

in order to grab the most common ones.

Regards,
Mauro
