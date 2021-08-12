Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03DB3EA328
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhHLKyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:54:43 -0400
Received: from cpanel8.indieserve.net ([199.212.143.3]:34433 "EHLO
        cpanel8.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbhHLKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:54:40 -0400
X-Greylist: delayed 1645 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Aug 2021 06:54:40 EDT
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.107.13]:58948 helo=fedora)
        by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1mE7vF-0003Bk-2G; Thu, 12 Aug 2021 06:26:48 -0400
Date:   Thu, 12 Aug 2021 06:26:44 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Muni Sekhar <munisekharrms@gmail.com>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: LDD 3rd ed. - It was: Re: read() via USB bus
In-Reply-To: <YRT1j20SRYXpPsXc@kroah.com>
Message-ID: <61d7271d-d3cb-f25d-eaad-5489461a3bef@crashcourse.ca>
References: <CAHhAz+jKREfXERKj7XB7U3Wh1g4STO2Dt0qnMkcPV5nXB3_bwg@mail.gmail.com> <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com> <YRDq530N/9uu2J0x@kroah.com> <13470108.apdoE9Qb8s@localhost.localdomain> <YRT1j20SRYXpPsXc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021, Greg KH wrote:

> On Thu, Aug 12, 2021 at 11:45:45AM +0200, Fabio M. De Francesco wrote:
> > Hi Greg,
> >
> > On Monday, August 9, 2021 10:44:23 AM CEST Greg KH wrote:
> > > On Mon, Aug 09, 2021 at 10:15:29AM +0200, Oliver Neukum wrote:
> > > > On 09.08.21 09:58, Muni Sekhar wrote:
> > > > > Hi all,
> > > > >
> > > > > PCIe memory mapped registers can be read via readb(), readw(), readl()
> > > > > kernel API's. Similarly what are the kernel API to read the device
> > > > > registers via USB bus
> > > >
> > > > [...]
> > > >
> > > > I hope this list stays friendly to newcomers and we will answer
> > > > specific questions, but at this point I must advise you to first
> > > > read an introductory book.
> > >
> > > Along these lines, take a look at the book, Linux Device Drivers, third
> > > edition, which is free online, as it has a chapter about USB drivers and
> > > how they work.  That should help you out to understand the issues
> > > involved with USB devices.
> > >
> > I've heard that your book, LDD 3rd edition, has become obsolete a long time
> > ago and most sample code cannot anymore build. Reading what you wrote above
> > seems to contradict what I've been told by others... I must admit that I've
> > just had a print copy of it that I have not yet opened for reading, therefore
> > maybe that I'm totally wrong in assuming the above.
>
> Look into it and see the differences, it's not hard to notice.
>
> And the code samples are all up to date online on github somewhere,
> there's people keeping them alive if you want to track them down,
> but really, just look at the in-kernel drivers for better examples
> of real drivers.

  it's possibly worth mentioning that a chap named javier martinez has
been doing a decent job of upgrading the examples from LDD3 to keep up
with current kernel development:

  https://github.com/martinezjavier/ldd3

of course, those examples won't match the explanations in the book
anymore, but still, worth perusing.

rday
