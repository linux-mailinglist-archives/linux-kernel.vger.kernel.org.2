Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05823C2764
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 18:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhGIQSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 12:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhGIQSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 12:18:40 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D71C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 09:15:56 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id j12so10878358ils.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7dcm1PHxfe/MGXlhDOiU+zwdMcSQc+7rJw2AsfVkt90=;
        b=PuflTcCHnqd+j/Ae7Rtx+QJJ1nuxzLq8MMNgL7hA05tWR97VcBeqLl3v/54LLaXa1n
         Nw/xwFPt34w8FVVr0FIubo/GyrVhkv6vYD4bHJm5nqLragsXxBoGCwwz46U5FUkzvcVA
         WlSrvo1xn6ZdBru3GTz0FtCZx+kAQIhbscA/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7dcm1PHxfe/MGXlhDOiU+zwdMcSQc+7rJw2AsfVkt90=;
        b=jDztZVhZxFO66e7iS+kDdfYFLmoweN9Juwj0JuHkPhNz9jqlQ11OLoqyxLWd8ur2Vn
         u0fBweXGnKFaZ2NbhOsJrkJDMCeI7wNTzWaOxcf2TAKeQsoz6wBpnZkg5pzJNJ6FL1Pu
         4L5V4Xpmv4E6pYAMnYdM3kFuQrqDdbRTWmvyD/lrmGtzuddLmezZryGFDYuMq9vNq0du
         y0sWcDeVaaFHras9eXallVbK+t+M30Y1hxaBXU5i/exGkbHhf6Yks3Hz4Z6TL5zpHZOQ
         2k8pN8RqXH7Ho9pV+N990kA2dq+rd/FCU2vIMTWRhf/rF33au+Fi7osQFqXj4cH/f17t
         LEww==
X-Gm-Message-State: AOAM530Cuyelos37Kkt4lmZxGHM+r0dByNKBDrZ/OR1zAB5+U3MZT6MS
        npTvnCyCTkWmh1P750yaSvz5hg==
X-Google-Smtp-Source: ABdhPJyOBHjjTeOkhkxWzqLyn9tIP332W22axVcbPReUam3QUn4KPFV1f0snG1NjF/ijtawxkf6nZw==
X-Received: by 2002:a92:2805:: with SMTP id l5mr13497645ilf.242.1625847356170;
        Fri, 09 Jul 2021 09:15:56 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x13sm3053076ilo.11.2021.07.09.09.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 09:15:55 -0700 (PDT)
Subject: Re: [PATCH] firmware_loader: Fix use-after-free Read in
 firmware_loading_store
To:     Hillf Danton <hdanton@sina.com>
Cc:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+77cea49e091776a57689@syzkaller.appspotmail.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210708031321.50800-1-skhan@linuxfoundation.org>
 <20210709091721.1869-1-hdanton@sina.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d851dd11-1b4f-4ed2-bad2-0c267e3d6021@linuxfoundation.org>
