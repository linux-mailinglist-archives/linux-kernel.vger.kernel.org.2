Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C0C38C5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhEULnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhEULm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:42:58 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3CBC061763;
        Fri, 21 May 2021 04:41:35 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id y76so10106174oia.6;
        Fri, 21 May 2021 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XHcOClEnqFRTGY7SbhLfjPRUQYzZ9hMkf86ng6qGxhM=;
        b=tVwJsMnFttY4NAXHEn3Ogw7kVL+1MR8xmImeOthNZhydIEiPadgYGNnxITv/xSYwoP
         yhK48gDIhny7wQZELy46oVg5MdZFTTj9LRBVHthtJ+K9mTC2A/own9uvtXQ12uHXaKXx
         PZ5Qy21mSR8ltx3f7fpfWyNU4aF2CUo6qKS0ixCwgvYoHDsNszltRcawuEuNEgIMAvgf
         CJ4Qs7QUtIc0+W7/iqXsh+GgwZsV72hcyizU9/0b6VxOWx1qvHi9r+YA+1LkyMNASULl
         LBMWr/AUcA0bq/lwMZznzsMU0EDZmQ+8PGLYzbChPHRVYCiQUB+VQO0jZrmnuJKjYl/1
         8Esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XHcOClEnqFRTGY7SbhLfjPRUQYzZ9hMkf86ng6qGxhM=;
        b=QzAlxLHM0fnv90oUvcSChL+kIUbUlFM00t+mReFW3Zf0XWt9LH6Wpym2mq7tlD4v7e
         DLdjrD10ERYIe+Z00Suxf5Y5e8TyS2V0+4ZHiTLDlgmGt4u79i4RgydtupTOQ6myGjTb
         FsscHe0uTuAMXy5v+Eywjq9K1o2abn8FvWOnVuO/xsiPg+gituf3FcmxQpeBCB2/LL/Z
         P1dAxinxDWFkrop8iscpSoR4IJeOFkAiZvPY3T6oUc147cfl0HSllYRjIjgebrXGJFLd
         gWF4wMzIiyvWBdsHF1jo/8BKp+Ft450TdgNF8zt0BE4HOUsd8UG+X5nnj3MpbEHl5HyM
         iolQ==
X-Gm-Message-State: AOAM533TtMucv0RPbO9rqjCenBA4ukrYUbm05IcxvTWYTAnzKKhn1N3s
        6D2XU/XWOY3EaUu0rb7IoUs=
X-Google-Smtp-Source: ABdhPJyvbmxISuKd4bgYXqiJFYbJwqXPphss630q/1QfZNqiqKfI2ckKhI5n70t9SR1hsxW/scpmFg==
X-Received: by 2002:aca:a9c6:: with SMTP id s189mr1885086oie.92.1621597294632;
        Fri, 21 May 2021 04:41:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w20sm1088939oic.54.2021.05.21.04.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 04:41:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
References: <20210430132735.127342-1-robert.marko@sartura.hr>
 <20210430134810.GA2714262@roeck-us.net>
 <CA+HBbNH+gQOmu_Ho0ivFuGHdu0zBtOrr1474z+7FA1zmNb4bug@mail.gmail.com>
 <2b990feb-dc26-debb-4f81-430bbc89b51c@roeck-us.net>
 <CA+HBbNHQHqD-wgryaBLZ5M2Lxafb0OwNcbiQJmRQPcZfprmUEg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
Message-ID: <cfbe487f-8d01-e9b7-0aae-f93a27aff023@roeck-us.net>
Date:   Fri, 21 May 2021 04:41:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+HBbNHQHqD-wgryaBLZ5M2Lxafb0OwNcbiQJmRQPcZfprmUEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 1:36 AM, Robert Marko wrote:
[ ... ]
>> In this context, I have a hard time finding a reference for
>> this power supply. Do you have a datasheet or some other documents
>> you can share ?
> 
> Unfortunately, I don't have a datasheet as that would have made this way easier.
> It was all based on the vendor "driver" from DENT:
> https://github.com/dentproject/dentOS/blob/main/packages/platforms/delta/arm64/tn48m/tn48m-poe/modules/builds/src/arm64-delta-tn48m-poe-psu.c
> 

Ah, so this is not a driver for a power supply from DeltaPSU,
but a power supply from Delta Networks Technology Corporation,
as used in that company's TN48M-POE switch. That is a world
of difference, even though the parent company seems to be the
same. I am not sure if, based on this information, the driver
should claim to be for "Delta DPS-920AB PSU" in the first place.

Can you run a block read on MFR_MODEL and MFG_SERIAL ?
That might give us an idea about the actual manufacturer
and model of this power supply.

Also, isn't that the same power supply for which you were
trying to add another hwmon driver to display some of its
status information, obtained from some CPLD ?

Thanks,
Guenter
