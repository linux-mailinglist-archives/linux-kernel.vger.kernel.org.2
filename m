Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4F93307FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhCHGNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:13:09 -0500
Received: from foss.arm.com ([217.140.110.172]:60146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232584AbhCHGMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:12:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82D82ED1;
        Sun,  7 Mar 2021 22:12:36 -0800 (PST)
Received: from bogus (unknown [10.57.15.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED17F3F73C;
        Sun,  7 Mar 2021 22:12:32 -0800 (PST)
Date:   Mon, 8 Mar 2021 06:12:29 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 35/37] firmware: arm_scmi: make notify_priv really
 private
Message-ID: <20210308061229.csrcamh6fkj3qfoc@bogus>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-36-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202221555.41167-36-cristian.marussi@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 10:15:53PM +0000, Cristian Marussi wrote:
> Notification private data is currently accessible via handle->notify_priv;
> this data was indeed meant to be private to the notification core support
> and not to be accessible by SCMI drivers: make it private hiding it inside
> instance descriptor struct scmi_info and accessible only via dedicated
> helpers.
> 

Patch 3 - 35 looks good to me. I need to look at last 2 patches again.
So thought of replying instead of keeping you waited. You can start
rebasing once we pull IIO branch from Jonathan. I will keep you posted.

-- 
Regards,
Sudeep
