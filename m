Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176CD42F1A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbhJONGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235659AbhJONGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:06:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFE9A610E5;
        Fri, 15 Oct 2021 13:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634303075;
        bh=ZwbUjjVkXwnP9fvH2v9rlpX5mwmFOSWZJoMxv6SG14E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pnavrw8D/+DioGAe+HDAoZQmZJJ3Ke0ORv0TGx+SDdKoZ+0sK/AIQheA8N5xuLywx
         NDUsUQ611LJE6Fg9/ewZRKy4Wnry+GsM2mHmPFC2YalL77AlTswtZnF6LmuyAzy+sg
         2cNMMA/xOanlx1/tnRt7pdqBQeEHjCvLEhMR3R6w=
Date:   Fri, 15 Oct 2021 15:04:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 5.15-rc6
Message-ID: <YWl8YP2n7WwrI2N0@kroah.com>
References: <YWl4TnaWxDLv/V5z@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWl4TnaWxDLv/V5z@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 02:47:10PM +0200, Johan Hovold wrote:
> The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:
> 
>   Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.15-rc6

Pulled and pushed out, thanks,

greg k-h

