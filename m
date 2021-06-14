Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607043A68A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhFNOF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:05:58 -0400
Received: from foss.arm.com ([217.140.110.172]:36916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233293AbhFNOF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:05:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7549B1FB;
        Mon, 14 Jun 2021 07:03:53 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 855953F70D;
        Mon, 14 Jun 2021 07:03:50 -0700 (PDT)
Date:   Mon, 14 Jun 2021 15:03:47 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v4 00/16] Introduce SCMI VirtIO transport
Message-ID: <20210614140347.GB35368@e120937-lin>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <YMdA+GkgJ+GONuJr@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMdA+GkgJ+GONuJr@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Jun 14, 2021 at 12:43:52PM +0100, Christoph Hellwig wrote:
> On Fri, Jun 11, 2021 at 05:59:21PM +0100, Cristian Marussi wrote:
> > Hi all,
> > 
> > I'm posting this V4 series starting from the work done up to V3 by
> > OpenSynergy.
> 
> Who is 'OpenSynergy'?
> 
> > The main aim of this rework is to simplify where possible the SCMI VirtIO
> > support added in V3 by adding upfront and then using some new mechanisms in
> > the SCMI Core Transport layer.
> 
> And what is 'SCMI', and why would anyone want a new virtio transport?

I'll start answering this last question first : SCMI stands for System Control
and Management Interface whose latest specification can be found at:

https://developer.arm.com/documentation/den0056/latest

The spec aims to provide a common way to handle power & performance related
needs by standardizing a set of protocols (clocks, power domains, sensors,
voltages, resets, etc..) to enable an SCMI agent (Kernel) to talk to an
external System Control Processor entity which acts as an SCMI Platform and
satisfies (or denies) such requests in a centralized manner for the Kernel
and any other SCMI agent present on system.

Such SCMI stack can be indeed deployed in a variety of way depending on
where the SCP running the SCMI Platofrm if physically situated: an
external microntroller ? part of the EL-3 Platform firmware ? some
functionality embedded in an Hypervisor ? a guest acting as an SCP ?

Support for SCMI is already in mainline as of today under:

	drivers/firmware/arm_scmi

But the currently existing transport mechanisms through which the SCMI agent
and the platform talks are based on mailboxes or SMCs.

In case the SCMI Stack is deployed in a virtualized environment we need
some sort of SCMI transport that runs on VirtIO to establish comms
between the VMs.

OpenSynergy is an ARM partner who has deployed a virtualized SCMI stack
in their own product and developed this series up to V3, taking care
also the proposed related VirtIO spec changes:

https://lists.oasis-open.org/archives/virtio-comment/202102/msg00018.html

Such proposed VirtIO changes expose a new VirtiIO SCMI Device that represents
the SCMI platform running the SCMI Server fw which answers the SCMI Kernel
Agent requests.

Similar approaches with virtualized SCMI stacks are being developed by
Linaro and other partners as far as I know.

I picked up this series from V4 since it was apparent that some changes were
needed in the core SCMI stack to better integrate this new VirtIO transport
that OpenSynergy developed up to V3.

Hope to have been clear and concise (not really :D) enough.

Thanks,
Cristian
