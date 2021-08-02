Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7C23DD302
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhHBJf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231460AbhHBJfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:35:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A996061057;
        Mon,  2 Aug 2021 09:35:14 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mAULo-002PoM-Kq; Mon, 02 Aug 2021 10:35:12 +0100
MIME-Version: 1.0
Date:   Mon, 02 Aug 2021 10:35:12 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, mark.rutland@arm.com
Subject: Re: [PATCH 10/10] arm64: errata: Add workaround for TSB flush
 failures
In-Reply-To: <477c4943-7c35-8502-0291-4c0ed3a03905@arm.com>
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-11-suzuki.poulose@arm.com>
 <87mtq5a1gs.wl-maz@kernel.org>
 <c41330d9-c2a2-afbe-624f-77c1e94f0490@arm.com>
 <477c4943-7c35-8502-0291-4c0ed3a03905@arm.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <32f719c8f9f61b244b3fc29137f76a19@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anshuman.khandual@arm.com, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, coresight@lists.linaro.org, will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com, mathieu.poirier@linaro.org, mike.leach@linaro.org, leo.yan@linaro.org, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-02 10:12, Anshuman Khandual wrote:
> On 7/29/21 4:11 PM, Suzuki K Poulose wrote:
>> On 29/07/2021 10:55, Marc Zyngier wrote:
>>> On Wed, 28 Jul 2021 14:52:17 +0100,
>>> Suzuki K Poulose <suzuki.poulose@arm.com>

[...]

>>>> +            __tsb_csync();                        \
>>>> +            __tsb_csync();                        \
>>>> +        } else {                            \
>>>> +            __tsb_csync();                        \
>>>> +        }                                \
>>> 
>>> nit: You could keep one unconditional __tsb_csync().
>> 
>> I thought about that, I was worried if the CPU expects them back to 
>> back
>> without any other instructions in between them. Thinking about it a 
>> bit
>> more, it doesn't look like that is the case. I will confirm this and
>> change it accordingly.
> But its a very subtle change which might be difficult to debug and 
> blame
> later on, if indeed both the instructions need to be back to back. 
> Seems
> like just better to leave this unchanged.

Is that an actual requirement? Sounds like you want to find out
from the errata document.

And if they actually need to be back to back, what ensures that
this is always called with interrupt disabled?

You would also need to have them in the same asm block to avoid
the compiler reordering stuff.

         M.
-- 
Jazz is not dead. It just smells funny...
