Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B0F382D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbhEQNTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235337AbhEQNTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621257477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=302eZ4qDI0GRNiemHwtsv0o7x2BmzRwhlMO3j9ZHKfo=;
        b=C4w/Bq9MyNLEIfg8Uezve8PBAdZzfKTa9M4YrJuF0sDc57oWUTYzGR2LQKLmazGGEsDFu2
        7Szzji5aqCmGcKwV6WZ7HDrR5EGuSFU2fT7Ac8UTWK7KL0abcHNcoCJd4gG/oCXASsaLfj
        nz2rw3GHBE5shHn1yI9bfjKJC4eNXHo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-leKVwvw6PnSqq8dX5ttXvA-1; Mon, 17 May 2021 09:17:56 -0400
X-MC-Unique: leKVwvw6PnSqq8dX5ttXvA-1
Received: by mail-qt1-f198.google.com with SMTP id e13-20020ac84e4d0000b02901e0f0a55411so5196047qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 06:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=302eZ4qDI0GRNiemHwtsv0o7x2BmzRwhlMO3j9ZHKfo=;
        b=fP9/TZJrs5T34kWxyHpisxZfLMZ8nrgpLbcDrgQVfC7iK3dHM4pfk4DPSMm/x2rjE0
         LMoDJU3NHlGlKhXIHCxXaMuXCebTnaROaU77tigEXbB+t0ZOAxm0iPLUNcJ/xpVzC6+Q
         O6QJR7MlYFyTB0NigbgL7aJkIo8yvF+xsOTp37ZYZ0yTZDNgRDB/awJXDalaRRmjsfqW
         atzA9xHDCP+GoD3RBPh4r5VKQUxkXLnWytFz/UmKJC/cieCVn8ftqBKsSExlODDEBUgl
         t4ke52ncuTAk4GZhyczJ9hiQE9bi/aYwQp+/SKrP9ki34UPjd3SH0TTilGGgKCrrF2cV
         skog==
X-Gm-Message-State: AOAM531qT5Xe14RfBBnH6TbcQC0VvmSwC/xQHD/tnxJdqIRwXEXE248D
        R3EzEdfg7hqdb4jRMV6CtHa/uVuQlMgcPN0ci6MnjRqy6nPw71OA/ZSW+AFxobRt259wYlQXw6/
        iDjuE7jg388eiTQghnIqg8PmLlPoAWqW6KaT+UA+bBOoSzPUWQaH9c0pJrgrd1k4vetLQu6w=
X-Received: by 2002:ac8:7f41:: with SMTP id g1mr57865329qtk.72.1621257470696;
        Mon, 17 May 2021 06:17:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1GXnceHJW1kNq377snFtM5QG53XeoeEVafMT93GToCW8jsZKQxNt7PKa6yc9SZ9VaeNkTPg==
X-Received: by 2002:ac8:7f41:: with SMTP id g1mr57865242qtk.72.1621257469608;
        Mon, 17 May 2021 06:17:49 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s5sm10465630qkg.88.2021.05.17.06.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 06:17:49 -0700 (PDT)
Subject: Re: [PATCH] percpu: initialize best_upa variable
To:     Dennis Zhou <dennis@kernel.org>
Cc:     tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210515180817.1751084-1-trix@redhat.com>
 <YKHPV4QAXmaWb6jJ@google.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <dd1dabe0-73a5-8a39-ba58-bb58a1453d90@redhat.com>
Date:   Mon, 17 May 2021 06:17:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKHPV4QAXmaWb6jJ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/16/21 7:05 PM, Dennis Zhou wrote:
> Hello,
>
> On Sat, May 15, 2021 at 11:08:17AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Static analysis reports this problem
>> percpu.c:2945:6: warning: Assigned value is garbage or undefined
>>          upa = best_upa;
>>              ^ ~~~~~~~~
>> best_upa may not be set, so initialize it.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   mm/percpu.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/percpu.c b/mm/percpu.c
>> index a257c3efdf18b..6578b706fae81 100644
>> --- a/mm/percpu.c
>> +++ b/mm/percpu.c
>> @@ -2916,6 +2916,7 @@ static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
>>   	 * Related to atom_size, which could be much larger than the unit_size.
>>   	 */
>>   	last_allocs = INT_MAX;
>> +	best_upa = max_upa;
>>   	for (upa = max_upa; upa; upa--) {
>>   		int allocs = 0, wasted = 0;
>>   
>> -- 
>> 2.26.3
>>
> I think the proper fix would be:
>
> best_upa = 0;

I was looking for initializing with something that would work.

> for (...) { }
> BUG_ON(!best_upa);
WARN_ON instead?
> upa = best_upa;
>
> If you're fine with this I'll make the changes and apply it to
> for-5.13-fixes.
>
> Can you also tell me what static analysis tool produced this? I'm just a
> little curious because this code hasn't changed in several years so I'd
> have expected some static analyzer to have caught this by now.

Clang 10

Tom

>
> Thanks,
> Dennis
>

