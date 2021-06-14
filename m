Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1D53A68BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhFNOMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:12:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3235 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbhFNOMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:12:46 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3Y5H5SsYz6G8p9;
        Mon, 14 Jun 2021 22:01:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 16:10:42 +0200
Received: from localhost (10.52.124.209) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 15:10:41 +0100
Date:   Mon, 14 Jun 2021 15:10:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <virtualization@lists.linux-foundation.org>,
        <virtio-dev@lists.oasis-open.org>, <sudeep.holla@arm.com>,
        <james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
        <etienne.carriere@linaro.org>, <vincent.guittot@linaro.org>,
        <souvik.chakravarty@arm.com>, <igor.skalkin@opensynergy.com>,
        <peter.hilber@opensynergy.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        <Vasyl.Vavrychuk@opensynergy.com>,
        <Andriy.Tryshnivskyy@opensynergy.com>
Subject: Re: [PATCH v4 12/16] firmware: arm_scmi: Add message passing
 abstractions for transports
Message-ID: <20210614151036.00000409@Huawei.com>
In-Reply-To: <20210611165937.701-13-cristian.marussi@arm.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
        <20210611165937.701-13-cristian.marussi@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.209]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 17:59:33 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> From: Peter Hilber <peter.hilber@opensynergy.com>
> 
> Add abstractions for future transports using message passing, such as
> virtio. Derive the abstractions from the shared memory abstractions.
> 
> Abstract the transport SDU through the opaque struct scmi_msg_payld.
> Also enable the transport to determine all other required information
> about the transport SDU.
> 
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> ---
...
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index b783ae058c8a..fa4075336580 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -410,6 +410,21 @@ void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
>  bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
>  		     struct scmi_xfer *xfer);
>  
> +/* declarations for message passing transports */
> +struct scmi_msg_payld;
> +
> +/** Maximum overhead of message w.r.t. struct scmi_desc.max_msg_size */

Doesn't look to be kernel-doc..

> +#define SCMI_MSG_MAX_PROT_OVERHEAD (2 * sizeof(__le32))
