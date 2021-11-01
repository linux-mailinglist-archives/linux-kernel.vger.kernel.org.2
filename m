Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1549C4414CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhKAIIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:08:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:30888 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhKAII3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:08:29 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HjQTL1yDDzcb0S;
        Mon,  1 Nov 2021 16:01:10 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 16:05:51 +0800
Received: from [10.174.178.155] (10.174.178.155) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 16:05:50 +0800
From:   Yongqiang Liu <liuyongqiang13@huawei.com>
To:     <mhocko@kernel.org>
CC:     <rientjes@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <penguin-kernel@i-love.sakura.ne.jp>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>
Subject: [QUESTION] oom killed the key system process triggered by a bad
 process alloc memory with MAP_LOCKED
Message-ID: <cc85a520-804c-35cc-c7d7-b9999c0671fe@huawei.com>
Date:   Mon, 1 Nov 2021 16:05:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.155]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was just wondering the process of  the patch "oom reaper: handle 
mlocked pages".

links:

https://lore.kernel.org/linux-mm/1454505240-23446-3-git-send-email-mhocko@kernel.org/

https://lore.kernel.org/linux-mm/20160223132157.GD14178@dhcp22.suse.cz/


In linux master, we found that when we start a process and alloc large 
memory with MAP_LOCKED, the oom will triggered and kill some system 
process such as sshd ,rsyslog etc.

...

[   45.110665] Out of memory: Killed process 2551 (oom) 
total-vm:1035324kB, anon-rss:1028196kB, file-rss:704kB, shmem-rss:0kB, 
UID:0 pgtables:2056kB oom_score_adj:1000
[   45.115303] Out of memory: Killed process 2554 (oom) 
total-vm:1025084kB, anon-rss:1015596kB, file-rss:388kB, shmem-rss:0kB, 
UID:0 pgtables:2032kB oom_score_adj:1000
[   45.115685] Out of memory: Killed process 2553 (oom) 
total-vm:953404kB, anon-rss:947748kB, file-rss:388kB, shmem-rss:0kB, 
UID:0 pgtables:1896kB oom_score_adj:1000
[   45.116031] Out of memory: Killed process 2552 (oom) 
total-vm:789564kB, anon-rss:783272kB, file-rss:388kB, shmem-rss:0kB, 
UID:0 pgtables:1576kB oom_score_adj:1000
[   45.117199] Out of memory: Killed process 2523 (sshd) 
total-vm:77052kB, anon-rss:804kB, file-rss:4672kB, shmem-rss:4kB, UID:0 
pgtables:196kB oom_score_adj:0
[   45.120936] Out of memory: Killed process 2526 (bash) 
total-vm:17792kB, anon-rss:1180kB, file-rss:2868kB, shmem-rss:0kB, UID:0 
pgtables:76kB oom_score_adj:0

...

the process demo is:

...

#define ALLOC_SIZE (10 * 1024 * 1024)

while (1) {

     addr = mmap(NULL, ALLOC_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | 
MAP_ANONYMOUS | MAP_LOCKED, -1, 0);

     if (addr != MAP_FAILED)

         memset(addr, 1, ALLOC_SIZE);

}

...

And we found that when the oom_reaper is done but the memory is still high:

[   45.115685] Out of memory: Killed process 2553 (oom) 
total-vm:953404kB, anon-rss:947748kB, file-rss:388kB, shmem-rss:0kB, 
UID:0 pgtables:1896kB oom_score_adj:1000
[   45.115739] oom_reaper: reaped process 2553 (oom), now 
anon-rss:947708kB, file-rss:0kB, shmem-rss:0kB

This is because the bad proccess which recieved SIGKILL is unlocking the 
mem to exit which needs more time. And the next oom is triggered to kill 
the other system process.

Kind regards,

Yongqiang Liu

