Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A37314628
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBICWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBICWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:22:09 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BD8C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 18:21:28 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id j12so10923048pfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 18:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=sLVYnGgC0u6HNMmR5euwsbFZLmEwQODu+ON6VAFee7Y=;
        b=KRzjTOJYNUFzL9WcgVPqYio9I9JLt2tCNA6EmvaxDbnhB+qv87f5RREpsfX+8r228i
         /GWVu6t2oA6P/cxuuhjhwRjGLfFlL+1mKECuNVIo9K9gcAwelNLA0r8DBxfbWMS6IhHU
         w+5O9jnqb4vRx+RrlIzSoF5Rb4BVP5P6Hm5nEYgZjH5JRa7a2wlrGZPLnHSZE07jU4yI
         ExLAYE2gCr8G3jOwaGuKnVYzjl6DAHp3+Qg/p0YBZM3z/CJdhI1K4F4fJL/ckJfKI3LP
         Hq7R6i28jZ9cOJBgstpwp2MjddAunlHLe93chB1iZIJqVxZoVRQxdMiaVk9IjRec4BC/
         UToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sLVYnGgC0u6HNMmR5euwsbFZLmEwQODu+ON6VAFee7Y=;
        b=MBVe5QUd2YQmOLRizUPy1UhVPhC3S80dj0y/JruISW1RDUAvKgciwwyZoHryW+XpYs
         rI5FcW0jj575j2hpaAoTCb3Pgb4/uyechEM5axYuk+ihkuVp76q2uiQUuPbqjkrEUFzY
         zQDmq4ZCFxCRLqM0BmLmNHD+l8YdpwLgdjo2IlLSH52KNxKaFM6/R47mN3p68f3qFKxY
         hGfQMzSX7lmfOYNq0lmHYgUdqsgEY/LxYaTN53m9j3CoEJFxkYS/nwM4IIpAqozom7wu
         8YXJjLxX0REkRR3aRxK0TLFwC8t+DRg42jhhXgDuQDNYpQWvOvMaHTQpbD0J2ZNngmeF
         HEug==
X-Gm-Message-State: AOAM532/8TuD28NPEaaOVe7VWUV7bwwwpo7tI1PvnkcGDK3VxG/qRMoM
        XggqpoAt5196eWlgwvGIjDmQThW7BX7fnw==
X-Google-Smtp-Source: ABdhPJyq3eRrqAukUrrfJxYxKM2POiyCQSaIzeKN5fHD0kxiIiwNBHMTB8WPgjJOBLEn4PhViTkLaQ==
X-Received: by 2002:a63:f74f:: with SMTP id f15mr20375419pgk.186.1612837288206;
        Mon, 08 Feb 2021 18:21:28 -0800 (PST)
Received: from [10.255.96.22] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id h23sm20696798pgh.64.2021.02.08.18.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 18:21:27 -0800 (PST)
Subject: Re: [External] Re: [PATCH] psi: Remove the redundant psi_task_tick
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
References: <20210207115642.75620-1-zhouchengming@bytedance.com>
 <YCFqxEw0wJC6UGiE@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <1165c0f2-134e-932d-e427-3b65c659108d@bytedance.com>
Date:   Tue, 9 Feb 2021 10:21:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCFqxEw0wJC6UGiE@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/2/9 上午12:45, Johannes Weiner 写道:

> On Sun, Feb 07, 2021 at 07:56:42PM +0800, Chengming Zhou wrote:
>> From: zhouchengming <zhouchengming@bytedance.com>
>>
>> When the current task in a cgroup is in_memstall, the corresponding psi_group
>> is in PSI_MEM_FULL state
> This is correct.
>
>> so we can remove the redundant psi_task_tick from scheduler_tick to
>> save this periodic cost.
> But this isn't. It IS the task tick that makes it so. The state change
> tracking counts MEMSTALL tasks and ONCPU tasks, but it doesn't check
> whether the ONCPU task is the MEMSTALL one.

Yes, you are right, I messed them up... will take a closer look at the code later.

Thanks.

> It would be possible to incorporate that into psi_task_switch(), but
> you have to be careful with the branches because that path is often
> hotter than the timer tick.
>
> This patch by itself breaks page reclaim detection, so NAK.
