Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18C43308DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhCHHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:37:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232678AbhCHHgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:36:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99D78651E8;
        Mon,  8 Mar 2021 07:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615189013;
        bh=D/4KudnhtSMN1x/gY5a3/M8JulIafkR5bugmrWfxE4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fm4SY6fZQ0F4WZSaiNP9z9a2TnqgpU1HCfWfOltNL92Wm1C3X5gKKA2CAxxGIPIVw
         2F/3QX/Vmq/xqxR2eJS3aKv4gWpLcwVFMv4w+68fv61V2cbhZld88WPeabaZlu0VjQ
         Sq8e3S3RZTXKSz+0+lzgx9N3TxV3Rw+QnjgwXqQo=
Date:   Mon, 8 Mar 2021 08:36:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     peter.chen@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com,
        sparmar@cadence.com
Subject: Re: [PATCH v2] usb: cdnsp: Fixes incorrect value in ISOC TRB
Message-ID: <YEXUErCmrgJp9+tw@kroah.com>
References: <20210308073103.33763-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308073103.33763-1-pawell@gli-login.cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 08:31:03AM +0100, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> Fixes issue with priority of operator. Operator "|" priority is
> higher then "? :".
> To improve the readability the operator "? :" has been replaced with
> "if ()" statement.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> 
> ---
> Changelog:
> v2:
> - changed the commit log
> - added separate "if" statement to improve readability
> 
>  drivers/usb/cdns3/cdnsp-ring.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
> index e15e13ba27dc..b23f09a68427 100644
> --- a/drivers/usb/cdns3/cdnsp-ring.c
> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> @@ -2198,7 +2198,10 @@ static int cdnsp_queue_isoc_tx(struct cdnsp_device *pdev,
>  	 * inverted in the first TDs isoc TRB.
>  	 */
>  	field = TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
> -		start_cycle ? 0 : 1 | TRB_SIA | TRB_TBC(burst_count);
> +		TRB_SIA | TRB_TBC(burst_count);
> +
> +	if (!start_cycle)
> +		field |= TRB_CYCLE;

Thank you for the change:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
