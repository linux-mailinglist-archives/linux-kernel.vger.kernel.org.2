Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160AE401CC3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbhIFOJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242521AbhIFOJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:09:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F74760F13;
        Mon,  6 Sep 2021 14:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630937303;
        bh=EKzrg0s9cAQ3WAFURVYWWL7gE0UNIfSw36IhF4UpEiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hzq2yz7XYNf9PG/NrOC1A9DkoIlxDOeABS4elyfIWQDd/IoGJQBSJJCLLfuMlVuSB
         v32c5QfsDac53b+YWY3MA0Gc6bf/kNSfzUFBb2gpBqFWTJDqzKDTfip2TYb7zEsdxk
         ZRtbkESR+Ipbs7Qz6cRnZ2r6wdwLY2FDLW/5Q8HM=
Date:   Mon, 6 Sep 2021 16:08:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] staging: r8188eu: remove _io_ops structure
Message-ID: <YTYg1PA94K2IPNWl@kroah.com>
References: <20210904220048.12822-1-fmdefrancesco@gmail.com>
 <20210904220048.12822-2-fmdefrancesco@gmail.com>
 <YTYeGH+5MG5OeEbi@kroah.com>
 <90459a0f-a32f-bf45-c790-19a03673d6fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90459a0f-a32f-bf45-c790-19a03673d6fc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 05:01:09PM +0300, Pavel Skripkin wrote:
> On 9/6/21 4:56 PM, Greg Kroah-Hartman wrote:
> > On Sun, Sep 05, 2021 at 12:00:46AM +0200, Fabio M. De Francesco wrote:
> > > -void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
> > > -{
> > > -	void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
> > > -	struct io_priv *pio_priv = &adapter->iopriv;
> > > -	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
> > > -
> > > -
> > > -	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
> > > -	     return;
> > > -	_read_mem = pintfhdl->io_ops._read_mem;
> > > -	_read_mem(pintfhdl, addr, cnt, pmem);
> > > -
> > > -}
> > 
> > This is odd, in that it resolves down to usb_read_mem which does
> > nothing at all.
> > 
> > And then no one calls this at all either?
> > 
> 
> Yep, there is no caller of this function... Idk why this was added :)

PCI devices require a read after a write to ensure that the write has
completed.  Odds are this is left over from that.

thanks,

greg k-h
