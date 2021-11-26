Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F9445EC0B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhKZLD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232674AbhKZLBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:01:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7836361052;
        Fri, 26 Nov 2021 10:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637924277;
        bh=FvYjzNyFFthyl2bbFp9amlnJBEJoTIzu3YJPp5b+YiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtFWdOOQhdXokkFhvltrDPGUNRKQKy4DZp7848BNrjyG6IX3oa3h+NpWAoMLvVAa8
         sLeSLsnMUJd9R41557dgoxXqDf/91d9XrEPoX61HBm25MkNnVBaUos5CqskfgPfW0b
         Jjk2QbuP3X+JO8fd4kIDVZdC00NZMi3sxnSm1Uy8=
Date:   Fri, 26 Nov 2021 11:57:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com
Subject: Re: [PATCH v16] tty: Fix the keyboard led light display problem
Message-ID: <YaC9so4FippjDCKK@kroah.com>
References: <20211126104832.11371-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126104832.11371-1-changlianzhi@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 06:48:32PM +0800, lianzhi chang wrote:
> When the desktop and tty switch mutually, the led state of the
> keyboard may be inconsistent with the state of the keyboard lock.
> This is because the desktop environment (Xorg, etc.) is bound to
> a tty, and the kb->kbdmode attribute of this tty is set to VC_OFF.
> This leads to the fact that in the desktop environment, the bound
> tty will not set the keyboard light state, so in the current tty
> scene, the values of ledstate and kb->ledflagstate are always 0.
> This leads to two situations: (1) When switching from the desktop
> to another tty, the code inside VT still compares ledstate with
> the kb->ledflagstate of the next tty. If they are equal, then
> after the switch is completed, The keyboard light will maintain
> the state of the previous desktop settings, and the state of the
> keyboard lock may be inconsistent; (2) When switching from another
> tty to the desktop, according to the code logic, it may still
> trigger the desktop bound tty to set the keyboard light state.
> After the switch is completed, the keyboard light is forcibly
> turned off. I think in this case, the tty should not set the
> keyboard light, and give control to Xorg etc. to handle it.
> The current modification judges the value of kb->kbdmode.
> In some modes, when switching VT, the current tty keyboard
> light status is forcibly issued. And when switching to the
> desktop, the tty no longer sets the keyboard light.

That is a "wall of text" that is impossible to read.

Please consider formatting it so that it is understandable.  Would you
want to read that and attempt to understand what is going on?

thanks,

greg k-h
