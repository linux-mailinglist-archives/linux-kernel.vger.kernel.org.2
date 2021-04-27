Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FD336CB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbhD0Skr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236942AbhD0Skp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:40:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B79D613F4;
        Tue, 27 Apr 2021 18:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619548801;
        bh=gALi6uG6jtgu0UC4nlF/Yc+OcZhw6SyYYYzmRLmG760=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=veNXeih7vAOkNsnrne4IAYM8Fl2yZqFhNiZTFsKfR3AAnJmjYhDBIkvsKR08fMkSX
         RWjOnuqNsLVFaSpDD3yhISfuZGpnRKMfhk/JDu4nU1/HMeXGXo8A5LLrhyg/kyUm5L
         /PK/d/hp6xOM0nzgbdIR4bvhW8OxENBpRWei7qMA=
Date:   Tue, 27 Apr 2021 20:39:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 063/190] Revert "hdlcdrv: replace unnecessary assertion
 in hdlcdrv_register"
Message-ID: <YIhaf3GrmPGwrUWq@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-64-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-64-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:58PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit a886ca6fcfffd337482352f383c1002c72786b17.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/hamradio/hdlcdrv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/hamradio/hdlcdrv.c b/drivers/net/hamradio/hdlcdrv.c
> index 9e0058154ac3..d8df4e2b162e 100644
> --- a/drivers/net/hamradio/hdlcdrv.c
> +++ b/drivers/net/hamradio/hdlcdrv.c
> @@ -687,6 +687,8 @@ struct net_device *hdlcdrv_register(const struct hdlcdrv_ops *ops,
>  	struct hdlcdrv_state *s;
>  	int err;
>  
> +	BUG_ON(ops == NULL);
> +
>  	if (privsize < sizeof(struct hdlcdrv_state))
>  		privsize = sizeof(struct hdlcdrv_state);
>  
> -- 
> 2.31.1
> 

Original was fine, dropping the revert now.

greg k-h
