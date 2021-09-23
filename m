Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6465B4157CF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 07:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbhIWFVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 01:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhIWFVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 01:21:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75A3661131;
        Thu, 23 Sep 2021 05:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632374402;
        bh=8QhBmcAYkwKnbZALoCVXITIZbxDQBwHjZfWw0diAJpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pShjpiwWB2yGoGkYnKVMCWHAM/f+8nnvcClkQsXaEqgczdjNgsECtaFu02hJ6Uz2B
         C/1/vwql0cdS0U5pC+K71M7IGtbTkcfqOM0/5Ae1sjxhoaeduEYMzHQBmDLVMOpz7p
         IiPsyGrZ+97jMcg7Or7xt+ilcDwfRD205nRAjUoM=
Date:   Thu, 23 Sep 2021 07:19:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     nsaenz@kernel.org, peterz@infradead.org, maz@kernel.org,
        bsegall@google.com, rdunlap@infradead.org, airlied@redhat.com,
        kan.liang@linux.intel.com, odin@uged.al,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchip_arm: Fix misuse of %x
Message-ID: <YUwOZjr06RV2BUi6@kroah.com>
References: <20210923035554.669434-1-qtxuning1999@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923035554.669434-1-qtxuning1999@sjtu.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 11:55:54AM +0800, Guo Zhi wrote:
> Pointers should be printed with %p or %px rather than
> cast to (unsigned long) and printed with %lx.
> Change %lx to %pK to print the pointers.
> 
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index b5aac862a29..408e5fe710b 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -591,11 +591,11 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
>  		return VCHIQ_SUCCESS;
>  
>  	vchiq_log_trace(vchiq_arm_log_level,
> -		"%s - service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
> -		__func__, (unsigned long)user_service,
> +		"%s - service %pK(%d,%p), reason %d, header %pK, instance %pK, bulk_userdata %pK",
> +		__func__, user_service,
>  		service->localport, user_service->userdata,
> -		reason, (unsigned long)header,
> -		(unsigned long)instance, (unsigned long)bulk_userdata);
> +		reason, header,
> +		instance, bulk_userdata);

Why print this out at all?  What uses this?  Can it just be deleted?

thanks,

greg k-h
