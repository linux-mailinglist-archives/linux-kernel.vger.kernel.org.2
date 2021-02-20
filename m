Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C963206F3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 20:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBTTlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 14:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhBTTlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:41:35 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF183C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 11:40:54 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDY7V-00GPdn-Ie; Sat, 20 Feb 2021 19:40:49 +0000
Date:   Sat, 20 Feb 2021 19:40:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, snovitoll@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in iov_iter_revert (2)
Message-ID: <YDFlwf3AKbLiZhvh@zeniv-ca.linux.org.uk>
References: <0000000000001fb73f05bb767334@google.com>
 <0000000000000ca18b05bbc556d6@google.com>
 <CAHk-=wiEBTD884i-U9DU7aDdRxXuz66Q1r-rKTiJUzZoYFgp+g@mail.gmail.com>
 <YDFJKR5uG1N+g9TL@zeniv-ca.linux.org.uk>
 <YDFjNRv+DNL/Xh8W@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDFjNRv+DNL/Xh8W@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 07:29:57PM +0000, Al Viro wrote:

> And then you notice that it has reports
> successful write of amount other than what you'd passed and tries
> to pull back.

Sorry, half-edited sentence has escaped ;-/  Should be

"And there the caller notices that callback has reported a successful
write, but the amount apparently written is not the same as the
amount it had asked to write.  It interprets that as a short write
and tries to pull back.  Only it's actually _forward_, since we'd
asked to write 0 bytes and got a small positive number from the
callback."
