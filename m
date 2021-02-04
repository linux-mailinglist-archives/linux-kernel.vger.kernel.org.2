Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AF930F2A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhBDLoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:44:21 -0500
Received: from foss.arm.com ([217.140.110.172]:56810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235831AbhBDLoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:44:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F02B11FB;
        Thu,  4 Feb 2021 03:43:26 -0800 (PST)
Received: from bogus (unknown [10.57.46.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 876F63F73B;
        Thu,  4 Feb 2021 03:43:24 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:43:18 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v6 13/37] cpufreq: scmi: port driver to the new
 scmi_perf_proto_ops interface
Message-ID: <20210204114318.eedlr3uqirixc7il@bogus>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-14-cristian.marussi@arm.com>
 <20210203030345.7lwcafpginkkcgik@vireshk-i7>
 <20210203121035.GD8355@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203121035.GD8355@e120937-lin>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 12:10:35PM +0000, Cristian Marussi wrote:
> Hi Viresh
>
>
> On Wed, Feb 03, 2021 at 08:33:45AM +0530, Viresh Kumar wrote:
> > On 02-02-21, 22:15, Cristian Marussi wrote:
> > > Port driver to the new SCMI Perf interface based on protocol handles
> > > and common devm_get_ops().
> > >
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > > v4 --> v5
> > > - using renamed devm_get/put_protocol
> >
> > Can this go through the PM tree ?
> >

Just to be clear, this is targeted for v5.13 not v5.12 in case you are
worried about some conflicts.

>
> It's part of a long series changing internal and external SCMI
> interfaces, series including a bit of per-protocol transient code added
> and removed around this patch to maintain bisectability along the way...
>
> ...I'd not recommend split this patch out and committ it out of the series,
> if this is what you meant.
>
> Anyway up to Sudeep really.
>

I prefer to get the entire series merged at once too. We can see if there
are any conflicts once I start merging them more v5.12-rc1 or later.

--
Regards,
Sudeep
