Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61A936BF58
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhD0Ggv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 02:36:51 -0400
Received: from foss.arm.com ([217.140.110.172]:45702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232783AbhD0Ggu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:36:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C640431B;
        Mon, 26 Apr 2021 23:36:07 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E738F3F70D;
        Mon, 26 Apr 2021 23:36:06 -0700 (PDT)
Date:   Tue, 27 Apr 2021 07:36:04 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] firmware: arm_scmi: Remove repeated struct declaration
Message-ID: <20210427063604.GH43717@e120937-lin>
References: <20210427033031.4580-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427033031.4580-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 27, 2021 at 11:30:31AM +0800, Wan Jiabing wrote:
> struct scmi_protocol_handle is declared at 34th line.
> The declaration here is duplicate. Remove it.
> 

You're right.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/firmware/arm_scmi/notify.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
> index ce0324be6c71..4e9b627edfef 100644
> --- a/drivers/firmware/arm_scmi/notify.h
> +++ b/drivers/firmware/arm_scmi/notify.h
> @@ -79,8 +79,6 @@ struct scmi_protocol_events {
>  
>  int scmi_notification_init(struct scmi_handle *handle);
>  void scmi_notification_exit(struct scmi_handle *handle);
> -
> -struct scmi_protocol_handle;
>  int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
>  				  const struct scmi_protocol_handle *ph,
>  				  const struct scmi_protocol_events *ee);
> -- 
> 2.25.1
> 
