Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B568841135E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhITLLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:11:24 -0400
Received: from foss.arm.com ([217.140.110.172]:45930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhITLLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:11:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2914511B3;
        Mon, 20 Sep 2021 04:09:57 -0700 (PDT)
Received: from bogus (unknown [10.57.23.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7AEA3F719;
        Mon, 20 Sep 2021 04:09:52 -0700 (PDT)
Date:   Mon, 20 Sep 2021 12:09:34 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        peter.hilber@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Tryshnivskyy@opensynergy.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] firmware: arm_scmi: Add proper barriers to scmi
 virtio device
Message-ID: <20210920110934.aloikpcc6uawouou@bogus>
References: <20210916103336.7243-1-cristian.marussi@arm.com>
 <20210916103336.7243-3-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916103336.7243-3-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Thu, Sep 16, 2021 at 11:33:36AM +0100, Cristian Marussi wrote:
> Only one single SCMI Virtio device is currently supported by this driver
> and it is referenced using a static global variable which is initialized
> once for all during probing and nullified at virtio device removal.
> 
> Add proper SMP barriers to protect accesses to such device reference to
> ensure that the initialzation state of such device is correctly observed by
> all PEs at any time.
> 
> Return -EBUSY, instead of -EINVAL, and a descriptive error message if more
> than one SCMI Virtio device is ever found and probed.
> 

I was thinking of applying this patch and probably 2/3 as fix for v5.15.
Let me know if you have any objections.

--
Regards,
Sudeep
