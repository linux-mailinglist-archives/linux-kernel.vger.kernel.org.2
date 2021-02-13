Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8404C31AA89
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 09:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhBMIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 03:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhBMIj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 03:39:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E49264E00;
        Sat, 13 Feb 2021 08:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613205527;
        bh=30CrHCumhUGMHavhG3IzYfh7g5G9PLDoLDPao3PDxTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yvVcJShU4u6MSogQNXiG1BTN0dbZ5pGX7Q0XQJmYe3wBbPIarQoph59tYyxHEZqIA
         727YANtpda49Lin7dQB7ZqDE6SLvoSoWta2H0Pd9XkM9uerD0seFekIBeAm34UMpRE
         esGOT9eXwRRbTrA3Lkiz7l+14kvmvJ+xHB71hGuI=
Date:   Sat, 13 Feb 2021 09:38:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ken Moffat <zarniwhoop73@googlemail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: objtool segfault in 5.10 kernels with binutils-2.36.1
Message-ID: <YCeQFYFpxBxsUYZK@kroah.com>
References: <CANVEwpb2oyYFbXkCaeuhnr0s1LH8ojf_WDoStcLYoB1eXWhgRw@mail.gmail.com>
 <20210212235145.t4jgnkyiztrbqlnp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212235145.t4jgnkyiztrbqlnp@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 05:51:45PM -0600, Josh Poimboeuf wrote:
> On Thu, Feb 11, 2021 at 05:16:56PM +0000, Ken Moffat wrote:
> > Hi,
> > 
> > in 5.10 kernels up to and including 5.10.15 when trying to build the
> > kernel for an x86_64 skylake using binutils-2.36.1, gcc-10.2 and
> > glibic-2.33 I get a segfault in objtool if the orc unwinder is
> > enabled.
> > 
> > This has already been fixed in 5.11 by ''objtool: Fix seg fault with
> > Clang non-section symbols'
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=44f6a7c0755d8dd453c70557e11687bb080a6f21
> > 
> > So can this be added to 5.10 stable, please ?
> > 
> > Please CC me as I am no-longer subscribed.
> 
> Hi Ken,
> 
> I agree that needs to be backported (and my bad for not marking it as
> stable to begin with).
> 
> Greg, this also came up in another thread, are you pulling that one in,
> or do you want me to send it to stable list?

I will pull it in after the next release happens in a few hours, thanks.

greg k-h
