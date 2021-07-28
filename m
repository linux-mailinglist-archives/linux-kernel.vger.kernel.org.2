Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E8E3D923A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbhG1PiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:38:13 -0400
Received: from foss.arm.com ([217.140.110.172]:58884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhG1PiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:38:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A5B61FB;
        Wed, 28 Jul 2021 08:38:08 -0700 (PDT)
Received: from bogus (unknown [10.57.37.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F1C83F70D;
        Wed, 28 Jul 2021 08:38:04 -0700 (PDT)
Date:   Wed, 28 Jul 2021 16:36:47 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        peter.hilber@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v6 15/17] firmware: arm_scmi: Add optional
 link_supplier() transport op
Message-ID: <20210728153647.llr6bfhyja5ezkth@bogus>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-16-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712141833.6628-16-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 03:18:31PM +0100, Cristian Marussi wrote:
> From: Peter Hilber <peter.hilber@opensynergy.com>
> 
> Some transports are also effectively registered with other kernel subsystem
> in order to be properly probed and initialized; as a consequence such kind
> of transports, and their related devices, might still not have been probed
> and initialized at the time the main SCMI core driver is probed.
> 
> Add an optional .link_supplier() transport operation which can be used by
> the core SCMI stack to dynamically check if the transport is ready and
> dynamically link its device to the platform instance device.
>

To be precise,

s/platform instance device/SCMI platform instance device

-- 
Regards,
Sudeep
