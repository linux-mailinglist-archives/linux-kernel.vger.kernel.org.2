Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5502F4001C5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbhICPKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhICPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:10:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D8C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 08:09:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c8so12376748lfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cqU2PGqygwu99ZbSzOT9TyhyUY2249zso5423D4lseM=;
        b=JatPzTL6lKTcgrasPi9n2LhNUb9YbfL9EY92QjDDjTfXDQT8a/L0p2yP4dX0xw3fdR
         wd/9l3PjOH9k6ECIZUaPpVEJYYTLdkMSmCL2gyOo3lFeM8Y7gG0+fEXVnSt4UAK5jtKR
         CwRQZPslXr/3+YqeULmtAM51kdld7tmYnGEavPKgMfaBtIScKHldITi5zN8X0DTUUrKh
         x323pPnTgeh0zcbgNrXpj+GhFvXh+qL0KR2e/9LCpRJAf9RwKNFCZ+EI6vFEEJnKlsYu
         D4567LW5K6fJU++lSHRTr3Q+8jTzbB65YGrliRJXRMxOA7rnopltlpGw7xcCTkpyp6qx
         U0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cqU2PGqygwu99ZbSzOT9TyhyUY2249zso5423D4lseM=;
        b=dIcE3zh59iK+Uap7HuWZABZb3NT159K8V7fYXsCQ76SJLWtRIlgeuOlYze7E88pFht
         WD6A6RigmXtSHgs0xczY7ES6h/OAslnxcTVLPFUEmmYI+QVmFkwtXZj1tRv6WGEmYCbR
         bgf2H9ja95i2M4+f+34tn8XymzQO79LHGo/2wTBS1RsTn5m9jQ1xwvIGzGLJlf9dTtwh
         FGIIwUyGYTGW9UN3xMU4u+ma5TcL/eMHmHpiFs++hATdkWypnV+OpTksXoq9WAfoaitl
         AlP6dhCrH+hrTLdXxRHcW7PIELHYVijtzZaGmRg/dQ6I7pTdYq8c7ucrwSNEuQWKVq3b
         skog==
X-Gm-Message-State: AOAM533Vxv7/Jd/lgDWbsPn+wgnMOluM9w5BLzujUbJjmfd8thy739BZ
        ngxahBwdfoo2s+pFHJJrLCo=
X-Google-Smtp-Source: ABdhPJzS0YAvlPsopOi+A7Sezb4QTIRI17QorQk8+EuniZgIw/NNYJjAHtIr+SiXkvNb39CxV5O3QQ==
X-Received: by 2002:a05:6512:3a88:: with SMTP id q8mr3211788lfu.228.1630681752555;
        Fri, 03 Sep 2021 08:09:12 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.70])
        by smtp.gmail.com with UTF8SMTPSA id k38sm532790lfv.128.2021.09.03.08.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 08:09:12 -0700 (PDT)
Message-ID: <cd1e8e38-29e7-3565-fb16-baa6c320100d@gmail.com>
Date:   Fri, 3 Sep 2021 18:09:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH v5] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aakash Hemadri <aakashhemadri123@gmail.com>
References: <20210828113656.6963-1-fmdefrancesco@gmail.com>
 <YTCaF5Ure2tjfbZB@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YTCaF5Ure2tjfbZB@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 12:32, Greg Kroah-Hartman wrote:
> On Sat, Aug 28, 2021 at 01:36:56PM +0200, Fabio M. De Francesco wrote:
>> Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
>> unnecessary wrappers, respectively to mutex_lock_interruptible() and
>> to mutex_unlock(). They also have an odd interface that takes an unused
>> argument named pirqL of type unsigned long.
>> The original code enters the critical section if the mutex API is
>> interrupted while waiting to acquire the lock; therefore it could lead
>> to a race condition. Use mutex_lock() because it is uninterruptible and
>> so avoid that above-mentioned potential race condition.
>> 
>> Tested-by: Pavel Skripkin <paskripkin@gmail.com>
>> Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>
>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> ---
>> 
>> v5: Fix a typo in the subject line. Reported by Aakash Hemadri.
>> 
>> v4: Tested and reviewed by Pavel Skripkin. No changes to the code.
>> 
>> v3: Assume that the original authors don't expect that
>> mutex_lock_interruptible() can be really interrupted and then lead to 
>> a potential race condition. Furthermore, Greg Kroah-Hartman makes me
>> notice that "[] one almost never needs interruptable locks in a driver".
>> Therefore, replace the calls to mutex_lock_interruptible() with calls to
>> mutex_lock() since the latter is uninterruptible and avoid race
>> conditions without the necessity to handle -EINTR errors.
> 
> Based on a recent conversation on the linux-usb mailing list, perhaps I
> was wrong:
> 	https://lore.kernel.org/r/20210829015825.GA297712@rowland.harvard.edu
> 
> Can you check what happens with your change when you disconnect the
> device and these code paths are being called?  That is when you do want
> the lock interrupted.
> 
> Yes, the logic still seems wrong, but I don't want to see the code now
> just lock up entirely with this change as it is a change in how things
> work from today.
> 

