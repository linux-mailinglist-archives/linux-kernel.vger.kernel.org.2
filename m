Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6838C9D8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhEUPRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:17:01 -0400
Received: from foss.arm.com ([217.140.110.172]:49592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230420AbhEUPQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:16:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71B7B11B3;
        Fri, 21 May 2021 08:15:36 -0700 (PDT)
Received: from bogus (unknown [10.57.72.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0001D3F73B;
        Fri, 21 May 2021 08:15:34 -0700 (PDT)
Date:   Fri, 21 May 2021 16:15:28 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 1/4] firmware: arm_scmi: fix deps arm-smccc-discovery
 deps in Kconfig
Message-ID: <20210521151528.pjbwkumfj4g6nu3q@bogus>
References: <20210521134055.24271-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521134055.24271-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Florian

On Fri, May 21, 2021 at 03:40:51PM +0200, Etienne Carriere wrote:
> ARM_SCMI_PROTOCOL depends one either MAILBOX or HAVE_ARM_SMCCC_DISCOVERY,
> not MAILBOX only. This change fixes this in Kconfig file and driver
> private header file.
>

Since HAVE_ARM_SMCCC_DISCOVERY depends on ARM_PSCI_FW, I want to check
if this is used on any 32-bit platforms w/o ARM_PSCI_FW

-- 
Regards,
Sudeep
