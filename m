Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF53DFE3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 11:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbhHDJoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 05:44:01 -0400
Received: from mail.ispras.ru ([83.149.199.84]:47584 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236511AbhHDJoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:44:01 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2141940D403D;
        Wed,  4 Aug 2021 09:43:43 +0000 (UTC)
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Fix potential buffer
 overflows
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
References: <20210803181135.22298-1-novikov@ispras.ru>
 <CAHp75Vde1RAKTCTzmt0eHjNGrKUyi7r1rtNo934WW6wqi9T=ng@mail.gmail.com>
 <CAHp75VfVCk1ueQZiGnJqwhD=j+zpVZ3Q-GmLMKX9AfP_BFMPNA@mail.gmail.com>
From:   Evgeny Novikov <novikov@ispras.ru>
Message-ID: <394f3b53-7896-c602-a6d2-e0e17d1e647e@ispras.ru>
Date:   Wed, 4 Aug 2021 12:43:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfVCk1ueQZiGnJqwhD=j+zpVZ3Q-GmLMKX9AfP_BFMPNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.2021 21:30, Andy Shevchenko wrote:
> On Tue, Aug 3, 2021 at 9:26 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Tue, Aug 3, 2021 at 9:21 PM Evgeny Novikov <novikov@ispras.ru> wrote:
>>> It looks like pmc_core_get_low_power_modes() mixes up modes and
>>> priorities. In addition to invalid behavior, potentially this can
>>> cause buffer overflows since the driver reads priorities from the
>>> register and then it uses them as indexes for array lpm_priority
>>> that can contain 8 elements at most. The patch swaps modes and
>>> priorities.
>>>
>>> Found by Linux Driver Verification project (linuxtesting.org).
>> Seems legit.
> Hold on, but then it follows with another loop where actually it reads
> modes by priority index. Can you elaborate what exactly is the problem
> you think?
>
I agree with you and David that my fix was not valid from the functional

point of view. Indeed, some issues can happen if something unexpected

will be read from the register. For instance, for priority equals to 255 you

will have pri0 = 15 and prio1 = 15. Obviously, you can not access the

lpm_priority array consisting of just 8 elements by these indexes.


Best regards,

Evgeny Novikov

