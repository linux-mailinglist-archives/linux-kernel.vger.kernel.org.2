Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E798E401CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 15:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbhIFN5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 09:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232432AbhIFN5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 09:57:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2096C60200;
        Mon,  6 Sep 2021 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630936607;
        bh=yTbpKAF7MjC8ekyK+CMlmHVAkTt9JrzZNsjMv7iwBZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+zi+Lj+cc3rvbDgo7o64nDDDSbB/tnn4Ws7H5Ac6rPkbcKRGzRItzTfweVJBaFT7
         sT/pRV/iK8gFQPNepUhkRnZtTHFePybyWKAcEVrNQ9lARP5qdB2B3Dhj9cN/qA5crJ
         NAEYjDnCExQVD4yNI7irmp34vB2RTzIfDaXz9t7g=
Date:   Mon, 6 Sep 2021 15:56:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] staging: r8188eu: remove _io_ops structure
Message-ID: <YTYeGH+5MG5OeEbi@kroah.com>
References: <20210904220048.12822-1-fmdefrancesco@gmail.com>
 <20210904220048.12822-2-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904220048.12822-2-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 12:00:46AM +0200, Fabio M. De Francesco wrote:
> -void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
> -{
> -	void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
> -	struct io_priv *pio_priv = &adapter->iopriv;
> -	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
> -
> -
> -	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
> -	     return;
> -	_read_mem = pintfhdl->io_ops._read_mem;
> -	_read_mem(pintfhdl, addr, cnt, pmem);
> -
> -}

This is odd, in that it resolves down to usb_read_mem which does
nothing at all.

And then no one calls this at all either?

How about removing the io ops that are not used at all first, one at a
time, making it obvious what is happening, and then convert the ones
that are used one at a time, and when all is done, then removing the
structure?

That makes it obvious what is happening and much much easier to review
for correctness.

thanks,

greg k-h
