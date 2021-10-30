Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A189E4408A9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhJ3MIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 08:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhJ3MH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 08:07:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69684C061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 05:05:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso4954727wmf.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=De3SzmRUMwnscDxEBtkqC2nJji6pArhOBilNpE3ydQI=;
        b=iOSp9G0195vo/kwecCUjIV3KtN8MV8GTRFOChdgh7UOzL10OmC20aIqMTX24uBvuvd
         hvDDE66nfW+CupcG2HOMGjy+w6dVwzKZ/xN+dkpp+Co/ZYYVICqygVtNrsm9soRfNoOJ
         2INAbLm+aplN3SSmPDzdkMZJOtonECJxuKEoWKSOg0uZF9M5edPfuSVjtKyOZgLIBrgK
         7vDQ/s8TnZCDQG9UQBp66tsiN3ALwTTq73OyuHz8SMz6JLZzLx0PBS5+31Ameyjwhc+0
         gHcbkRKFHcx8A/aYwP47VJ0FieeGYrFnS2g/rKTZ3M1LBWcY67SL0o7HaXMqp09gAiG6
         iIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=De3SzmRUMwnscDxEBtkqC2nJji6pArhOBilNpE3ydQI=;
        b=mzfFtVysrxzEsEI4LD1COyWosKcZT8fGzG0p/IiArAO2ORI7OL5igDQ8s8gCN5Iflb
         MfYTTMkGDOW7SAMtrQqv38w37J5jE5mYu/vSPYsVEcKtKWBfw/+Fkpbx6iVvCx/27Z4k
         /wrq+2Y9HgSvVAqYm4sh/hj5uog1lw5BKBPu5MMafl5FV6+cbXCvubiLDUmJabxHvJvr
         k1gM282qJYGas+N0pQl24Ve8prWueVg9AZelAgzj9iDoJMYm31ggXoWvrLRPbi9WYP9k
         faUFZVH7lxdKeg1cidU99VjMGB3yGqJftH7vLUwihQuFzMnKPp/GIGZFGB+G5J1d89KL
         ksHg==
X-Gm-Message-State: AOAM532UObJFCakJku0fqVkO+zpyziT171kF/fu5sF0M73Lui1G7zLuD
        Dynj0BqqcvK1OPCmoT6gfl9/ae0fBQw=
X-Google-Smtp-Source: ABdhPJx0kB7qFH1jGsdKnPz+Av8xQ68ia0ljeygj/0wmzZUARCY0t5bhrzsRaKrlM4rishZ4E44/ow==
X-Received: by 2002:a05:600c:1550:: with SMTP id f16mr26406402wmg.5.1635595528044;
        Sat, 30 Oct 2021 05:05:28 -0700 (PDT)
Received: from [10.8.0.130] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id j9sm7994730wrt.96.2021.10.30.05.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 05:05:27 -0700 (PDT)
Message-ID: <480456b0-5e10-9179-73c0-0a92649f8874@gmail.com>
Date:   Sat, 30 Oct 2021 14:05:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [Bug 214873] New: man 2 fsync implies possibility to return early
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
References: <bug-214873-216477@https.bugzilla.kernel.org/>
Cc:     bugzilla-daemon@bugzilla.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <bug-214873-216477@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC += LKML and a few kernel programmers]

Hi,

On 10/29/21 23:25, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=214873
> 
>              Bug ID: 214873
>             Summary: man 2 fsync implies possibility to return early
>             Product: Documentation
>             Version: unspecified
>            Hardware: All
>                  OS: Linux
>              Status: NEW
>            Severity: low
>            Priority: P1
>           Component: man-pages
>            Assignee: documentation_man-pages@kernel-bugs.osdl.org
>            Reporter: sworddragon2@gmail.com
>          Regression: No
> 
> The manpage for the fsync system call (
> https://man7.org/linux/man-pages/man2/fsync.2.html ) describes as flushing the
> related caches to a storage device so that the information can even be
> retrieved after a crash/reboot. But then it does make the statement "The call
> blocks until the device reports that the transfer has completed." which causes
> now some interpretation: What happens if the device reports early completion
> (e.g. via a bugged firmware) of the transfer while the kernel still sees unsent
> caches in its context? Does fsync() indeed return then as the last referenced
> sentence implies or does it continue to send the caches the kernel sees to
> guarantee data integrity as good as possible as the previous documented part
> might imply?
> 
> I noticed this discrepancy when reporting a bug against dd (
> https://debbugs.gnu.org/cgi/bugreport.cgi?bug=51345 ) that causes dd to return
> early when it is used with its fsync capability while the kernel still sees
> caches and consulting the fsync() manpage made it not clear if such a
> theoretical possibility from the fsync() system call would be intended or not
> so eventually this part could be slighty enhanced.
> 

I don't know how fsync(2) works.  Could some kernel fs programmer please 
check if the text matches the implementation, and if that issue reported 
should be reworded in the manual page?

Thanks,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
