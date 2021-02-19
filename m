Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF84331F5CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBSIX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhBSIXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:23:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4179464EB8;
        Fri, 19 Feb 2021 08:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613722939;
        bh=YcfM6Nd6zgmghDPB1XXn5JJry5eIgHdHD9ec4/vuPwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=krnU5a09BP8y4DKtPeof+p1H+UMbuCwjswokyJf96obEIff/MC9I5J4xCWttOBthX
         bUT4GMUDaolg/nWmybNAyNLhW6B/rp57aet7urN7ytPyy+PkdSfn0V1xcKx2AOBmCw
         JnEFt/AeuMum/JOncetSBk/8B/fUvNY6w+bCH7fg=
Date:   Fri, 19 Feb 2021 09:22:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jari Ruusu <jariruusu@protonmail.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC91OWVGAfyorRbc@kroah.com>
References: <YA/E1bHRmZb50MlS@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <YC4atKmK7ZqlOGER@kroah.com>
 <20210218113107.GA12547@1wt.eu>
 <602E766F.758C74D8@users.sourceforge.net>
 <20210218143341.GB13671@1wt.eu>
 <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com>
 <YC6nZH/4CkLLsxxB@kroah.com>
 <sjYC-8XCIa2KTTlzjXs95LPnYQJvJe3Lrz4tR9NZTLLIfQpWLquW6W2siZAP7wtgHXOsK5bSxo8JqJp7iPLQ_NtDhh8GbES8J3dUlB5sqYs=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sjYC-8XCIa2KTTlzjXs95LPnYQJvJe3Lrz4tR9NZTLLIfQpWLquW6W2siZAP7wtgHXOsK5bSxo8JqJp7iPLQ_NtDhh8GbES8J3dUlB5sqYs=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 07:10:35AM +0000, Jari Ruusu wrote:
> On Thursday, February 18, 2021 7:44 PM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > It was the other way around. Fine working in-tree driver got
> > > broken by backported "fixes". I did mention bit-rot.
> >
> > It did? Please let us stable maintainers know about, we will always
> > gladly revert problems patches. What commits caused the problem?
> 
> I don't have a list of commits for you. It took me long time to
> figure out that it was iwlwifi that was causing those problems.
> 
> In-tree iwlwifi on 4.19.y kernels needs professional quality
> locking audit and backporting of necessary fixes from upstream
> Intel out-of-tree version.

That's not the goal of stable kernel releases/trees.  If the driver
version that is in 4.19.y does not work for you on release 4.19.0, odds
of that "changing" in later stable releases is slim to none.

Especially without any specific bug reports or emails to the developers
to tell them what is broken and not working for you.

If however, you wish to stick with an out-of-tree driver, wonderful,
that's your choice.  But don't claim that somehow the stable kernel
process is broken because of that, as it has nothing to do with this
type of thing.

Best of luck!

greg k-h
