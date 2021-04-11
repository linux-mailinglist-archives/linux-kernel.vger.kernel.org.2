Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0535B292
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 11:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhDKJNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 05:13:19 -0400
Received: from mout.web.de ([212.227.15.4]:43241 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhDKJNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 05:13:19 -0400
X-Greylist: delayed 3002 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Apr 2021 05:13:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618132353;
        bh=3rMIJcb5GjWas/Zd/eJWhyvFbgoz2c0PEFfSHFr1sRM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rZdx1+F0tuEYmTICd2/nBRtJ0jYg9HhGwQ4F6ekjTWrSicYt9d8ZWC5InRKiYy4SC
         r+GInBMZu0l4qPIwvW4x7Aei3qZYrabnkB43tnt9fX/fE7XMZJiITYgdcmp6kSgB/v
         ojMFEW8KwQZBDyTjO6ix0rFQYyAt6/z1S+RPtomg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.10.10] ([88.215.87.53]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLgCx-1lVFA21jox-000v9Z; Sun, 11
 Apr 2021 11:12:33 +0200
Subject: Re: [PATCH v2] x86: pat: Do not compile stubbed functions when
 X86_PAT is off
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <198c94a8-12ea-88e7-6f08-b3456473e5c3@siemens.com>
 <87r1z6xxh5.fsf@nanos.tec.linutronix.de>
 <a2788ff7-c524-52de-3f45-82613410f872@siemens.com>
 <a9351615-7a0d-9d47-af65-d9e2fffe8192@siemens.com>
 <802cefc7-b475-c6d6-ece7-8232d7f3891d@web.de>
 <20210411091056.GA14022@zn.tnic>
From:   Jan Kiszka <jan.kiszka@web.de>
Message-ID: <7c606ebd-e8d8-0853-bab5-5e77b1359dcc@web.de>
Date:   Sun, 11 Apr 2021 11:12:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210411091056.GA14022@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BhdpBvpVM4hm1VmZgPSIMtkVJHUoiYWZXfXSWabqqyHr6d+hp1L
 l1E28nRJye3N+BgNiG+6vhsZhPndb0lMV1beddHjL2OLSb4V+tbNmpxndQ0rxDE2ZJzSrl+
 560uNNDFeKYjdI6dVUq7MPoK1CKRFQvpQW+dWg5WQr8dKk4LmhS5FI+yy5gSYhmQiWNGZBP
 ZkjvmYI3dtQtEfjsfI47Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AxQfkGuL0eY=:UOtTkBoIvF1/xtQv1GEQUg
 o6J+jEaxWXvPNhz68nRMQjpA18JIDSatxiDPh0tTExkcxk6X+l3pbNPGstIMJj3QaBVVNX/E2
 6L31C1HSr9ML7MIN9ViPow2q2JWSyTvMz7GrdOW0RRHgosGvzbxfIVMdbeFKgdHIuhcUbvjW7
 vFVyCWEZMWyxFMu/i8GuaKuGiH8wyTW2O8l2VS2p9RRjeiPPeSOcHDxMssOYz9IxdfNk1ztXg
 DIbEQm15G5g7ARTPOXr7mTtRBqQmx76jqVjnmLrJOi/BhgXWBDiIITHcfwwVS/lL8TI7sZJsj
 ZIhjYfap5mxEK2t+32xvjGXjyPR3vj2rHudtTgsCxifmUJLXxKhMUB3snUzsKBNT1WXrZZFP7
 LNasNVDUtJKkAIIcyMKk8H2iEhCEX3BkvE5isRs1ghkCcnI638G1hay8tyB9Xyv8A6a/GFQ5s
 lvEDaOMzcLcHx/kmYhvzLzcFvs674FLNqz5x6k2RlUAxPmxQLhL8qMs+rSKYWW3EoO0EL+0zX
 7CEUk0MSAH3GHdWtCvbx/o1dUlYJDC0FX8XSjeWZE9reCAtS9JG4xxa/J72O/G+HRQEZLybAU
 xmRs3QGk32JAN5Zc/xaPxjNhhLnlVyRoLDt3GzObIfHkN9/ACX2R2lNuUV4KZc0mUqRq7RGWy
 T7dpBbOkL0j2axbYmM0zZoSv6QMK2ysUD+zPxFKKAJYUJR1ikku0yjlXWCqJ6kiLQs+Xc+DZY
 c3kWyKlNcNUFRNzBXo1t0PyDHY1I6GIKKMlJbNjJ0OJJUAnuL662gItg0JQOu9kl4h2S4rPJ/
 PyydM3VXfox6QyPCQ9KSjD7jw8s3tZN1IJVWjXz7VRMtuOMje8y8DGyOLbt2TWN+7QgdlrFp6
 MS263L8wGMwsJNnSzJHqHxKLLqXq/F81rXj5o9gFj5PRAGfx3UDzFP0oAFTMf33LW8bKmaMHK
 Pb6N6rmKzoU6ZYCjABwmBAsYutk3e9x30ydSzxY5XpV8cSCHCHWnSkrgLfs7iyBngGDKDI2j4
 Kr/Z+M84CWHZkXKYvq0uWhm7kUTEgyEnLPn7te4FK74h9ga7/WNM1UKzXyLiQYy2lgCQeBN5F
 1ajze0xN/igek+AukaoQFRyAhVijevPk6EAtBbLHbToMZQOlsPFwf7xWv4l9ZctgJO1hyJoHZ
 sd4YseZKeqo4UuHRPJb5rieb6MMA6JCWC66LSlICksF31kWXkpBZi5B8LzCyq/nDyxpvE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.04.21 11:10, Borislav Petkov wrote:
> On Sun, Apr 11, 2021 at 10:22:19AM +0200, Jan Kiszka wrote:
>> On 26.10.20 18:39, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Those are already provided by linux/io.h as stubs.
>>>
>>> The conflict remains invisible until someone would pull linux/io.h int=
o
>>> memtype.c.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Change in v2:
>>>  - correct commit message
>>>
>>>  arch/x86/mm/pat/memtype.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
>>> index 8f665c352bf0..41a4ac585af3 100644
>>> --- a/arch/x86/mm/pat/memtype.c
>>> +++ b/arch/x86/mm/pat/memtype.c
>>> @@ -800,6 +800,7 @@ void memtype_free_io(resource_size_t start, resour=
ce_size_t end)
>>>  	memtype_free(start, end);
>>>  }
>>>
>>> +#ifdef CONFIG_X86_PAT
>>>  int arch_io_reserve_memtype_wc(resource_size_t start, resource_size_t=
 size)
>>>  {
>>>  	enum page_cache_mode type =3D _PAGE_CACHE_MODE_WC;
>>> @@ -813,6 +814,7 @@ void arch_io_free_memtype_wc(resource_size_t start=
, resource_size_t size)
>>>  	memtype_free_io(start, start + size);
>>>  }
>>>  EXPORT_SYMBOL(arch_io_free_memtype_wc);
>>> +#endif
>>>
>>>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>>>  				unsigned long size, pgprot_t vma_prot)
>>>
>>
>> What happened to this?
>
> What is this patch and your other asm/proto.h thing fixing?
>
> Looks like you're using kernel headers in something else and don't want
> to include the whole world thus those fixes... so that you can include
> upstream kernel headers without having to touch them...
>
> Or am I way off base here?
>

The patches are coming from downstream usage, yes, but I think the
solutions are relevant cleanups for upstream as well.

Jan
