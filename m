Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08C73DE482
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhHCCqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 22:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbhHCCqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 22:46:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A01C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 19:46:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ca5so27788700pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 19:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Yk5HA+RCKHucxQd1hb4X8opTplCmtw5uKcxcakFiF0U=;
        b=MaG58TNhD4YNzQyT3/dmEVsU7r4gkAb1PD/HMSjheFBh4SDFSb6bqqYXazBNxJpdeV
         XPjGsWWDDpw7GC3r7Ib63O6iufdA0E29ko7akAMpPlUjf2zZfDn7iA4F20oW4i/8MOW9
         ujSt5aPdaCeNwfSFK2nXXUj4WZqEg3Jhcq3PK5WRGPFeK3aFcwrXHRWLhfQ3P686HHa8
         VyRGtD+H0g5LuK2Kotp9ubmv9UIAMBntG5ekjsscAgsygd0X1523gfP+kkf9FKTxdE/E
         vc4klUtLOYq9cEByFZSO2AmuRh4QX/hZbLIPO9eC3sP6Trs7zXqoHVt1gU7BgxMcUEYn
         QPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Yk5HA+RCKHucxQd1hb4X8opTplCmtw5uKcxcakFiF0U=;
        b=a7/dE2NlKcnxuz7wLdROK6lEPwQk9Wl+ec+hEV2vBQTVnvNa9GXEh5JmvY+mXjdgo2
         /gTGY6pnRHvI53egxzzZp7Mtfms1dFwhEvjI9bgBpS0xhfmXtxK/DCYgiSg9Lj9PLRfj
         +5gD2J/hidAG2Fdv0jN/w01G3VthLVlZH3LKkmsRQdRaYEu4l1s3zcb/GYBEqGDQcSpD
         +rpgDcQ+a9t8p4BpYOllZRMMlbBu43wcR3jlLkzEp0jccdXq2UShB3y4w9QwYK0+iGM3
         n8+kROq48YTuoKnsBvlmxwcRz8K5WaKxhnZi1kU5SLg36GFa+PmcnNp8tonz4wa1nmo1
         1p/Q==
X-Gm-Message-State: AOAM530h7+laUOxLt+704e/l+ipHmT0dEJ5X1jm17OyKl4VF0jgMXbsH
        fuaaalBY5Pd5IPfKRVpa5BQ=
X-Google-Smtp-Source: ABdhPJwZS5jd92KVmGgS4zUDIGxaEMC8bTGpcCpTB+MRGs/Z5typsAOun/fc/bi5Awfz1SP4o/kvHA==
X-Received: by 2002:a05:6a00:1305:b029:347:676:d38f with SMTP id j5-20020a056a001305b02903470676d38fmr19626430pfu.39.1627958791419;
        Mon, 02 Aug 2021 19:46:31 -0700 (PDT)
Received: from [10.58.0.94] ([45.135.186.121])
        by smtp.gmail.com with ESMTPSA id j19sm13396893pfr.82.2021.08.02.19.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 19:46:31 -0700 (PDT)
Subject: Re: [BUG] jfs: possible uninitialized-variable access in xtSplitUp()
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com
References: <6b3b3a56-b77c-aff7-c9f1-94a99d4929d2@gmail.com>
 <a01909f1-19d9-8b3e-f772-3aa03b9b139c@oracle.com>
From:   Li Tuo <islituo@gmail.com>
Message-ID: <09905e41-c450-df22-45bb-746be314ecc5@gmail.com>
Date:   Tue, 3 Aug 2021 10:46:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a01909f1-19d9-8b3e-f772-3aa03b9b139c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your feedback, and any feedback about the further check would 
be appreciated!

Best wishes,
Tuo Li

On 2021/8/3 3:04, Dave Kleikamp wrote:
> On 7/31/21 1:31 AM, Li Tuo wrote:
>> Hello,
>>
>> Our static analysis tool finds a possible uninitialized-variable 
>> access in the jfs driver in Linux 5.14.0-rc3:
>>
>> At the beginning of the function xtSplitUp(), the variable rbn is not 
>> initialized.
>> If sp->header.flag & BT_ROOT is true,
>> 780:    rc = (sp->header.flag & BT_ROOT) ? xtSplitRoot(tid, ip, 
>> split, &rmp) : xtSplitPage(tid, ip, split, &rmp, &rbn);
>>
>> the varialbe rbn will remain uninitialized.
>> However, it is accessed through:
>> 814:    rcbn = rbn;
>>
>> I am not quite sure whether this possible uninitialized-variable 
>> access is real and how to fix it if it is real.
>> Any feedback would be appreciated, thanks!
>
> I think the logic that protects us is that in the case where rbn is 
> uninitialized, sp->header.flag & BT_ROOT, which means it SHOULD BE the 
> last entry in btstack, so we shouldn't enter the loop:
>     while ((parent = BT_POP(btstack)) != NULL) {
>
> It does seem that some type of sanity check is warranted. I'll take a 
> closer look and see if I can add some kind of error path if things are 
> out of sync.
>
>>
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>>
>> Best wishes,
>> Tuo Li

