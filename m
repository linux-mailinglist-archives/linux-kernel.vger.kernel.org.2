Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041153F2831
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhHTIQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhHTIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:16:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B9BC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:16:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso13235803pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ecM/6ojxZtANL/C/M4VUBHGG8yziqnnJSVmQ/MwMgJU=;
        b=dYWcrRFGVy+Hspxx11e/2FIBZDrV3bxa2lacG8O6IlMMM62HW/quyHYtMsVs+/Qbzu
         OA7KhrqGYcFoRDMe9gekLOYtFXHf2co/vXmhOocqfx4S/mlefCvCPHBLQgfahSfpVAiQ
         Gvjcb2ekAIWGyM4kRFTc6xNnwlzpD3lWnQ1leiQA8gVejGj2AVukgFPwNV4QYxfG7IvJ
         Y5wT4jiD7RTcDQbtYzNvkB0JcVE9JnX08v1VB0BJa7u/ncqkBlajAe35r6bm0fcNTuv0
         VhE5G2p9n/VcuGzZ3GWCrABQ3MLEcFDdf5APAm2xuNdwPTZRbb3RBBLPnUap7xhrxv1V
         yZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ecM/6ojxZtANL/C/M4VUBHGG8yziqnnJSVmQ/MwMgJU=;
        b=HK5qNbFte9sXZIavooC8/scluZkqOpxCj6R3APAsF4HaCPIl6m9TMosrszw90s6Izo
         CflF+a+hbYY2XvcPUdGZuwV6SuBIL42FdG35fC4oArsEW+YzidawDifgiWXsGhLGxIh8
         bSde+Pn7hKBir1hDc/8hINtntJ93/ONMNSQXX6T63wlh1G/iI4V4Nf8PldpO4cQu0OSK
         lO1JhIDebrpwIrGMd6mU7dwZYvTRkQxdQ7LPtXIQ9JeksZXB1MRCPFd1GVAkkNh45ejQ
         qKcvsX+UmENGnu1yHKqdSEvDdsrYO7BLbzytVcVwck5/Lb+DDCEK45vuC312WUEpVSNg
         zrGQ==
X-Gm-Message-State: AOAM5303Mf71x550AgQ6zUQ5cAc7K0/q5wOhlDn3ZF1UBrhO3n9UFSW0
        R82JUVAxvTlVg8HVYVRohmeGhtb6iKM=
X-Google-Smtp-Source: ABdhPJyCSGe/hfzAk/jJoivsKxpsVAEPc7XenK2xB+GtUdWIqsUhGpzvYjAu7Vc8MhOyAhOAOxtUOA==
X-Received: by 2002:a17:90a:2f44:: with SMTP id s62mr3374998pjd.222.1629447365080;
        Fri, 20 Aug 2021 01:16:05 -0700 (PDT)
Received: from [10.133.0.54] ([85.203.23.237])
        by smtp.gmail.com with ESMTPSA id n15sm6081871pff.149.2021.08.20.01.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 01:16:04 -0700 (PDT)
Subject: Re: [BUG] fs: dlm: possible ABBA deadlock
To:     David Teigland <teigland@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
References: <79f8d302-f53f-3891-965a-bcb460ab15ca@gmail.com>
 <20210819155509.GB21218@redhat.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <fbf23736-26a7-7442-2c19-ae0bea25b296@gmail.com>
Date:   Fri, 20 Aug 2021 16:16:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20210819155509.GB21218@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/19 23:55, David Teigland wrote:
> On Thu, Aug 19, 2021 at 04:54:57PM +0800, Jia-Ju Bai wrote:
>> Hello,
>>
>> My static analysis tool reports a possible ABBA deadlock in the dlm
>> filesystem in Linux 5.10:
>>
>> dlm_recover_waiters_pre()
>>    mutex_lock(&ls->ls_waiters_mutex); --> line 5130
>>    recover_convert_waiter()
>>      _receive_convert_reply()
>>        lock_rsb()
>>          mutex_lock(&r->res_mutex); --> line 69
>>
>> dlm_recover_waiters_post()
>>    lock_rsb()
>>      mutex_lock(&r->res_mutex); --> line 69
>>    mutex_lock(&ls->ls_waiters_mutex); --> line 5307
>>
>> When dlm_recover_waiters_pre() and dlm_recover_waiters_post() are
>> concurrently executed, the deadlock can occur.
>>
>> I am not quite sure whether this possible deadlock is real and how to fix it
>> if it is real.
>> Any feedback would be appreciated, thanks :)
> They won't be concurrent, "pre" runs before recovery, and "post" is after.

Okay, thanks for your reply :)


Best wishes,
Jia-Ju Bai
