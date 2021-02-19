Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6CA31F66F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhBSJSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:18:42 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44]:37479 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBSJSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:18:39 -0500
Received: by mail-ej1-f44.google.com with SMTP id d8so11383925ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P7plXYyBJGEyQFVaumgZw2bPyhz33gTigGSr4ns5JY8=;
        b=cdIBruiLzHeeNVM/taZ06J0bqTMQPmqJPQsFKTn/vtp0T2LW/Q8653vuBxsVEXwQ4Y
         F0OI6p5VCrhywruUX3D+JjBYRBjj4SUwsUnCSrRNAZY37EiGtB4swcB90v4QhH8J1Eq7
         TQATZSypzXi35N4XRF8jVjA3C0Jf4g+3bz52Q/41kMHeKC21MQwE2h09QyKIYYUNmuFG
         RKDgRaIsBnydeFgPU6ToV/HD3xUHT5Ox1WgwOjb3hpMIotDR/B7KIL6UfNJVSxOoXM/o
         tjvLfZxRBvPc3oJgKM3ITLJhR6ILdV0aDBKflZ3pl3lYyIGskv678RWnEn0GOiHCAPUn
         6k9Q==
X-Gm-Message-State: AOAM531SDGdOy1Qg15kSL9P3pUAKDTj6PGDrWBLSdGoWvnRh0WF9J24P
        bmcs5ZFAOvSmBhwBlcnswKE=
X-Google-Smtp-Source: ABdhPJw1AwT98wHTLcvrL5MaF0jmJGxMjUhMWocE2wkYxtIet7qI/kOvRFkQLTtsnw6wWsBkmOML8g==
X-Received: by 2002:a17:906:7119:: with SMTP id x25mr5128009ejj.362.1613726277515;
        Fri, 19 Feb 2021 01:17:57 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id s12sm4487828edu.28.2021.02.19.01.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 01:17:56 -0800 (PST)
Subject: Re: [PATCH v2] tty: fix when iov_iter_count() returns 0 in
 tty_write()
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com
References: <YC0zGySVWMKdpulA@kroah.com>
 <20210217155536.2986178-1-snovitoll@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <e94a2ce5-3329-1c4f-3919-8db125da83d3@kernel.org>
Date:   Fri, 19 Feb 2021 10:17:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217155536.2986178-1-snovitoll@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. 02. 21, 16:55, Sabyrzhan Tasbolatov wrote:
> syzbot found WARNING in iov_iter_revert[1] when iov_iter_count() returns 0,
> therefore INT_MAX is passed to iov_iter_revert() causing > MAX_RW_COUNT
> warning.
> 
> static inline ssize_t do_tty_write()
> {
> ..
> 	size_t count = iov_iter_count(from);
> ..
> 		size_t size = count;
> 		if (ret != size)
> 			iov_iter_revert(from, size-ret);
> 
> [1] WARNING: lib/iov_iter.c:1090
> Call Trace:
>   do_tty_write drivers/tty/tty_io.c:967 [inline]
>   file_tty_write.constprop.0+0x55f/0x8f0 drivers/tty/tty_io.c:1048
>   call_write_iter include/linux/fs.h:1901 [inline]
>   new_sync_write+0x426/0x650 fs/read_write.c:518
>   vfs_write+0x791/0xa30 fs/read_write.c:605
>   ksys_write+0x12d/0x250 fs/read_write.c:658
> 
> Fixes: 9bb48c82aced ("tty: implement write_iter")
> Reported-by: syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> 
> v2: Fixed "Fixed" tag to proper commit and changed write return to -EFAULT
> as this statement is valid, tested via strace:
> 
> write(3, NULL, 0)                       = -1 EFAULT (Bad address)
> 
> Updated to -EFAULT, should be a valid exit code as
> copy_from_iter(.., .., from) returns -EFAULT as well if *from is invalid
> address.

Exactly, EFAULT is for invalid memory accesses. But this should be IMO 
EINVAL as it's an invalid argument.

BTW what's the reason vfs calls ->write with zero count of iter?

>> Nit, you need a ' ' before your '(' character here, otherwise the
>> linux-next scripts will complain.
> 
>> Also, you got the git commit id wrong, so this needs to be fixed up
>> anyway.  You are pointing to a merge point, I doubt that's what you want
>> to point to here, right?
> 
> Thanks!
> ---
>   drivers/tty/tty_io.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 816e709afa56..e1460cad8b7d 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -905,6 +905,9 @@ static inline ssize_t do_tty_write(
>   	ssize_t ret, written = 0;
>   	unsigned int chunk;
>   
> +	if (!count)
> +		return -EFAULT;
> +
>   	ret = tty_write_lock(tty, file->f_flags & O_NDELAY);
>   	if (ret < 0)
>   		return ret;
> 


-- 
js
