Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6916130EC6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 07:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhBDGXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 01:23:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232009AbhBDGXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:23:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D09764DE9;
        Thu,  4 Feb 2021 06:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612419746;
        bh=BgL/8xotpS0w+cquZ0Hj3CHCeKVielVHwolNyzu6+b0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=we+v7zZ+j3cIFphOIOIBnAYprbVW+qK29a9weJjk34K6JoKRZz8Qg6QMQVTvBaH8A
         by272+igLF/4z9HpH8nVmsax1NnHW0Xub8XqSgiNX8qmOzY6e+95SAVZnNUAvrE/Tm
         xgAHQrw7VWFPqWF3lMVdgyICO1Iqpw6JdZCndHzI=
Date:   Thu, 4 Feb 2021 07:22:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ye Bin <yebin10@huawei.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] usb: typec: remove =?utf-8?Q?u?=
 =?utf-8?Q?nused_variable_=E2=80=98ret?= =?utf-8?B?4oCZ?= in
 typec_partner_set_pd_revision
Message-ID: <YBuSnPDbrXcnBcgZ@kroah.com>
References: <20210204012430.3686636-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210204012430.3686636-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:24:30AM +0800, Ye Bin wrote:
> Fix follow warning:
> drivers/usb/typec/class.c:763:6: warning: unused variable ‘ret’ [-Wunused-variable]
>   int ret;
>       ^~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  drivers/usb/typec/class.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index b6ceab3dc16b..1c2d50e016e2 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -760,8 +760,6 @@ EXPORT_SYMBOL_GPL(typec_partner_set_identity);
>   */
>  int typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revision)
>  {
> -	int ret;
> -
>  	if (partner->pd_revision == pd_revision)
>  		return 0;
>  

This is already fixed in my tree, right?  What did you make this
against?

thanks,

greg k-h
