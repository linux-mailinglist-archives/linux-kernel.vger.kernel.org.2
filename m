Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF87454787
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbhKQNjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhKQNjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:39:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A49476152B;
        Wed, 17 Nov 2021 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637156197;
        bh=YnDG0MXUI5zY1mjYU3GC0NpmjBAFFfx4W8XlUwroPO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0+d7T1sFlBcbZW/DfpTzroXV2o3IFzLkd0A13UaZ3B843z1pF0f0/8I9qSUa7IyJ
         qS/xCm/dbTKqL689F3mtHr5fi9oyMTDeX0gxJU4XqBh9H9yHRr3QiJyQwPL/MsCeth
         gEIrtX6+HIQ80oxfUdyKoSUutkZuXFaj6ldEtq4k=
Date:   Wed, 17 Nov 2021 14:36:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ferlandm@amotus.ca
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: simple: add sierra wireless xm1210 gnss
 receiver
Message-ID: <YZUFYsaskqDan6kF@kroah.com>
References: <20211027200223.72701-1-ferlandm@amotus.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027200223.72701-1-ferlandm@amotus.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 04:02:23PM -0400, ferlandm@amotus.ca wrote:
> From: Marc Ferland <ferlandm@amotus.ca>
> 
> Add device id for the Sierra Wireless XM1210 Multi-GNSS module.
> 
> https://www.sierrawireless.com/iot-solutions/products/xm1210/
> 
> $ lsusb -vd 1199:b000
> 
> Bus 002 Device 003: ID 1199:b000 Sierra Wireless, Inc. Sierra Wireless_GNSS

Why doesn't this device work with the qcserial.c driver instead?  Have
you tried that?

thanks,

greg k-h
