Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB0345A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCWJRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhCWJRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:17:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1ED61990;
        Tue, 23 Mar 2021 09:17:02 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lOd9n-003GRa-JN; Tue, 23 Mar 2021 09:17:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Mar 2021 09:16:59 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 05/19] kvm: arm64: Disable guest access to trace filter
 controls
In-Reply-To: <cbe4ef17-38f9-c555-d838-796be752d4a3@arm.com>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-6-suzuki.poulose@arm.com>
 <cbe4ef17-38f9-c555-d838-796be752d4a3@arm.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <8cb6eced29d9749d88af6f6d2f649019@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, mike.leach@linaro.org, anshuman.khandual@arm.com, leo.yan@linaro.org, will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 2021-03-22 22:24, Suzuki K Poulose wrote:
> Hi Marc,
> 
> On 25/02/2021 19:35, Suzuki K Poulose wrote:
>> Disable guest access to the Trace Filter control registers.
>> We do not advertise the Trace filter feature to the guest
>> (ID_AA64DFR0_EL1: TRACE_FILT is cleared) already, but the guest
>> can still access the TRFCR_EL1 unless we trap it.
>> 
>> This will also make sure that the guest cannot fiddle with
>> the filtering controls set by a nvhe host.
>> 
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> We have already have the v8.4 self hosted tracing support in 5.12-rcX.
> Do you think you can pick this up for this 5.12 ?

Sure, no problem. Shall I pick patch #3 at the same time?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
