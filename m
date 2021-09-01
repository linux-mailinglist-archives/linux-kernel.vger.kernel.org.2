Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1BB3FE36A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbhIATx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhIATxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:53:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C59C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 12:52:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630525945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GSRhAxPtx88bURKwE5S92sADqnou/RaVw+AB4weTUvI=;
        b=yBVdRuRGHTZZrEtmXU04MKNvPilbczcQucHvriaSOFS7PCkI83Ep7OD4HtvZ5UNcB3qf56
        qmXlO+qwDfYY3+hgBKJcCgF37OPNAzV16XjEg8UszA4MIvsJ7oliw+F54+sUjJQhBC+m9v
        BZUXbQKLTJMcvyYehaYkH6d+vyGFFHAD9CFMs9RaAnWswXiK0jqG1Hw6905yX4+1y9X/Xw
        RAQ4HtfsUyMsmJdVWatoDShFAg//B05iD/NAqtlPHW1bNis9HleMsG2b74C2RltiAEQ7lU
        k24LfJmE5LTxI9Ry6CPIY1eQBEBlKvTu/VOjE5Q/3Kr+w+ltSRbRKzSSj3wohQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630525945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GSRhAxPtx88bURKwE5S92sADqnou/RaVw+AB4weTUvI=;
        b=ARO8n8Bllvj+4NwKXtvPoOhGbPYSGg5VyQwPKYcjWGhDbzIrOVFrYutlLEWx96zdgdK5iN
        PnxxYe+6LPRWyNCw==
To:     syzbot <syzbot+4d1bd0725ef09168e1a0@syzkaller.appspotmail.com>,
        dave@stgolabs.net, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in futex_requeue
In-Reply-To: <0000000000002b577805caef03d8@google.com>
References: <0000000000002b577805caef03d8@google.com>
Date:   Wed, 01 Sep 2021 21:52:25 +0200
Message-ID: <87fsuocbuu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01 2021 at 06:26, syzbot wrote:
> syzbot found the following issue on:
>
> HEAD commit:    b91db6a0b52e Merge tag 'for-5.15/io_uring-vfs-2021-08-30' ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17907235300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=961d30359ac81f8c
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d1bd0725ef09168e1a0
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1222185d300000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4d1bd0725ef09168e1a0@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5701 at kernel/futex.c:2259 futex_requeue+0x1467/0x2d50 kernel/futex.c:2259

Doh. That Gleixner dude did not think this through completely. Fix will
follow.

Thanks,

        tglx
