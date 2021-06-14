Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661A03A68A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhFNOGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:06:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3234 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbhFNOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:06:26 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3Xt040pMz6H7qR;
        Mon, 14 Jun 2021 21:51:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 14 Jun 2021 16:04:22 +0200
Received: from localhost (10.52.124.209) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 15:04:21 +0100
Date:   Mon, 14 Jun 2021 15:04:15 +0100
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
Subject: Re: [PATCH v4 07/16] firmware: arm_scmi: Add op to override max
 message #
Message-ID: <20210614150415.00005d92@Huawei.com>
In-Reply-To: <20210611165937.701-8-cristian.marussi@arm.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
        <20210611165937.701-8-cristian.marussi@arm.com>
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

On Fri, 11 Jun 2021 17:59:28 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> The number of simultaneously pending messages that the upcoming
> scmi-virtio transport can support depends on the virtio device (SCMI
> platform) and can differ for each channel. (The scmi-virtio transport
> does only have one tx and at most 1 rx channel.)
> 
> Add an optional transport op so that scmi-virtio can report the actual
> max message # for each channel type. Respect these new limits.
> 
> Reflect that the limit in struct scmi_desc is now only a default any
> more.
> 
> [ Peter: Adapted patch for submission to upstream. ]
> 
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Cristian,

Give you are sending this on to the list, should have your
Signed-off-by as well.

Jonathan
