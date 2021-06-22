Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3F3B03AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhFVMHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhFVMHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:07:46 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361D2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:05:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g192so8562574pfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Y5Xd78GOu9lf6VGo75b/TA4qnuHXHBd8W++bq5LOH+4=;
        b=NL1K7FSeYlvZGEB8KXoGhN+/g5qyYPDTIiWCjGX5UcORupJdb/yXhs7Z5GwVqaX8oY
         oho4+RSnvmXCojlsxXcfaeS+oC4Hq/t1ehzUg/nQqDX9TWksefnRNlNnSej24o1H09gI
         AfKJXYQX/y+MtrmADeEe1OuecTCzOffJsLGxMYDiS8PxjF8e3cK6VFct1RMI5HUrmaz9
         nIzl8Bh4Xe+zJGev9J5Uy/zvW91o0q3ugJqfmsYM7S4hcMdN2Gavowv9KmTkmTaWL1j3
         oWlbzbyTOlRfXYnefMMCM0EOKKT6s9IbVBzcfkQBlxWE7blqdEMi6zgwBkj8jsALWAF9
         n/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y5Xd78GOu9lf6VGo75b/TA4qnuHXHBd8W++bq5LOH+4=;
        b=FA3c+Yqw2NWNxhhzBRKSdm1A018e4ddjRmaIDD8xsV5+52+dE+BkCEjckRQ8E2wSmA
         uJrk4inRuYhdvGgh3AGAs5bC09P5+i+EG620DcIwkD4uvOkJ2KCoAd13ONtGr8Ixfg4P
         79UvpO530U94eLGv7YkYItMrjz2+lMJCdGQtNN10AGfgUPICA2QBFBFSFVK90v94nj2k
         Zmp2Mr2f6tp7JJAIvGm5MCMiZqiSe0mh2aonJ4E2uWUY4GXCiBggtB4Hr7VSzlKUpPF5
         drXkcIhCwsysSBmiLqk69aMqq+1Xvv6ucSRhSGAAXXGKt3VYbqOno+pxNxpHs0yskehU
         vWaQ==
X-Gm-Message-State: AOAM53354jU63Z7fJa0LvklKNJ3JyqzI8ELrNzhBigzc6XhrtiCe4AAI
        uih61dqpYeZlD91Y8mfnY8M=
X-Google-Smtp-Source: ABdhPJwEmLqFurG6dRqn42RL70KDNQxGKHpGZp9KdHcv3WBMTCcNa734K58EiVGU/y+UeF/BvFcj3Q==
X-Received: by 2002:a65:5c4a:: with SMTP id v10mr3456442pgr.142.1624363530586;
        Tue, 22 Jun 2021 05:05:30 -0700 (PDT)
Received: from [192.168.1.153] (163.128.178.217.shared.user.transix.jp. [217.178.128.163])
        by smtp.gmail.com with ESMTPSA id c68sm5923987pfc.75.2021.06.22.05.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 05:05:29 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] riscv: improving uaccess with logs from network
 bench
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
 <e7d5f98b-5e0d-19b3-08f5-a7b49d542a85@codethink.co.uk>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <f54ec904-2bf5-0c29-d467-7465993d5d6b@gmail.com>
Date:   Tue, 22 Jun 2021 21:05:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e7d5f98b-5e0d-19b3-08f5-a7b49d542a85@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/2021 5:30 PM, Ben Dooks wrote:
> On 19/06/2021 12:21, Akira Tsukamoto wrote:
>> Optimizing copy_to_user and copy_from_user.
>>
>> I rewrote the functions in v2, heavily influenced by Garry's memcpy
>> function [1].
>> The functions must be written in assembler to handle page faults manually
>> inside the function.
>>
>> With the changes, improves in the percentage usage and some performance
>> of network speed in UDP packets.
>> Only patching copy_user. Using the original memcpy.
>>
>> All results are from the same base kernel, same rootfs and same
>> BeagleV beta board.
>>
>> Comparison by "perf top -Ue task-clock" while running iperf3.
> 
> I did a quick test on a SiFive Unmatched with IO to an NVME.
> 
> before: cached-reads=172.47MB/sec, buffered-reads=135.8MB/sec
> with-patch: cached-read=s177.54Mb/sec, buffered-reads=137.79MB/sec
> 
> That was just one test run, so there was a small improvement. I am
> sort of surprised we didn't get more of a win from this.
> 
> perf record on hdparm shows that it spends approx 15% cpu time in
> asm_copy_to_user. Does anyone have a benchmark for this which just
> looks at copy/to user? if not should we create one?

Thanks for the result on the Unmatched with hdparm. Have you tried
iperf3?

The 15% is high, is it before or with-patch?

Akira
