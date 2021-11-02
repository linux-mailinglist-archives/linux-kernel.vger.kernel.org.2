Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B188D442A90
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 10:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhKBJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBJog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:44:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7C4C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 02:42:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k4so5359056plx.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZW+8O4s0rJ1wYpYQ/yCPUQIYSI2PgmRKLIuSTxGkos4=;
        b=N3sCvzxnUT9zaeiJElQoQrxkV2YKMetiR5J3Ix3oFsFtSTdlRi4sy5Bdj+huJwEWIJ
         TdKK6YyM4lWcmvbAvWA0AA6GfoLPO7YJ4Xk7FvAAE3lmmGj4uZtazBOf32DaP7fSouYh
         bPkB7AzIlU0OUNHBJUphmDSkatjarUgKyBRefa6yzXemWCQEhLw2NFdG5XkOcSEyE7tZ
         rYhPWFEFv77kHDyrbROdI3KJCEq+T8L5sljgE2ChcmoAtNDdQioxbRZ1FaCPjprHBOdv
         dxYbm1FKxpSTNj661BzXgT5L/uoVFWtW/1wtPcD1F268njQwo1FRMlK8ngggHa8DlFYC
         TP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZW+8O4s0rJ1wYpYQ/yCPUQIYSI2PgmRKLIuSTxGkos4=;
        b=J8licBCqby4I2jokS1FjzXTWfywcOkli/Hya1lnIl+MihaEmmNSENW7ymYZUK2G7KU
         IG5uRu4U4kgEr28fipux2I09KqHefB6ytWcJcH1XIjlTGBR3jZ1LR358YZTAU21BKsJP
         1NXCH47hNtsJKN8RxOF5J684VPuNA2nAbYyFqxLLmInRyyRblskClDAQPRJ6eTByvRyZ
         g2warVzcTWcZb2yqaePT+baCb3oL8idPTiRg2b2UwgwhAkOQoGOzbLfW2PluH+gUk3nk
         6SjXGh+8VJ5BYGQbUqqAe1ppF1h+ZKf2n79pXR3MxT7+urzGPbP0GnzfXN929HCEAbzC
         S9QQ==
X-Gm-Message-State: AOAM533BQ79yMp0npgCqdHNLu9u8fdD59jJ6kbQExyPS2uxtK3yLOg4X
        xMTcmt9C5eJZ4/a39lWPW93iDxJcuCMZ2w==
X-Google-Smtp-Source: ABdhPJzIt3kOFjeG48wBYaH6SfFwd2fYnyeO4PwiyCsMqk4A0BeWy/3837ahX2HwxZk+h1W4ZHOHWA==
X-Received: by 2002:a17:90a:6e41:: with SMTP id s1mr3838341pjm.166.1635846120628;
        Tue, 02 Nov 2021 02:42:00 -0700 (PDT)
Received: from [172.18.2.138] ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id m22sm17957193pfo.71.2021.11.02.02.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 02:42:00 -0700 (PDT)
Subject: Re: [PATCH] ALSA: seq: Fix RCU stall in snd_seq_write()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20211102033222.3849-1-qiang.zhang1211@gmail.com>
 <s5hy267ot27.wl-tiwai@suse.de>
From:   Zqiang <qiang.zhang1211@gmail.com>
Message-ID: <2d05ceab-b8b7-0c7b-f847-69950c6db14e@gmail.com>
Date:   Tue, 2 Nov 2021 17:41:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <s5hy267ot27.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/11/2 下午4:33, Takashi Iwai wrote:
> On Tue, 02 Nov 2021 04:32:22 +0100,
> Zqiang wrote:
>> If we have a lot of cell object, this cycle may take a long time, and
>> trigger RCU stall. insert a conditional reschedule point to fix it.
>>
>> rcu: INFO: rcu_preempt self-detected stall on CPU
>> rcu: 	1-....: (1 GPs behind) idle=9f5/1/0x4000000000000000
>> 	softirq=16474/16475 fqs=4916
>> 	(t=10500 jiffies g=19249 q=192515)
>> NMI backtrace for cpu 1
>> ......
>> asm_sysvec_apic_timer_interrupt
>> RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70
>> spin_unlock_irqrestore
>> snd_seq_prioq_cell_out+0x1dc/0x360
>> snd_seq_check_queue+0x1a6/0x3f0
>> snd_seq_enqueue_event+0x1ed/0x3e0
>> snd_seq_client_enqueue_event.constprop.0+0x19a/0x3c0
>> snd_seq_write+0x2db/0x510
>> vfs_write+0x1c4/0x900
>> ksys_write+0x171/0x1d0
>> do_syscall_64+0x35/0xb0
>>
>> Reported-by: syzbot+bb950e68b400ab4f65f8@syzkaller.appspotmail.com
>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>> ---
>>   sound/core/seq/seq_queue.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
>> index d6c02dea976c..f5b1e4562a64 100644
>> --- a/sound/core/seq/seq_queue.c
>> +++ b/sound/core/seq/seq_queue.c
>> @@ -263,6 +263,7 @@ void snd_seq_check_queue(struct snd_seq_queue *q, int atomic, int hop)
>>   		if (!cell)
>>   			break;
>>   		snd_seq_dispatch_event(cell, atomic, hop);
>> +		cond_resched();
>>   	}
>>   
>>   	/* Process time queue... */
>> @@ -272,6 +273,7 @@ void snd_seq_check_queue(struct snd_seq_queue *q, int atomic, int hop)
>>   		if (!cell)
>>   			break;
>>   		snd_seq_dispatch_event(cell, atomic, hop);
>> +		cond_resched();
>
> It's good to have cond_resched() in those places but it must be done
> more carefully, as the code path may be called from the non-atomic
> context, too.  That is, it must have a check of atomic argument, and
> cond_resched() is applied only when atomic==false.
>
> But I still wonder how this gets a RCU stall out of sudden.  Looking
> through https://syzkaller.appspot.com/bug?extid=bb950e68b400ab4f65f8
> it's triggered by many cases since the end of September...

I did not find useful information from the log,  through calltrace, I 
guess it may be triggered by the long cycle time, which caused the 
static state of the RCU to

not be reported in time.

I ignore the atomic parameter check,  I will resend v2 .   in no-atomic 
context, we can insert

cond_resched() to avoid this situation, but in atomic context,

the RCU stall maybe still trigger.

thanks
Zqiang

>
>
> thanks,
>
> Takashi




