Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54B140FAB1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhIQOr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232396AbhIQOqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:46:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD4D060F5B;
        Fri, 17 Sep 2021 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631889932;
        bh=ULeRIIIFttKb+b4QoTM0Wj+fNNtwkoySJ0NifURqcYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0YUF0xQ2ApWpA7Gb2ZOzLP5X9zHsBQKrhr9uF00QzULRewUj7i3q1JbFgMRGOqsw9
         W/YTjgaycqi7fox8DKJsLHmq5nLhSk1HnwN2pqxsX4ndcun830ZSR2Ws8cdWirDDXH
         oM1fJA6jsp/G1P13R4bgwqVPAAXZ1DHWaYZT8IWU=
Date:   Fri, 17 Sep 2021 16:45:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 16/19] staging: r8188eu: clean up rtw_read*() and
 rtw_write*()
Message-ID: <YUSqCYKOulGjk1lZ@kroah.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
 <20210917071837.10926-17-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917071837.10926-17-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 09:18:34AM +0200, Fabio M. De Francesco wrote:
> Clean up rtw_read{8,16,32}() and rtw_write{8,16,32,N}() in usb_ops_linux.c.
> 
> 1) Rename variables:
>         length => len
>         pio_priv => io_priv
>         pintfhdl => intfhdl
>         wvalue => address.

Wait, why are you changing wvalue?  Isn't that the USB name for this
variable in the USB message sent to the device?  Check the USB spec
before changing this, that is a common field and probably should not be
changed.

thanks,

greg k-h
