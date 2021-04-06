Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46A355CE4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245347AbhDFUaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhDFUaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:30:13 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8995C06174A;
        Tue,  6 Apr 2021 13:30:03 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c4so16450472qkg.3;
        Tue, 06 Apr 2021 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rFWTvnpJmpxXvRgAFEwpmVlAO1PN7uCT5Wr0ZlRsOlg=;
        b=i0XGu1GuQ73wV+fSkC0Cy6ZaKgG66Ke4Lr3E5zNTArNo+f3Cas7wa9fOEgvJmFm8XE
         SGIk2LCWA7ZEGGXUy0Xs1NEt7VT4fzVPZpA7hoo0zIfZxtoK6WfK7eisOC7axcR+pR1m
         SIqYfIny93LIMsq6Kk7Iii2jcOHSMfpJjl5tjhGK/gVVWmJl1Omi7xf/ZNvoVnTDIsyY
         UkXJl7y7WPQEQ187i6zd0vB0MG8CsJyByuwwhgIJ1FyTKsEWSmxRx0LR6hDeAw6uhAXm
         ffFVnxhHpUZgYUlMTXkiWjqBqof24qTJVx1/8bxyeRmvc82nmYQMBLtjRw8oHufFUb7f
         BzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rFWTvnpJmpxXvRgAFEwpmVlAO1PN7uCT5Wr0ZlRsOlg=;
        b=JopdFH3oZ8sAmMUkkaLOA4BbLP8eUGO21i4mThQnA5VFznHliTjJRkYUItj5qOS7mt
         /WT4hq5Bk0xoCkbFaj+LzwLOmsyn2hnEjGz5okejtJM8XaloahuDrx6mBKGRQnJ4uvfh
         aiRw99t6rDVDsObJ4ELC73jLWf+9yo486Ud5Dx4E907qrmxx07ukZHYRktcsRog+pZFI
         R4z7GdjAUMb2GUaaKvxIBQxOk8LHtRQC7HbjGjc7Wr4D1WnSxqlejETvJbUSyYz8KR0p
         zRZh0CiGNiYf7D8ouUxdXS8l1ADTBhkk3kjnCdNruc1c2VN76wPD4D6VOJdyDCc41bz+
         jOsw==
X-Gm-Message-State: AOAM533dJhANT+bBWTkkyVCAV1j7NOVPJgeU39itfsM9EMQJ1yHTHiyM
        V5/7mYFH+7eYmx5/KDl5C7g=
X-Google-Smtp-Source: ABdhPJyTKwBCExnMK0DlX3zcyPIut/98t2ajn30cpY+OtX+QH1Z9muYVhE0Z7q7tmGreQuvQ6agAzQ==
X-Received: by 2002:a37:7c8:: with SMTP id 191mr31272465qkh.53.1617741003128;
        Tue, 06 Apr 2021 13:30:03 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id 75sm16445829qkd.114.2021.04.06.13.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 13:30:02 -0700 (PDT)
Subject: Re: [PATCH 1/1] of: properly check for error returned by
 fdt_get_name()
To:     Rob Herring <robh@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
References: <20210405032845.1942533-1-frowand.list@gmail.com>
 <20210406192100.GA2050740@robh.at.kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <86171ba4-7251-2a3b-01fe-5da4af3eb8af@gmail.com>
Date:   Tue, 6 Apr 2021 15:30:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406192100.GA2050740@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 2:21 PM, Rob Herring wrote:
> On Sun, Apr 04, 2021 at 10:28:45PM -0500, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> fdt_get_name() returns error values via a parameter pointer
>> instead of in function return.  Fix check for this error value
>> in populate_node() and callers of populate_node().
>>
>> Chasing up the caller tree showed callers of various functions
>> failing to initialize the value of pointer parameters that
>> can return error values.  Initialize those values to NULL.
>>
>> The bug was introduced by
>> commit e6a6928c3ea1 ("of/fdt: Convert FDT functions to use libfdt")
>> but this patch can not be backported directly to that commit
>> because the relevant code has further been restructured by
>> commit dfbd4c6eff35 ("drivers/of: Split unflatten_dt_node()")
>>
>> The bug became visible by triggering a crash on openrisc with:
>> commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
>> as reported in:
>> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
>>
>> Fixes: commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>
>> ---
>>
>> This patch papers over the unaligned pointer passed to
>> of_fdt_unflatten_tree() bug that Guenter reported in
>> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
>>
>> I will create a separate patch to fix that problem.

Likely to be tomorrow (Wed 4/7).

-Frank

> 
> Got an ETA for that?
> 
> Rob
> .
> 

