Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D947357636
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhDGUk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:32990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhDGUkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:40:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3E07611EE;
        Wed,  7 Apr 2021 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617828009;
        bh=qer9V+6v8rne4ZWhl7n/GA+WMUBQCoqRMmjY3g2/a/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOuCQSEQWoW2aOIcFrJjEVivxOEqXekovzlpo8fOfRfIfUbzBb0170auUzEMA7P/H
         WuheI6aFP+YZ95iu0hpU+7AtxyBVPB1/5Wd8QJVgwHQT0WURF9Bn6IRNgEcWdyc2qQ
         fY217KuJyS9PuipqNMdImSeV8uV1upfXn+cvYjBKmdmSaeoDaU4OnNmc2SBr4yxiaZ
         6g3XFVQBRdI00HWwuhXq6VhgOwiL31s5zHVhMRTl7rECOE6rJwacnJTeoYarzabSXA
         WN4Us9zNPC8tVRAZpP1uRVNRp8NZEQHUDUzi5sU29rnoticph3+xg/kUBg1hoxA5tt
         NFBLdiKwyWb6Q==
Date:   Wed, 7 Apr 2021 21:40:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     mark.rutland@arm.com, zhangshaokun@hisilicon.com,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers/perf: hisi: Add driver for HiSilicon PCIe PMU
Message-ID: <20210407204004.GB16011@willie-the-truck>
References: <1617788943-52722-1-git-send-email-liuqi115@huawei.com>
 <1617788943-52722-2-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617788943-52722-2-git-send-email-liuqi115@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 05:49:02PM +0800, Qi Liu wrote:
> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
> to sample bandwidth, latency, buffer occupation etc.
> 
> Each PMU RCiEP device monitors multiple root ports, and each RCiEP is
> registered as a pmu in /sys/bus/event_source/devices, so users can
> select target PMU, and use filter to do further sets.
> 
> Filtering options contains:
> event        - select the event.
> subevent     - select the subevent.
> port         - select target root ports. Information of root ports
>                are shown under sysfs.
> bdf           - select requester_id of target EP device.
> trig_len     - set trigger condition for starting event statistics.
> trigger_mode - set trigger mode. 0 means starting to statistic when
>                bigger than trigger condition, and 1 means smaller.
> thr_len      - set threshold for statistics.
> thr_mode     - set threshold mode. 0 means count when bigger than
>                threshold, and 1 means smaller.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Do you have a link to this review, please?

Will
