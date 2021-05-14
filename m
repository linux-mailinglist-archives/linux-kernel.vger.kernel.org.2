Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3473804E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhENIMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhENIMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:12:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B596D613AF;
        Fri, 14 May 2021 08:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620979901;
        bh=euz8DtD99/HthYNgEju8MOzMQzZ0NYPXxckHxBD8Uq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boP+BBAmTJ/uVUb7/U5yieQDFlI0JhFlnKZM3oZpq/zEupz4AcPjpbsfn5xx8Qb7y
         NtQRm1Jd/I94VRnARgyZpLP9S/Tu5+744tcfadOi5qtkknfEEUyoXEfZgQMAAIhXIO
         Ffr5mH4bPZx80Jf6fzh8R/AFOwk+Hx1txUti7ERudfwe3roTQd4lpP9Btq3xxmgFYo
         K7J2iFb3NkibRBrJuASu0wiQxU1FiESxPWsHscjw/U77exS4OSRLV+61GMqXU3Lpg8
         DAEpAXv56NAAlJNifTdjlsnXm9vCQzMNWTrNvfg2G5uvcD0xDphqYQJOS7VYrx49md
         Ou065fBnYDNmw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lhSv8-0008VS-3B; Fri, 14 May 2021 10:11:42 +0200
Date:   Fri, 14 May 2021 10:11:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/35] tty cleanup for 5.14
Message-ID: <YJ4wvv+BpgUExmAw@hovoldconsulting.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <YJ1ACSO+JKRhZZ0/@kroah.com>
 <YJ1RyscrL2bNYXou@hovoldconsulting.com>
 <YJ1T/3PhnVBxJfmV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ1T/3PhnVBxJfmV@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 06:29:51PM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 13, 2021 at 06:20:26PM +0200, Johan Hovold wrote:

> > Greg, could you consider dropping the three USB-serial patches from
> > tty-testing? They don't have any dependency on the tty changes and we
> > can avoid unnecessary merge conflicts if I take them through through my
> > tree instead.
> > 
> > 	USB: serial: make usb_serial_driver::write_room return uint
> > 	serial: make usb_serial_driver::chars_in_buffer return uint
> > 	USB: serial: digi_acceleport, simplify digi_chars_in_buffer
> 
> Sure, I've dropped them from my tree now and pushed out a rebased branch
> for 0-day to run on.

Thanks, I'll queue them up next week.

Johan
