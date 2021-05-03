Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9533237205D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhECTZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhECTZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:25:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43D7A6115C;
        Mon,  3 May 2021 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620069869;
        bh=OKudAjjnl8svSwq1luMmalScMJ7m6qMNbFwp6vBMip8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cd81NwdkpRHRTtCT75jMGyMD1Fa74ZxaMVdbcHmBYWmNY3U/LCgxE5B26f2x/rlud
         firEqe/4nvLpncdLC2xkfFkrsjdIp05sL8p+8oXih/N/T57iB6G+aQMC7YYvEmT3hn
         yiiqK1ZTGOgVl+DC4qkHHFejB/UYc/p7NqnUr7I8=
Date:   Mon, 3 May 2021 12:24:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+882a85c0c8ec4a3e2281@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [syzbot] WARNING in do_proc_bulk
Message-Id: <20210503122428.30ebfddbaf8f5184dc73e1a7@linux-foundation.org>
In-Reply-To: <20210503185614.GA628313@rowland.harvard.edu>
References: <000000000000b47bc805c15e4b11@google.com>
        <00000000000000186405c16a6156@google.com>
        <20210503105351.0966275d0d9e001ed794de2c@linux-foundation.org>
        <20210503185614.GA628313@rowland.harvard.edu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2021 14:56:14 -0400 Alan Stern <stern@rowland.harvard.edu> wrote:

> > 
> > do_proc_bulk() is asking kmalloc for more than MAX_ORDER bytes, in
> > 
> > 	tbuf = kmalloc(len1, GFP_KERNEL);
> 
> This doesn't seem to be a bug.  do_proc_bulk is simply trying to 
> allocate a kernel buffer for data passed to/from userspace.  If a user 
> wants too much space all at once, that's their problem.
> 
> As far as I know, the kmalloc API doesn't require the caller to filter 
> out requests for more the MAX_ORDER bytes.  Only to be prepared to 
> handle failures -- which do_proc_bulk is all set for.
> 
> Am I wrong about this?  Should we add __GFP_NOWARN to the gfp flags?

Yes, if the oversized request is a can-happen and the resulting error is handled
appropriately, __GFP_NOWARN is the way to go.
