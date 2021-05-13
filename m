Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3577537FB7B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhEMQbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230375AbhEMQbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:31:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F30BE6143B;
        Thu, 13 May 2021 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620923393;
        bh=i9I2ka1Fjg1jf3aUwxg9K1DcAal8NUVPIyoZfuKnPIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cuhui35k5Ah+Rz7OT59x21OD0YapBookYPgw+DPzacmVG2mKACeuNE5pIldBieMZc
         eXZdvHtcoVrB4ahfSbW9Umo3H8lBDXJJTQ5fOPnp/Wyb3tKTwf/ZGm+XrAtmr6X7+4
         meVAqOpDhrn2RPJJCpxlFddYeZvDZLn0ifhG8svQ=
Date:   Thu, 13 May 2021 18:29:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/35] tty cleanup for 5.14
Message-ID: <YJ1T/3PhnVBxJfmV@kroah.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <YJ1ACSO+JKRhZZ0/@kroah.com>
 <YJ1RyscrL2bNYXou@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ1RyscrL2bNYXou@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 06:20:26PM +0200, Johan Hovold wrote:
> On Thu, May 13, 2021 at 05:04:41PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, May 05, 2021 at 11:18:53AM +0200, Jiri Slaby wrote:
> > > Hi,
> > > 
> > > this is again a series of various TTY cleanups. The stats say: 116 files
> > > changed, 661 insertions, 2602 deletions. The major part of the removal
> > > is a drop of BROKEN r3964 ldisc. The rest is mostly removal of dead
> > > code, or adaption to the current tty core state.
> > 
> > I've applied the first 33 patches in this series.  Can you resend the
> > last two after you have revised them based on the review?
> 
> Greg, could you consider dropping the three USB-serial patches from
> tty-testing? They don't have any dependency on the tty changes and we
> can avoid unnecessary merge conflicts if I take them through through my
> tree instead.
> 
> 	USB: serial: make usb_serial_driver::write_room return uint
> 	serial: make usb_serial_driver::chars_in_buffer return uint
> 	USB: serial: digi_acceleport, simplify digi_chars_in_buffer

Sure, I've dropped them from my tree now and pushed out a rebased branch
for 0-day to run on.

thanks,

greg k-h
