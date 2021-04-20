Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203EC364FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 02:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhDTAzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 20:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhDTAzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 20:55:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F2FB6135F;
        Tue, 20 Apr 2021 00:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618880075;
        bh=qTK3Fpvc67yWL/Kayfv/rqU7Z0F1EUK2wV7/8jEgAZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xq2jKbGVk6uctWQjVax3OjBzu4mHMAGLMqyexDSDFi37dH9ZQHIfNf18VDL02fYGk
         4iIXFRNTbAFmkME79UD3mrwl7WIzL9H3CIttpVTuN5BWd7I24+wKTJ13WwVpBM1GjL
         SRLA2XD6/oEX54penqMetgjw1b7ucY+fQ/DSaM4mAt2T14l3p01r/xLGQTJ26DSYDo
         gTdrLt18louCkjEW/7sfU9Hfqmhz0wNzdekIG3Foa6mpNBoOpARxB20i+qcCbZTJor
         U0Hfbn9FHc9Zq+GZiIC4ImEbTR6E6A1MOtm4M/UyfTCU+1mV4QxzouCZFagoDmw01I
         ptfKdINW0XDkg==
Date:   Tue, 20 Apr 2021 08:54:29 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, Hemant Kumar <hemantk@codeaurora.org>
Subject: Re: [PATCH] usb: gadget: Fix double free of device descriptor
 pointers
Message-ID: <20210420005429.GA5069@nchen>
References: <1618862240-5965-1-git-send-email-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618862240-5965-1-git-send-email-wcheng@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-19 12:57:20, Wesley Cheng wrote:
> From: Hemant Kumar <hemantk@codeaurora.org>
> 
> Upon driver unbind usb_free_all_descriptors() function frees all
> speed descriptor pointers without setting them to NULL. In case
> gadget speed changes (i.e from super speed plus to super speed)
> after driver unbind only upto super speed descriptor pointers get
> populated. Super speed plus desc still holds the stale (already
> freed) pointer. Fix this issue by setting all descriptor pointers
> to NULL after freeing them in usb_free_all_descriptors().
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  drivers/usb/gadget/config.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/gadget/config.c b/drivers/usb/gadget/config.c
> index 2d11535..8bb2577 100644
> --- a/drivers/usb/gadget/config.c
> +++ b/drivers/usb/gadget/config.c
> @@ -194,9 +194,13 @@ EXPORT_SYMBOL_GPL(usb_assign_descriptors);
>  void usb_free_all_descriptors(struct usb_function *f)
>  {
>  	usb_free_descriptors(f->fs_descriptors);
> +	f->fs_descriptors = NULL;
>  	usb_free_descriptors(f->hs_descriptors);
> +	f->hs_descriptors = NULL;
>  	usb_free_descriptors(f->ss_descriptors);
> +	f->ss_descriptors = NULL;
>  	usb_free_descriptors(f->ssp_descriptors);
> +	f->ssp_descriptors = NULL;
>  }
>  EXPORT_SYMBOL_GPL(usb_free_all_descriptors);
>  

Reviewed-by: Peter Chen <peter.chen@kernel.org>

You may add Fixed-by tag, and cc to stable tree.

-- 

Thanks,
Peter Chen

