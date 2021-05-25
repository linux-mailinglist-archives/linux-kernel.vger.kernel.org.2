Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C480538FD61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhEYJG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhEYJGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:06:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED22C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:04:55 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i67so29679951qkc.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLBrpSUVYe3BchjjtmRCD7XsQQbPVjOXKsyKgeg5wIM=;
        b=NR8CU1IogJOPlaB5t+/vO4wcz/A9zBQnoQxAe57WCseGCXlhGRcs8CSTuRiobNTRaq
         s5NvI2K0MI9N7bwYPy3vDBRuvDeIjrHj/9/trkenwoywnf2CNah9nJ/ZiSZCOoVJSlbD
         3fd5CAzpoMO7IAjE/9Nn3kvC33l2KipwM6vtKes51/8Xiv6ei6quS0gRocUrfa3Vx7PP
         eKNFDX+IM7t5Ds30Jck7YcqZ+7uwsULpUlEsdstOIFR0fMIgJl4W4xvC8pmmobrJJS//
         Dla+JAwjpvJuiq2Nzk40cEu/gxuh9BR6muImAI4LbIXQ9Nt4y8lt6YQkHu3GydTjckbl
         WDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLBrpSUVYe3BchjjtmRCD7XsQQbPVjOXKsyKgeg5wIM=;
        b=nwtbJBlECv8T9XEf2DXIJr9rHKMh9i2vqEnZHsku8bJFSIPl5qEI3cO7z19rOREflM
         RmjgmririivpVydZLYACmf/JaDzSYq+8PEHaUWXBsOh4Cgv+uA5o/TT8YXiB6B3/wCtG
         WaEdL4lDHmJMNJQuKkLAvbSvRxUXN+XGAhi4R8Xa+nFvp1g6gHl3QTgb5KPiDlixRDEx
         EllXHnZhytdJWDzOamUCNjeR2a+9FHlEmlSH0XNwHmjzXnjKMbxfqZj+Z1GMk2bmJdOC
         8d2myoyWbqq0tEJuA88C0IZETl9TWkHms8OggYi2yvTH3U6Y7/TSRbZ4+YPfjlge0MFd
         hrvA==
X-Gm-Message-State: AOAM531kndoj7JRO0iOVSQqkvzLtTydmagIqBzalVjFzwwx6BnnatpZm
        fao2UrwmPs1CpvxaLfxrmVeY0h91FvL1zWL2y3PnuA==
X-Google-Smtp-Source: ABdhPJw7raiLrKpOT5YEdk7s0JPohuHM9wM1NmOtm5pAl7LljqrPNdjOPiEdqRkKaRuAwGAR2A0iiOCtg9rGF7OSMWQ=
X-Received: by 2002:ae9:e014:: with SMTP id m20mr32651517qkk.424.1621933494463;
 Tue, 25 May 2021 02:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f61b1905c30fd185@google.com> <YKtwMB0bXhayVwt4@hovoldconsulting.com>
In-Reply-To: <YKtwMB0bXhayVwt4@hovoldconsulting.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 25 May 2021 11:04:43 +0200
Message-ID: <CACT4Y+YEi2zh0bxLcP7CaRrkKEg+9R3L3jQCS6WNVRZZGTFnPQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in e2i_init/usb_submit_urb
To:     Johan Hovold <johan@kernel.org>
Cc:     syzbot <syzbot+5d0b6bcdaaa6d1cb6ef3@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        mathias.nyman@linux.intel.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 11:21 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, May 24, 2021 at 02:13:18AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    5cc59c41 USB: core: WARN if pipe direction != setup packet..
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17a30553d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1206ee92dd3d988d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5d0b6bcdaaa6d1cb6ef3
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5d0b6bcdaaa6d1cb6ef3@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > usb 6-1: BOGUS control dir, pipe 80001d80 doesn't match bRequestType 2
> > WARNING: CPU: 0 PID: 7 at drivers/usb/core/urb.c:410 usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
> > Modules linked in:
> > CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.13.0-rc2-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > RIP: 0010:usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
> > Code: 84 4c 01 00 00 e8 a6 14 b3 fd 4c 89 f7 e8 4e a7 1b ff 45 89 e8 44 89 e1 48 89 ea 48 89 c6 48 c7 c7 c0 09 63 86 e8 18 f1 fb 01 <0f> 0b 49 8d 4f 5c 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 89 4c
> > RSP: 0018:ffffc9000007eee0 EFLAGS: 00010286
> > RAX: 0000000000000000 RBX: ffff88811f21b058 RCX: 0000000000000000
> > RDX: 0000000000040000 RSI: ffffffff812a6013 RDI: fffff5200000fdce
> > RBP: ffff888100bf5e60 R08: 0000000000000001 R09: 0000000000000000
> > R10: ffffffff814b996b R11: 0000000000000000 R12: 0000000080001d80
> > R13: 0000000000000002 R14: ffff88811f21b0a8 R15: ffff88813b0c7800
> > FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000014a53ad CR3: 0000000007825000 CR4: 00000000001506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
> >  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
> >  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
> >  e2i_init+0xb3/0x150 drivers/input/touchscreen/usbtouchscreen.c:254
> >  usbtouch_probe+0xfc9/0x1c40 drivers/input/touchscreen/usbtouchscreen.c:1771
>
> Had already found but not yet posted the fix for this one too:
>
>         https://lore.kernel.org/r/20210524092048.4443-1-johan@kernel.org

Hi Johan,
Thanks for double checking.Let's tell syzbot about the fix:

#syz fix: Input: usbtouchscreen - fix control-request directions
