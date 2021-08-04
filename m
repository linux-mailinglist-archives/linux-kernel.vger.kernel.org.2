Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8433E0226
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbhHDNlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:41:21 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:51944
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235532AbhHDNlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:41:19 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 580D13F228;
        Wed,  4 Aug 2021 13:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628084466;
        bh=lFojyGKTjPs1WHFbR8j0rBafp8XajAZ525KT5rkGLos=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Fh3OVbLKgCd1iCimdmU0jvESTC/CRuoOASP4WTiASaP96L0w04pjmDpIG/DLpbDSC
         KKJ3MUFZ0Unl3v63zdmXJE0830RpM8FjDWdwkxWX5YAXFmBd5V252bUHjvGBbZ6Aqc
         +hO6kE0yhROukCLwyDNCtFvQTM+kVb9id1u5QxF9LrHBWm/hi0b4RTkhTn+jPYp9LR
         Ag594oTp4NAGvjtV3PFOc2nFUkU3N2/6r9eIoRYBzrib003S/YfkHZOQCOPA/kCmhi
         cIYId1iWcp92j5aYmLvz2VTMpQW1S2sAbzfYjnXeLF7fp21ZhBl6uq5YtzDlU8tz5I
         Z69XppiFTl6lA==
Subject: Re: [PATCH][next] kernel/user.c: Fix spelling mistake "cpunter" ->
 "counter"
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210804120658.110124-1-colin.king@canonical.com>
 <e67d1ff8-f872-c1af-7f1c-03ac9e9d7d2e@infradead.org>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <481ca355-6359-b8b4-423e-54b0c6000b00@canonical.com>
Date:   Wed, 4 Aug 2021 14:41:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e67d1ff8-f872-c1af-7f1c-03ac9e9d7d2e@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2021 14:35, Randy Dunlap wrote:
> On 8/4/21 5:06 AM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> There is a spelling mistake in a panic message. Fix it.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   kernel/user.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/user.c b/kernel/user.c
>> index a2673f940506..7fc40af8d8ac 100644
>> --- a/kernel/user.c
>> +++ b/kernel/user.c
>> @@ -223,7 +223,7 @@ static int __init uid_cache_init(void)
>>           INIT_HLIST_HEAD(uidhash_table + n);
>>         if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
>> -        panic("percpu cpunter alloc failed");
>> +        panic("percpu counter alloc failed");
>>         /* Insert the root user immediately (init already runs as
>> root) */
>>       spin_lock_irq(&uidhash_lock);
>>
> 
> Nick Piggin has reworded that panic message text in a patch
> yesterday so this patch isn't needed.

Fair enough. Thanks for the info.

> 
> https://lore.kernel.org/lkml/1628051945.fens3r99ox.astroid@bobo.none/
> 
> 
> thanks.

