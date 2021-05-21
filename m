Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F16838CA0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhEUP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:27:49 -0400
Received: from foss.arm.com ([217.140.110.172]:49806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232199AbhEUP1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:27:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C38AF11B3;
        Fri, 21 May 2021 08:26:20 -0700 (PDT)
Received: from bogus (unknown [10.57.72.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17D183F73B;
        Fri, 21 May 2021 08:26:18 -0700 (PDT)
Date:   Fri, 21 May 2021 16:26:13 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 1/4] firmware: arm_scmi: fix deps arm-smccc-discovery
 deps in Kconfig
Message-ID: <20210521152613.3uyapbuiylt3btid@bogus>
References: <20210521134055.24271-1-etienne.carriere@linaro.org>
 <20210521151528.pjbwkumfj4g6nu3q@bogus>
 <713c4c93-4dc9-ac5f-0749-f69f1763f876@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713c4c93-4dc9-ac5f-0749-f69f1763f876@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 08:20:29AM -0700, Florian Fainelli wrote:
> On 5/21/2021 8:15 AM, Sudeep Holla wrote:
> > + Florian
> > 
> > On Fri, May 21, 2021 at 03:40:51PM +0200, Etienne Carriere wrote:
> >> ARM_SCMI_PROTOCOL depends one either MAILBOX or HAVE_ARM_SMCCC_DISCOVERY,
> >> not MAILBOX only. This change fixes this in Kconfig file and driver
> >> private header file.
> >>
> > 
> > Since HAVE_ARM_SMCCC_DISCOVERY depends on ARM_PSCI_FW, I want to check
> > if this is used on any 32-bit platforms w/o ARM_PSCI_FW
> 
> Not on ARCH_BRCMSTB, there is no SMCCC without PSCI.

Thanks for the confirmation.

-- 
Regards,
Sudeep
