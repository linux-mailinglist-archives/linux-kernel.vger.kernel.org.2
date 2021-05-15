Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5739B3818AE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhEOMOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 08:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhEOMOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 08:14:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B89F613CD;
        Sat, 15 May 2021 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621080788;
        bh=U/JFt12QT7Iu0Rh/16tmtuAXXMhHHtt0jXL8aPw3sWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRBSMcIFy4RoiVCAZYbCY+eq2rhR8lp2tth/AZXWJOwatlwE922GRMdyz6Q/RlCsK
         KHd+xirP7nCIRXbz+T6eaAxEKse1U45oR1JI1EZ8/sLk5CZFC3rmRIZxubOncES5Km
         mThntS6Qw5g/P2b7cuCGwrIfHDj0ddTRoTCrUU1s=
Date:   Sat, 15 May 2021 14:13:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2] usb: xhci: Check the return value from
 sg_pcopy_from_buffer
Message-ID: <YJ+60n/xPCqH4BcI@kroah.com>
References: <20210515115715.314138-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210515115715.314138-1-chengzhihao1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 07:57:15PM +0800, Zhihao Cheng wrote:
> Fix the following gcc warning:
> 
> drivers/usb/host/xhci.c:1349:15: warning: variable ‘len’ set but not
> used [-Wunused-but-set-variable ]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  drivers/usb/host/xhci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index ca9385d22f68..08290698b939 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1361,11 +1361,15 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>  				 urb->transfer_buffer_length,
>  				 dir);
>  
> -	if (usb_urb_dir_in(urb))
> +	if (usb_urb_dir_in(urb)) {
>  		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
>  					   urb->transfer_buffer,
>  					   buf_len,
>  					   0);
> +		if (len != buf_len)
> +			xhci_warn(hcd_to_xhci(hcd), "WARN Wrong transfer buffer read length: %u != %u\n",
> +				  len, buf_len);

So you complain to the user and then don't do anything else?  that feels
very wrong, who is going to address the user complaints that this change
will cause?

greg k-h