Hi, Greg!

I've retested this patch with lockdep enabled and I actually hit a 
deadlock. It's really my fault to forgot about lockdep while testing v4, 
I am sorry about the situation.

Actually, the disconnect here is not the problem, the problem was in 
original code. Changing mutex_lock_interruptible to mutex_lock just 
helped to discover it.


The log:

[  252.063305] WARNING: possible recursive locking detected
[  252.063642] 5.14.0+ #9 Tainted: G         C
[  252.063946] --------------------------------------------
[  252.064282] ip/335 is trying to acquire lock:
[  252.064560] ffff888009ebad28 (pmutex){+.+.}-{4:4}, at: 
usbctrl_vendorreq+0xc5/0x4a0 [r8188eu]
[  252.065168]
[  252.065168] but task is already holding lock:
[  252.065536] ffffffffc021b3b8 (pmutex){+.+.}-{4:4}, at: 
netdev_open+0x3a/0x5f [r8188eu]
[  252.066085]
[  252.066085] other info that might help us debug this:
[  252.066494]  Possible unsafe locking scenario:
[  252.066494]
[  252.066866]        CPU0
[  252.067025]        ----
[  252.067184]   lock(pmutex);
[  252.067367]   lock(pmutex);
[  252.067548]
[  252.067548]  *** DEADLOCK ***
[  252.067548]
[  252.067920]  May be due to missing lock nesting notation
[  252.067920]
[  252.068346] 2 locks held by ip/335:
[  252.068570]  #0: ffffffffbda94628 (rtnl_mutex){+.+.}-{4:4}, at: 
rtnetlink_rcv_msg+0x1e0/0x660
[  252.069115]  #1: ffffffffc021b3b8 (pmutex){+.+.}-{4:4}, at: 
netdev_open+0x3a/0x5f [r8188eu]
[  252.069690]
[  252.069690] stack backtrace:
[  252.069968] CPU: 1 PID: 335 Comm: ip Tainted: G         C 
5.14.0+ #9
[  252.071111] Call Trace:
[  252.071273]  dump_stack_lvl+0x45/0x59
[  252.071513]  __lock_acquire.cold+0x1fe/0x31b
[  252.072709]  lock_acquire+0x157/0x3c0
[  252.074445]  __mutex_lock+0xf6/0xc90
[  252.076294]  usbctrl_vendorreq+0xc5/0x4a0 [r8188eu]
[  252.076651]  usb_read8+0x68/0x8f [r8188eu]
[  252.076962]  ? usb_read16+0x8e/0x8e [r8188eu]
[  252.077287]  _rtw_read8+0x2d/0x32 [r8188eu]
[  252.077601]  HalPwrSeqCmdParsing+0x143/0x1de [r8188eu]
[  252.077979]  rtl8188eu_InitPowerOn+0x5a/0xe0 [r8188eu]
[  252.078352]  rtl8188eu_hal_init+0xe7/0x1008 [r8188eu]
[  252.078989]  rtw_hal_init+0x38/0xb5 [r8188eu]
[  252.079317]  _netdev_open+0x282/0x4db [r8188eu]
[  252.079653]  netdev_open+0x42/0x5f [r8188eu]


The problem was here before, but it was race condition, rather than a 
deadlock: netdev_open() locks the mutex, but internally calls usb_read8().

With previous code mutex_lock_interruptible() just fails and execution 
goes forward. It's not correct anyway... Fabio's patch helps to discover 
design bug :)


Again, I am so sorry for not enabling lockdep while testing this first 
time...





With regards,
Pavel Skripkin
