Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B003357678
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhDGVEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhDGVEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:04:47 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD88C061760;
        Wed,  7 Apr 2021 14:04:36 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id j7so14839023qtx.5;
        Wed, 07 Apr 2021 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ffmLm2hyUUXP4LxBQtwBNm73vqUptqsi9ePxQY+FZvU=;
        b=YzM+yb8KPifbWBcac+0REB2CbJeNc+LYrxRzU7ifShNBBHeADCOkTAMu95e/5JLILy
         B3exdf2S7vyQSY0VnnBLVeRlI30ncDVBt9Nh9GUKcsAZnpPlEhm6oBOAfKvvuBgg9YOc
         Jb4x9gr2a2Hm40lEQHDgudnVbR+z8422z5J9ZdSp7gnwA/b6TDJZ2k3K6eGSJs/MQNUm
         BOkDo/FBphxD5Augclk+YISNlYDMUiYlvOQ4HN1pt788iZmnOzV9Lb8XGnBUE2nN3uJu
         Cm9MY3PTa8YY3UezxdwRH+C82okupzDvarGmq372lVadGZFZYn1YTr0fr7F8TiJIecV8
         Z0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ffmLm2hyUUXP4LxBQtwBNm73vqUptqsi9ePxQY+FZvU=;
        b=rw8rBxbWxY9kKJOAyJOknEgu5Lytwn1ttkFQp4HwByorhZnA3KgV4LDxIZ6o+AA3h1
         X0g3hG5AuXmqjjAGt2U5HiCvHdEIBQnDh3Ccyziu/M69dUIHJDST3I/9otGQZ4Tfm3Bv
         LD31dYSPT8mmr234uNOSnPqwqaHlvsVhThVjaCdlKhZfmJ0FjBT3Q3LfCYJMiJ7lxIJ6
         tqsaKOeZROCMWDNswVIG/CJbjPQGnTNxdYsqa/ic0Xt0MN4k4Y/qRtaQl7mlakfCUvNz
         YVE7TC7ofiFrnRJhSsNJTOZyGpWv0mhNvYjvHMU199pOA9pIm4K9QZoldUFAft+R07iB
         6WPw==
X-Gm-Message-State: AOAM530ATUHVU0afAgRVWf0rOhEBsOFZa9vsLTJuuArgJEWh7EEkiOW2
        pBUYIkJvjvrAaUDf7CEh5Vs=
X-Google-Smtp-Source: ABdhPJzwOGhYmXE75VXZu3QgKgD+ug/07IGkx4FUKDMaQMhxSrpSQ3I2PJJN26zxCoIcSZHYqiM5QA==
X-Received: by 2002:ac8:5a51:: with SMTP id o17mr4467902qta.116.1617829475672;
        Wed, 07 Apr 2021 14:04:35 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id m8sm9596077qtg.67.2021.04.07.14.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 14:04:35 -0700 (PDT)
Subject: Re: [PATCH 1/1] of: properly check for error returned by
 fdt_get_name()
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
References: <20210405032845.1942533-1-frowand.list@gmail.com>
 <20210406192100.GA2050740@robh.at.kernel.org>
 <86171ba4-7251-2a3b-01fe-5da4af3eb8af@gmail.com>
Message-ID: <2c430615-22ac-2769-9348-f6ccbae6e3f7@gmail.com>
Date:   Wed, 7 Apr 2021 16:04:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <86171ba4-7251-2a3b-01fe-5da4af3eb8af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 3:30 PM, Frank Rowand wrote:
> On 4/6/21 2:21 PM, Rob Herring wrote:
>> On Sun, Apr 04, 2021 at 10:28:45PM -0500, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> fdt_get_name() returns error values via a parameter pointer
>>> instead of in function return.  Fix check for this error value
>>> in populate_node() and callers of populate_node().
>>>
>>> Chasing up the caller tree showed callers of various functions
>>> failing to initialize the value of pointer parameters that
>>> can return error values.  Initialize those values to NULL.
>>>
>>> The bug was introduced by
>>> commit e6a6928c3ea1 ("of/fdt: Convert FDT functions to use libfdt")
>>> but this patch can not be backported directly to that commit
>>> because the relevant code has further been restructured by
>>> commit dfbd4c6eff35 ("drivers/of: Split unflatten_dt_node()")
>>>
>>> The bug became visible by triggering a crash on openrisc with:
>>> commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
>>> as reported in:
>>> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
>>>
>>> Fixes: commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>
>>> ---
>>>
>>> This patch papers over the unaligned pointer passed to
>>> of_fdt_unflatten_tree() bug that Guenter reported in
>>> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
>>>
>>> I will create a separate patch to fix that problem.
> 
> Likely to be tomorrow (Wed 4/7).
> 
> -Frank
> 
>>
>> Got an ETA for that?
>>
>> Rob
>> .
>>
> 

The patch to fix the alignment issue is:

  https://lore.kernel.org/linux-devicetree/20210407205110.2173976-1-frowand.list@gmail.com/

Hopefully it will pass testing by Guenter.
  
Sorry about the previous vertical dyslexia response... :-)

-Frank
