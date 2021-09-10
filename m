Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D594406C63
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhIJMmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233545AbhIJMmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:42:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7054B60E94;
        Fri, 10 Sep 2021 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631277686;
        bh=Ny+TBmYm0Glx2ncjaBaqRJOzvS8UE8xM7y5YZjKFfVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ZI5+bC6IkGmQaSoxUudj5Ol8ZkgoStlRl7s3g4kiirHqqxwFP+ccQMYgOPzvixbp
         XOybQxFkh0hzxy9NQzHMI1KONgViQ+wY4Z7pWRZp4cQpALPsNksyFgfLZbU8BkCFHw
         o0g8Hmh0cz9F2Rnf/t3e2WyAYtsFQ2ef9RwWgQfM=
Date:   Fri, 10 Sep 2021 14:41:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] USB: serial: allow hung up ports to be suspended
Message-ID: <YTtSdGTYAv53XdoI@kroah.com>
References: <20210910121128.18664-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910121128.18664-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 02:11:26PM +0200, Johan Hovold wrote:
> User space can keep a tty open indefinitely and that should not prevent
> a hung up port and its USB device from being runtime suspended.
> 
> Also clean up a few related error labels in a preparatory patch.
> 
> Johan
> 
> 
> Johan Hovold (2):
>   USB: serial: clean up core error labels
>   USB: serial: allow hung up ports to be suspended
> 
>  drivers/usb/serial/usb-serial.c | 59 +++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> -- 
> 2.32.0
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
