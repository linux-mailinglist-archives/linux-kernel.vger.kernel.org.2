Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5525B3F77A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbhHYOrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:47:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40114 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhHYOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:47:51 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17PEkv8l092082;
        Wed, 25 Aug 2021 09:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629902817;
        bh=nwh02xipkI1jnIdUSjsZH9g82cOygoChw7cSdHLzyPM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=B3RJA1MFn55XH7ReR6dXKojzYFg0/e6BkrUx8NNrdxYSxPMIZ8L9KG9GLJo1nQ0EK
         M+GGg24XtTm+1zcmJ6kVJFN2GjWcHIByyE0O+v0Kw8cJxTcfptF1qCWvuFKlMNDARH
         pfsuS+f57rb3cO/fyDkX8mRZ/735ydgW+ha5ue5E=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17PEkvuD068190
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Aug 2021 09:46:57 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 25
 Aug 2021 09:46:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 25 Aug 2021 09:46:57 -0500
Received: from [10.250.232.42] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17PEkrwO010426;
        Wed, 25 Aug 2021 09:46:54 -0500
Subject: Re: [PATCH 3/3] xhci: Set HCD flag to defer primary roothub
 registration
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, <lokeshvutla@ti.com>
References: <20210825105132.10420-1-kishon@ti.com>
 <20210825105132.10420-4-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e16a6657-5fa3-52cb-e5ea-710c77e457d8@ti.com>
Date:   Wed, 25 Aug 2021 20:16:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825105132.10420-4-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/08/21 4:21 pm, Kishon Vijay Abraham I wrote:
> Set "HCD_FLAG_DEFER_PRI_RH_REGISTER" to hcd->flags in xhci_run() to defer
> registering primary roothub in usb_add_hcd(). This will make sure both
> primary roothub and secondary roothub will be registered along with the
> second HCD. This is required for cold plugged USB devices to be detected
> in certain PCIe USB cards (like Inateck USB card connected to AM64 EVM
> or J7200 EVM).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
>  drivers/usb/host/xhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 3618070eba78..9b7d968022c8 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -644,7 +644,6 @@ int xhci_run(struct usb_hcd *hcd)
>  	/* Start the xHCI host controller running only after the USB 2.0 roothub
>  	 * is setup.
>  	 */
> -

I just realized I've left a spurious space here. While fixing Alan's
comment, I'll fix this one.

Regards,
Kishon
>  	hcd->uses_new_polling = 1;
>  	if (!usb_hcd_is_primary_hcd(hcd))
>  		return xhci_run_finished(xhci);
> @@ -692,6 +691,7 @@ int xhci_run(struct usb_hcd *hcd)
>  		if (ret)
>  			xhci_free_command(xhci, command);
>  	}
> +	set_bit(HCD_FLAG_DEFER_PRI_RH_REGISTER, &hcd->flags);
>  	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>  			"Finished xhci_run for USB2 roothub");
>  
> 
