Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9969733A84B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 22:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhCNVje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 17:39:34 -0400
Received: from relay.yourmailgateway.de ([188.68.63.166]:56457 "EHLO
        relay.yourmailgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhCNVjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 17:39:24 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Mar 2021 17:39:23 EDT
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
        by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4DzCPT4ttsz4cKj;
        Sun, 14 Mar 2021 22:29:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=alexander-lochmann.de; s=key2; t=1615757389;
        bh=PzERdEWcS2/yiftutH4LPVdFWNzELzOF2AS6NkH1yDM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QzHTLq7YuDWLkXvNJSKxJwvbu0ZgQ9tKTessnqcsi6GMzi83oqCY7BwRD+rc1Q+hL
         prK1xDlmCOmnslsQGhyRvuLlobA98wbrqLFZsAsx1f0BZY7vEn6vWG/8how0+1+MBL
         F0jncV6cHXD/600tYBolb+nT5t/O8GdoIKIPJ1l7kopFxlWjfszbhj4Hv21Onk4nHN
         +86w+8GSTHV4T2ozWh2gRjkgfIVobn5G1Oo9K/2pTxQWyzuLIvcYOFBN3E9LKzAQYm
         pvExJIu32tXbwinfuzlTRw/tOuUqS/TzFisW5+hd/L3kOB3jOF77axYMw2FFxvPIIr
         epZdcl12I4j8Q==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4DzCPT4HzXz4cKD;
        Sun, 14 Mar 2021 22:29:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
X-Spam-Status: No, score=-2.901 required=6.31 tests=[ALL_TRUSTED=-1,
        BAYES_00=-1.9, SPF_PASS=-0.001] autolearn=ham autolearn_force=no
Received: from mx2e12.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy01-mors.netcup.net (Postfix) with ESMTPS id 4DzCPS00BLz8tGF;
        Sun, 14 Mar 2021 22:29:47 +0100 (CET)
Received: from [IPv6:2003:ed:7f1a:8ff0:bc4f:7872:30f9:5dc9] (p200300ed7f1a8ff0bc4f787230f95dc9.dip0.t-ipconnect.de [IPv6:2003:ed:7f1a:8ff0:bc4f:7872:30f9:5dc9])
        by mx2e12.netcup.net (Postfix) with ESMTPSA id 2C6D1A0792;
        Sun, 14 Mar 2021 22:29:46 +0100 (CET)
Authentication-Results: mx2e12;
        spf=pass (sender IP is 2003:ed:7f1a:8ff0:bc4f:7872:30f9:5dc9) smtp.mailfrom=info@alexander-lochmann.de smtp.helo=[IPv6:2003:ed:7f1a:8ff0:bc4f:7872:30f9:5dc9]
Received-SPF: pass (mx2e12: connection is authenticated)
Subject: Re: [PATCH] KCOV: Introduced tracing unique covered PCs
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <20210211080716.80982-1-info@alexander-lochmann.de>
 <CACT4Y+YwRE=YNQYmQ=7RWde33830YOYr5pEAoYbrofY2JG43MA@mail.gmail.com>
From:   Alexander Lochmann <info@alexander-lochmann.de>
Message-ID: <01a9177f-bfd5-251a-758f-d3c68bafd0cf@alexander-lochmann.de>
Date:   Sun, 14 Mar 2021 22:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YwRE=YNQYmQ=7RWde33830YOYr5pEAoYbrofY2JG43MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <161575738654.15961.2097524548515925129@mx2e12.netcup.net>
X-PPP-Vhost: alexander-lochmann.de
X-NC-CID: JmTQRHjKDd5kGOW4U22LAUruP+XW8WLQK9Pb1HY7IfAcDGn68gXTIGqh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.02.21 13:54, Dmitry Vyukov wrote:
> 
> I think we could make KCOV_IN_CTXSW sign bit and then express the check as:
> 
> void foo2(unsigned mode) {
>   if (((int)(mode & 0x8000000a)) > 0)
>     foo();
> }
> 
> 0000000000000020 <foo2>:
>   20: 81 e7 0a 00 00 80    and    $0x8000000a,%edi
>   26: 7f 08                jg     30 <foo2+0x10>
>   28: c3                    retq
> 
So ((int)(mode & (KCOV_IN_CTXSW | needed_mode))) > 0?
> 
> 
> 
>>  }
>>
>>  static notrace unsigned long canonicalize_ip(unsigned long ip)
>> @@ -191,18 +192,26 @@ void notrace __sanitizer_cov_trace_pc(void)
>>         struct task_struct *t;
>>         unsigned long *area;
>>         unsigned long ip = canonicalize_ip(_RET_IP_);
>> -       unsigned long pos;
>> +       unsigned long pos, idx;
>>
>>         t = current;
>> -       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
>> +       if (!check_kcov_mode(KCOV_MODE_TRACE_PC | KCOV_MODE_UNIQUE_PC, t))
>>                 return;
>>
>>         area = t->kcov_area;
>> -       /* The first 64-bit word is the number of subsequent PCs. */
>> -       pos = READ_ONCE(area[0]) + 1;
>> -       if (likely(pos < t->kcov_size)) {
>> -               area[pos] = ip;
>> -               WRITE_ONCE(area[0], pos);
>> +       if (likely(t->kcov_mode == KCOV_MODE_TRACE_PC)) {
> 
> Does this introduce an additional real of t->kcov_mode?
> If yes, please reuse the value read in check_kcov_mode.
Okay. How do I get that value from check_kcov_mode() to the caller?
Shall I add an additional parameter to check_kcov_mode()?
> 
> 
>> +               /* The first 64-bit word is the number of subsequent PCs. */
>> +               pos = READ_ONCE(area[0]) + 1;
>> +               if (likely(pos < t->kcov_size)) {
>> +                       area[pos] = ip;
>> +                       WRITE_ONCE(area[0], pos);
>> +               }
>> +       } else {
>> +               idx = (ip - canonicalize_ip((unsigned long)&_stext)) / 4;
>> +               pos = idx % BITS_PER_LONG;
>> +               idx /= BITS_PER_LONG;
>> +               if (likely(idx < t->kcov_size))
>> +                       WRITE_ONCE(area[idx], READ_ONCE(area[idx]) | 1L << pos);
>>         }
>>  }
>>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
>> @@ -474,6 +483,7 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
>>                 goto exit;
>>         }
>>         if (!kcov->area) {
>> +               kcov_debug("mmap(): Allocating 0x%lx bytes\n", size);
>>                 kcov->area = area;
>>                 vma->vm_flags |= VM_DONTEXPAND;
>>                 spin_unlock_irqrestore(&kcov->lock, flags);
>> @@ -515,6 +525,8 @@ static int kcov_get_mode(unsigned long arg)
>>  {
>>         if (arg == KCOV_TRACE_PC)
>>                 return KCOV_MODE_TRACE_PC;
>> +       else if (arg == KCOV_UNIQUE_PC)
>> +               return KCOV_MODE_UNIQUE_PC;
> 
> As far as I understand, users can first do KCOV_INIT_UNIQUE and then
> enable KCOV_TRACE_PC, or vice versa.
> It looks somewhat strange. Is it intentional? 
I'll fix that.
It's not possible to
> specify buffer size for KCOV_INIT_UNIQUE, so most likely the buffer
> will be either too large or too small for a trace.
No, the buffer will be calculated by KCOV_INIT_UNIQUE based on the size
of the text segment.

- Alex

-- 
Alexander Lochmann                PGP key: 0xBC3EF6FD
Heiliger Weg 72                   phone:  +49.231.28053964
D-44141 Dortmund                  mobile: +49.151.15738323
