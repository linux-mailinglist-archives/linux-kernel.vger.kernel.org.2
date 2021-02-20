Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8FE32065E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 18:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBTRNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 12:13:43 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49901 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhBTRNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 12:13:42 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 11KH60NN007214;
        Sat, 20 Feb 2021 18:06:00 +0100
Date:   Sat, 20 Feb 2021 18:06:00 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jari Ruusu <jariruusu@protonmail.com>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210220170600.GB7159@1wt.eu>
References: <YC6nZH/4CkLLsxxB@kroah.com>
 <sjYC-8XCIa2KTTlzjXs95LPnYQJvJe3Lrz4tR9NZTLLIfQpWLquW6W2siZAP7wtgHXOsK5bSxo8JqJp7iPLQ_NtDhh8GbES8J3dUlB5sqYs=@protonmail.com>
 <YC91OWVGAfyorRbc@kroah.com>
 <QYs3MUT8alABsssQUgn1j3b7BF6zgqqiBq0-76Rqcpo6lPFnKyfd8iAagAfotVhDzKP6FFRIjlRVVoIaRtCAEaNT3P-4gyF43rTEPEsvqEA=@protonmail.com>
 <YC+U+beaI91aXh5z@kroah.com>
 <OurD0pqDIPLLZlt1kk-JE57wXeMoh0NFPKKcBrbY3ValknDXcpLwAJz6x1DMbB6LNZ6FDdeUrPM-pX60VF5FERTiDK_gzgHy4tq7iG3MFAM=@protonmail.com>
 <YC+d/NyXDebGSHwN@kroah.com>
 <NBnmv-hTU50xKWL-Q7clpw69elSJgEX7kWA2LiuvzVJ4uOwh8xc5yh83qQDmAfMZl8OcCZxatCZ84dxV2-R2bv25kZLhW0howAP0kOadkwE=@protonmail.com>
 <RpmkVZBUhx36C8VTTIM1SZz6jf46qBoOL4rMaBMuTMRTe-TQGmEfgeMcrGhXWt1N6SSPrHfFERM_hzHRBod7Xn9XV6d0cyEHoQ8nqXi7rXA=@protonmail.com>
 <YDEzOg4WTRWBC7DS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDEzOg4WTRWBC7DS@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 05:05:14PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Feb 20, 2021 at 01:29:21PM +0000, Jari Ruusu wrote:
> > On Friday, February 19, 2021 5:23 PM, Jari Ruusu <jariruusu@protonmail.com> wrote:
> > > My contribution here is trying to point you guys to right direction.
> > 
> > I have been able to narrow the beginning of the problem to these kernels:
> > 4.14.188 ... 4.14.202
> > 
> > Same "fix" that went info 4.14.y is also bugging 4.19.y kernels.
> 
> Great, any chance you can narrow this down to the commit itself?

What is strnage is that there was no iwlwifi driver change in this
interval. Only iwlegacy (don't know if this one was used instead).

Note, my laptop uses iwlwifi as well. I've met random issues with it
a year ago when I started to use wifi, such as wifi randomly freezing
during audio meetings, and automatically fixing itself after 1 minute.
I also found that a down-up cycle on the interface would fix it. It
happened less than once a day so it was not easy to diagnose, and given
how crappy all wifi chips are, I naturally attributed this to the
hardware. But since I upgraded to 5.4 months ago, I don't remember having
met that issue anymore, so it was likely related to the driver. All I can
say is that 4.19.68 was exhibiting this issue. I can't say for older ones
because I didn't use wifi before.

Just my two cents,
Willy
