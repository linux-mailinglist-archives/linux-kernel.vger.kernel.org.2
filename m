Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB53B5679
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhF1BJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:09:08 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41061 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231892AbhF1BJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:09:07 -0400
Received: (qmail 639287 invoked by uid 1000); 27 Jun 2021 21:06:41 -0400
Date:   Sun, 27 Jun 2021 21:06:41 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "i.kononenko" <i.kononenko@yadro.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] usb:gadget:mass-storage: refactoring the SCSI
 command handling
Message-ID: <20210628010641.GB638648@rowland.harvard.edu>
References: <20210626211820.107310-1-i.kononenko@yadro.com>
 <20210626211820.107310-3-i.kononenko@yadro.com>
 <20210627142355.GD624763@rowland.harvard.edu>
 <bc8059b1-0f56-fc3b-6ec8-0bf1043fc9e5@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8059b1-0f56-fc3b-6ec8-0bf1043fc9e5@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 08:14:48PM +0300, i.kononenko wrote:
> 
> 
> On 27.06.2021 17:23, Alan Stern wrote:
> > On Sun, Jun 27, 2021 at 12:18:15AM +0300, Igor Kononenko wrote:
> >> Implements a universal way to define SCSI commands and configure
> >> precheck handlers.
> > 
> > What is the reason for doing this?
> 
> I have started implementing a way to specify a backend-file of 
> mass-storage images greater than 2.1Gb for cdrom-like mediums. 
> I notice the implementation of each scsi-command handler uses too 
> many magic-constant, hardcoded indexes and shifts. I decided to 
> define structures that contained appropriate SCSI-defined fields 
> and constant-values to clarify the code.
> 
> Additionally, I noticed, many kernel subsystems use the 'separate
> data and logic' approach, making a code more explicit and readable.
> This looks reasonable to me, and a code looks more clearly, at 
> least - we don't need to examine each magic constant and its purpose. 
> 
> > 
> > At first glance, it appears you have added a great deal of complexity
> > to the driver.  The patch replaces a large amount of easily understood
> > (albeit rather repetitious) code with an approximately equal amount
> > of rather complicated code.  This does not seem like an improvement.
> 
> The SCSI-commands table is defined as unifying a way to specify the 
> SCSI-command handler, with corresponding required data instead pass 
> it to each repeatedly switch-case block, which makes code more readable
> to me. If there isn't, I can keep the definition of SCSI-handlers as is,
> but the SCSI-data structures with their constant-values are still 
> required, in my opinion.
> 
> > 
> > Furthermore, the code you removed is flexible; it easily allows for
> > small variations as neede by some command handlers.  But the code you
> > added is all table-driven, which does not easily permit arbitrary
> > variations.
> > 
> 
> I don't think that the SCSI-command handlers table is an obstacle to 
> define variation into a specific handler because the current patch has 
> helper macros, which can specify a behavior for each requirement of 
> handler.
> 
> Anyway, the definition of the scsi-command handlers table may be discarded,
> because this work done to helping developers who will work the 
> 'usb:gadget:mass-storage' subsystem in the future.

Can you submit a patch that adds only the data structures without the
commands table?

Alan Stern
