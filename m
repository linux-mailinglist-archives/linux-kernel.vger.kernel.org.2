Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC7423BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 12:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbhJFLBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:01:32 -0400
Received: from foss.arm.com ([217.140.110.172]:53524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhJFLBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:01:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C7471FB;
        Wed,  6 Oct 2021 03:59:39 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D4C663F70D;
        Wed,  6 Oct 2021 03:59:36 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, alex.bennee@linaro.org,
        jean-philippe@linaro.org, vincent.guittot@linaro.org,
        Jonathan.Cameron@Huawei.com, anton.yakovlev@opensynergy.com,
        f.fainelli@gmail.com, mikhail.golubev@opensynergy.com,
        igor.skalkin@opensynergy.com, etienne.carriere@linaro.org,
        Tryshnivskyy@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>, james.quinlan@broadcom.com,
        peter.hilber@opensynergy.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH 1/3] firmware: arm_scmi: Review some virtio log messages
Date:   Wed,  6 Oct 2021 11:59:24 +0100
Message-Id: <163351790165.4059368.3232543340076499229.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916103336.7243-1-cristian.marussi@arm.com>
References: <20210916103336.7243-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 11:33:34 +0100, Cristian Marussi wrote:
> Be more verbose avoiding to use _once flavour of dev_info/_err/_notice.
> Remove usage of __func_ to identify which vqueue is referred in some error
> messages and explicitly name the TX/RX vqueue.
> 
> 

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/3] firmware: arm_scmi: Review some virtio log messages
      https://git.kernel.org/sudeep.holla/c/0830e033c0

This one for v5.16

[2/3] firmware: arm_scmi: Simplify spinlocks in virtio transport
      https://git.kernel.org/sudeep.holla/c/a14a14595d
[3/3] firmware: arm_scmi: Add proper barriers to scmi virtio device
      https://git.kernel.org/sudeep.holla/c/bf1acf809d

These 2 as fixes potentially for v5.15

--
Regards,
Sudeep

