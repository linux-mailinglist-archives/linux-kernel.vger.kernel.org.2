Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4D354125
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbhDEKTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241151AbhDEKTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:19:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E83E361399;
        Mon,  5 Apr 2021 10:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617617952;
        bh=rd8LEjO/uhcqPSOwrQIOXBSJlpMdwgd0/QOwQoJAV/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0AjI0xm1lli8E5jQojcxugwJgxGnNekw7zKxW/Kep1yJ4NBQ7HFjcIZgpEWUzS8Ej
         QaZgyMxrLor6zLv0bqCrW0FJVFNfmNZsCzLNmX6ub3yEFRM1pc6E1NVlTFPXGit/It
         PzO/EVUMyk8HFrcHzw0bE/ac7SEWmSNRJwzCeTXI=
Date:   Mon, 5 Apr 2021 12:19:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Hao Sun <sunhao.th@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in cdev_del
Message-ID: <YGrkHoYjTmR7HQeM@kroah.com>
References: <CACkBjsYEhOuQUd2qjobumByFtAXyyoGqXgM8gXYZHqsnV8dgUg@mail.gmail.com>
 <20210404123934.2620-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210404123934.2620-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 08:39:34PM +0800, Hillf Danton wrote:
> On Sun, 4 Apr 2021 17:05:17 Hao Sun wrote:
> > Besides, the 'refcount bug in cdev_del' bug still exists too.
> 
> Thanks for your report, Hao.
> > 
> > Here is the detailed information:
> > commit:   5e46d1b78a03d52306f21f77a4e4a144b6d31486
> > version:   Linux 5.12-rc5
> > git tree:    upstream
> > kernel config (KASAN not enabled) and reproducing program can be found
> > in the attachment.
> > Report:
> > ------------[ cut here ]------------
> > refcount_t: underflow; use-after-free.
> > WARNING: CPU: 1 PID: 8923 at lib/refcount.c:28
> > refcount_warn_saturate+0x1cf/0x210 -origin/lib/refcount.c:28
> > Modules linked in:
> > CPU: 1 PID: 8923 Comm: executor Not tainted 5.12.0-rc5+ #8
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.13.0-1ubuntu1.1 04/01/2014
> > RIP: 0010:refcount_warn_saturate+0x1cf/0x210 -origin/lib/refcount.c:28
> > Code: 4f ff ff ff e8 32 fa b5 fe 48 c7 c7 3d f8 f6 86 e8 d6 ab c6 fe
> > c6 05 7c 34 67 04 01 48 c7 c7 68 f8 6d 86 31 c0 e8 81 2e 9d fe <0f> 0b
> > e9 22 ff ff ff e8 05 fa b5 fe 48 c7 c7 3e f8 f6 86 e8 a9 ab
> > RSP: 0018:ffffc90001633c60 EFLAGS: 00010246
> > RAX: 15d08b2e34b77800 RBX: 0000000000000003 RCX: ffff88804c056c80
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000000003 R08: ffffffff813767aa R09: 0001ffffffffffff
> > R10: 0001ffffffffffff R11: ffff88804c056c80 R12: ffff888040b7d000
> > R13: ffff88804c206938 R14: ffff88804c206900 R15: ffff888041b18488
> > FS:  00000000022c9940(0000) GS:ffff88807ec00000(0000) knlGS:000000000000000=
> > 0
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f9f9b122008 CR3: 0000000044b4b000 CR4: 0000000000750ee0
> > PKRU: 55555554
> > Call Trace:
> >  __refcount_sub_and_test -origin/./include/linux/refcount.h:283 [inline]
> >  __refcount_dec_and_test -origin/./include/linux/refcount.h:315 [inline]
> >  refcount_dec_and_test -origin/./include/linux/refcount.h:333 [inline]
> >  kref_put -origin/./include/linux/kref.h:64 [inline]
> >  kobject_put+0x17b/0x180 -origin/lib/kobject.c:753
> >  cdev_del+0x4b/0x50 -origin/fs/char_dev.c:597
> >  tty_unregister_device+0x99/0xd0 -origin/drivers/tty/tty_io.c:3343
> >  gsmld_detach_gsm -origin/drivers/tty/n_gsm.c:2409 [inline]
> >  gsmld_close+0x6c/0x140 -origin/drivers/tty/n_gsm.c:2478
> >  tty_ldisc_close -origin/drivers/tty/tty_ldisc.c:488 [inline]
> >  tty_ldisc_kill -origin/drivers/tty/tty_ldisc.c:636 [inline]
> >  tty_ldisc_release+0x1b6/0x400 -origin/drivers/tty/tty_ldisc.c:809
> >  tty_release_struct+0x19/0xb0 -origin/drivers/tty/tty_io.c:1714
> >  tty_release+0x9ad/0xa00 -origin/drivers/tty/tty_io.c:1885
> >  __fput+0x260/0x4e0 -origin/fs/file_table.c:280
> >  ____fput+0x11/0x20 -origin/fs/file_table.c:313
> >  task_work_run+0x8e/0x110 -origin/kernel/task_work.c:140
> >  tracehook_notify_resume -origin/./include/linux/tracehook.h:189 [inline]
> >  exit_to_user_mode_loop -origin/kernel/entry/common.c:174 [inline]
> >  exit_to_user_mode_prepare+0x16b/0x1a0 -origin/kernel/entry/common.c:208
> >  __syscall_exit_to_user_mode_work -origin/kernel/entry/common.c:290 [inline]
> >  syscall_exit_to_user_mode+0x20/0x40 -origin/kernel/entry/common.c:301
> >  do_syscall_64+0x45/0x80 -origin/arch/x86/entry/common.c:56
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> No error check on registering tty device - add it.
> And roll back in case of error.
> 
> --- x/drivers/tty/n_gsm.c
> +++ y/drivers/tty/n_gsm.c
> @@ -2384,8 +2384,19 @@ static int gsmld_attach_gsm(struct tty_s
>  		/* Don't register device 0 - this is the control channel and not
>  		   a usable tty interface */
>  		base = mux_num_to_base(gsm); /* Base for this MUX */
> -		for (i = 1; i < NUM_DLCI; i++)
> -			tty_register_device(gsm_tty_driver, base + i, NULL);
> +		for (i = 1; i < NUM_DLCI; i++) {
> +			struct device *dev;
> +
> +			dev = tty_register_device(gsm_tty_driver,
> +							base + i, NULL);
> +			if (IS_ERR(dev)) {
> +				for (i--; i >= 1; i--)
> +					tty_unregister_device(gsm_tty_driver,
> +								base + i);
> +				ret = PTR_ERR(dev);
> +				return ret;
> +			}
> +		}
>  	}
>  	return ret;
>  }

Are you testing these patches somehow?  Can you do that and then submit
them correctly?

thanks,

greg k-h
