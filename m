Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBFB3BE2E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 08:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhGGGEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 02:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhGGGEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 02:04:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B19161C7C;
        Wed,  7 Jul 2021 06:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625637710;
        bh=1KWqWAZB3rP/4U41gdG0pcG9MN0h5yyh2IsQiyYBmmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cg2sqEPS19wM2Me4VxoG5IDzC0xCxVTvZkJK7WQe4K++q7bWY2bAg8O5e6F4uCls0
         /8L+WWHxMidjgfbIyaHhsC1dUoxFsK2fDg5Tjbqi1zXlgxROW9049NmrjzfKMCx7sH
         EcuwSS2FI+tR0akTXp3QuCYMAxtX67/MRbVYzCXA=
Date:   Wed, 7 Jul 2021 08:01:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Sunip Mukherjee <sunipkmukherjee@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Char Driver for Silicon Labs Si446x Transceivers
Message-ID: <YOVDSjXuOll5I8uL@kroah.com>
References: <CADLJR24hQya0MkJhdDAJ0KO4MG+Fj4tRU5dNrbNdD9DMG_gLHg@mail.gmail.com>
 <YOPl3dXamM3FERYT@kroah.com>
 <fe95e46b-fbc9-6411-0e4c-7b72040cddc5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe95e46b-fbc9-6411-0e4c-7b72040cddc5@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 01:17:09PM -0700, Randy Dunlap wrote:
> On 7/5/21 10:10 PM, Greg KH wrote:
> > On Mon, Jul 05, 2021 at 06:09:28PM -0400, Sunip Mukherjee wrote:
> >> Hi,
> >>
> >> I am very new to the kernel community; this is my first message in the
> >> LKML so my apologies if I am doing things wrong.
> >>
> >> I have been using an Si4463 transceiver for UHF communication with a
> >> cubesat I developed. I could not find any code to control the
> >> transceiver on Linux. The closest thing I could find was an AVR
> >> implementation by Zak Kemble
> >> (https://blog.zakkemble.net/si4463-radio-library-avr-arduino/).
> >> I followed the API docs and rewrote the whole thing at first for
> >> userland only (can be found here:
> >> https://github.com/SPACE-HAUC/si446x_linux/releases/tag/v3.1), and
> >> then I decided it would be a great learning opportunity for me to port
> >> it to the kernel.
> >>
> >> The kernel port has gone mostly smoothly. The transceiver communicates
> >> with the host MCU over SPI, and requires a pin for RESET, and another
> >> pin for IRQ.
> >> I have implemented the driver to provide a char device (/dev/si446x#)
> >> to the userland for open, read, write, poll and ioctl.
> >> I had initially set up a pull request for the driver and the device
> >> tree overlay to the Raspberry Pi kernel community. They have agreed to
> >> accept the device tree overlay for the device, however the driver
> >> needs to be included by the Linux Kernel community. I want to use this
> >> opportunity to find some people who have access to a Si446x
> >> transceiver and a Raspberry Pi, so that the code I have can be tested,
> >> and if deemed worthy, included in the kernel tree.
> >>
> >> My code is hosted here: https://github.com/sunipkmukherjee/silabs.git
> >>
> >> Any suggestions/criticisms are welcome.
> > 
> > If you post it in a patch form, as described in our documentation, I
> > will be glad to review it.  Otherwise just looking at a random github
> > repo is quite difficult and provides no way to give proper feedback.
> > 
> > Instructions on how to make a patch and submit it and the proper format
> > for everything can be found in the Documentation/SubmittingPatches file.
> 
> which is now known as Documentation/process/submitting-patches.rst

That's what that file says :)

I should update my bot one of these days to point to the real
location...

thanks,

greg k-h
