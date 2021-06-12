Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814483A4F3A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 16:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhFLOV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 10:21:28 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36467 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230191AbhFLOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 10:21:27 -0400
Received: (qmail 78830 invoked by uid 1000); 12 Jun 2021 10:19:26 -0400
Date:   Sat, 12 Jun 2021 10:19:26 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com>,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in vmk80xx_auto_attach/usb_submit_urb
Message-ID: <20210612141926.GA78629@rowland.harvard.edu>
References: <00000000000074a21005c482fce2@google.com>
 <YMRbTj2RAbIFZKw6@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMRbTj2RAbIFZKw6@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 08:59:26AM +0200, Greg KH wrote:
> On Fri, Jun 11, 2021 at 01:02:23PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    614124be Linux 5.13-rc5
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12188667d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=547a5e42ca601229
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5f29dc6a889fc42bd896
> > compiler:       Debian clang version 11.0.1-2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1687ec3fd00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172f44ffd00000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com
> > 
> > usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > usb 1-1: config 0 descriptor??
> > ------------[ cut here ]------------
> > usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> > WARNING: CPU: 1 PID: 20 at drivers/usb/core/urb.c:494 usb_submit_urb+0xacd/0x1550 drivers/usb/core/urb.c:493
> 
> Looks correct to me, you did not create a valid USB device for the
> system to use :)

The problem is that vmk80xx_write_packet submits an interrupt URB to 
the ep_tx endpoint, but vmk80xx_find_usb_endpoints will set ep_tx to the 
first OUT endpoint it finds that is either interrupt or bulk.  In this 
case it was bulk, so the driver submitted an interrupt URB to a bulk 
endpoint.

Alan Stern
