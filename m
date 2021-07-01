Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B53B907F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 12:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhGAKaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 06:30:04 -0400
Received: from foss.arm.com ([217.140.110.172]:50760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhGAKaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 06:30:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95317D6E;
        Thu,  1 Jul 2021 03:27:31 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FD073F718;
        Thu,  1 Jul 2021 03:27:28 -0700 (PDT)
Date:   Thu, 1 Jul 2021 11:27:25 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v4 06/16] firmware: arm_scmi, smccc, mailbox: Make shmem
 based transports optional
Message-ID: <20210701102725.GC17807@e120937-lin>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-7-cristian.marussi@arm.com>
 <039f1a64-b4b6-5274-1fff-253f1dd6eac8@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039f1a64-b4b6-5274-1fff-253f1dd6eac8@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 01, 2021 at 10:42:56AM +0200, Peter Hilber wrote:
> On 11.06.21 18:59, Cristian Marussi wrote:
> > From: Igor Skalkin <igor.skalkin@opensynergy.com>
> > 
> > Upon adding the virtio transport in this patch series, SCMI will also
> > work without shared memory based transports. Also, the mailbox transport
> > may not be needed if the smc transport is used.
> > 
> > - Compile shmem.c only if a shmem based transport is available.
> > 
> > - Remove hard dependency of SCMI on mailbox.
> 
> The hard dependency has now already been removed with
> 
>   c05b07963e96 ("firmware: arm_scmi: Add SMCCC discovery dependency in")
> 

I deeply reviewed transport Kconfig approach in V5 in general, making
all transport configurable (y/n), so this patch will be adapted to the new
Kconfig layout annd basically just provide the HAVE_SHMEM feature.

Thanks,
Cristian
