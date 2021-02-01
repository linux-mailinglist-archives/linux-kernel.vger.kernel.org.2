Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52FC30A595
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhBAKkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233145AbhBAKjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:39:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB44764E99;
        Mon,  1 Feb 2021 10:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612175910;
        bh=lm8X3GKu5SNKtsEnd0SUr/ObfF/s25EHiET6S6n5UPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Io9CRcs1XTSHUs4iCAvpc1B+xzVJ51g6YR6dzwx+I8F+/x2b+Miyv827+4EL2L9Ws
         +2bFTFGb0dZtOiQntx7Oy4S+p3jB7kFhK8IwJ1V9kwzHMK9mMMBqWIBLSekFdf0C2b
         XamtswYRtfj5r8F6msySeEPMkEa5AiC3cHx3OBf+mqtoH97H870oUbOSIMT3E5vz+1
         uRwKt5KoBjdIlTR9A4isxHSOt5XrRFdXBOxUZteNps47G/ig/As8Jotbev0OdNfgPX
         n384mImWXy3GfJIT/BZpyKdaKySTda/M89/ztLeuemzGX4wyvg5wwTV7s/jbvASEb/
         gFyuFJORF1E+w==
Date:   Mon, 1 Feb 2021 16:08:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 1/3] soundwire: bus: clear bus clash interrupt before the
 mask is enabled
Message-ID: <20210201103825.GV2771@vkoul-mobl>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-2-yung-chuan.liao@linux.intel.com>
 <20210201102844.GU2771@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201102844.GU2771@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-02-21, 15:58, Vinod Koul wrote:
> On 26-01-21, 16:37, Bard Liao wrote:

> >  struct sdw_master_prop {
> >  	u32 revision;
> > @@ -421,8 +422,11 @@ struct sdw_master_prop {
> >  	u32 err_threshold;
> >  	u32 mclk_freq;
> >  	bool hw_disabled;
> > +	u32 quirks;
> 
> Can we do u64 here please.. I dont know where we would end up.. but
> would hate if we start running out of space ..

Also, is the sdw_master_prop right place for a 'quirk' property. I think
we can use sdw_master_device or sdw_bus as this seems like a bus
quirk..?

--
~Vinod
