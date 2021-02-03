Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633A530D98E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhBCMLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:11:32 -0500
Received: from foss.arm.com ([217.140.110.172]:38880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234187AbhBCML3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:11:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03FDED6E;
        Wed,  3 Feb 2021 04:10:44 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCB483F73B;
        Wed,  3 Feb 2021 04:10:41 -0800 (PST)
Date:   Wed, 3 Feb 2021 12:10:35 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v6 13/37] cpufreq: scmi: port driver to the new
 scmi_perf_proto_ops interface
Message-ID: <20210203121035.GD8355@e120937-lin>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-14-cristian.marussi@arm.com>
 <20210203030345.7lwcafpginkkcgik@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203030345.7lwcafpginkkcgik@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh


On Wed, Feb 03, 2021 at 08:33:45AM +0530, Viresh Kumar wrote:
> On 02-02-21, 22:15, Cristian Marussi wrote:
> > Port driver to the new SCMI Perf interface based on protocol handles
> > and common devm_get_ops().
> > 
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v4 --> v5
> > - using renamed devm_get/put_protocol
> 
> Can this go through the PM tree ?
> 

It's part of a long series changing internal and external SCMI
interfaces, series including a bit of per-protocol transient code added
and removed around this patch to maintain bisectability along the way...

...I'd not recommend split this patch out and committ it out of the series,
if this is what you meant.

Anyway up to Sudeep really.

Thanks

Cristian

> -- 
> viresh
