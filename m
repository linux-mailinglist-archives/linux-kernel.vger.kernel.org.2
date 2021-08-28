Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15663FA71A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 20:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhH1SEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 14:04:53 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40695 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229912AbhH1SEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 14:04:51 -0400
Received: (qmail 291460 invoked by uid 1000); 28 Aug 2021 14:03:58 -0400
Date:   Sat, 28 Aug 2021 14:03:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+ada0f7d3d9fd2016d927@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: task hung in do_proc_bulk
Message-ID: <20210828180358.GA291431@rowland.harvard.edu>
References: <000000000000a83c6a05caa09572@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a83c6a05caa09572@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 08:52:17AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d5ae8d7f85b7 Revert "media: dvb header files: move some he..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=155fa21e300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2fd902af77ff1e56
> dashboard link: https://syzkaller.appspot.com/bug?extid=ada0f7d3d9fd2016d927
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a1ab0e300000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15662ee1300000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17662ee1300000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13662ee1300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ada0f7d3d9fd2016d927@syzkaller.appspotmail.com
> 
> INFO: task syz-executor.0:8700 blocked for more than 143 seconds.
>       Not tainted 5.14.0-rc7-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.0  state:D stack:23192 pid: 8700 ppid:  8455 flags:0x00004004
> Call Trace:
>  context_switch kernel/sched/core.c:4681 [inline]
>  __schedule+0xc07/0x11f0 kernel/sched/core.c:5938
>  schedule+0x14b/0x210 kernel/sched/core.c:6017
>  schedule_timeout+0x98/0x2f0 kernel/time/timer.c:1857
>  do_wait_for_common+0x2da/0x480 kernel/sched/completion.c:85
>  __wait_for_common kernel/sched/completion.c:106 [inline]
>  wait_for_common kernel/sched/completion.c:117 [inline]
>  wait_for_completion_timeout+0x46/0x60 kernel/sched/completion.c:157
>  usb_start_wait_urb+0x167/0x550 drivers/usb/core/message.c:63
>  do_proc_bulk+0x978/0x1080 drivers/usb/core/devio.c:1236

Looks like the wait needs to be interruptible.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d5ae8d7f85b7

Index: usb-devel/drivers/usb/core/message.c
===================================================================
--- usb-devel.orig/drivers/usb/core/message.c
+++ usb-devel/drivers/usb/core/message.c
@@ -60,12 +60,18 @@ static int usb_start_wait_urb(struct urb
 		goto out;
 
 	expire = timeout ? msecs_to_jiffies(timeout) : MAX_SCHEDULE_TIMEOUT;
-	if (!wait_for_completion_timeout(&ctx.done, expire)) {
+	retval = wait_for_completion_interruptible_timeout(&ctx.done, expire);
+	if (retval <= 0) {
 		usb_kill_urb(urb);
-		retval = (ctx.status == -ENOENT ? -ETIMEDOUT : ctx.status);
+		if (retval < 0)
+			retval = -EINTR;
+		else if (ctx.status == -ENOENT)
+			retval = -ETIMEDOUT;
+		else
+			retval = ctx.status;
 
 		dev_dbg(&urb->dev->dev,
-			"%s timed out on ep%d%s len=%u/%u\n",
+			"%s timed out or interrupted on ep%d%s len=%u/%u\n",
 			current->comm,
 			usb_endpoint_num(&urb->ep->desc),
 			usb_urb_dir_in(urb) ? "in" : "out",
