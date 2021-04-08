Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D843E35882F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhDHPXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:23:50 -0400
Received: from foss.arm.com ([217.140.110.172]:51382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231907AbhDHPXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:23:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF131D6E;
        Thu,  8 Apr 2021 08:23:29 -0700 (PDT)
Received: from [10.37.8.4] (unknown [10.37.8.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE3CB3F694;
        Thu,  8 Apr 2021 08:23:28 -0700 (PDT)
Subject: Re: [PATCH] arm64: mte: Move MTE TCF0 check in entry-common
To:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20210408143723.13024-1-vincenzo.frascino@arm.com>
 <20210408145604.GB18211@willie-the-truck>
 <20210408150612.GA37165@C02TD0UTHF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <e3c6fa5b-82a2-dfd9-859b-efbb9970c5e5@arm.com>
Date:   Thu, 8 Apr 2021 16:23:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210408150612.GA37165@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/21 4:06 PM, Mark Rutland wrote:
> On Thu, Apr 08, 2021 at 03:56:04PM +0100, Will Deacon wrote:
>> On Thu, Apr 08, 2021 at 03:37:23PM +0100, Vincenzo Frascino wrote:
>>> The check_mte_async_tcf macro sets the TIF flag non-atomically. This can
>>> race with another CPU doing a set_tsk_thread_flag() and the flag can be
>>> lost in the process.
>>
>> Actually, it's all the *other* flags that get lost!
>>

You are right, I need to explain this better.

...

-- 
Regards,
Vincenzo
