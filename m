Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70581377D50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhEJHlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhEJHlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:41:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C81FF6128E;
        Mon, 10 May 2021 07:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620632446;
        bh=a5WQLkTrgvDHxX8OYf0xab/F1Y2rE/TyolaT9zSqt0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nou3l5FLu7HzXLCFWRz0LXc+epg3UYf6R16RSywaRy1XszV+FWHroPi8ApWuRiQXm
         N4loDySvSF6l6/33+XzZgh4poDv8jeiHhte+/qp5q2JDojqO0R5dtoUFPBR6LjH2d+
         Z0ucjQz5P/tZFPxwcIiriMYyAfSQ6WHnrey7/l32KCwGrd8hB8kgYDWJmp6DMN75Ul
         i2tJBLb03r9JEmPtGU04UWoQGcTnL5TlBaewzfzkgMJt2SpwdYNrkgcBdgY8tr8TT0
         1niZx5U508+g0bvQzFQxsGcENSz7kzocXmDx66winUv2IXzVdicPeijWqJwCwPxk8h
         yeBtrjccimzCw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lg0X1-0000Dd-Oy; Mon, 10 May 2021 09:40:48 +0200
Date:   Mon, 10 May 2021 09:40:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Frank Zago <frank@zago.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jan-Niklas Burfeind <kernel@aiyionpri.me>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, linux-usb@vger.kernel.org,
        gunar@schorcht.net
Subject: Re: [PATCH v2 1/2] Revert "USB: serial: ch341: add new Product ID
 for CH341A"
Message-ID: <YJjjfx49nCflzFbR@hovoldconsulting.com>
References: <20210423002852.3904-1-frank@zago.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423002852.3904-1-frank@zago.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 07:28:51PM -0500, Frank Zago wrote:
> From: frank zago <frank@zago.net>
> 
> The 0x5512 USB PID is for the I2C/GPIO/SPI interfaces. UART is still
> present but only the TX and RX pins are available; DTS, DTR, ... are
> used for other things. Remove the PID, and let a I2C driver bind to
> it.
> 
> Existing CH341 boards usually have physical jumpers to switch between
> the 3 modes.
> 
> This reverts commit 46ee4abb10a07bd8f8ce910ee6b4ae6a947d7f63.

You can't just revert something which people clearly depend on and
therefore added to the kernel in the first place.

Can you reprogram the device with a newly allocated PID to be used for
i2c-only instead?
 
Johan
