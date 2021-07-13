Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2E03C712C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhGMNaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:30:07 -0400
Received: from foss.arm.com ([217.140.110.172]:43432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236222AbhGMNaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:30:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A9B31FB;
        Tue, 13 Jul 2021 06:27:16 -0700 (PDT)
Received: from bogus (unknown [10.57.79.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC7F03F694;
        Tue, 13 Jul 2021 06:27:14 -0700 (PDT)
Date:   Tue, 13 Jul 2021 14:26:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, james.morse@arm.com
Subject: Re: [PATCH] cacheinfo: clear cache_leaves(cpu) in
 free_cache_attributes()
Message-ID: <20210713132612.gvx7xpdp3tjcmxxu@bogus>
References: <1626148058-55230-1-git-send-email-wangxiongfeng2@huawei.com>
 <20210713113315.thsvrvqvqptc7hje@bogus>
 <303cd2bf-7142-6ec9-548a-afe7f6e5ca8f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <303cd2bf-7142-6ec9-548a-afe7f6e5ca8f@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 08:46:19PM +0800, Xiongfeng Wang wrote:
> Hi Sudeep,
>
> On 2021/7/13 19:33, Sudeep Holla wrote:
> > On Tue, Jul 13, 2021 at 11:47:38AM +0800, Xiongfeng Wang wrote:
> >> On ARM64, when PPTT(Processor Properties Topology Table) is not
> >> implemented in ACPI boot, we will goto 'free_ci' with the following
> >> print:
> >>   Unable to detect cache hierarchy for CPU 0
> >>
> >
> > The change itself looks good and I am fine with that. However,...
> >
> >> But some other codes may still use 'num_leaves' to iterate through the
> >
> > Can you point me exactly where it is used to make sure there are no
> > other issues associated with that.
> >
> >> 'info_list', such as get_cpu_cacheinfo_id(). If 'info_list' is NULL , it
> >> would crash. So clear 'num_leaves' in free_cache_attributes().
> >>
> >
> > And can you provide the crash dump please ? If we are not hitting any
> > issue and you just figured this with code inspection, that is fine. It
> > helps to determine if this needs to be backport or just good to have
> > clean up.
>
> There is no issue in the mainline kernel. get_cpu_cacheinfo_id() is only called
> on x86. I didn't hit any issue using the mainline kernel.
>

Thanks for confirming.

> Actually, it's our own code that crashed. My colleague Shaobo(CCed) tried to add
> MPAM support on ARM64. His code called get_cpu_cacheinfo_id() and crashed when
> PPTT is not implemented. Maybe he should check whether PPTT is implemented
> before calling get_cpu_cacheinfo_id(), but we think it is also better to clear
> cache_leaves(cpu) in free_cache_attributes().
> Sorry for not clearly expressed.
>

Thanks for detailed explanation. In this case I would drop the Fixes: tag
as it is not fixing anything in the commit mentioned in the tag.

Also not sure if we can tag this as fixes
709c4362725a ("cacheinfo: Move resctrl's get_cache_id() to the cacheinfo header file")
as that is introducing the possible access that could crash. @James ?

Anyways, irrespective of whether you add above tag, feel free to add
once to drop the original fixes tag in the patch.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
