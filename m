Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB08F3B2F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhFXNCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhFXNCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:02:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 312F961003;
        Thu, 24 Jun 2021 13:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624539601;
        bh=1fuYk8LvyHxK1nd8kAGgU5F/ANhdDvNqsNFMA40L9Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6+/n/Zw7UQBqw0eTfWzB0uYqlZIxPtuLLplxc079DvLQxPadlXzIUT6KRn5JRE+K
         VMxnN1jekp0h83tZoFr0vvZWPoCMvbnTTvbqY4FLtJ0S3mmci0Y79hklyeO8K5Kajz
         juevqV5KxdFgJMIBhzJv0Z/UNeaU7MkXG9tlOPAE=
Date:   Thu, 24 Jun 2021 14:59:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: modify the doc punctuation "," to "."
Message-ID: <YNSBz60hC2Czy95I@kroah.com>
References: <1623981811-19505-1-git-send-email-zhenguo6858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623981811-19505-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 10:03:31AM +0800, Zhenguo Zhao wrote:
> From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
> 
> End punctuation of items 5 and 6 are ".",other lists
> should be modify to "."
> 
> Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
> ---
>  Documentation/driver-api/serial/n_gsm.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/driver-api/serial/n_gsm.rst b/Documentation/driver-api/serial/n_gsm.rst
> index 87dfcd5..154c75e 100644
> --- a/Documentation/driver-api/serial/n_gsm.rst
> +++ b/Documentation/driver-api/serial/n_gsm.rst
> @@ -14,11 +14,11 @@ How to use it
>  -------------
>  1. initialize the modem in 0710 mux mode (usually AT+CMUX= command) through
>     its serial port. Depending on the modem used, you can pass more or less
> -   parameters to this command,
> +   parameters to this command.
>  2. switch the serial line to using the n_gsm line discipline by using
> -   TIOCSETD ioctl,
> -3. configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl,
> -4. obtain base gsmtty number for the used serial port,
> +   TIOCSETD ioctl.
> +3. configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl.
> +4. obtain base gsmtty number for the used serial port.
>  

Strangly, the use of a ',' here is correct as this is a list of things
to do in a specific order.  If you wrote this all out at once in a
single sentance without the numbers, a ',' would make sense.

But this isn't a big deal, if you want to use '.' then please capitalize
the first word of each item in the list.

Picky, yes, sorry.

greg k-h
