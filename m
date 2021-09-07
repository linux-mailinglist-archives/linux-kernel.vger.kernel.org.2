Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A28E4022F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 07:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhIGFC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 01:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233755AbhIGFC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 01:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4176960ED8;
        Tue,  7 Sep 2021 05:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630990882;
        bh=+DwFL4bVabNWWgQK1ObX9GwAradwBOrI5qsddr1H0FQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2eVjaaNzftPCY7XxL4jNzAKsRWFFVwWnbe15Kmf2tzVXxToUIVfFI9WQ+lSLqyJh
         /Bz0q6SWE5VmnymxbRaYrinS3fDCnQKa8NQHqdpCIilFa/jTk4cjoZNpSg9r4effde
         bPIbtPwZbzYc1g8iKbM9Zz2h3qW/HCnFBZWG+E9Y=
Date:   Tue, 7 Sep 2021 07:01:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] staging: r8188eu: remove _io_ops structure
Message-ID: <YTbyFyVe37YTV8VC@kroah.com>
References: <20210904220048.12822-1-fmdefrancesco@gmail.com>
 <20210904220048.12822-2-fmdefrancesco@gmail.com>
 <YTYeGH+5MG5OeEbi@kroah.com>
 <d9e536d6-1b66-52d5-50a8-0c011b23e018@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e536d6-1b66-52d5-50a8-0c011b23e018@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 08:19:05PM +0300, Pavel Skripkin wrote:
> On 9/6/21 16:56, Greg Kroah-Hartman wrote:
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
> > How about removing the io ops that are not used at all first, one at a
> > time, making it obvious what is happening, and then convert the ones
> > that are used one at a time, and when all is done, then removing the
> > structure?
> > 
> 
> Just have started to cut one big patch to smaller ones and does it make
> sense to group changes like: one for usb_read*, one for usb_write* and one
> for usb_port*? I think, it would be cleaner and series won't be too big.
> 
> 
> What do you think?

I will not know until I see the patches, so no need to ask :)
