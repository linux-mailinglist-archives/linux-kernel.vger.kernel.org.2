Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BCE3DA8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhG2QT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:19:28 -0400
Received: from foss.arm.com ([217.140.110.172]:52102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhG2QT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:19:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49A191FB;
        Thu, 29 Jul 2021 09:19:24 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 727793F73D;
        Thu, 29 Jul 2021 09:19:21 -0700 (PDT)
Date:   Thu, 29 Jul 2021 17:19:18 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        peter.hilber@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v6 15/17] firmware: arm_scmi: Add optional
 link_supplier() transport op
Message-ID: <20210729161918.GO6592@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-16-cristian.marussi@arm.com>
 <20210728153647.llr6bfhyja5ezkth@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728153647.llr6bfhyja5ezkth@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 04:36:47PM +0100, Sudeep Holla wrote:
> On Mon, Jul 12, 2021 at 03:18:31PM +0100, Cristian Marussi wrote:
> > From: Peter Hilber <peter.hilber@opensynergy.com>
> > 
> > Some transports are also effectively registered with other kernel subsystem
> > in order to be properly probed and initialized; as a consequence such kind
> > of transports, and their related devices, might still not have been probed
> > and initialized at the time the main SCMI core driver is probed.
> > 
> > Add an optional .link_supplier() transport operation which can be used by
> > the core SCMI stack to dynamically check if the transport is ready and
> > dynamically link its device to the platform instance device.
> >
> 
> To be precise,
> 
> s/platform instance device/SCMI platform instance device

Yes I'll fix.

Thanks,
Cristian

