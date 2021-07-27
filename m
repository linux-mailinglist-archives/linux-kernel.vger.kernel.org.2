Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915283D7DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhG0SqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhG0SqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:46:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05A2960F9D;
        Tue, 27 Jul 2021 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627411565;
        bh=OmsQNasGdmEuVCgiK/QdSJd/m0VpwUaamHWqgJzUrI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDSkkd8XP/azVdxPc0wHyBo9WM7QAjNinGJNgBsr1m5bprl7sFXl+PKunqqbDu7dU
         DwPP03d1+m7Pk9D781yYvC8s7Y4aL4agIESEGr4xCl5YzfdmeNib8RBCI/9DK5Qa7q
         KT0DNcO0AALTGYmfuY5MX0OBxdVr1Nz44C6tXtkY=
Date:   Tue, 27 Jul 2021 20:46:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     balbi@kernel.org, sandeen@redhat.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_hid: added GET_IDLE and SET_IDLE
 handlers
Message-ID: <YQBUa+YrPc8e07Yv@kroah.com>
References: <20210727183140.42330-1-mdevaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727183140.42330-1-mdevaev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 09:31:41PM +0300, Maxim Devaev wrote:
> The USB HID standard declares mandatory support for GET_IDLE and SET_IDLE
> requests for Boot Keyboard. Most hosts can handle their absence, but others
> like some old/strange UEFIs and BIOSes consider this a critical error
> and refuse to work with f_hid.
> 
> This primitive implementation of saving and returning idle is sufficient
> to meet the requirements of the standard and these devices.
> 
> Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
> ---
>  drivers/usb/gadget/function/f_hid.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

As I already took your first patch, and I can not drop it as it is a
public tree, can you just send me the fixup patch?  That would be
simpler than me reverting the original and then applying a "fixed"
version, right?

thanks,

greg k-h
