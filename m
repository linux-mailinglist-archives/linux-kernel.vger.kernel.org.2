Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F8640D0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhIPAVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhIPAVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:21:07 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CBCC061574;
        Wed, 15 Sep 2021 17:19:47 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQf7v-004Y0I-Rg; Thu, 16 Sep 2021 00:19:43 +0000
Date:   Thu, 16 Sep 2021 00:19:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] m68k: leave stack mangling to asm wrapper of
 sigreturn()
Message-ID: <YUKNn3erTbH+ytpM@zeniv-ca.linux.org.uk>
References: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk>
 <YP2dTQPm1wGPWFgD@zeniv-ca.linux.org.uk>
 <08183665-f846-0c5e-a8c7-d0a65e78a3da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08183665-f846-0c5e-a8c7-d0a65e78a3da@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:35:05AM +1200, Michael Schmitz wrote:

> This one's a little harder - you use a 84 byte gap on each sigreturn, no
> matter what the frame size we need to restore. The original
> mangle_kernel_stack() only makes room on the stack when it has no other
> option (using twice as much size - correct me if I'm wrong).
> 
> Ideally, we'd only leave a gap for mangle_kernel_stack() to use if the frame
> size requires us to do so. Working that out in asm glue would be
> sufficiently convoluted as to cancel out the benefits of cleaning up the C
> sigreturn part. Probably not worth it.

You'd need to
	* load the frame type from sigcontext (and deal with EFAULT, etc.)
	* make decision based on that
	* pass the type down into sigreturn(), so we wouldn't run into
mismatches.

And all that just to avoid a single "subtract a constant from stack pointer"
insn.  We are on a very shallow kernel stack here - it's a syscall entry,
after all.  And the stack footprint of do_sigreturn() is fairly small - e.g.
stat(2) eats a lot more.

We are not initializing the gap either - it's just reserved on stack; we only
access it if we need to enlarge the stack frame.

IOW, what would be the benefit of trying to avoid unconditional gap there?
