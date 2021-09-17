Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AE640FC14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbhIQPVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243002AbhIQPTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:19:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC5EC61164;
        Fri, 17 Sep 2021 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631891895;
        bh=96NVuakQJdmaO277CeGDiyCBNXhMgA/638vNRLesnyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYxvoiO1I1AqWfBxf49rIRQgHssvElBbASOYmcN03uAx8XkjMi30rkGKyC6p9X3aE
         l1671X4Q95CkCh9/kN89XUfd3HU80h1TP0EsOLmAkm+GVVKx3yGNbuQZNM5R1GIJgY
         jI61iXwzKsAQyc3QcFU7qeiDnWgGtNWrFJsZFmqY=
Date:   Fri, 17 Sep 2021 17:18:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v7 19/19] staging: r8188eu: remove shared buffer for usb
 requests
Message-ID: <YUSxtQ7D0w6QkB/N@kroah.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
 <20210917071837.10926-20-fmdefrancesco@gmail.com>
 <YUSsa+3NjQVGD9gb@kroah.com>
 <ef2a89f5-f68c-e7e2-9338-78e70dc41701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef2a89f5-f68c-e7e2-9338-78e70dc41701@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 06:03:52PM +0300, Pavel Skripkin wrote:
> On 9/17/21 17:55, Greg Kroah-Hartman wrote:
> > On Fri, Sep 17, 2021 at 09:18:37AM +0200, Fabio M. De Francesco wrote:
> > > From: Pavel Skripkin <paskripkin@gmail.com>
> > > 
> > > This driver used shared buffer for usb requests. It led to using
> > > mutexes, i.e no usb requests can be done in parallel.
> > > 
> > > USB requests can be fired in parallel since USB Core allows it. In
> > > order to allow them, remove usb_vendor_req_buf from dvobj_priv (since
> > > USB I/O is the only user of it) and remove also usb_vendor_req_mutex
> > > (since there is nothing to protect).
> > 
> > Ah, you are removing this buffer, nice!
> > 
> > But, just because the USB core allows multiple messages to be sent to a
> > device at the same time, does NOT mean that the device itself can handle
> > that sort of a thing.
> > 
> > Keeping that lock might be a good idea, until you can prove otherwise.
> > You never know, maybe there's never any contention at all for it because
> > these accesses are all done in a serial fashion and the lock
> > grab/release is instant.  But if that is not the case, you might really
> > get a device confused here by throwing multiple control messages at it
> > in ways that it is not set up to handle at all.
> > 
> > So please do not drop the lock.
> > 
> > More comments below.
> > 
> 
> We have tested this change. I've tested it in qemu with TP-Link TL-WN722N v2
> / v3 [Realtek RTL8188EUS], and Fabio has tested it on his host for like a
> whole evening.
> 
> I agree, that our testing does not cover all possible cases and I can't say
> it was "good stress testing", so, I think, we need some comments from
> maintainers.

Ok, then make it a single patch that does nothing but remove the lock so
that we can revert it later when problems show up :)

thanks,

greg k-h
