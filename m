Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF3B415F01
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbhIWM7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:59:17 -0400
Received: from smtp179.sjtu.edu.cn ([202.120.2.179]:56340 "EHLO
        smtp179.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241163AbhIWM7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:59:15 -0400
Received: from mta04.sjtu.edu.cn (mta04.sjtu.edu.cn [202.121.179.8])
        by smtp179.sjtu.edu.cn (Postfix) with ESMTPS id D3D03100B0956;
        Thu, 23 Sep 2021 20:57:40 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mta04.sjtu.edu.cn (Postfix) with ESMTP id A6EFD185F5217;
        Thu, 23 Sep 2021 20:57:40 +0800 (CST)
X-Virus-Scanned: amavisd-new at mta04.sjtu.edu.cn
Received: from mta04.sjtu.edu.cn ([127.0.0.1])
        by localhost (mta04.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RQH_rqVoKD0b; Thu, 23 Sep 2021 20:57:40 +0800 (CST)
Received: from mstore105.sjtu.edu.cn (unknown [10.118.0.105])
        by mta04.sjtu.edu.cn (Postfix) with ESMTP id 4D72C1804EE54;
        Thu, 23 Sep 2021 20:57:40 +0800 (CST)
Date:   Thu, 23 Sep 2021 20:57:40 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     nsaenz@kernel.org, peterz@infradead.org, maz@kernel.org,
        bsegall@google.com, rdunlap@infradead.org, airlied@redhat.com,
        kan liang <kan.liang@linux.intel.com>, odin@uged.al,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <590112814.393656.1632401860257.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <YUwOZjr06RV2BUi6@kroah.com>
References: <20210923035554.669434-1-qtxuning1999@sjtu.edu.cn> <YUwOZjr06RV2BUi6@kroah.com>
Subject: Re: [PATCH] staging: vchip_arm: Fix misuse of %x
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.120.40.82]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - GC92 (Linux)/8.8.15_GA_3928)
Thread-Topic: staging: vchip_arm: Fix misuse of %x
Thread-Index: m/b7F6kEdO6ZCcPPUHN2BXNzlm0fqQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should restrict kernel pointer leakage issue by using kptr_restrict. 
Therefore kernel pointers should be specified by %pK rather than %lx.

Thanks.

Guo

----- Original Message -----
From: "Greg KH" <gregkh@linuxfoundation.org>
To: "Guo Zhi" <qtxuning1999@sjtu.edu.cn>
Cc: nsaenz@kernel.org, peterz@infradead.org, maz@kernel.org, bsegall@google.com, rdunlap@infradead.org, airlied@redhat.com, "kan liang" <kan.liang@linux.intel.com>, odin@uged.al, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, "linux-kernel" <linux-kernel@vger.kernel.org>
Sent: Thursday, September 23, 2021 1:19:34 PM
Subject: Re: [PATCH] staging: vchip_arm: Fix misuse of %x

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
