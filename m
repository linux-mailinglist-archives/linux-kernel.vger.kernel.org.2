Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4F93B594B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhF1Gzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhF1Gza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:55:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A435D619A3;
        Mon, 28 Jun 2021 06:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624863185;
        bh=G3fzbTwZoVC5otl/ywBvSBZTfbpse+RSsAZqEbAHOOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRlKkDF0aaCNiuNNNfNpQNovBX7R+0xJj3sd18dP2Q9GwDNOKvZXDO3rCdQPLVxRr
         pB9iTTrOXq/OD2tpqHEBl+gtiNO/nlcS6SZlpc4qCNKxB5lHsaJGXz/BkY0G4gAJZL
         QqBIMOAkzaAtBeUaBd5d45/JWz9Ver9N1vGvrwm8=
Date:   Mon, 28 Jun 2021 08:53:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: usb: host: Reduce xhci_handshake timeout in xhci_reset
Message-ID: <YNlxzj7KXG43Uyrp@kroah.com>
References: <CGME20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b@epcas2p2.samsung.com>
 <1624361096-41282-1-git-send-email-dh10.jung@samsung.com>
 <YNJAZDwuFmEoTJHe@kroah.com>
 <20210628022548.GA69289@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628022548.GA69289@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 11:25:48AM +0900, Jung Daehwan wrote:
> On Tue, Jun 22, 2021 at 09:56:20PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 22, 2021 at 08:24:56PM +0900, Daehwan Jung wrote:
> > > It seems 10 secs timeout is too long in general case. A core would wait for
> > > 10 secs without doing other task and it can be happended on every device.
> > 
> > Only if the handshake does not come back sooner, right?
> 
> Yes, right.
> 
> > What is causing your device to timeout here?
> 
> Host Controller doesn't respond handshake. I don't know why and I ask HW team
> to debug it.

Please work to fix your hardware, that feels like the root of the
problem here.  If you require the timeout for xhci_reset() to happen,
then how do you know that the hardware really did reset properly in the
reduced amount of time you just provided?

thanks,

greg k-h
