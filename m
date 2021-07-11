Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33943C3DC3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 17:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhGKP4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 11:56:33 -0400
Received: from netrider.rowland.org ([192.131.102.5]:32861 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236269AbhGKP4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 11:56:33 -0400
Received: (qmail 295134 invoked by uid 1000); 11 Jul 2021 11:53:45 -0400
Date:   Sun, 11 Jul 2021 11:53:45 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_proc_control/usb_submit_urb
Message-ID: <20210711155345.GB293743@rowland.harvard.edu>
References: <0000000000005d93c405c6c2f20d@google.com>
 <20210710145003.GA271154@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710145003.GA271154@rowland.harvard.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 10:50:03AM -0400, Alan Stern wrote:
> On Sat, Jul 10, 2021 at 04:11:15AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    ee268dee Add linux-next specific files for 20210707
> > git tree:       linux-next
> 
> Is this an old version of syzbot?  I thought it had been fixed up to 
> give a real URL (one that "#syz test:" would accept) for the git 
> tree and a 12-digit SHA-1 abbreviation for the HEAD commit.

Actually, on further thought it looks like only a one-line change is 
needed.  Let's make sure it works.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git ee268dee

> Index: usb-devel/drivers/usb/core/devio.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/core/devio.c
> +++ usb-devel/drivers/usb/core/devio.c
> @@ -1133,7 +1133,7 @@ static int do_proc_control(struct usb_de
>  		"wIndex=%04x wLength=%04x\n",
>  		ctrl->bRequestType, ctrl->bRequest, ctrl->wValue,
>  		ctrl->wIndex, ctrl->wLength);
> -	if (ctrl->bRequestType & 0x80) {
> +	if ((ctrl->bRequestType & USB_DIR_IN) && ctrl->wLength) {
>  		pipe = usb_rcvctrlpipe(dev, 0);
>  		snoop_urb(dev, NULL, pipe, ctrl->wLength, tmo, SUBMIT, NULL, 0);
>  
