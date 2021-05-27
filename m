Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F37D3927BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhE0GjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 02:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhE0GjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 02:39:13 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6775AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:37:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id v14so2945925pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tf0o2vs0T6C29p93j+xX0Wb3cwZvOLfvMJ6EQ3nK0vA=;
        b=xOKj/CYrKJUifx2Y1O2r/iim5TBbQkrFqHQG+JEt6BSAHhtB3ABMnhb4AYCRA+wd6m
         9DgFq5DuRtejpr2r6eraIjnd7abCzgRs6v151vWtWmZu/VD45J69mJTWsOCmQwe0GLnb
         AmJCsx4qjZwnaLE6hpmofoqWdfMsL9FUR8/HTCMctf/sWAFX3AEyYm+mmRRPByJW3szX
         tvrg2RMf4jL5D/+5rpkFkr9vtdOzl5yQZTgAH70iaabGqEF3SMMMWquZq9ciHSNuiCCm
         5zaAK7Zdm/0unV0FLMJFa9bMQVSDRBnC96wEFkeuyPN4W3pkJ1He61HoHo8hE8NPHJWr
         731w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tf0o2vs0T6C29p93j+xX0Wb3cwZvOLfvMJ6EQ3nK0vA=;
        b=Pphw2lv+ZNGScH+y6oDbm65vBXhjsoZaLOXwguc3f1ql1lc7Ik6QwKUebOcTlNMaBd
         JXasymwbMhmhIwHcPSyeOdYiXRGi1JtwlZZhPhtDnP/hDw3YMgojEpBabfxTfn9KlMKT
         JMPg4qT8j0Okdg1eDQ0pdMA2HEk1XzLM+S4un0mJ/co5vYtyPogl9u8Ryv7nkk5Fuz8o
         KDDO2yQk12E6j9kW4vGwyQtfajfBfkPVcJvggS4wgGmpTLlPv1vq7cnpfQ3x60wc7qa+
         Iei72UrHQPQpv+laLyf4xHIDWZpGbxs1hlqOyRIlLiKqHW/mq6F+IEi3rzm+9JtKi7iJ
         VSPA==
X-Gm-Message-State: AOAM530hhJxKsm/D1IOgKEoexuyOwKoUxOQOSTQeBC2ogkQ9Gq1IxXBq
        CIgVH9drOwcQ43QPdoewmy5PZA==
X-Google-Smtp-Source: ABdhPJzZaq8D6xBG+Thlxap9mTdChxd1tyEKxVIfetix/NPBx1jmzHIargKuNUFgELkX/csEHlvqmg==
X-Received: by 2002:a63:f245:: with SMTP id d5mr2289866pgk.416.1622097459337;
        Wed, 26 May 2021 23:37:39 -0700 (PDT)
Received: from [10.86.119.121] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id p18sm979473pff.112.2021.05.26.23.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 23:37:38 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] fs/proc/kcore.c: add mmap interface
To:     Andrew Morton <akpm@linux-foundation.org>, adobriyan@gmail.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com,
        chenying.kernel@bytedance.com, zhengqi.arch@bytedance.com
References: <20210526075142.9740-1-zhoufeng.zf@bytedance.com>
 <20210526173953.49fb3dc48c0f2a8b3c31fe2b@linux-foundation.org>
From:   zhoufeng <zhoufeng.zf@bytedance.com>
Message-ID: <5faab938-8eb9-268b-e45d-b33e6a9089d6@bytedance.com>
Date:   Thu, 27 May 2021 14:37:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210526173953.49fb3dc48c0f2a8b3c31fe2b@linux-foundation.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/5/27 ÉÏÎç8:39, Andrew Morton Ð´µÀ:
> On Wed, 26 May 2021 15:51:42 +0800 Feng zhou <zhoufeng.zf@bytedance.com> wrote:
> 
>> From: ZHOUFENG <zhoufeng.zf@bytedance.com>
>>
>> When we do the kernel monitor, use the DRGN
>> (https://github.com/osandov/drgn) access to kernel data structures,
>> found that the system calls a lot. DRGN is implemented by reading
>> /proc/kcore. After looking at the kcore code, it is found that kcore
>> does not implement mmap, resulting in frequent context switching
>> triggered by read. Therefore, we want to add mmap interface to optimize
>> performance. Since vmalloc and module areas will change with allocation
>> and release, consistency cannot be guaranteed, so mmap interface only
>> maps KCORE_TEXT and KCORE_RAM.
>>
>> The test results:
>> 1. the default version of kcore
>> real 11.00
>> user 8.53
>> sys 3.59
>>
>> % time     seconds  usecs/call     calls    errors syscall
>> ------ ----------- ----------- --------- --------- ----------------
>> 99.64  128.578319          12  11168701           pread64
>> ...
>> ------ ----------- ----------- --------- --------- ----------------
>> 100.00  129.042853              11193748       966 total
>>
>> 2. added kcore for the mmap interface
>> real 6.44
>> user 7.32
>> sys 0.24
>>
>> % time     seconds  usecs/call     calls    errors syscall
>> ------ ----------- ----------- --------- --------- ----------------
>> 32.94    0.130120          24      5317       315 futex
>> 11.66    0.046077          21      2231         1 lstat
>>   9.23    0.036449         177       206           mmap
>> ...
>> ------ ----------- ----------- --------- --------- ----------------
>> 100.00    0.395077                 25435       971 total
>>
>> The test results show that the number of system calls and time
>> consumption are significantly reduced.
>>
> 
> hm, OK, I guess why not.  The performance improvements for DRGN (which
> appears to be useful) are nice and the code is simple.
> 
> I'm surprised that it makes this much difference.  Has DRGN been fully
> optimised to minimise the amount of pread()ing which it does?  Why does
> it do so much reading?

DRGN is a tool similar to Crash, but much lighter. It allows users to 
obtain kernel data structures from Python scripts. Based on this, we 
intend to use DRGN for kernel monitoring. So we used some pressure test 
scripts to test the loss of monitoring.
Monitoring is all about getting current real-time data, so every time 
DRGN tries to get kernel data, it needs to read /proc/kcore. In my 
script, I tried to loop 1000 times to obtain the information of all the 
processes in the machine, in order to construct a scene where kernel 
data is frequently read. So, the frequency in the default version of 
kcore, pread is very high. In view of this situation, our optimization 
idea is to reduce the number of context switches as much as possible 
under the scenario of frequent kernel data acquisition, to reduce the 
performance loss to a minimum, and then move the monitoring system to 
the production environment.  After running for a long time in a 
production environment, the number of kernel data reads was added as 
time went on, and the pread number also increased. If users use mmap, 
it's once for all.

Attached is the test script:
#!/usr/bin/env drgn
# Copyright (c) Facebook, Inc. and its affiliates.
# SPDX-License-Identifier: GPL-3.0-or-later

"""A simplified implementation of ps(1) using drgn"""

from drgn.helpers.linux.pid import for_each_task

count = 0
while (count < 1000):
     count = count + 1
     #print("PID        COMM")
     for task in for_each_task(prog):
         pid = task.pid.value_()
         comm = task.comm.string_().decode()
         #print(f"{pid:<10} {comm}")

> 
> Thanks, I shall await input from others before moving ahead with this.
> 
