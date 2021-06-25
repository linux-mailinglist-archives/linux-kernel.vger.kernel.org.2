Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9227A3B48A7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 20:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFYSOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYSOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 14:14:52 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F38C061766
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 11:12:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id a133so10033947oib.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ct3MQ6EVGM3aUC7kPQsBxLhhRATM6qEQXZLBxW0+bMo=;
        b=aM4YYWm3TCNLwJGKsVoi4ObhIrMX9cS4+PhwDhut28/lIHUlnaoGUoZlbMJpfcAVH2
         Crqt8VaEj3oWzqiAZ1IxNdtM7Zm15DaUlK+bygIn+zSTAJNdyYLiGXhK9yCE+fOQAVV3
         2qOuMrjkbd8h2cX3ecger1+dJBawPtF5Awj0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ct3MQ6EVGM3aUC7kPQsBxLhhRATM6qEQXZLBxW0+bMo=;
        b=r6yvfBO10cNKWVK9Yyf9eNR65TgsKN1/agi/tZAt7TcIjJM7Tv3nrsJASBnRWznS9J
         26dLrGFp0g/c9uRAmwCoH6Fqr1kcPQZ4dZxcjcJ191ZDeQGqCCxrUhIINYkwrCmnuVsy
         Roq+TOfIV57hm4mclc12LW5drxbzZOHGkpUE6xuhJyNBpVgL3qjUO+zPWtBJ7qDipvYq
         wm2zNC0/o9+asYSUM5D03zigwxkjuleSj/Rgoi0YuClHaRjJUjrMxY+1UniEZYU7Okm+
         YTOJuGK4Q4r0DBSrHewtijbfQSj3OwCgOBKu4SMIpCU+TW6GCIKcirznmqcd30UlGoHq
         QnpA==
X-Gm-Message-State: AOAM533fZz5XGlORZUrSVgQrl2L3SXTXcdzmMMP1oBDIE2P1s+KdrP5Z
        229X8srtrCT7pgKf8a7VTNBLMg==
X-Google-Smtp-Source: ABdhPJy0vTlLWhAH/nfZsF4MeA6KtEu6NoNfDV8FVVnCJe3M7Bswjy+W6GvO9VUeVbNYyv9/gdA5Aw==
X-Received: by 2002:aca:f0d5:: with SMTP id o204mr9178716oih.71.1624644750009;
        Fri, 25 Jun 2021 11:12:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u206sm48012oif.17.2021.06.25.11.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 11:12:29 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the kunit-fixes tree
To:     Daniel Latypov <dlatypov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210625195232.3a307e53@canb.auug.org.au>
 <CAGS_qxq4_G7dbefETo57hUZgD+A3QK7rxiY=Nk=m0xZGt35zGw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4f1fc11b-64a6-984f-ede3-d4ce5c0ac3e3@linuxfoundation.org>
Date:   Fri, 25 Jun 2021 12:12:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAGS_qxq4_G7dbefETo57hUZgD+A3QK7rxiY=Nk=m0xZGt35zGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 11:53 AM, Daniel Latypov wrote:
> On Fri, Jun 25, 2021 at 2:52 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> After merging the kunit-fixes tree, today's linux-next build (powerpc
>> allyesconfig) failed like this:
>>
>> lib/kunit/executor.c:26:1: error: expected identifier or '(' before '+' token
>>     26 | +kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
>>        | ^
>> lib/kunit/executor.c: At top level:
>> lib/kunit/executor.c:140:10: fatal error: executor_test.c: No such file or directory
>>    140 | #include "executor_test.c"
>>        |          ^~~~~~~~~~~~~~~~~
>>
>> Caused by commit
>>
>>    c9d80ffc5a0a ("kunit: add unit test for filtering suites by names")
> 
> For posterity, David sent out a patch addressing this here:
> https://lore.kernel.org/linux-kselftest/20210625111603.358518-1-davidgow@google.com/
> 

It is all fixed now. When I applied this patch yesterday, I needed to
fix merge conflicts. When I did that the newly added file was left
behind.

Build didn't find it since the file was in the repo. Oh well. So much
for trying to save you a rebase.

Sorry for the trouble. It should all be squared away now. Build and
exec tested it for sanity.

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=1d71307a6f94df3750f8f884545a769e227172fe

thanks,
-- Shuah
