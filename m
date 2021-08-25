Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3973F7BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhHYRxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:53:25 -0400
Received: from foss.arm.com ([217.140.110.172]:57056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhHYRxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:53:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2803AD6E;
        Wed, 25 Aug 2021 10:52:38 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFA453F66F;
        Wed, 25 Aug 2021 10:52:36 -0700 (PDT)
Date:   Wed, 25 Aug 2021 18:52:33 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v4 05/12] firmware: arm_scmi: Use new trace event
 scmi_xfer_response_wait
Message-ID: <20210825175233.GH13160@e120937-lin>
References: <20210824135941.38656-1-cristian.marussi@arm.com>
 <20210824135941.38656-6-cristian.marussi@arm.com>
 <2ffa7d65-21ef-433b-8a86-068df13950d2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ffa7d65-21ef-433b-8a86-068df13950d2@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 06:31:13PM +0200, Florian Fainelli wrote:
> 
> 
> On 8/24/2021 3:59 PM, Cristian Marussi wrote:
> > Use new trace event to mark start of waiting for response section.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
Hi Florian,

Thanks for the review and the feedback across this series.

> Might be worth squashing into patch 4?
> 

Yes indeed I never know for sure when to squash when stuff crosses
subsystems/maintaners boundaries.

Thanks,
Cristian

