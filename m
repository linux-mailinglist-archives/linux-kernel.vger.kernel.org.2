Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F6335C2DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbhDLJvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243475AbhDLJmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:42:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43D6F61241;
        Mon, 12 Apr 2021 09:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618220516;
        bh=nryu7mJqQngn8j8YZtZLJYylcpSAA1GV7IacvGJBhU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STuZV4GG16WFSbDXkoIzgUj4qrGE+BNfUh2Lg/WrGBN+xuo3qmDW8oxav8Am7+q5q
         gF/rw4eY3zm1BugsCBhA865iV4Ks6WF33e28RZbPtqreibVHp1BFK68nJtVmCtWld+
         laVT1Liw4U7iEvDtgZ3dSDEJzsCG9W3QZLfwevTY=
Date:   Mon, 12 Apr 2021 11:41:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: emxx_udc: remove useless variable
Message-ID: <YHQV4sX6rGjFb9yj@kroah.com>
References: <1618195990-85967-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1618195990-85967-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:53:10AM +0800, Jiapeng Chong wrote:
> Fix the following gcc warning:
> 
> vers/staging/emxx_udc/emxx_udc.c:41:19: warning: ‘driver_desc’ defined
> but not used [-Wunused-const-variable=].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index 3536c03..741147a 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -38,7 +38,6 @@
>  static int vbus_irq;
>  
>  static const char	driver_name[] = "emxx_udc";
> -static const char	driver_desc[] = DRIVER_DESC;
>  
>  /*===========================================================================*/
>  /* Prototype */
> -- 
> 1.8.3.1
> 
>

Does not apply to my tree at all :(
