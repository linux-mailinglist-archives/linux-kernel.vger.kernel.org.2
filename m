Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51398434221
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 01:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJSXhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 19:37:41 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39695 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229668AbhJSXhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 19:37:38 -0400
Received: (qmail 1099285 invoked by uid 1000); 19 Oct 2021 19:35:24 -0400
Date:   Tue, 19 Oct 2021 19:35:24 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+9df2568864dedf79db36@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in ehci_hub_control
Message-ID: <20211019233524.GA1099077@rowland.harvard.edu>
References: <0000000000001611e605cebabab5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001611e605cebabab5@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 01:44:24PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d999ade1cc86 Merge tag 'perf-tools-fixes-for-v5.15-2021-10..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17d85d34b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b5d8cfd89abd92bf
> dashboard link: https://syzkaller.appspot.com/bug?extid=9df2568864dedf79db36
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9df2568864dedf79db36@syzkaller.appspotmail.com
> 
> ================================================================================
> UBSAN: array-index-out-of-bounds in drivers/usb/host/ehci-hub.c:754:39
> index 254 is out of range for type 'u32 [15]'
> CPU: 0 PID: 11514 Comm: syz-executor.1 Not tainted 5.15.0-rc5-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014

This should already be fixed by

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/drivers/usb/host/ehci-hub.c?h=usb-next&id=846cbf98cbef20376b1a95fa3734c435543f3519

(although it can't be tested if there is no reproducer).  That commit is 
scheduled to go into 5.16-rc1.

This isn't really a bug, because the pointer doesn't get used in cases 
where the index is beyond the end of the array.

Alan Stern
