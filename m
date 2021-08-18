Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8123F0B61
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhHRTCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:02:03 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46201 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229965AbhHRTCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:02:01 -0400
Received: (qmail 205175 invoked by uid 1000); 18 Aug 2021 15:01:25 -0400
Date:   Wed, 18 Aug 2021 15:01:25 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+9b57a46bf1801ce2a2ca@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in hid_submit_ctrl/usb_submit_urb
Message-ID: <20210818190125.GE197200@rowland.harvard.edu>
References: <000000000000d77b6505c767b8f8@google.com>
 <00000000000038c55d05c9d1dc3b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000038c55d05c9d1dc3b@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 02:14:23AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    794c7931a242 Merge branch 'linus' of git://git.kernel.org/..
> git tree:       upstream

Dmitry:

Why does syzbot persist in reporting useless names like "upstream" for 
the git tree being tested?  How is anyone supposed to know what that 
actually refers to?  Why doesn't it put the real name (maybe with 
"upstream" in parentheses as an additional comment)?

Furthermore, the last time I tried to submit a test patch with something 
like "#syz test: upstream 794c7931a242", it didn't work because syzbot 
itself didn't recognize the repository name!

This should already be fixed -- I can't remember when I first reported 
the problem but it must have been at least two years ago.  

If there isn't already a change request pending for this issue, can you 
add one?

Thanks,

Alan Stern
