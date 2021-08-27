Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3978C3F9699
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244591AbhH0JBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232048AbhH0JBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:01:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76510608FE;
        Fri, 27 Aug 2021 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630054832;
        bh=23w14PHSR1S/hXG90KFAr1k9F0viwRPCAvAEd5AX2Mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+dBROUY5Tyvdc12gmi1XyOlgx6WummT6gQ4vLz5paKBD5NxhwDk6mV1as71SGfLk
         OgvtJn3lgGX4zsCsiGvoLwNcDJn0GXep5Cu24qtXWCJFpzYXxEpkd8gTcvfgbcfGOu
         efr4J+Nc1V85cP9KQokNqZo8d1GI7Xvz/IlSIugE=
Date:   Fri, 27 Aug 2021 11:00:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     amit@kernel.org, arnd@arndb.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] virtio_console: protect max_nr_ports to avoid
 invalid value
Message-ID: <YSippdinb67QYU6K@kroah.com>
References: <20210820075219.202404-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820075219.202404-1-xianting.tian@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 03:52:19PM +0800, Xianting Tian wrote:
> In theory untrusted remote host can pass a big or overflow value
> of max_nr_ports to guest, it may cause guest system consumes
> a lot of memory when create vqs and other impacts.

How can you have a untrusted host?  Can't they do a lot worse things
than just this?

> 
> Add the protection to guarantee max_nr_ports to get a safe value.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  drivers/char/virtio_console.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 7eaf303a7..bba985c81 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -29,6 +29,8 @@
>  
>  #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
>  
> +#define MAX_NR_PORTS	MAX_NR_HVC_CONSOLES

How was this value picked?

thanks,

greg k-h
