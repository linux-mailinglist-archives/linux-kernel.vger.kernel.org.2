Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59643DCBCC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 15:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhHANbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 09:31:13 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50835 "EHLO
        einhorn-mail-out.in-berlin.de" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231546AbhHANbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 09:31:11 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 171DUQ6w005133
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 1 Aug 2021 15:30:28 +0200
Date:   Sun, 1 Aug 2021 15:30:24 +0200
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jordy Zomer <jordy@pwning.systems>, linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] firewire: ohci: make reg_(read|write) unsigned
Message-ID: <20210801153024.21941652@kant>
In-Reply-To: <YQY+U9i8Zw7OAKOO@kroah.com>
References: <20210731104112.512449-1-jordy@pwning.systems>
        <YQY+BL4nR9Loddum@kroah.com>
        <YQY+U9i8Zw7OAKOO@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 01 Greg Kroah-Hartman wrote:
> On Sun, Aug 01, 2021 at 08:24:04AM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Jul 31, 2021 at 12:41:12PM +0200, Jordy Zomer wrote:  
> > > The reg_(read|write) functions used to
> > > take a signed integer as an offset parameter.
> > > The callers of this function only pass an unsigned integer to it.
> > > Therefore to make it obviously safe, let's just make this an unsgined
> > > integer as this is used in pointer arithmetics.
> > > 
> > > Signed-off-by: Jordy Zomer <jordy@pwning.systems>
> > > ---
> > >  drivers/firewire/ohci.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)  
> > 
> > Same thing should probably also be done in
> > drivers/firewire/init_ohci1394_dma.c for the same inline functions,
> > right?  

Yes, register offsets are always non-negative; the lowest register address
is used as the base address.  All of the offset values are taken from
macros which are define in ohci.h.

> And sound/firewire/isight.c also could use this.  Seems like there was
> some copy/paste in firewire drivers :)

These offsets are non-negative too; they defined as macros at the top of
isight.c.  However, here we aren't in the 32 bit (?) PCI register space but
in the 48 bit FireWire node address space, which is why the functions which
are wrapped up by reg_read/write() --- snd_fw_transaction() and
fw_run_transaction() --- use u64 or unsigned long long for @offset.

Long story short, isight.c::reg_read/write() could use u32 or unsigned int
or u64 or unsigned long long for @offset; it's going to be added to an u64
so maybe that's what we should use right away?
-- 
Stefan Richter
-======--=-= =--- ----=
http://arcgraph.de/sr/
