Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191FE35EBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhDNEJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhDNEIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:08:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC82F61154;
        Wed, 14 Apr 2021 04:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618373294;
        bh=Z+UFwSwbY5ODpHNEo1Xqlqvm4gPb50y3Q5DfZe0rBQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpk/NEetYX72BKqsyciatQVIc+LHjsR3P6Sf/Lpt9FmnBFLMt7miUWdYoOgDIx/k7
         8dWC5UDHAN4UjaIWPu3VTp8ikH4MkMyp3smEHvkIlLbeL615mvetSMU8Od3imYFdoI
         d5HJUZEi6YNU1h79dBhe/NEuWMZUKdmkniRW+lcdk3owjidbnjlN2cEq29ryz2rVtu
         C8OHLP69qIb7Jy/f3kDXwY56hbzuSDQPQmX9tq2CkZr3hR0I9feZ+igDJquKqkdSMn
         a4s6hTqHYBmb3CpDz0BkIWYjpXQ9m1LhRxj1druJrwTQGBTq1XWadxDUosTAgj5GN3
         hChOcujmL+Uhw==
Date:   Wed, 14 Apr 2021 09:38:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        pierre-louis.bossart@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH v2 2/3] soundwire: Intel: introduce DMI quirks for HP
 Spectre x360 Convertible
Message-ID: <YHZqqjUSJvYxhEw6@vkoul-mobl.Dlink>
References: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
 <20210302075105.11515-3-yung-chuan.liao@linux.intel.com>
 <de65866a-bb8f-f5c6-2829-42b561f282f7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de65866a-bb8f-f5c6-2829-42b561f282f7@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-04-21, 14:37, Dave Hansen wrote:
> On 3/1/21 11:51 PM, Bard Liao wrote:
> > +++ b/drivers/soundwire/dmi-quirks.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +// Copyright(c) 2021 Intel Corporation.
> 
> It looks like this is already in intel-next, so this may be moot.  But,
> is there a specific reason this is dual licensed?  If so, can you please
> include information about the license choice in the cover letter of any
> future version?

The soundwire module from Intel and core soundwire core was always dual
licensed, so it kind of followed that..

> If there is no specific reason for this contribution to be dual
> licensed, please make it GPL-2.0 only.

This module, I would say NO. Unless someone from Intel disagree..
Pierre/Bard..?

If all agree I dont see a reason why this cant be updated to GPL only.

Thanks
-- 
~Vinod
