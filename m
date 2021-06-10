Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AC93A37F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhFJXfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:35:01 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:39663 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFJXe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:34:59 -0400
Received: by mail-pj1-f50.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so4710830pjp.4;
        Thu, 10 Jun 2021 16:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hRw2xzr7UjnBlZ+QB9b3zSuBhoYlGpx3jNmt2ODUJ4c=;
        b=TyWPTxVwL52WP/P+bDjkPG1jC78s+wxXCrpXXybprdWYCxaFdEu0QsWa70r4zJf2gu
         6tKhVWfbB11HV+5TjtE1pgFP5Vz1OJ/MzezjdjhiunTAdfOnEuUleB8qvks0VhbopS1L
         8odjXbdOQi57H2xvPxF44W//c0RiUI+vlNFWef7TejVRZJo9V5CWhtnREnOgPdyeK6dS
         3ATdXh12AE7DpReiDUYNHo5End8u9RBnw8d5yZhQXXB8sQKT8N91mU3T2b+Bp+CirxDi
         r5sChdDoBtTEcaHIic7E3FpuYDXgNJjC6ohWqz4FRIUcEAdDZ6Y4UYG0hJ65zexhXi7N
         gvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=hRw2xzr7UjnBlZ+QB9b3zSuBhoYlGpx3jNmt2ODUJ4c=;
        b=S6qr9YF3htscWDjjKG2zoXzLsNf/WoxjlmXC9C2atPW76Ow8HKMROxSQ5QRbuM8Guj
         W3ehDwZJ8Z28cIAv9AkvDNiM5GvVN3hwzOg/neG4Q8t6Tw+/dZCdF5a5nSTzkArLQNul
         t3KWLEKGAgrN4DclSJV/oYEvx9EL3Yd9z5/RHHg90y8QFAzjKdED0lVkzEYGVgwS+oz2
         COk37SKW3KX/h+vINCSdpfGMIZgfUYaaXe6OhE/KrtJVh8ynF+jWhWPGn3eJoPF/jPv0
         f8TwTdscS7uCpP5cfhVTiCjvhbTRcb75RO0ib3RHXPnauoKImYeG3dP38425zTOoRQNa
         MuUA==
X-Gm-Message-State: AOAM530ZPkc1U/Vpw9iOkvYMfLln/OZ4vCpidl5Iz9BQHX18V366qZB2
        C6GE0YCqxz9S61K4Qf1DiG4=
X-Google-Smtp-Source: ABdhPJyeUC/HGYqc/WzekWu8q0H3SUFOzuqTN27aVixOnNg/rM/udoTKdO4ZG5zzQ3exMwrVEwCocQ==
X-Received: by 2002:a17:902:ee8c:b029:fe:dc5f:564 with SMTP id a12-20020a170902ee8cb02900fedc5f0564mr1104647pld.71.1623367908212;
        Thu, 10 Jun 2021 16:31:48 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id 188sm3340563pfz.146.2021.06.10.16.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 16:31:47 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        guoren@kernel.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH 1/5] kprobes: Do not use local variable when creating
 debugfs file
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
        <20210609105019.3626677-2-punitagrawal@gmail.com>
        <20210609233543.e846251ccaa227317de26b11@kernel.org>
Date:   Fri, 11 Jun 2021 08:31:44 +0900
In-Reply-To: <20210609233543.e846251ccaa227317de26b11@kernel.org> (Masami
        Hiramatsu's message of "Wed, 9 Jun 2021 23:35:43 +0900")
Message-ID: <87im2ljnz3.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Masami Hiramatsu <mhiramat@kernel.org> writes:

> On Wed,  9 Jun 2021 19:50:15 +0900
> Punit Agrawal <punitagrawal@gmail.com> wrote:
>
>> debugfs_create_file() takes a pointer argument that can be used during
>> file operation callbacks (accessible via i_private in the inode
>> structure). An obvious requirement is for the pointer to refer to
>> valid memory when used.
>> 
>> When creating the debugfs file to dynamically enable / disable
>> kprobes, a pointer to local variable is passed to
>> debugfs_create_file(); which will go out of scope when the init
>> function returns. The reason this hasn't triggered random memory
>> corruption is because the pointer is not accessed during the debugfs
>> file callbacks.
>> 
>> Fix the incorrect (and unnecessary) usage of local variable during
>> debugfs_file_create() by passing NULL instead.
>> 
>
> Good catch! Since the enabled state is managed by the kprobes_all_disabled
> global variable, it is not needed.
>
> Fixes: bf8f6e5b3e51 ("Kprobes: The ON/OFF knob thru debugfs")
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks a lot for reviewing the patches.

I am assuming the tags can be picked up when applying. Let me know if I
need to resend.

Thanks,
Punit

>
> Thank you!
>
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> ---
>>  kernel/kprobes.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index 745f08fdd7a6..fdb1ea2e963b 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -2816,13 +2816,12 @@ static const struct file_operations fops_kp = {
>>  static int __init debugfs_kprobe_init(void)
>>  {
>>  	struct dentry *dir;
>> -	unsigned int value = 1;
>>  
>>  	dir = debugfs_create_dir("kprobes", NULL);
>>  
>>  	debugfs_create_file("list", 0400, dir, NULL, &kprobes_fops);
>>  
>> -	debugfs_create_file("enabled", 0600, dir, &value, &fops_kp);
>> +	debugfs_create_file("enabled", 0600, dir, NULL, &fops_kp);
>>  
>>  	debugfs_create_file("blacklist", 0400, dir, NULL,
>>  			    &kprobe_blacklist_fops);
>> -- 
>> 2.30.2
>> 
