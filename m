Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9434032DAB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbhCDT6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhCDT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:58:43 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8704C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 11:58:02 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x9so4787687edd.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/BriSpcy9LU3hOjUA17kvD5P5X48lwv8ftAZizprRcs=;
        b=BIvd7NpT3EHkS9O1bloXlk6jHwftF7Tx7KifnWUtshc8a+6DAR2bi1Kjo9QEkNgO1k
         XEmbKKlN+m11njhNggCHJJ7mQsVMUbTnZGb3pU6w5O7W7seRklc+Y9HVsL4s4giDsazY
         JMCr7YCu6Aq1Jn6GVk0fz0qrGm+SpaSjyvAFVJsxj6kFTEaStD35QyO0UWpACUMh1mCg
         6uTY9P/MZrCYglxVMwWT19yAGLBjZZzfT+gTlzUOpzQ2k4hCIhSOMFfSi2gFVOsAoCsU
         5h8KdQ+XRy1Nm/kpIeWOG7wgiMhvIAOQqz/4QYTHG5zzGwZYpDt9afwcmBXjdwd6ncfZ
         cLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/BriSpcy9LU3hOjUA17kvD5P5X48lwv8ftAZizprRcs=;
        b=qW8G0Uo60FSuLDei9k3QPD2w0+1zCwcyyK5Ewl3lfFsyP2UNWH4ZQdlw5v6iG4ox2R
         IvoAyc9Ij/Bw8dZt3OPUteqbBKvxNCMfs5GWejJUjaLMLexeo+gGqwNQxvdCsTSrPd33
         wTuCWvmQQc+bO7BrZhVDjIssLP2jWsSNSNWePtNExQmE/v+XyjDcEHZCHiHlXGUeHLMh
         yOcSiFl6iVnnwBQCOPUa/b1dTn/XuPa7HsTeJ5d7V5oX86KGVlwMg1F8BS1WdfCaLz1o
         +i4GBMMhWM70dhiNzuThKml8gjSLi+WCIWIPT4gBOaXG8TdtNVF2C/9793+P45ri9Xcf
         T5Kw==
X-Gm-Message-State: AOAM531dvqY/qltEOTpwM6NuKaDeJANEOZxr/QjE9UtXQ5tFgeyxEXMF
        cjWMamVc+ZsIxQZ8z4l8xmmk+A==
X-Google-Smtp-Source: ABdhPJyeQPIkbs3ZXchnX1XGB3rUpJPxEzyWtnfArEqicHZX8f1sUMLtsVWQkKWi2oOgSH0A9QrPlQ==
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr1609276edw.354.1614887881376;
        Thu, 04 Mar 2021 11:58:01 -0800 (PST)
Received: from ?IPv6:2003:d9:970b:e100:5aee:8298:cfca:a055? (p200300d9970be1005aee8298cfcaa055.dip0.t-ipconnect.de. [2003:d9:970b:e100:5aee:8298:cfca:a055])
        by smtp.googlemail.com with ESMTPSA id v8sm215093edq.76.2021.03.04.11.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 11:58:00 -0800 (PST)
Subject: Re: [PATCH] ipc/msg: add msgsnd_timed and msgrcv_timed syscall for
 system V message queue
To:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Gao <eric.tech@foxmail.com>
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
References: <tencent_E0772A5A82FD941DB0B488DF366F3F509F07@qq.com>
 <20210303171220.79faee7108f846b8e140e44d@linux-foundation.org>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <9727c4d0-c65c-a95a-1661-fc6da3a85045@colorfullife.com>
Date:   Thu, 4 Mar 2021 20:57:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210303171220.79faee7108f846b8e140e44d@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,


On 3/4/21 2:12 AM, Andrew Morton wrote:
> On Tue, 23 Feb 2021 23:11:43 +0800 Eric Gao <eric.tech@foxmail.com> wrote:
>
>> sometimes, we need the msgsnd or msgrcv syscall can return after a limited
>> time, so that the business thread do not be blocked here all the time. In
>> this case, I add the msgsnd_timed and msgrcv_timed syscall that with time
>> parameter, which has a unit of ms.
> Please cc Manfred and Davidlohr on ipc/ changes.
>
> The above is a very brief description for a new syscall!  Please go to
> great lengths to tell us why this is considered useful - what are the
> use cases?
>
> Also, please fully describe the proposed syscall interface right here
> in the changelog.  Please be prepared to later prepare a full manpage.
>
>> ...
>> +SYSCALL_DEFINE5(msgsnd_timed, int, msqid, struct msgbuf __user *, msgp, size_t, msgsz,
>> +		int, msgflg, long, timeoutms)
> Specifying the timeout in milliseconds is problematic - it's very
> coarse.  See sys_epoll_pwait2()'s use of timespecs.

What about using an absolute timeout, like in mq_timedsend()?

That makes restart handling after signals far simpler.

> > -               schedule();
> > +
> > +               /* sometimes, we need msgsnd syscall return after a given time */
> > +               if (timeoutms <= 0) {
> > +                       schedule();
> > +               } else {
> > +                       timeoutms = schedule_timeout(timeoutms);
> > +                       if (timeoutms == 0)
> > +                               timeoutflag = true;
> > +               }
>
> I wonder if this should be schedule_timeout_interruptible() or at least
> schedule_timeout_killable() instead of schedule_timeout(). If it should,
> this should probably be done as a separate change.
No. schedule_timeout_interruptible() just means that 
__set_current_state() is called before the schedule_timeout().

The __set_current_state() is done directly in msg.c, before dropping the 
lock.

--

     Manfred

