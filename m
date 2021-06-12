Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B633A4D32
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 08:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFLHBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 03:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLHB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 03:01:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E543E61009;
        Sat, 12 Jun 2021 06:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623481170;
        bh=K4jM6AUqyTLpmK+CZISvtI1+6QvgFWFIceLUxFTnUuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nH2cG9VdBAWwISy2gKPXunRORyLet3xJcWUC5gf3am+6JcBR9WY24Kx5UgyzWkzU6
         ZyxXSt0SEFATJ1lzxbOSECEbJr2/Adjwcci96biU0JQ9qxUk5RVSX+WkE08LvpbpYx
         zFbv8voLI8GLKaomkR14Ouu4JDtCiCP7yZPAjIbM=
Date:   Sat, 12 Jun 2021 08:59:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com>
Cc:     johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in vmk80xx_auto_attach/usb_submit_urb
Message-ID: <YMRbTj2RAbIFZKw6@kroah.com>
References: <00000000000074a21005c482fce2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000074a21005c482fce2@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 01:02:23PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    614124be Linux 5.13-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12188667d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=547a5e42ca601229
> dashboard link: https://syzkaller.appspot.com/bug?extid=5f29dc6a889fc42bd896
> compiler:       Debian clang version 11.0.1-2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1687ec3fd00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172f44ffd00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com
> 
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> WARNING: CPU: 1 PID: 20 at drivers/usb/core/urb.c:494 usb_submit_urb+0xacd/0x1550 drivers/usb/core/urb.c:493

Looks correct to me, you did not create a valid USB device for the
system to use :)

