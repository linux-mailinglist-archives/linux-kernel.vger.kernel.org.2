Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6B93FD3C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbhIAGZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231501AbhIAGZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:25:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B33A560FE6;
        Wed,  1 Sep 2021 06:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630477472;
        bh=owYWeMNxRWHqiz4Ls+78+kJdlpX2ot1Aci5dyemJqEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vm7rX9XNGZJGt1FcOVRYNqEvPXHqOs52Ph0PA4oH8nLjNHpg6D8S6J5vlOsZCcQhf
         XmDTfrcGKtBmSYTpIUmSWUHtd6Znx4aLB90i0XbufniVREUT0xTSb7BD/flF2o7mPL
         +gS1vhbGjHOCgvbUmtVAEjlMo8lUZhwFJTSGwGn0=
Date:   Wed, 1 Sep 2021 08:24:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver core: fw_devlink: Don't create device links
 for devices not on a bus
Message-ID: <YS8cncQxUZDRuhUG@kroah.com>
References: <20210831224510.703253-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831224510.703253-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 03:45:10PM -0700, Saravana Kannan wrote:
> Devices that are not on a bus will never have a driver bound to it. So,
> fw_devlink should not create device links for it as it can cause probe
> issues[1] or sync_state() call back issues[2].
> 
> [1] - https://lore.kernel.org/lkml/CAGETcx_xJCqOWtwZ9Ee2+0sPGNLM5=F=djtbdYENkAYZa0ynqQ@mail.gmail.com/
> [2] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index f6360490a4a3..304a06314656 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1719,8 +1719,24 @@ static int fw_devlink_create_devlink(struct device *con,
>  	struct device *sup_dev;
>  	int ret = 0;
>  
> +	/*
> +	 * If a consumer device is not on a bus (i.e. a driver will never bind
> +	 * to it), it doesn't make sense for fw_devlink to create device links
> +	 * for it.
> +	 */
> +	if (con->bus == NULL)
> +		return -EINVAL;
> +

Why would a device not be on a bus that has to do with a driver needing
it?  What types of devices are these?

thanks,

greg k-h
