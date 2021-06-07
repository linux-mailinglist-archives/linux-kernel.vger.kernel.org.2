Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F63A39DCA1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhFGMjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhFGMjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:39:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E861860FEE;
        Mon,  7 Jun 2021 12:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623069475;
        bh=zh1UFk/5eurUdtKRROoZk1qCuui3pWGJTVi5Qwa6lsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IcPJALVoNRZZX0/VjCaIhaxWMCNjrMxrYb0DAXNuUbyer4V/P5P778Ko4vDXjIPVi
         XRx2P+VCNtQ0jvZuMq6bfyjTrmnnefqG4EwBHaPuqyUOFbPk+OSZ3o/YXyPdd+yN5M
         3p7sLJQJFaBwUgd2aj9YwqoE+6G/mq0HNlNDTFp0=
Date:   Mon, 7 Jun 2021 14:37:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linyu Yuan <linyyuan@codeaurora.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linyu Yuan <linyyuan@codeaurora.com>
Subject: Re: [PATCH][v2] usb: gadget: eem: fix wrong eem header operation
Message-ID: <YL4TIBuob2nvyYeJ@kroah.com>
References: <20210607122825.3210-1-linyyuan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607122825.3210-1-linyyuan@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 08:28:25PM +0800, Linyu Yuan wrote:
> From: Linyu Yuan <linyyuan@codeaurora.com>
> 
> when skb_clone() or skb_copy_expand() fail,
> it should pull skb with lengh indicated by header,
> or not it will read network data and check it as header.
> 
> Signed-off-by: Linyu Yuan <linyyuan@codeaurora.com>
> ---
>  drivers/usb/gadget/function/f_eem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
