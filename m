Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8742308D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 21:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhJETIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 15:08:40 -0400
Received: from ciao.gmane.io ([116.202.254.214]:58430 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhJETIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:08:39 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1mXpm3-0001b4-9s
        for linux-kernel@vger.kernel.org; Tue, 05 Oct 2021 21:06:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Thomas Backlund <tmb@iki.fi>
Subject: Re: [PATCH 5.14 000/173] 5.14.10-rc2 review
Date:   Tue, 5 Oct 2021 22:06:40 +0300
Message-ID: <160e0fba-29d8-b775-e89c-96afa29a86c1@iki.fi>
References: <20211005083311.830861640@linuxfoundation.org>
 <20211005155909.GA1386975@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Cc:     stable@vger.kernel.org
Content-Language: en-US
In-Reply-To: <20211005155909.GA1386975@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 2021-10-05 kl. 18:59, skrev Guenter Roeck:
> On Tue, Oct 05, 2021 at 10:38:40AM +0200, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.14.10 release.
>> There are 173 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 07 Oct 2021 08:32:44 +0000.
>> Anything received after that time might be too late.
>>
> 
> AFAICS the warning problems are still seen. Unfortunately I won't be able
> to bisect since I have limited internet access.
> 
> Guenter
> 
> =========================
> WARNING: held lock freed!
> 5.14.10-rc2-00174-g355f3195d051 #1 Not tainted
> -------------------------
> ip/202 is freeing memory c000000009918900-c000000009918f7f, with a lock still held there!
> c000000009918a20 (sk_lock-AF_INET){+.+.}-{0:0}, at: .sk_common_release+0x4c/0x1b0
> 2 locks held by ip/202:
>   #0: c00000000ae149d0 (&sb->s_type->i_mutex_key#5){+.+.}-{3:3}, at: .__sock_release+0x4c/0x150
>   #1: c000000009918a20 (sk_lock-AF_INET){+.+.}-{0:0}, at: .sk_common_release+0x4c/0x1b0
> 
> 


Isn't this a fallout of:

queue-5.14/net-introduce-and-use-lock_sock_fast_nested.patch
that has: Fixes: 2dcb96bacce3 ("net: core: Correct the 
sock::sk_lock.owned lockdep annotations")

BUT:

$ git describe --contains 2dcb96bacce3
v5.15-rc3~30^2~26

--
Thomas


