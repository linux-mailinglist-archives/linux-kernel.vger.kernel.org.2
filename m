Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5872A418B4E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 23:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhIZVuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 17:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhIZVuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 17:50:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E184EC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 14:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Tw65aNmxnM9/K7u2U3QRi6kOxX3UaX2u6AJJK6c0E24=; b=ohoD6AHId6glTizVzppyXfnFgM
        bFU3tUVrGUgruilqmGNvDMu0bIZ3tZCWfC8UbzH7CYDqLCpSQVKz/CA7qjpCEHj5bBE5POarlYmH7
        7LZAT/neG7J2xSXR2s+/u5IEV8VYn4D2iNzHD8Wj9w1k3M2xFMyMEsyxrSoeW7cQAdXlX2o8L5ztp
        HUAQxbNFe5UmCM78QhIFTMinNqwZLATXCQX4NnWDbOR9agfXxw4txm0EVdyN2eGN1BV9mwXcEBO5n
        raMAm6ILMYkmllukbi9lQQRCOblssaHYPjgmOUow++oM0eCajsP3WL6teNuUKOmo4fG5wt8fVA4+S
        f86Gd5SQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUc0e-0017NX-Bj; Sun, 26 Sep 2021 21:48:32 +0000
Subject: Re: [RFC PATCH] xtensa: setup: use CONFIG_USE_OF instead of CONFIG_OF
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
References: <20210925032951.6767-1-rdunlap@infradead.org>
 <CAMo8Bf+TE4PX5PBD8bSsF6Cx+LGunExjuB3xXyyRvwzC0iHMDA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2cc9c34f-e166-51bc-eedc-e4086753c011@infradead.org>
Date:   Sun, 26 Sep 2021 14:48:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMo8Bf+TE4PX5PBD8bSsF6Cx+LGunExjuB3xXyyRvwzC0iHMDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/21 11:55 AM, Max Filippov wrote:
> Hi Randy,
> 
> On Fri, Sep 24, 2021 at 8:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> CONFIG_OF can be set by a randconfig or by a user -- without setting the
>> early flattree option (OF_EARLY_FLATTREE).  This causes build errors.
>> However, if randconfig or a user sets USE_OF in the Xtensa config,
>> the right kconfig symbols are set to enable xtensa/kernel/setup.c to
>> build.
>>
>> Fixes these build errors:
>>
>> ../arch/xtensa/kernel/setup.c: In function 'xtensa_dt_io_area':
>> ../arch/xtensa/kernel/setup.c:201:14: error: implicit declaration of function 'of_flat_dt_is_compatible'; did you mean 'of_machine_is_compatible'? [-Werror=implicit-function-declaration]
>>    201 |         if (!of_flat_dt_is_compatible(node, "simple-bus"))
>> ../arch/xtensa/kernel/setup.c:204:18: error: implicit declaration of function 'of_get_flat_dt_prop' [-Werror=implicit-function-declaration]
>>    204 |         ranges = of_get_flat_dt_prop(node, "ranges", &len);
>> ../arch/xtensa/kernel/setup.c:204:16: error: assignment to 'const __be32 *' {aka 'const unsigned int *'} from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
>>    204 |         ranges = of_get_flat_dt_prop(node, "ranges", &len);
>>        |                ^
>> ../arch/xtensa/kernel/setup.c: In function 'early_init_devtree':
>> ../arch/xtensa/kernel/setup.c:228:9: error: implicit declaration of function 'early_init_dt_scan'; did you mean 'early_init_devtree'? [-Werror=implicit-function-declaration]
>>    228 |         early_init_dt_scan(params);
>> ../arch/xtensa/kernel/setup.c:229:9: error: implicit declaration of function 'of_scan_flat_dt' [-Werror=implicit-function-declaration]
>>    229 |         of_scan_flat_dt(xtensa_dt_io_area, NULL);
>>
>> Fixes: da844a81779e ("xtensa: add device trees support")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Max Filippov <jcmvbkbc@gmail.com>
>> Cc: Chris Zankel <chris@zankel.net>
>> Cc: linux-xtensa@linux-xtensa.org
>> ---
>>   arch/xtensa/kernel/setup.c |    6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Thanks for your RFC. I've tested it and found a couple more places
> where CONFIG_USE_OF should be used instead of CONFIG_OF.
> I'll post the revised version.
> 

Hi Max,
Thanks for checking and for the extra fixes.
Looks good.

-- 
~Randy
