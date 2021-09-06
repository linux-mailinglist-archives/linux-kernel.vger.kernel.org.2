Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFF401EAF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhIFQsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhIFQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:48:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F54C061575;
        Mon,  6 Sep 2021 09:47:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n2so4928852lfk.0;
        Mon, 06 Sep 2021 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=hj6jr/Bay+4stbYvb9h9fv4qa8ImPa2qelZrSXh4XGM=;
        b=NaeQ3lsb689M28sB2sF8AhjeWPoYlRdGxderE/wKH+GaDVw+FKFIp/0J/H+Z2HHTgN
         acNmsPgmOdUWAq/2GojBGc7dGIzudvLPvd1htq2EqpTXzhyPQXomquidRBJsufcjn2dc
         qweTVD10sEgFfK/uv/7JHh4EEO04M4sd9ZsRoHrolMxc4meFecIFDqMQ/+/L6DBijDQq
         mXXBz+vUG3YllgBqoXAmv5NaisL/OnGiS/3e9gp28ZvUxj74xmYuV2N0rvlNrRPEU1pj
         rFJj9pQoYQYynT6kLilZ3X1kLTokqjpGXtk85lGX2Ax8I/LbiqPk3Y7uFpHoLS/ZdP+s
         anXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=hj6jr/Bay+4stbYvb9h9fv4qa8ImPa2qelZrSXh4XGM=;
        b=MsnMFnGUmQKsFg3xFlQDacNDL3hgss/3gmqehLRKsdw5b8sIOCMeELxMJdmMr5cwp7
         ZBb8iP/dfXGmOi9d/QF6BuMboCzKU7a7ouvQoAmNVYi6BVfvMKvO9gSrJOpPzFA/CpaQ
         3QMh5yg0NANK5ksTT/eQXAwndwRJ6PP9tp4sI1VSh+hMvOQG39Espg8cLTRZwqC7qEn7
         fJqmvHzPAkvekufl3QADaonk+fkA2MsHuSmtbQ/9FB9ak4/eff73y4Unm23QGrC7l6CS
         AWkMaRZ40eUJIf3VBQ41eX8+fT+MCmzS1me66Xv4CjEJywJljrdof5AayaHkWlowVfD0
         XOmQ==
X-Gm-Message-State: AOAM532g6NDi/Pdk2z4AKmaJJ+BPLg+V9IZUqTw6B1dEs6cMJrlFO7JJ
        KgbwR5B7pFRzyO2ZzNhCq44=
X-Google-Smtp-Source: ABdhPJzoWMXF+xcV4GpW+8D+GAE2haWpH/HebUMDRgOE//rNIOGie4gYy9Kn8UfWkX6oLbhChsPSqQ==
X-Received: by 2002:ac2:4a6a:: with SMTP id q10mr10491522lfp.259.1630946856826;
        Mon, 06 Sep 2021 09:47:36 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.70])
        by smtp.gmail.com with UTF8SMTPSA id x33sm779674lfu.8.2021.09.06.09.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 09:47:36 -0700 (PDT)
Message-ID: <53fb4217-21b8-ac46-bb39-581a4c9837a4@gmail.com>
Date:   Mon, 6 Sep 2021 19:47:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] nilfs2: fix memory leak in
 nilfs_sysfs_create_device_group
Content-Language: en-US
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210906041330.2065214-1-mudongliangabcd@gmail.com>
 <CAD-N9QUHfoqOOxDuKniMi8VGLR2j6g50BBy45eAL0kPRrntmgA@mail.gmail.com>
 <aa2fb8c6-ef6b-a1ca-d598-b0814529a31d@gmail.com>
In-Reply-To: <aa2fb8c6-ef6b-a1ca-d598-b0814529a31d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 18:56, Pavel Skripkin wrote:
> On 9/6/21 08:43, Dongliang Mu wrote:
>> On Mon, Sep 6, 2021 at 12:13 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>>>
>>> The commit 8fd0c1b0647a ("nilfs2: fix memory leak in
>>> nilfs_sysfs_delete_device_group") adds a kobject_put to free the leaking
>>> object name. However, it is incomplete to only add kobject_put in the
>>> nilfs_sysfs_delete_device_group. The function
>>> nilfs_sysfs_create_device_group also needs the kobject_put to
>>> free the object name in the error handling part.
>>>
>>> Fix this by adding kobject_put in the error handling code of
>>> nilfs_sysfs_create_device_group.
>> 
>> Even after I add this patch, my local syzkaller still reports this
>> memory leak one hour later. Therefore, there are some other paths or
>> magics which can trigger the memory leak. I need to dig deeper.
>> 
>> Pavel, do you have any idea about this crash report?
>> 
>> BUG: memory leak
>> unreferenced object 0xffff88804a1a8a60 (size 32):
>>    comm "syz-executor", pid 14551, jiffies 4294960586 (age 14.780s)
>>    hex dump (first 32 bytes):
>>      6c 6f 6f 70 35 00 00 00 00 00 00 00 00 00 00 00  loop5...........
>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    backtrace:
>>      [<ffffffff814750c6>] kstrdup+0x36/0x70
>>      [<ffffffff81475153>] kstrdup_const+0x53/0x80
>>      [<ffffffff822773a2>] kvasprintf_const+0xc2/0x110
>>      [<ffffffff82337c5b>] kobject_set_name_vargs+0x3b/0xe0
>>      [<ffffffff823385ed>] kobject_init_and_add+0x6d/0xc0
>>      [<ffffffff81d2bd08>] nilfs_sysfs_create_device_group+0x98/0x3a0
>>      [<ffffffff81d14fc4>] init_nilfs+0x424/0x580
>>      [<ffffffff81d02962>] nilfs_mount+0x532/0x8c0
>>      [<ffffffff815c754b>] legacy_get_tree+0x2b/0x90
>>      [<ffffffff81565158>] vfs_get_tree+0x28/0x100
>>      [<ffffffff815a3a82>] path_mount+0xb92/0xfe0
>>      [<ffffffff815a3f71>] do_mount+0xa1/0xc0
>>      [<ffffffff815a4584>] __x64_sys_mount+0xf4/0x160
>>      [<ffffffff8433fd35>] do_syscall_64+0x35/0xb0
>>      [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>> 
>> 
> 
> Hi, Dongliang!
> 
> 
> This report says nothing to me... It shows, that there is missing
> kobject_put() somewhere. I think, we need a reproducer for this leak,
> otherwise only code review can help :(
> 
> 
> 

Hm, I guess, I see... We should call kobject_put() in case of 
kobject_init_and_add() failure:

lib/kobject.c:459

  * If this function returns an error, kobject_put() must be called to
  * properly clean up the memory associated with the object.  This is the


so I suggest:

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 68e8d61e28dd..e8717f4ba2a1 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -1026,6 +1026,7 @@ int nilfs_sysfs_create_device_group(struct 
super_block *sb) 	kobject_del(&nilfs->ns_dev_kobj);

  free_dev_subgroups:
+	kobject_put(&nilfs->ns_dev_kobj);
  	kfree(nilfs->ns_dev_subgroups);

  failed_create_device_group:


This patch should fix 2 memory leaks :)




With regards,
Pavel Skripkin
