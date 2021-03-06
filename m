Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8582132F760
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCFAyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:54:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhCFAxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:53:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE58A65052;
        Sat,  6 Mar 2021 00:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614992032;
        bh=CZURL3WwRKubZxQMNBHgM3FkfqGkDexN/FbrmIjSFTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hEFM2NWtm3cfamA4qZHzqDhtr1iSiZGrCKWkGpr2yWST1Yrx7ZDe/Xi8Ek1FS5tsF
         HCoHsHWYdJ5Pe2CmrE9mUeq6QkUzw/6rlocgNJUa1YyYOWKBfnZvTkvNHYGCoMkEd8
         54DttivboipCxLxdtCpQQCV0i9HCQMNeUwN2FCTj5RMvn3dSfGoNrzlw/Jn2Nn+9Mk
         hUilBou/aCOXemrxPushq3dE2GSI8hRln+4LaPpxXJTrFlN3VRwmwr/+4H7A/UUZwZ
         IfOA1OgU5Cyc87FWXIdqmID2Z7fjd4o065PvJB28pT0Lj4W7Q7IIPwruLbjDpZ2vFq
         cJrTHWZ9vlYxw==
Date:   Sat, 6 Mar 2021 08:53:42 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com,
        sparmar@cadence.com
Subject: Re: [PATCH] usb: cdnsp: Fixes incorrect value in ISOC TRB
Message-ID: <20210306005342.GA1119@b29397-desktop>
References: <20210305051059.31623-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305051059.31623-1-pawell@gli-login.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-05 06:10:59, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> The value "start_cycle ? 0 : 1" in assignment caused
> implicit truncation whole value to 1 byte.
> To fix the issue, an explicit casting has been added.

The root cause for this issue should be operator "|" priority higher
than "? :", I think just add () for start_cycle ? 0 : 1 could fix it.
Please double confirm it, and change the commit log if necessary

Peter
> 
> Fixes: commit 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/cdnsp-ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
> index f9170d177a89..d35bc4490216 100644
> --- a/drivers/usb/cdns3/cdnsp-ring.c
> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> @@ -2197,7 +2197,7 @@ static int cdnsp_queue_isoc_tx(struct cdnsp_device *pdev,
>  	 * inverted in the first TDs isoc TRB.
>  	 */
>  	field = TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
> -		start_cycle ? 0 : 1 | TRB_SIA | TRB_TBC(burst_count);
> +		(u32)(start_cycle ? 0 : 1) | TRB_SIA | TRB_TBC(burst_count);
>  
>  	/* Fill the rest of the TRB fields, and remaining normal TRBs. */
>  	for (i = 0; i < trbs_per_td; i++) {
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen

