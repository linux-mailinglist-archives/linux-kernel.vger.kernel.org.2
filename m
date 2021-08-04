Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34E83E099A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 22:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbhHDUsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 16:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhHDUsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 16:48:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E42C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wAqDBGufZ3HnG8iKRVoSJO5xND5+Q2Z3LVLdxKZmvQg=; b=HkgWi2xHWKArlqsFTmW3AiPb6F
        bCoFY1WBZnPDv0BEYvEmSyPu5s7dRCKPbRvnndUuIhYyhhXwKbSwt0Pgib3WFCojfY9SEhvJTt7Ir
        X7J9VVA03mVEcSWu/kQ8XpWFm7R5YoKROb9Yd6vtxUjVHHPVBzPA5CZ8+pETAMJEU1mqClFd3nPFc
        S9oJ4k3euzuTkk7sKguB3m33DwvB+EpIEpPrBMVb39Lw3whcsSCRA1fOfCbiY6RK28MoODV/ogmpU
        cWDEkLUx1R0LA+HUpCkjtYiv5LDw9JboHu7zmZh4XAN3kkX/8+sj06YQbELTTUgt8kPllYO2mGtFx
        hiM2X/YA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBNna-006Han-F2; Wed, 04 Aug 2021 20:47:40 +0000
Subject: Re: linux-next: objtool hang/loop?
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <be49b820-434f-cebe-0902-3d5177239233@infradead.org>
 <20210804183419.k7p3tvqerwgzxpuz@treble>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f45ba1d7-a175-c284-5489-b2c2eaa7131c@infradead.org>
Date:   Wed, 4 Aug 2021 13:47:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804183419.k7p3tvqerwgzxpuz@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 11:34 AM, Josh Poimboeuf wrote:
> On Wed, Jul 28, 2021 at 07:25:21PM -0700, Randy Dunlap wrote:
>> Hi Josh & Peter,
>>
>> Yesterday (2021-07-27), one of my x86_64 randconfig build ran for
>> over 2 hours (it's a slow core i5 laptop and spinning rust media).
>> I killed it and reran the .config file today on linux-next-20210728.
>> I killed this one after 30 minutes on its last message:
>>    OBJTOOL vmlinux.o
>>
>> This is a .config with # CONFIG_MODULES is not set.
>> vmlinux.o is 253 MB in size.
>> I see that using verbose make (V=1) won't help me any here.
>>
>> The problematic (if it is a problem: maybe I didn't wait long
>> enough?) .config file is attached.  The gzipped vmlinux.o file is at:
>>    http://www.infradead.org/~rdunlap/vmlinux.o.gz
>>
>> If there is a problem, I can test any patches...
> 
> Hi Randy,
> 
> I'm guessing your laptop doesn't have a lot of RAM.  I ran

Hey, it has a whopping 6 GB of RAM. :)

>    /usr/bin/time -v tools/objtool/objtool check --noinstr --vmlinux --no-fp --uaccess vmlinux.o
> 
> It showed a max RSS of 6.5GB.
> 
> Can you try this patch from Peter?  It halves the memory usage.
> 
>    https://lkml.kernel.org/r/20210507164925.GC54801@worktop.programming.kicks-ass.net

Yes, that fixes the problem for me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy


