Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856ED358BDC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhDHSB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232771AbhDHSBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:01:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDDF3610C8;
        Thu,  8 Apr 2021 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617904871;
        bh=+eaGpVC7iGbDCkxhs5YszeBxO/5SQpqKc8nZVWHLW+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NS+ORlc71xvRJWrdZgr5W+1yFBVz0qppZNJgZa13261WJmnGl1YZNlmORPH1H7zPC
         EgHgK39G02ztwrZFcrKu1+z5R8/7TrpPpOiyhVfu+bf4+3G5wnDQB6/ajUzBCMZuUf
         SexeZbhm2W+RopYxcORoPUOS1ImPDv8xBgkLOFPY=
Date:   Thu, 8 Apr 2021 20:01:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 00/13] tty.h cleanups
Message-ID: <YG9E5GpLljkXARDj@kroah.com>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
 <YG8SUl+B8+76JZwV@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG8SUl+B8+76JZwV@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 04:25:22PM +0200, Johan Hovold wrote:
> On Thu, Apr 08, 2021 at 02:51:21PM +0200, Greg Kroah-Hartman wrote:
> > Turns out there is a lot of tty-internal stuff in include/linux/tty.h
> > that do not belong there.  Create a internal-to-the-tty-layer .h file
> > for these types of things and move function prototypes to it instead of
> > being in the system-wide header file.
> > 
> > Along the way clean up the use of some old tty-only debugging macros and
> > use the in-kernel dev_*() calls instead.
> 
> I'm afraid that's not a good idea since not all ttys have a
> corresponding class device. Notable exception include pseudo terminals
> and serdev.
> 
> While dev_printk() can handle a NULL device argument without crashing,
> we'll actually lose log information by removing the tty printk helpers.

I think the same info will be printed here as before, just some NULL
information at the beginning, right?  And the benifits overall (for real
tty devices), should outweigh the few devices that do not have this
information.

But let me run some tests, on those devices to see just how this
looks...

thanks,

greg k-h
