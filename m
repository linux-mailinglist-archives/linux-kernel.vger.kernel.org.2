Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CA5362717
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243525AbhDPRqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:46:31 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36825 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235877AbhDPRqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:46:30 -0400
Received: (qmail 48215 invoked by uid 1000); 16 Apr 2021 13:46:04 -0400
Date:   Fri, 16 Apr 2021 13:46:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] general protection fault in gadget_setup
Message-ID: <20210416174604.GA47856@rowland.harvard.edu>
References: <00000000000075c58405bfd6228c@google.com>
 <CACT4Y+bTjQz=RBXVNrVMQ9xPz5CzGNBE854fsb0ukS-2_wdi3Q@mail.gmail.com>
 <20210413161311.GC1454681@rowland.harvard.edu>
 <YHkjUwhlCYIxCUYt@anirudhrb.com>
 <20210416152734.GB42403@rowland.harvard.edu>
 <YHnD0AVXiwdsw46L@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHnD0AVXiwdsw46L@anirudhrb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:35:20PM +0530, Anirudh Rayabharam wrote:
> On Fri, Apr 16, 2021 at 11:27:34AM -0400, Alan Stern wrote:
> > Actually, I wanted to move this emulation code into a new subroutine and 
> > then call that subroutine from _both_ places.  Would you like to write 
> 
> Does it really need to be called from both places?

You know, I was going to say Yes, but now I think you're right; it's not 
needed in dummy_udc_stop.  This is because core.c always calls 
usb_gadget_disconnect before usb_gadget_udc_stop.  And we can rely on 
this behavior; it's obviously necessary to disconnect from the host 
before stopping the UDC driver.

On the other hand, while checking that fact I noticed that 
soft_connect_store in core.c doesn't call synchronize_irq in between the 
other two, the way usb_gadget_remove_driver does.  That seems like a bug 
-- if it's necessary to synchronize with the IRQ handler on one path, it 
should be necessary on the other path as well.  But that's a matter for 
a separate patch.

Alan Stern

> > and submit a patch that does this?
> 
> Sure! I will do that.
> 
> Thanks!
> 
> 	- Anirudh.
