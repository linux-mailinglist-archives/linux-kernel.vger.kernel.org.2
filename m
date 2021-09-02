Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20763FF54C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346444AbhIBVGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346354AbhIBVGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:06:30 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCE1C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 14:05:32 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id l10so3212374ilh.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UKQA6105U/KVkWHwxi6wOBNzf8KnL2jJdYFFqD/Cpts=;
        b=AL45Z9yfhzYsQXhwsWSSSzmSFoHTh1zXmGbd5aRZ7bMHRzX3/6EzZJOX+caYIleCK4
         yar37y95+8ts5wed/FTUHeCjZNtm9B/u5DEsYplmUreErb3Ii608+msxCKVLGx5fFIHm
         G4G2TdtEn1JmzXhnKwOYbw0CPuunD5ad2bh/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UKQA6105U/KVkWHwxi6wOBNzf8KnL2jJdYFFqD/Cpts=;
        b=SndkRqj6H//cbS8+PAZfwR1SXpTW2T9ElPNMIAPowtcXfSsr+DBS327KfWF5Jopp/c
         hwcjY/t1N4jKdIlt7tUw60LI0VajpGTvwTNLSJJnZaHcZ+vtjbdCv2i75Ba5iFpmNq2G
         bI0sObBA7c6HW+tcLKToq4v/0Pk/VuIjaJikK2H0bUxpRNfR6JZEm9IANS89Mcwwf1s7
         tFMLOdzXI5zCQRcKGqDEzexBz5J8Qt9NuFFWXBCzW3JwD3Qajx//MMcxQwy5PtE0lJiN
         C+TUb/gBy4bQWPO5hK3hmfRCn770x2YM7iKvE/Vc0Sqc1JD7xTkC0j8xcY/0o4kMFGa6
         T0PQ==
X-Gm-Message-State: AOAM530jaMMDo1IWqHWHelKQkyRIvNHAwjE2beedmWzds4pYVnDu8EZy
        ROq95hzNBrQqOAE7kqvld8cZSQ==
X-Google-Smtp-Source: ABdhPJw5GAc9DTRWylSMfJnI1zbZ0iQjuwMt7FZFYe2a3rMq6xrlZ5peC24FrbeFUtjMrOgHri01iA==
X-Received: by 2002:a92:c109:: with SMTP id p9mr98850ile.115.1630616731535;
        Thu, 02 Sep 2021 14:05:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d14sm1719037iod.18.2021.09.02.14.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 14:05:31 -0700 (PDT)
Subject: Re: [V3][PATCH] selftests/x86: Fix error: variably modified
 'altstack_data' at file scope
To:     Jun Miao <jun.miao@windriver.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210824024358.4183342-1-jun.miao@windriver.com>
 <09fb52ee-3041-991a-0277-ff01eef2643f@windriver.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c21053a0-c3bb-4cda-4f16-24427dd5b0ff@linuxfoundation.org>
Date:   Thu, 2 Sep 2021 15:05:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <09fb52ee-3041-991a-0277-ff01eef2643f@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 2:45 AM, Jun Miao wrote:
> Hi all,
> 
> What about this patch?
> 
> Thanks
> Jun
> 
> 
> On 8/24/21 10:43 AM, Jun Miao wrote:
>> Based on glibc 2.33 -> 2.34, there is one new feature:
>>

Please don't top post.

It is applied to linux-kselftest next for Linux 5.15-rc1

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

thanks,
-- Shuah
