Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B2931FD68
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBSQwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:52:19 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43163 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229577AbhBSQwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:52:17 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11JGog0G026060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 11:50:42 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E836615C342A; Fri, 19 Feb 2021 11:50:41 -0500 (EST)
Date:   Fri, 19 Feb 2021 11:50:41 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jari Ruusu <jariruusu@protonmail.com>, Willy Tarreau <w@1wt.eu>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC/sYe2vyES0pYQC@mit.edu>
References: <602E766F.758C74D8@users.sourceforge.net>
 <20210218143341.GB13671@1wt.eu>
 <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com>
 <YC6nZH/4CkLLsxxB@kroah.com>
 <sjYC-8XCIa2KTTlzjXs95LPnYQJvJe3Lrz4tR9NZTLLIfQpWLquW6W2siZAP7wtgHXOsK5bSxo8JqJp7iPLQ_NtDhh8GbES8J3dUlB5sqYs=@protonmail.com>
 <YC91OWVGAfyorRbc@kroah.com>
 <QYs3MUT8alABsssQUgn1j3b7BF6zgqqiBq0-76Rqcpo6lPFnKyfd8iAagAfotVhDzKP6FFRIjlRVVoIaRtCAEaNT3P-4gyF43rTEPEsvqEA=@protonmail.com>
 <YC+U+beaI91aXh5z@kroah.com>
 <OurD0pqDIPLLZlt1kk-JE57wXeMoh0NFPKKcBrbY3ValknDXcpLwAJz6x1DMbB6LNZ6FDdeUrPM-pX60VF5FERTiDK_gzgHy4tq7iG3MFAM=@protonmail.com>
 <YC+d/NyXDebGSHwN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC+d/NyXDebGSHwN@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 12:16:12PM +0100, Greg Kroah-Hartman wrote:
> 
> Great!  Can you run 'git bisect' on the 4.14.y stable tree to find the
> offending change?

To be fair, especially with WiFi bugs, you may need to run for hours
or days before you are absolutely sure that a particular bisection
point will result in the the locking/kernel crash bug to manifest
itself.  Worse, you have to be actively using the Wifi in order to see
the problem, and in some cases, it only triggers when you switch
between AP's, so you have to be actively using it in the work office,
and taking it between conference rooms, only to see your machine crash
taking your unsaved work, email drafts, etc. with it.

That being said, users should at least report the bug.  (That's what I
did, when I ran into this a bunch of years ago, with an explanation of
"I'm trying to do a bisect, but it may take a few weeks for me to
figure out what the !@#!? is going on.  In my case, I was trying to
use upstream -rcX kernels to dogfood on my work laptop, but the
principle is the same.)

Ultiumately, I solved the problem, by switching laptops to one that
didn't use an NVidia GPU (which sometimes forced me to stay 1-2
upstream versions behind, making life even more difficult when
debugging these issues, until the out-of-tree video driver got updated
to work with newer upstream), and which also had WiFi hardware which
was less subject to these issues.

It's unfortunate, but not all hardware is as well supported on Linux.
And in my case, because $WORK was using Enterprise WiFi systems with
AP's that don't get as much testing by developers, very few other
people could repro the bugs.  That's life, and sometimes the only
solution is to switch hardware.  And/or you just use a Chromebook in
those sorts of situations, separating your work/enterprise and
upstream development hardware, and be done with it.  :-)

Cheers,

						- Ted
