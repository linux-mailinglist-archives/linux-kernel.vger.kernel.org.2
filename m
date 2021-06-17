Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211AB3AB494
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhFQNYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhFQNYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:24:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81262613BA;
        Thu, 17 Jun 2021 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623936153;
        bh=m8K5khmOV4Nt95fDzRf7f7CuZlwaLm2UDMhLZOcWULs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xa4OOiGtb2s2c6xosB8LEOG+gNZ84PRyBoDa09ioQao+sz4MK5zqRDenVsZEAZ7yM
         IQ+1ClNUraerQMlwzeWiacQNxPzdZDVMshXPe0OAYLRpvJMdACX4zZyvC8S8+I6LpH
         7dWMM5nutSBB2Q8Zfsaalk4e3JA5Wd60BCpUuzFk=
Date:   Thu, 17 Jun 2021 15:22:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linyu Yuan <linyyuan@codeaurora.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linyu Yuan <linyyuan@codeaurora.com>
Subject: Re: [PATCH v3] usb: gadget: eem: fix echo command packet response
 issue
Message-ID: <YMtMlmwuIU3YmwAq@kroah.com>
References: <20210616115142.34075-1-linyyuan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616115142.34075-1-linyyuan@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 07:51:42PM +0800, Linyu Yuan wrote:
> From: Linyu Yuan <linyyuan@codeaurora.com>
> 
> when receive eem echo command, it will send a response,
> but queue this response to the usb request which allocate
> from gadget device endpoint zero,
> and transmit the request to IN endpoint of eem interface.
> 
> on dwc3 gadget, it will trigger following warning in function
> __dwc3_gadget_ep_queue(),
> 
> 	if (WARN(req->dep != dep, "request %pK belongs to '%s'\n",
> 				&req->request, req->dep->name))
> 		return -EINVAL;

Is this really a problem?  I am guessing the request will not work at
all?  Or just warn and continue with it?

How was this ever working?

> 
> fix it by allocating a usb request from IN endpoint of eem interface,
> and transmit the usb request to same IN endpoint of eem interface.
> 
> Signed-off-by: Linyu Yuan <linyyuan@codeaurora.com>
> ---

What commit does this fix?  Should it be backported to older stable
kernels?  If so, how far back?

thanks,

greg k-h
