Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE33C3457C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhCWGZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:25:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41545 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhCWGZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:25:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616480753; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=xAtJAW22wshljF0u7U/N/2tn/kZSmDX0sMzuBmxR0jk=; b=Pnx4tOlHgNxrPwDB+HppQrzxzyN1J0ftYugxLD8COK9ueMRWR486oYo0IRNRk3ZJIQB9uu4u
 peh22xDIIhd89gL3rp4jC+U2ZMx9JGa/yS+UmKAlcIJ3L2wGDeQMxu2wZNdGO3MaBqHsnCt3
 CAf9LzG8kGRuWyVLgAyJBHvofVA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 605989ed5d70193f887c25cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Mar 2021 06:25:49
 GMT
Sender: jackp=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7A62C43461; Tue, 23 Mar 2021 06:25:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jackp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0002C433CA;
        Tue, 23 Mar 2021 06:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0002C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jackp@codeaurora.org
Date:   Mon, 22 Mar 2021 23:25:42 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
Subject: Re: [PATCH] usb: gadget: Stall OS descriptor request for unsupported
 functions
Message-ID: <20210323062542.GA17922@jackp-linux.qualcomm.com>
References: <1616464217-2650-1-git-send-email-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616464217-2650-1-git-send-email-wcheng@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wesley,

On Mon, Mar 22, 2021 at 06:50:17PM -0700, Wesley Cheng wrote:
> From: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
> 
> Hosts which request "OS descriptors" from gadgets do so during
> the enumeration phase and before the configuration is set with
> SET_CONFIGURATION. Composite driver supports OS descriptor
> handling in composite_setup function. This requires to pass
> signature field, vendor code, compatibleID and subCompatibleID
> from user space.
> 
> For USB compositions that contain functions which don't implement os
> descriptors, Windows is sending vendor specific requests for os
> descriptors and composite driver handling this request with invalid
> data. With this invalid info host resetting the bus and never
> selecting the configuration and leading enumeration issue.
> 
> Fix this by bailing out from the OS descriptor setup request
> handling if the functions does not have OS descriptors compatibleID.
> 
> Signed-off-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  drivers/usb/gadget/composite.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 72a9797..473edda6 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -1945,6 +1945,12 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>  				buf[6] = w_index;
>  				/* Number of ext compat interfaces */
>  				count = count_ext_compat(os_desc_cfg);
> +				/*
> +				 * Bailout if device does not
> +				 * have ext_compat interfaces.
> +				 */
> +				if (count == 0)
> +					break;
>  				buf[8] = count;
>  				count *= 24; /* 24 B/ext compat desc */
>  				count += 16; /* header */

Do we still need this fix? IIRC we had this change in our downstream
kernel to fix the case when dynamically re-configuring ConfigFS, i.e.
changing the composition of functions wherein none of the interfaces
support OS Descriptors, so this causes count_ext_compat() to return
0 and results in the issue described in $SUBJECT.

But I think this is more of a problem of an improperly configured
ConfigFS gadget. If userspace instead removes the config from the
gadget's os_desc subdirectory that should cause cdev->os_desc_config to
be set to NULL and hence composite_setup() should never enter this
handling at all, right?

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
