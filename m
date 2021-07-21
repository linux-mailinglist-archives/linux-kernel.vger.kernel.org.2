Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872C93D0A47
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhGUH0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234924AbhGUHYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:24:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4E0961019;
        Wed, 21 Jul 2021 08:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626854641;
        bh=I26Kg2IdIL1hUzZmRwfX5BJtizycpexzZBkB4rGP160=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=shplYQUONL46UJLS0Um93PTepLnuJb41fmxhCIOWfFASjNuIrJkqm7/9ayv6Zz1eP
         os2iYwL2Sjc5BgV37DCznxRGiAGUNW2fs40U1ixGbVysNKyWtRT1gu5HpE3DaW5jq0
         0VwBcNjcgac0aVxsQvwopn6w2bJzMAhboP8wpr58=
Date:   Wed, 21 Jul 2021 10:03:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kelly Devilliv <kelly.devilliv@gmail.com>
Cc:     shubhankarvk@gmail.com, lee.jones@linaro.org,
        gustavoars@kernel.org, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] usb: host: fotg210: fix malfunctions in usb camera
 scenario
Message-ID: <YPfU7v5lhjgqIBJp@kroah.com>
References: <20210627125747.127646-1-kelly.devilliv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627125747.127646-1-kelly.devilliv@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 08:57:44PM +0800, Kelly Devilliv wrote:
> Hi :-)
> 
> Currently, I tried to support usb camera on the fotg210 host
> controller but came across a few issues, for example system
> crash, video streaming error, etc. As fotg210 is an ehci-like
> controller, I borrowed some ideas from the ehci-hcd driver,
> and at least the usb camera can work now.
> 
> By the way, the fotg210-hcd driver seems a bit out of date,
> is there any plan to update it based on the latest ehci-hcd
> driver?

No idea, feel free to send changes to fix it up!

thanks,

greg k-h
