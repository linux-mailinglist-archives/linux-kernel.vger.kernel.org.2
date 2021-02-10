Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98F1315DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 04:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbhBJDDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 22:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbhBJDCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 22:02:54 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D99C061756
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 19:02:13 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d13so432898plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 19:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=V10BJdzxHAV0h7gQUJltJC4aCoH9Xjs54AoTSTl4hSI=;
        b=B3QvcCQEy6cR9gkJxqSGDQpsdvdK0oByDZi6KuRQHOO5TRJWgwwvZtlFfB9DpcJZVi
         BSgS/waeFXr8zrwEZns/9ouePB1Zlhywu5QpxxgpLO45Av+TSVwDUG9D630ifX0ed6lR
         GrQ1kSOj+dDiADDYISeh82iFtENUeH872A1VbhdQ/g1bwnnCvCkoFFwPrRsKzp4PaGqk
         D5oB9zFAmnTCZ7P9T+XgRZREbPYv+buNkuNJJiMEc5Mz5oQY/McOwiQWD8YxOT/38Lip
         nlDxVKH2ZK3tWp0xaB3GHzsoOnyHqT2HSCf9t9KAolMUuWEeIk/TW1eG2dGPa18wWh5x
         Sa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V10BJdzxHAV0h7gQUJltJC4aCoH9Xjs54AoTSTl4hSI=;
        b=BzqNrsUcWFZCruWUvIrf/IeB73R03YAW5JdktdIiIYPK9leFJjsBrSAGg6CwOktR6I
         JJR2UAVQ0Hvnkt27a9O13O6Xzze5M+X4WZONOWlv222W0+fvAEal8iv5wcC+NuCXcL/d
         FLMLt2hbZhYVk+bGn819uCKcR4ehuIlkP51+JnrHrbnwRetrRn9QzpRKPoPCPXQTzmEZ
         9MwnCOrzS/Iv5msdoet3Pm90pblJEREcXXW/J7JKCLzPHcrbOvCfibBvfZUJ75pe9eaS
         CwBxF7ahhwWP8yCHVBIzVSnU6lR8WwbsqM5OInhf4w1n7z7di30QQCilc/oV0SUaEDmG
         b5lQ==
X-Gm-Message-State: AOAM532J+KML2eNQDTkJ7iZNlCoKzntqfLon2b9lkJXUT+zyJid0hTHp
        vBx0QilOfK9B7xxARaPSH+zIZw==
X-Google-Smtp-Source: ABdhPJzhRsdvQ7CU2FbitYCA1/Q8bFd4++eUf5JS+orCsOYBlsHPreE6iJfRI2xsHf65FBXuiw/VKw==
X-Received: by 2002:a17:902:eb53:b029:e1:2b0f:6a88 with SMTP id i19-20020a170902eb53b02900e12b0f6a88mr1003861pli.36.1612926133001;
        Tue, 09 Feb 2021 19:02:13 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b27sm276960pgb.82.2021.02.09.19.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 19:02:12 -0800 (PST)
Subject: Re: INFO: task hung in io_uring_cancel_task_requests
To:     Pavel Begunkov <asml.silence@gmail.com>,
        syzbot <syzbot+695b03d82fa8e4901b06@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000075f90305baf0d732@google.com>
 <4ccfa4de-b63e-10c6-786a-d745cdf22535@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <563f69d6-6e93-f375-c3b9-dcb3afdae025@kernel.dk>
Date:   Tue, 9 Feb 2021 20:02:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4ccfa4de-b63e-10c6-786a-d745cdf22535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 7:57 PM, Pavel Begunkov wrote:
> On 10/02/2021 00:54, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    dd86e7fa Merge tag 'pci-v5.11-fixes-2' of git://git.kernel..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13e43f90d00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e83e68d0a6aba5f6
>> dashboard link: https://syzkaller.appspot.com/bug?extid=695b03d82fa8e4901b06
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1490f0d4d00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17aedf1cd00000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+695b03d82fa8e4901b06@syzkaller.appspotmail.com
> 
> It looks like SQPOLL. I wonder if that's due to parked SQPOLL task that
> won't be able to do task_work run, and so reap poll-cancelled requests
> killed by io_put_deferred().
> 
> I'll test it out tomorrow.

It is indeed SQPOLL. From a quick look, it's doing a POLL_ADD on the ring
fd itself.

-- 
Jens Axboe

