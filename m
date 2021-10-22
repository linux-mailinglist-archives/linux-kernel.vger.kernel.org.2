Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A855643762D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 13:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhJVLtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 07:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhJVLtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 07:49:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1960560F4B;
        Fri, 22 Oct 2021 11:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634903243;
        bh=qw6WeHQjz5BGcN40R316+5AOhKOKwg58R+12KXsfyE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esMebFbfxvNI7HVc9VDFBaau3u1+sIJ8qIWyo/ZIowItMmwfRpKgBQFiRRHWBmcGE
         2zjDXI5EXGBqqRKYbV6YIDQlLjmczank1xyaRVmyyjoSJaOJwa1S5RJoRmclXFWz9b
         6aBRTTtm1f6AIDruhjYN/1A8+y8iCDDcMiDU/iJk=
Date:   Fri, 22 Oct 2021 13:47:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     dingsenjie@163.com
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: Re: [PATCH] usb: tcpm: Simplify the return expression of
 tcpm_start_toggling
Message-ID: <YXKkyRGoH+UJzIFw@kroah.com>
References: <20211022110045.11044-1-dingsenjie@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022110045.11044-1-dingsenjie@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 07:00:45PM +0800, dingsenjie@163.com wrote:
> From: dingsenjie <dingsenjie@yulong.com>
> 
> Simplify the return expression in the tcpm.c

Why?

> 
> Signed-off-by: dingsenjie <dingsenjie@yulong.com>

Is this the full name you sign legal documents with?  (I have to ask...)

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 22a85b396f69..dabe694a7eb1 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2766,14 +2766,11 @@ static int tcpm_set_charge(struct tcpm_port *port, bool charge)
>  
>  static bool tcpm_start_toggling(struct tcpm_port *port, enum typec_cc_status cc)
>  {
> -	int ret;
> -
>  	if (!port->tcpc->start_toggling)
>  		return false;
>  
>  	tcpm_log_force(port, "Start toggling");
> -	ret = port->tcpc->start_toggling(port->tcpc, port->port_type, cc);
> -	return ret == 0;
> +	return port->tcpc->start_toggling(port->tcpc, port->port_type, cc) == 0;

Why change this from the original code?  The original code is easier to
read, right?

thanks,

greg k-h
