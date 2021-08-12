Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151E23EA2EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhHLKTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236024AbhHLKTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:19:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67F7260FC4;
        Thu, 12 Aug 2021 10:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628763538;
        bh=wswBG1MQzg0pXBIwFWmKSKxwNYHFJHoFRGi2AqN7ChQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUsB0L0PxpYzpXIYS9mAmoWTQpMv0E+C1kRm4VH/hT+A9IEQVjkeZbw0JmmSH4E4y
         3fEQKmSY1LiEmdFp8Sj6RADm3le1GNCcMdlcDz4wufJ5pWHZvN+Yb0rz+rJw9Shb10
         B4KatYY1gfuNNPtTWkj3YXrb0euGh8h03L9/W+Gw=
Date:   Thu, 12 Aug 2021 12:18:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Muni Sekhar <munisekharrms@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: LDD 3rd ed. - It was: Re: read() via USB bus
Message-ID: <YRT1j20SRYXpPsXc@kroah.com>
References: <CAHhAz+jKREfXERKj7XB7U3Wh1g4STO2Dt0qnMkcPV5nXB3_bwg@mail.gmail.com>
 <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com>
 <YRDq530N/9uu2J0x@kroah.com>
 <13470108.apdoE9Qb8s@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13470108.apdoE9Qb8s@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 11:45:45AM +0200, Fabio M. De Francesco wrote:
> Hi Greg,
> 
> On Monday, August 9, 2021 10:44:23 AM CEST Greg KH wrote:
> > On Mon, Aug 09, 2021 at 10:15:29AM +0200, Oliver Neukum wrote:
> > > On 09.08.21 09:58, Muni Sekhar wrote:
> > > > Hi all,
> > > > 
> > > > PCIe memory mapped registers can be read via readb(), readw(), readl()
> > > > kernel API's. Similarly what are the kernel API to read the device
> > > > registers via USB bus
> > > 
> > > [...]
> > >
> > > I hope this list stays friendly to newcomers and we will answer
> > > specific questions, but at this point I must advise you to first
> > > read an introductory book.
> > 
> > Along these lines, take a look at the book, Linux Device Drivers, third
> > edition, which is free online, as it has a chapter about USB drivers and
> > how they work.  That should help you out to understand the issues
> > involved with USB devices.
> > 
> I've heard that your book, LDD 3rd edition, has become obsolete a long time 
> ago and most sample code cannot anymore build. Reading what you wrote above 
> seems to contradict what I've been told by others... I must admit that I've 
> just had a print copy of it that I have not yet opened for reading, therefore 
> maybe that I'm totally wrong in assuming the above.

Look into it and see the differences, it's not hard to notice.

And the code samples are all up to date online on github somewhere,
there's people keeping them alive if you want to track them down, but
really, just look at the in-kernel drivers for better examples of real
drivers.

> Do you mind to elaborate a bit more on this subject, please? I mean: can you 
> point out which chapters, which content, should be skipped (if there's really 
> something which is no more correct/relevant to today's practice of drivers  
> development and kernel hacking?

I am not going to create a study guide like this, sorry, I've already
given away the book for free to you :)

> One more question, please... if after carefully studying its content, someone 
> wanted to change and update part of the book content to reflect the changes in 
> Linux API and in the current best practices, would it be (legally) allowed to 
> publish a v4 on GitHub for the convenience of everyone interested in learning 
> for free? However, I understand that it would be not so easy to come up with a 
> good and error free text if not addressed as a public long term project and 
> I'm also not sure of what tools are needed to edit PDF files. (At the moment 
> my question is for a hypothetical scenario, just to know whether or not it 
> would be technically and legally doable). 

Please see the license of the book for what you are, and are not,
allowed to do with it to answer this question.

thanks,

greg k-h
