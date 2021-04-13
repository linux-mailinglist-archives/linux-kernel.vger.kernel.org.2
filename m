Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5856A35E471
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346956AbhDMQ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:57:58 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33503 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1346946AbhDMQ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:57:45 -0400
Received: (qmail 1462034 invoked by uid 1000); 13 Apr 2021 12:57:25 -0400
Date:   Tue, 13 Apr 2021 12:57:24 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] general protection fault in gadget_setup
Message-ID: <20210413165724.GD1454681@rowland.harvard.edu>
References: <00000000000075c58405bfd6228c@google.com>
 <CACT4Y+bTjQz=RBXVNrVMQ9xPz5CzGNBE854fsb0ukS-2_wdi3Q@mail.gmail.com>
 <20210413161311.GC1454681@rowland.harvard.edu>
 <CACT4Y+YEw4iJPxY4b6LPXrU91TODfu09dG=53exvQkwjPBg23w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YEw4iJPxY4b6LPXrU91TODfu09dG=53exvQkwjPBg23w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 06:47:47PM +0200, Dmitry Vyukov wrote:
> On Tue, Apr 13, 2021 at 6:13 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > Hopefully this patch will make the race a lot more likely to occur.  Is
> > there any way to tell syzkaller to test it, despite the fact that
> > syzkaller doesn't think it has a reproducer for this issue?
> 
> If there is no reproducer the only way syzbot can test it is if it's
> in linux-next under CONFIG_DEBUG_AID_FOR_SYZBOT:
> http://bit.do/syzbot#no-custom-patches

There _is_ a theoretical reproducer: the test that provoked syzkaller's 
original bug report.  But syzkaller doesn't realize that it is (or may 
be) a reproducer.

It ought to be possible to ask syzkaller to run a particular test that 
it has done before, with a patch applied -- and without having to add 
anything to linux-next.

Alan Stern