Date:   Fri, 9 Jul 2021 10:15:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210709091721.1869-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/21 3:17 AM, Hillf Danton wrote:
> On Wed,  7 Jul 2021 21:13:21 -0600 Shuah Khan wrote:
>>
>> If user writes to 'loading' between loading aborted and 'loading'
>> gets removed, __fw_load_abort() could be called twice in error
>> path setting the state to load aborted. __fw_load_abort() checks
>> for fw_sysfs_done() case, but doesn't check for abort case. This
>> opens the window for use-after-free Read in firmware_loading_store().
>>
>> Fix it by adding check for fw load aborted in addition to done in
>> __fw_load_abort() and return if either one of the states is true.
>>
>> BUG: KASAN: use-after-free in __list_del_entry_valid+0xd6/0xf0 lib/list_debug.c:54
>> Read of size 8 at addr ffff88802b3da2c8 by task systemd-udevd/25252
>>
>> CPU: 0 PID: 25252 Comm: systemd-udevd Not tainted 5.13.0-rc1-syzkaller #0
>> Hardware name: Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>> __dump_stack lib/dump_stack.c:79 [inline]
>> dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>> print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:233
>> __kasan_report mm/kasan/report.c:419 [inline]
>> kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:436
>> __list_del_entry_valid+0xd6/0xf0 lib/list_debug.c:54
>> __list_del_entry include/linux/list.h:132 [inline]
>> list_del_init include/linux/list.h:204 [inline]
>> __fw_load_abort drivers/base/firmware_loader/fallback.c:97 [inline]
>> __fw_load_abort drivers/base/firmware_loader/fallback.c:88 [inline]
>> fw_load_abort drivers/base/firmware_loader/fallback.c:105 [inline]
>> firmware_loading_store+0x141/0x650 drivers/base/firmware_loader/fallback.c:297
>> dev_attr_store+0x50/0x80 drivers/base/core.c:2066
>> sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
>> kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
>> call_write_iter include/linux/fs.h:2114 [inline]
>> new_sync_write+0x426/0x650 fs/read_write.c:518
>> vfs_write+0x796/0xa30 fs/read_write.c:605
>> ksys_write+0x12d/0x250 fs/read_write.c:658
>> do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
>> entry_SYSCALL_64_after_hwframe+0x44/0xae
>> RIP: 0033:0x7f6d0b3fe970
>> Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
>> RSP: 002b:00007ffde8a82ba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f6d0b3fe970
>> RDX: 0000000000000002 RSI: 00005567e595b380 RDI: 0000000000000007
>> RBP: 00005567e595b380 R08: 00007f6d0c58c8c0 R09: 0000000000000002
>> R10: 0000000000000020 R11: 0000000000000246 R12: 0000000000000002
>> R13: 0000000000000001 R14: 00005567e59427d0 R15: 0000000000000002
>>
>> Reported-by: syzbot+77cea49e091776a57689@syzkaller.appspotmail.com
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>> drivers/base/firmware_loader/fallback.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
>> index 91899d185e31..e6a18c2a6c43 100644
>> --- a/drivers/base/firmware_loader/fallback.c
>> +++ b/drivers/base/firmware_loader/fallback.c
>> @@ -89,9 +89,10 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
>> {
>> 	/*
>> 	 * There is a small window in which user can write to 'loading'
>> -	 * between loading done and disappearance of 'loading'
>> +	 * between loading done or aborted and disappearance of
>> +	 * 'loading'
>> 	 */
>> -	if (fw_sysfs_done(fw_priv))
>> +	if (fw_sysfs_done(fw_priv) || fw_state_is_aborted(fw_priv))
>>
> 
> Given the fw_state_is_aborted() in firmware_loading_store(), could you specify
> why it is a correct fix to check again?
> 

Yes fw_state_is_aborted() is checked at the beginning of
firmware_loading_store(). Later on you will see that for
for case 0 logic it will do a variation on abort when
failure happens and sets the state to aborted. Note that
this would happen on failure case. Looking at the log from
the report this will be the case as I see errors in loading
path.

/*
  * Same logic as fw_load_abort, only the DONE bit
  * is ignored and we set ABORT only on failure.
  */
  list_del_init(&fw_priv->pending_list);
  if (rc) {
       fw_state_aborted(fw_priv);
       written = rc;
  } else {
       fw_state_done(fw_priv);
  }
  break;

If another user writes to the "loading" file before it gets
deleted, if user writes 0 again, fw_sysfs_loading() will be
false, however the fallthrough will invoked fw_load_abort()
and list_del_init() will be called triggering user-after-free

Note that in __fw_load_abort() handles this window for loading
done case and doesn't for error case when fw load is aborted.

/*
  * There is a small window in which user can write to 'loading'
  * between loading done and disappearance of 'loading'
  */

if (fw_sysfs_done(fw_priv))
	return;

This fix closes the window for aborted case. However, I can't
test this because there is no reproducer.

thanks,
-- Shuah

