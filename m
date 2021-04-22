Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05369367CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhDVIj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:39:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45226 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbhDVIj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:39:26 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1D1871C0B76; Thu, 22 Apr 2021 10:38:51 +0200 (CEST)
Date:   Thu, 22 Apr 2021 10:38:50 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <jikos@kernel.org>, Will Deacon <will@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
Message-ID: <20210422083850.GA5316@amd>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I don't believe doing huge revert is good idea.

> I have been meaning to do this for a while, but recent events have
> finally forced me to do so.
>=20
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).

Do you have examples of those "bad faith" commits? Because that's not
what the paper says. While I identified one unneccessary commit during
stable review, I don't believe it was done in bad faith. According to
the paper, there are just three (3) (!!) bad faith commits, and were
done from gmail addresses, and steps were taken so to prevent them
=66rom entering git.

I do believe we have problem with -stable kernel getting way too many
changes that are not really fixing anything, or are fixing stuff like
"16 bytes memory leak once per boot" or printk log levels. I tried
pushing back with little success. Stable kernel rules are not
consistent with patches actually accepted into stable. Plus, it is
quicker to get patch to stable release than to mainline release, which
I believe is additional problem.

For the reference, the paper seems to be available here:

https://github.com/QiushiWu/QiushiWu.github.io/blob/main/papers/OpenSourceI=
nsecurity.pdf

Quoting the paper:

Experiment overview. In this experiment, we leverage
program-analysis techniques to prepare three minor hypocrite
commits that introduce UAF bugs in the Linux kernel. The
three cases represent three different kinds of hypocrite commits:
(1) a coding-improvement change that simply prints an error
message, (2) a patch for fixing a memory-leak bug, and (3) a
patch for fixing a refcount bug. We submit the three patches
using a random Gmail account to the Linux community and
seek their feedback=E2=80=94whether the patches look good to them.
The experiment is to demonstrate the practicality of hypocrite
commits, and it will not introduce or intend to introduce actual
UAF or any other bug in the Linux kernel.
A. Ethical Considerations
Ensuring the safety of the experiment. In the experiment,
we aim to demonstrate the practicality of stealthily introducing
vulnerabilities through hypocrite commits. Our goal is not to
introduce vulnerabilities to harm OSS. Therefore, we safely
conduct the experiment to make sure that the introduced UAF
bugs will not be merged into the actual Linux code. In addition
to the minor patches that introduce UAF conditions, we also
prepare the correct patches for fixing the minor issues. We
send the minor patches to the Linux community through email
to seek their feedback. Fortunately, there is a time window
between the confirmation of a patch and the merging of the
patch. Once a maintainer confirmed our patches, e.g., an email
reply indicating =E2=80=9Clooks good=E2=80=9D, we immediately notify the
maintainers of the introduced UAF and request them to not
go ahead to apply the patch. At the same time, we point out
the correct fixing of the bug and provide our correct patch.
In all the three cases, maintainers explicitly acknowledged
and confirmed to not move forward with the incorrect patches
=2E..

Best regards,
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCBNhkACgkQMOfwapXb+vIoFgCgs7JgMZ1iyWnYu6g2D5GdSQaL
gLkAn3ME9jobyMWuLtQ0qtiBQymAiLJp
=VUCC
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
