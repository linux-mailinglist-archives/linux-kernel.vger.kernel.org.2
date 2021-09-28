Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4EE41AC95
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbhI1KEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239815AbhI1KEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B023F60E09;
        Tue, 28 Sep 2021 10:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632823387;
        bh=ULvY2kQ//pktQDFUCn0fZI98L8jCGIXAZrIqZ77NBW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u68mgzYBhq+BABdSbEOsejKoFvHY1DJRrS4Y9hoXL1gHeih1yWzezvqOtCyEKUt4C
         A2SYaSGnWVJSCA8kbL1kkkmetG7bmYiBF8fcBSxlxmZiA0oX+tnqUE227Mpk6JNnhp
         8T9Q3V5hWA6Cc5XldC0QJ0owBJH7j3w6h6KIHvUJv4OlrJeVvZNSuY/eN9HDyuH638
         iJR1BhxibKvYnqEj5oVpCsufnw6FGi5JTkDlYD330E1O6YH4oaLm9zrjhfxbH/FCl2
         H5T2Jh+cVePvoNDakKdBjRmq3ctV0qTR5PeUh/Sk40Ij1G0cpfcbQBs2GZIkury8EB
         I48msSm9d7gQw==
Date:   Tue, 28 Sep 2021 12:03:04 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] (REBASED) get_abi.pl undefined: improve precision
 and performance
Message-ID: <20210928120304.62319fba@coco.lan>
In-Reply-To: <YVHntS2e3FTWIjds@kroah.com>
References: <YUyICHTRdfL8Ul7X@kroah.com>
        <cover.1632411447.git.mchehab+huawei@kernel.org>
        <YUy1oPjdLTh9rEfq@kroah.com>
        <20210927105553.105f22c5@coco.lan>
        <YVGNiPXNbWWy3CSj@kroah.com>
        <20210927153942.75bbb9cf@coco.lan>
        <YVHntS2e3FTWIjds@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 27 Sep 2021 17:48:05 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Mon, Sep 27, 2021 at 03:39:42PM +0200, Mauro Carvalho Chehab wrote:
> > Em Mon, 27 Sep 2021 11:23:20 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> >  =20
> > > On Mon, Sep 27, 2021 at 10:55:53AM +0200, Mauro Carvalho Chehab wrote=
: =20
> > > > Em Thu, 23 Sep 2021 19:13:04 +0200
> > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > > >    =20
> > > > > On Thu, Sep 23, 2021 at 05:41:11PM +0200, Mauro Carvalho Chehab w=
rote:   =20
> > > > > > Hi Greg,
> > > > > >=20
> > > > > > As requested, this is exactly the same changes, rebased on the =
top of
> > > > > > driver-core/driver-core-next.
> > > > > >=20
> > > > > > -
> > > > > >=20
> > > > > > It follows a series of improvements for get_abi.pl. it is on th=
e top of driver-core/driver-core-next.
> > > > > >=20
> > > > > > With such changes, on my development tree, the script is taking=
 6 seconds to run=20
> > > > > > on my desktop:
> > > > > >=20
> > > > > > 	$ !1076
> > > > > > 	$ time ./scripts/get_abi.pl undefined |sort >undefined_after &=
& cat undefined_after| perl -ne 'print "$1\n" if (m#.*/(\S+) not found#)'|s=
ort|uniq -c|sort -nr >undefined_symbols; wc -l undefined_after undefined_sy=
mbols
> > > > > >=20
> > > > > > 	real	0m6,292s
> > > > > > 	user	0m5,640s
> > > > > > 	sys	0m0,634s
> > > > > > 	  6838 undefined_after
> > > > > > 	   808 undefined_symbols
> > > > > > 	  7646 total
> > > > > >=20
> > > > > > And 7 seconds on a Dell Precision 5820:
> > > > > >=20
> > > > > > 	$ time ./scripts/get_abi.pl undefined |sort >undefined && cat =
undefined| perl -ne 'print "$1\n" if (m#.*/(\S+) not found#)'|sort|uniq -c|=
sort -nr >undefined_symbols; wc -l undefined; wc -l undefined_symbols
> > > > > >=20
> > > > > > 	real	0m7.162s
> > > > > > 	user	0m5.836s
> > > > > > 	sys	0m1.329s
> > > > > > 	6548 undefined
> > > > > > 	772 undefined_symbols
> > > > > >=20
> > > > > > Both tests were done against this tree (based on today's linux-=
next):
> > > > > >=20
> > > > > > 	$ https://git.kernel.org/pub/scm/linux/kernel/git/mchehab/deve=
l.git/log/?h=3Dget_abi_undefined-latest
> > > > > >=20
> > > > > > It should be noticed that, as my tree has several ABI fixes,  t=
he time to run the
> > > > > > script is likely less than if you run on your tree, as there wi=
ll be less symbols to
> > > > > > be reported, and the algorithm is optimized to reduce the numbe=
r of regexes
> > > > > > when a symbol is found.
> > > > > >=20
> > > > > > Besides optimizing and improving the seek logic, this series al=
so change the
> > > > > > debug logic. It how receives a bitmap, where "8" means to print=
 the regexes
