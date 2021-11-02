Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8BD44288E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhKBHfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231661AbhKBHfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:35:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFBDA60C51;
        Tue,  2 Nov 2021 07:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635838346;
        bh=uv4ufzZGU1l7JY8t1NRhOWd+QqYv9Wc508fqxnm/Xeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2PScwB+aJRKaUhAkILDjNHxl0g3Ie9M9m8GxbxXaLtY4ub7WP7GX4t1WE0k6u4kAl
         4Z9NuxEXhPnaTxYL6gtErpjW+jpWuoqQ0kujSG+NBzxHa9TMBxO4JNnWBuRi2QXcRH
         p4ML4KjBg3w3ZUh3mXrz5iESbQNYZ9fwzoBQTwnw=
Date:   Tue, 2 Nov 2021 08:32:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     robh@kernel.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v1 1/3] serdev: Add interface serdev_device_ioctl
Message-ID: <YYDphyMRE1z7K0KC@kroah.com>
References: <1635836707-29341-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635836707-29341-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 03:05:07PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For serdev_device which is mounted at virtual tty port, tty ioctl()
> maybe be used to make serdev_device ready to talk with tty port, so
> add interface serdev_device_ioctl().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/tty/serdev/core.c           | 13 +++++++++++++
>  drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++++
>  include/linux/serdev.h              |  9 +++++++++
>  3 files changed, 34 insertions(+)

Why did I only recieve patch 1/3 here?  Where are the rest of them?

And as Marcel said, I though we stated that this change was NOT needed
at all.  What driver needs special ioctls for bluetooth that is not
already handled by the bluetooth layer?

thanks,

greg k-h
