Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9F3E11A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbhHEJxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232930AbhHEJx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:53:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A31566104F;
        Thu,  5 Aug 2021 09:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628157194;
        bh=V1aHmeLRX6++4XDyNMvcfjO6Y76SBpqT5PWm6Es+pSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kRsUOYeD0MNRodBiiDiul52bTxM6iT43h7w/2/cXIl69MAMyDHCGLQ7LbTAFZG7lh
         B7cl2DfTWwD+3OZm8WskYoZelkC7ZgnehZQruQ+jBIdmyXXBvbmiPwRl/Lal0GXTGz
         N2pGvcfz1ZlIg09jeQvAsA7//TFLgBIWLg8clFPI=
Date:   Thu, 5 Aug 2021 11:53:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: USB xhci crash under load on 5.14-rc3
Message-ID: <YQu1AgtuCWaW32U9@kroah.com>
References: <YQpJLk42b+0g7WFB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQpJLk42b+0g7WFB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 10:00:46AM +0200, Greg KH wrote:
> Hi,
> 
> I was doing some filesystem backups from one USB device to another one
> this weekend and kept running into the problem of the xhci controller
> shutting down after an hour or so of high volume traffic.
> 
> I finally captured the problem in the kernel log as this would also take
> out my keyboard, making it hard to recover from :)
> 
> The log is below for when the problem happens, and then the devices are
> disconnected from the bus (ignore the filesystem errors, those are
> expected when i/o is in flight and we disconnect a device.
> 
> Any hint as to what the IO_PAGE_FAULT error messages are?
> 
> I'll go back to 5.13.y now and see if I can reproduce it there or not,
> as my backups are not yet done...

5.13.7 seemed to work, but locked up overnight when running this same
workload, so it is a bit worse.  Let me split the USB devices across PCI
devices and see if that helps...