> > > > > > that will be used by "undefined" command:
> > > > > >=20
> > > > > > 	$ time ./scripts/get_abi.pl undefined --debug 8 >foo
> > > > > > 	real	0m17,189s
> > > > > > 	user	0m13,940s
> > > > > > 	sys	0m2,404s
> > > > > >=20
> > > > > > 	$wc -l foo
> > > > > > 	18421939 foo
> > > > > >=20
> > > > > > 	$ cat foo
> > > > > > 	...
> > > > > > 	/sys/kernel/kexec_crash_loaded =3D~ /^(?^:^/sys/.*/iio\:device=
.*/in_voltage.*_scale_available$)$/
> > > > > > 	/sys/kernel/kexec_crash_loaded =3D~ /^(?^:^/sys/.*/iio\:device=
.*/out_voltage.*_scale_available$)$/
> > > > > > 	/sys/kernel/kexec_crash_loaded =3D~ /^(?^:^/sys/.*/iio\:device=
.*/out_altvoltage.*_scale_available$)$/
> > > > > > 	/sys/kernel/kexec_crash_loaded =3D~ /^(?^:^/sys/.*/iio\:device=
.*/in_pressure.*_scale_available$)$/
> > > > > > 	...
> > > > > >=20
> > > > > > On other words, on my desktop, the /sys match is performing >18=
M regular=20
> > > > > > expression searches, which takes 6,2 seconds (or 17,2 seconds, =
if debug is=20
> > > > > > enabled and sent to an area on my nvme storage).     =20
> > > > >=20
> > > > > Better, it's down to 10 minutes on my machine now:
> > > > >=20
> > > > > 	real	10m39.218s
> > > > > 	user	10m37.742s
> > > > > 	sys	0m0.775s   =20
> > > >=20
> > > > A lot better, but not clear why it is still taking ~40x more than h=
ere...
> > > > It could well be due to the other ABI changes yet to be applied
> > > > (I'll submit it probably later today), but it could also be related=
 to
> > > > something else. Could this be due to disk writes?   =20
> > >=20
> > > Disk writes to where for what?  This is a very fast disk (nvme raid
> > > array)  It's also a very "big" system, with lots of sysfs files:
> > >=20
> > > 	$ find /sys/devices/ -type f | wc -l
> > > 	44334 =20
> >=20
> > Ok. Maybe that partially explains why it is taking so long, as the
> > number of regex to compare will increase (not linearly). =20
>=20
> No idea.  I just ran it on my laptop and it took only 5 seconds.

Ok, 5 seconds is similar to what I got here on the machines I
tested so far. I'm waiting for a (shared) big machine to be available
in order to be able to do some tests on it.

> Hm, you aren't reading the values of the sysfs files, right?

No. Just retrieving the directory contents. That part is actually
fast: it takes less than 2 seconds here to read all ABI + traverse
sysfs directories. Also, from your past logs, the time is spent
later on, when it is handling the regex. On that time, there are
just the regex parsing and printing the results.=20

> Anything I can do to run to help figure out where the script is taking
> so long?

Not sure if it is worth the efforts. I mean, the relationship
between the number of processed sysfs nodes and the number of regex
to be tested (using big-oh and big-omega notation) should be between
=CE=A9(n . log(n)) and O(n^2 . log(n)). There's not much space left for
optimizing it, I guess.

So, I would expect that a big server would take a log more time to
process, it, due to the larger number of sysfs entries.

Also, if one wants to speedup on a big machine, it could either
exclude some pattern, like:

	# Won't parse any PCI devices
	$time ./scripts/get_abi.pl undefined --search-string '^(?!.*pci)' |wc -l
	8438

	real	0m3,494s
	user	0m2,829s
	sys	0m0,658s

or (more likely) just search for an specific part of the ABI:

	# Seek ABI only for PCI devices
 	$ ./scripts/get_abi.pl undefined --search-string pci

---

After sleeping on it, I opted to implement some progress information.

That will help to identify any issues that might be causing the
script to take so long to finish.

I'll send the patches on a new series.

>=20
> > > And any Documentation/ABI/ updates you might have I'll gladly
> > > take as well. =20
> >=20
> > I'll be submitting it soon enough. Got sidetracked by a regression
> > on my INBOX due to a fetchmail regression[1]. =20
>=20
> Ick, fetchmail.  I recommend getmail instead, much more robust and a
> sane maintainer :)

Hmm... interesting. Never tried getmail. I guess I'll give it a
try. It is a shame that Fedora doesn't package it yet.

>=20
> I'll take a look at those patches now.
>=20
> thanks,
>=20
> greg k-h



Thanks,
Mauro
