Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558F33A95AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhFPJPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:15:42 -0400
Received: from foss.arm.com ([217.140.110.172]:59694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232148AbhFPJPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:15:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2386731B;
        Wed, 16 Jun 2021 02:13:35 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EA963F70D;
        Wed, 16 Jun 2021 02:13:31 -0700 (PDT)
Date:   Wed, 16 Jun 2021 10:13:28 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        peter.hilber@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v4 07/16] firmware: arm_scmi: Add op to override max
 message #
Message-ID: <20210616091328.GE35368@e120937-lin>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-8-cristian.marussi@arm.com>
 <20210614150415.00005d92@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614150415.00005d92@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 03:04:15PM +0100, Jonathan Cameron wrote:
> On Fri, 11 Jun 2021 17:59:28 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > From: Igor Skalkin <igor.skalkin@opensynergy.com>
> > 
> > The number of simultaneously pending messages that the upcoming
> > scmi-virtio transport can support depends on the virtio device (SCMI
> > platform) and can differ for each channel. (The scmi-virtio transport
> > does only have one tx and at most 1 rx channel.)
> > 
> > Add an optional transport op so that scmi-virtio can report the actual
> > max message # for each channel type. Respect these new limits.
> > 
> > Reflect that the limit in struct scmi_desc is now only a default any
> > more.
> > 
> > [ Peter: Adapted patch for submission to upstream. ]
> > 
> > Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> > Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> > Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> Cristian,
> 
> Give you are sending this on to the list, should have your
> Signed-off-by as well.
> 

Right, sorry for this, the series is still sort of WIP so I have not
properly cleanup and signed these if I have not touched it.
My bad, I'll fix.

Thanks,
Cristian
