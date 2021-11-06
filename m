Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71499446BC5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 02:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhKFB2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 21:28:07 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:20570 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233096AbhKFB2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 21:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636161925; x=1667697925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sglaOwUzHlzlCzVky4H9HY7VZv0OsVdHPN/wDLDLv40=;
  b=AtSxkRCwxD0BF/jeo1kHoPhihRNS0Hiipzqi7p4Hx6YUoeVl/vQzWnku
   1F7jHB4Qon8Ukmd7RyaRFAzCAhYbazCxz3fFYJznFHpzoMFfIlcJOxFtI
   P2aGwYI3bNuv2X42UIBo/iDwAguFyXkL0FEmuI6kgNhx2TkY/uii4RblL
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Nov 2021 18:25:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 18:25:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 18:25:24 -0700
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 18:25:23 -0700
Date:   Fri, 5 Nov 2021 18:25:17 -0700
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Albert Wang <albertccwang@google.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <badhri@google.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix null pointer exception
Message-ID: <20211106012513.GA19852@jackp-linux.qualcomm.com>
References: <20211104062616.948353-1-albertccwang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211104062616.948353-1-albertccwang@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:26:16PM +0800, Albert Wang wrote:
> In the endpoint interrupt functions
> dwc3_gadget_endpoint_transfer_in_progress() and
> dwc3_gadget_endpoint_trbs_complete() will dereference the endpoint
> descriptor. But it could be cleared in __dwc3_gadget_ep_disable()
> when accessory disconnected. So we need to check whether it is null
> or not before dereferencing it.
> 
> Signed-off-by: Albert Wang <albertccwang@google.com>

Nice catch.  I think this might have been caused when the call to
dwc3_remove_requests() in __dwc3_gadget_ep_disable() was moved after
the endpoint descriptors is cleared.  So you can probably add:

Fixes: f09ddcfcb8c5 ("usb: dwc3: gadget: Prevent EP queuing while
stopping transfers").

Reviewed-by: Jack Pham <quic_jackp@quicinc.com>

> ---
>  drivers/usb/dwc3/gadget.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 23de2a5a40d6..83c7344888fd 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -3252,6 +3252,9 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
>  	struct dwc3		*dwc = dep->dwc;
>  	bool			no_started_trb = true;
>  
> +	if (!dep->endpoint.desc)
> +		return no_started_trb;
> +
>  	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
>  
>  	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
> @@ -3299,6 +3302,9 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
>  {
>  	int status = 0;
>  
> +	if (!dep->endpoint.desc)
> +		return;
> +
>  	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
>  		dwc3_gadget_endpoint_frame_from_event(dep, event);
>  
> -- 
> 2.33.1.1089.g2158813163f-goog
> 
