Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6832240AC26
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhINLBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231661AbhINLBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:01:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E2476044F;
        Tue, 14 Sep 2021 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631617205;
        bh=KwKvOEgdRbMrwhSphGjZpOW6/gFamFWiWsP1OVnir+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ACjV2TdliNRtLlbNmgWAQWqm9/5gPJyH73e46HG0nlseBhZUbef7sVprio4Sjs2L
         Epbhn4lXDXXVb7Dl1BcsuEXe6ZKeLUFsHgI6FpyR2AYPDb4j72EjiM1toODRbLVskn
         ZLwBT2tD/OOTiDGdWXku+u7TTveJnEAiKj7BcNo0=
Date:   Tue, 14 Sep 2021 13:00:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: tipd: Add an additional overflow check
Message-ID: <YUCAsmRLu1hBlfRI@kroah.com>
References: <20210914104253.61365-1-sven@svenpeter.dev>
 <20210914104253.61365-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914104253.61365-2-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:42:53PM +0200, Sven Peter wrote:
> tps6598x_block_read already checks for the maximum length of the read
> but tps6598x_block_write does not. Add the symmetric check there as
> well.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/usb/typec/tipd/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index c18ec3785592..70e2d0d410c9 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -139,6 +139,9 @@ static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
>  {
>  	u8 data[TPS_MAX_LEN + 1];
>  
> +	if (WARN_ON(len + 1 > sizeof(data)))
> +		return -EINVAL;

No need to crash anything.  If this is a valid thing for us to check,
let's check it and handle the error, but we should not reboot systems
that are running with panic-on-warn enabled, right?

thanks,

greg k-h
