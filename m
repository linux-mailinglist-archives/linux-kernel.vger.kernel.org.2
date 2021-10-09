Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E41427967
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 13:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbhJILUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 07:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232413AbhJILUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 07:20:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB40060F6E;
        Sat,  9 Oct 2021 11:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633778290;
        bh=u+T2URSeKvvUkGwYGntQux2WgX9PNNIpVRX7fSEdBBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNVfs00KSx/2yFKvN1uwob61/nOAuteTeWJNG7icV+/tMuerFmn7z7BWr+s++HpLd
         gx1WbqAGKBc7FI0zS1RrR2MXFtFU077HKxK0DxGuQDIHQWrE8EUe+QZEfqMnHq8GK8
         yGCwN/DPmEmbr/KE2wrHyqllp2VnEnv1vepV/Zik=
Date:   Sat, 9 Oct 2021 13:18:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+cf1553a86d1962a0c79f@syzkaller.appspotmail.com>
Cc:     hadess@hadess.net, johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.v.b@runbox.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: global-out-of-bounds Read in usb_match_device
Message-ID: <YWF6b/evdTe9Q3z9@kroah.com>
References: <00000000000046faa305cde9998e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000046faa305cde9998e@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 04:14:26AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    89e84f946479 usb: typec: tipd: Remove FIXME about testing ..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=1638063f300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cd8a1eadba1e4ce4
> dashboard link: https://syzkaller.appspot.com/bug?extid=cf1553a86d1962a0c79f
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158c3deb300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1190df03300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cf1553a86d1962a0c79f@syzkaller.appspotmail.com

Should already be fixed in my latest tree.

thanks,

greg k-h
