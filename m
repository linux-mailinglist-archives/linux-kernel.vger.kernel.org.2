Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DD73DCA58
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 08:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhHAGbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 02:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHAGb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 02:31:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E32AF60F46;
        Sun,  1 Aug 2021 06:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627799479;
        bh=Hjk4mRvv4tZfmzufHhgGp+Gs+CqEJwXIrTWoRuq3fAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/zttzu26H9ajVZnIPfx40VcPQwq8gVE0MEMBYMhhDqyKQmSwj5qeJgdj5oP/vIsi
         agImCk1DOwgtV50eWbICFz1gtlcfehbDjrVpjvR1qTEmeK7/mzUTi2bVS+LA4a//NT
         OSzZiA1HN8XgYNWT24ZutqnsZRU5opPvxvr/TwOY=
Date:   Sun, 1 Aug 2021 08:31:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-staging@lists.linux.dev
Subject: Re: kernel BUG in new r8188eu
Message-ID: <YQY/tfJJdBVg/mwf@kroah.com>
References: <80042e9f-6811-38f3-010b-1c0951ba88db@lwfinger.net>
 <YQThm1A0Up1m4l1S@kroah.com>
 <c2a6746a-24e6-6888-9208-32fccebb3fec@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2a6746a-24e6-6888-9208-32fccebb3fec@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 11:18:10AM -0500, Larry Finger wrote:
> On 7/31/21 12:37 AM, Greg Kroah-Hartman wrote:
> > Is this a new regression due to the recent cleanups, or something that
> > has always been here?
> 
> I suspect that it has been there forever. I was just doing the kinds of
> things a user might do, and locked up my box.
> 
> > As for the error, looks like someone is reading to an address that is
> > in userspace without doing the proper copy_from_user() thing.  Do you
> > have a full traceback?
> 
>  BUG: unable to handle page fault for address: ffffeb020003b848
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP PTI
>  CPU: 2 PID: 45 Comm: kworker/2:1 Tainted: G         C O
> 5.14.0-rc2-00157-g390c661543a8 #8
>  Hardware name: TOSHIBA TECRA A50-A/TECRA A50-A, BIOS Version 4.50   09/29/2014
>  Workqueue: usb_hub_wq hub_event [usbcore]
>  RIP: 0010:kfree+0x68/0x2c0
>  Code: 01 e5 0f 82 5f 02 00 00 48 b8 00 00 00 80 7f 77 00 00 48 01 c5 48 b8
> 00 00 00 00 00 ea ff ff 48 c1 ed 0c 48 c1 e5 06 48 01 c5 <48> 8b 45 0>
>  RSP: 0018:ffffc900001efa78 EFLAGS: 00010282
>  RAX: ffffea0000000000 RBX: ffffc90000ee1028 RCX: 000000008010000d
>  RDX: 0000000000000000 RSI: ffffffffa149eddf RDI: ffffc90000ee1578
>  RBP: ffffeb020003b840 R08: 0000000000000001 R09: 0000000000000001
>  R10: 0000000000000000 R11: ffff888121c0e400 R12: ffffc90000ee1578
>  R13: ffff888101fd0000 R14: ffff888101fd0030 R15: 0000000000000003
>  FS:  0000000000000000(0000) GS:ffff888323280000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ffffeb020003b848 CR3: 000000000220a002 CR4: 00000000001706e0
>  Call Trace:
>   ? kfree+0x25a/0x2c0
>   rtw_free_mlme_priv_ie_data+0x15/0xf8 [r8188eu]
>   _rtw_free_mlme_priv+0xe/0x30 [r8188eu]
>   rtw_free_mlme_priv+0x1a/0x47 [r8188eu]
>   rtw_free_drv_sw+0x5c/0x1ae [r8188eu]
>   rtw_usb_if1_deinit+0x67/0xcd [r8188eu]
>   rtw_dev_remove+0x5a/0xf4 [r8188eu]
>   usb_unbind_interface+0x8a/0x270 [usbcore]
>   ? kernfs_find_ns+0x35/0xd0
>   __device_release_driver+0x1a0/0x260
>   device_release_driver+0x24/0x30
>   bus_remove_device+0xd8/0x140
>   device_del+0x18b/0x3e0
>   ? kobject_cleanup+0x49/0x130
>   usb_disable_device+0xd9/0x260 [usbcore]
>   usb_disconnect.cold+0x7b/0x201 [usbcore]
>   hub_port_connect+0x88/0x8d0 [usbcore]
>   ? kfree+0xe6/0x2c0
>   hub_port_connect_change+0xb1/0x3a0 [usbcore]
>   port_event+0x5d4/0x720 [usbcore]
>   hub_event+0x1db/0x430 [usbcore]
>   process_one_work+0x1dd/0x3a0
>   worker_thread+0x50/0x3f0
>   ? rescuer_thread+0x390/0x390
>   kthread+0x128/0x140
>   ? set_kthread_struct+0x40/0x40
>   ret_from_fork+0x22/0x30
>  Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device ctr ccm
> r8188eu(C) rfcomm rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs>
>   crypto_simd cryptd i915 i2c_algo_bit serio_raw ttm drm_kms_helper
> syscopyarea sysfillrect sysimgblt fb_sys_fops drm xhci_pci ehci_pci xhci_hcd
> >
>  CR2: ffffeb020003b848
>  ---[ end trace f5f4e2b2680b5fd7 ]---

Hm, if you revert c7e88ecbe328 ("staging: r8188eu: remove rtw_buf_free()
function"), does the crash go away?

> The driver is allocating some buffers using kmalloc variants, and others
> using vmalloc. I checked to see if there was confusion on which form of free
> should be used, but this one is allocated with kmalloc and freed with kfree,
> which should be OK.

I am worried that my "remove the wrapper" logic got something wrong
here, so if you could test the revert of that, I would appreciate it.

I think I need to go buy one of these devices so I can test cleanups
locally...

thanks,

greg k-h
