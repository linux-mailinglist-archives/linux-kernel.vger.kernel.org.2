Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481753BC5F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 07:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhGFFNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 01:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhGFFNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 01:13:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DEE76198D;
        Tue,  6 Jul 2021 05:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625548255;
        bh=5WR28VC8jPXn2qMGrHg8NPIQISa/BFrzapW1vbjsOoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UH15tlyS5QBbtsSxnEAc4oZ1Ddyp7I4+YNavkMwrZ4G0DXRl7TViu10+dpqC+/CF+
         fJYbK37bs9Hiw+vqZ0GE928iHSUM1DfFbgOCtZoNgrMloVtzw8ADotnKXdfZ6aUf5t
         UuAihk4k81g/Ch0w1ylM04Oc7+5xjUcOU/F6ueGw=
Date:   Tue, 6 Jul 2021 07:10:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sunip Mukherjee <sunipkmukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Char Driver for Silicon Labs Si446x Transceivers
Message-ID: <YOPl3dXamM3FERYT@kroah.com>
References: <CADLJR24hQya0MkJhdDAJ0KO4MG+Fj4tRU5dNrbNdD9DMG_gLHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADLJR24hQya0MkJhdDAJ0KO4MG+Fj4tRU5dNrbNdD9DMG_gLHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 06:09:28PM -0400, Sunip Mukherjee wrote:
> Hi,
> 
> I am very new to the kernel community; this is my first message in the
> LKML so my apologies if I am doing things wrong.
> 
> I have been using an Si4463 transceiver for UHF communication with a
> cubesat I developed. I could not find any code to control the
> transceiver on Linux. The closest thing I could find was an AVR
> implementation by Zak Kemble
> (https://blog.zakkemble.net/si4463-radio-library-avr-arduino/).
> I followed the API docs and rewrote the whole thing at first for
> userland only (can be found here:
> https://github.com/SPACE-HAUC/si446x_linux/releases/tag/v3.1), and
> then I decided it would be a great learning opportunity for me to port
> it to the kernel.
> 
> The kernel port has gone mostly smoothly. The transceiver communicates
> with the host MCU over SPI, and requires a pin for RESET, and another
> pin for IRQ.
> I have implemented the driver to provide a char device (/dev/si446x#)
> to the userland for open, read, write, poll and ioctl.
> I had initially set up a pull request for the driver and the device
> tree overlay to the Raspberry Pi kernel community. They have agreed to
> accept the device tree overlay for the device, however the driver
> needs to be included by the Linux Kernel community. I want to use this
> opportunity to find some people who have access to a Si446x
> transceiver and a Raspberry Pi, so that the code I have can be tested,
> and if deemed worthy, included in the kernel tree.
> 
> My code is hosted here: https://github.com/sunipkmukherjee/silabs.git
> 
> Any suggestions/criticisms are welcome.

If you post it in a patch form, as described in our documentation, I
will be glad to review it.  Otherwise just looking at a random github
repo is quite difficult and provides no way to give proper feedback.

Instructions on how to make a patch and submit it and the proper format
for everything can be found in the Documentation/SubmittingPatches file.

thanks,

greg k-h

