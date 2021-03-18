Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129003401EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCRJX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhCRJXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:23:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A8B164E3F;
        Thu, 18 Mar 2021 09:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616059389;
        bh=lG0HowW4e+FPMkk0A+FYgGzD8QLpys03bXXWgi/QB4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xvle20FiBO7Ol9vp6zjTQ4LcHBvTK5OIyn/fq/CtiW86hSDVlFv8+sdGSM9FstFMy
         Oemkq/KDu6dN/6zmhC9WJ0SGAtWd3phGMWGtGk3PHNN+aXZs59bDfUSs9UEnY3CPkF
         BgGGsm5Gv+orlgzUaf4CLQyqIcDhtOsJ1McmRzqk=
Date:   Thu, 18 Mar 2021 10:23:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: staging: rtl8723bs: prefer ftrace
Message-ID: <YFMb+7jjmj7Oty8B@kroah.com>
References: <20210318091415.GA3683@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318091415.GA3683@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:14:15AM +0100, Fabio Aiuto wrote:
> Hi,
> 
> some suggestions before diving in a new task.
> The following checkpatch issue:
> 
> --
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> #559: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:559:
> +	DBG_871X("%s\n", __func__);
> 
> simply says to remove the line, due to the existence of the more
> appealing ftrace facility, right?
> 
> @@ -556,8 +554,6 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
>  	/* set intf_tag to if1 */
>  	/* psta->intf_tag = 0; */
>  
> -	DBG_871X("%s\n", __func__);
> -
>  	/* psta->mac_id = psta->aid+4; */
>  	/* psta->mac_id = psta->aid+1;//alloc macid when call rtw_alloc_stainfo(), */
>  	/* release macid when call rtw_free_stainfo() */
> 

Yes, stuff like this can be deleted.

thanks,

greg k-h
