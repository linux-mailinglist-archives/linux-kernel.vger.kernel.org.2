Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335B6330C96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhCHLkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:40:11 -0500
Received: from foss.arm.com ([217.140.110.172]:36536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhCHLkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:40:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84133D6E;
        Mon,  8 Mar 2021 03:40:03 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A56123F73C;
        Mon,  8 Mar 2021 03:40:01 -0800 (PST)
Date:   Mon, 8 Mar 2021 11:39:59 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 35/37] firmware: arm_scmi: make notify_priv really
 private
Message-ID: <20210308113959.GE30179@e120937-lin>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-36-cristian.marussi@arm.com>
 <20210308061229.csrcamh6fkj3qfoc@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308061229.csrcamh6fkj3qfoc@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 06:12:29AM +0000, Sudeep Holla wrote:
> On Tue, Feb 02, 2021 at 10:15:53PM +0000, Cristian Marussi wrote:
> > Notification private data is currently accessible via handle->notify_priv;
> > this data was indeed meant to be private to the notification core support
> > and not to be accessible by SCMI drivers: make it private hiding it inside
> > instance descriptor struct scmi_info and accessible only via dedicated
> > helpers.
> > 
> 
> Patch 3 - 35 looks good to me. I need to look at last 2 patches again.
> So thought of replying instead of keeping you waited. You can start
> rebasing once we pull IIO branch from Jonathan. I will keep you posted.
> 
Ok, thanks I'm anyway starting rebasing on bare v5.12-rc2 (locally
without posting) and then I'll rebase on top of your pulled Jonathan
immutable branch and other cpufreq changes (from Nicola I think they
were).

Thanks

Cristian

> -- 
> Regards,
> Sudeep
