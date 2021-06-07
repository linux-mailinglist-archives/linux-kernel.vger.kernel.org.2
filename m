Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A93939E59F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhFGRkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:40:23 -0400
Received: from foss.arm.com ([217.140.110.172]:38864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229997AbhFGRkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:40:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D16112FC;
        Mon,  7 Jun 2021 10:38:30 -0700 (PDT)
Received: from bogus (unknown [10.57.73.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B1493F73D;
        Mon,  7 Jun 2021 10:38:28 -0700 (PDT)
Date:   Mon, 7 Jun 2021 18:38:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [RFC PATCH 01/10] firmware: arm_scmi: Reset properly xfer SCMI
 status
Message-ID: <20210607173809.et6fzayvubsosvso@bogus>
References: <20210606221232.33768-1-cristian.marussi@arm.com>
 <20210606221232.33768-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606221232.33768-2-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 11:12:23PM +0100, Cristian Marussi wrote:
> When an SCMI command transfer fails due to some protocol issue an SCMI
> error code is reported inside the SCMI message payload itself and it is
> then retrieved and transcribed by the specific transport layer into the
> xfer.hdr.status field by transport specific .fetch_response().
> 
> The core SCMI transport layer never explicitly reset xfer.hdr.status,
> so when an xfer is reused, if a transport misbehaved in handling such
> status field, we risk to see an invalid ghost error code.
> 
> Reset xfer.hdr.status to SCMI_SUCCESS right before each transfer is
> started.
>

Any particular reason why it can't be part of xfer_get_init which has other
initialisations ? If none, please move it there.

-- 
Regards,
Sudeep
