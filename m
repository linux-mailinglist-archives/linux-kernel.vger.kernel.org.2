Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E7538C5BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhEULcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhEULca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:32:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4DAF613DA;
        Fri, 21 May 2021 11:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621596667;
        bh=XCW+h8GxyRMMPHetbkEqtfnjz33mh3sQXexOSdqhuy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ONWDyYeVs/0J4Vkz+ueCYV0mSFQu9dZ6ray+woDOk8ypSUcoMX6Tw4aQZ3M2eq1da
         wouGyDIgIDRtX3zrdMpVRBUZS2hL6f0PSp9DUlX7FDqpAviYiNx/nER4LuMFzqxqgX
         +wEmCOIz4t+QuO9vJE1Tz0RiQbNwgTCxxyNwgV4A=
Date:   Fri, 21 May 2021 13:31:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     cernekee@gmail.com, jirislaby@kernel.org,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] serial: rp2: use 'request_firmware' instead of
 'request_firmware_nowait'
Message-ID: <YKeZ+JMvlQ8YvDuw@kroah.com>
References: <1621577323-1541-1-git-send-email-zheyuma97@gmail.com>
 <YKdYZF8zDGl0hxeX@kroah.com>
 <CAMhUBjkeXn=Yf+dsdKo5_H1Tko3Qhfr+y=9b47XtHA04k2smXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhUBjkeXn=Yf+dsdKo5_H1Tko3Qhfr+y=9b47XtHA04k2smXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 07:15:21PM +0800, Zheyu Ma wrote:
> On Fri, May 21, 2021 at 2:51 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, May 21, 2021 at 06:08:43AM +0000, Zheyu Ma wrote:
> > > In 'rp2_probe', the driver registers 'rp2_uart_interrupt' then calls
> > > 'rp2_fw_cb' through 'request_firmware_nowait'. In 'rp2_fw_cb', if the
> > > firmware don't exists, function just return without initializing ports
> > > of 'rp2_card'. But now the interrupt handler function has been
> > > registered, and when an interrupt comes, 'rp2_uart_interrupt' may access
> > > those ports then causing NULL pointer dereference or other bugs.
> > >
> > > Because the driver does some initialization work in 'rp2_fw_cb', in
> > > order to make the driver ready to handle interrupts, 'request_firmware'
> > > should be used instead of asynchronous 'request_firmware_nowait'.
> >
> > You just now slowed down the probe function.  Are you _sure_ this is ok?
> 
> Sorry, I'm not an expert in the field, but from my point of view, the
> previous function 'rp2_fw_cb' does some initialization work that is
> not suitable for asynchronous execution. Because after these initial
> work, the driver can work normally (including preparing to handle
> interrupts).
> 
> > Do you have this hardware to test this?  If so, what is the init time
> > before and after this change?
> 
> To be honest, I don't have real hardware, I tested it with QEMU. I
> made a total of 5 attempts. Before this change, the average boot time
> required by kernel is 6.382s, the time required for insmoding this
> module is 0.139s; After this change, the average boot time required by
> kernel is 6.426s, the time required for insmoding this module is
> 0.160s. This change really slowed down the probe function.

Ok, at least you've tested it :)

I'll take a slower init over a broken init any day.  I'll go queue this
up, thanks.

greg k-h
