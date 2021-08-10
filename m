Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85553E0631
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbhHDQ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbhHDQ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:57:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24F1C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 09:57:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so6425140pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n/ydrZoBnTnGVePnkLl67Uygiapkqd3aQOEpbd0KF1Q=;
        b=eCRQdH5apsetsVkiAmtu3sr/Ir5ypuLwjrJmExN+1AfyfcCL5tkENpCuUELQvR76UV
         /a4tBIT5VSaBmVDtXyqspVeHh/2JkwH1JqvFnr97JKlfTbJjutUYozHYFvUiNtNe4y7I
         oUBS5Ec7JN0Ygiv0ZbvaKxj9RAzk8i+QHgTsE/EEHZPAUnERtjUfab5cEiOh5Yo/eX8J
         wpOnI0JHH0ow1jgHA9xGygu02GzlRkLQo3Bb+2LJx3bUcJFquUoFsUN42b8G37pJz7Zk
         Jzk/RoH47YXFZqfImcTRy3H9dB3xGO1oTnq99LZMGcWGb9kTZCkDoobNqFTkNsJLYhZ7
         cLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n/ydrZoBnTnGVePnkLl67Uygiapkqd3aQOEpbd0KF1Q=;
        b=Z6QYlQebxXVs6uB2DUThhCNDY8T2tHwViq0sTIHIqmoydLAv5abLQuj6er1JDT9PoI
         LV6p4Zr0HBvDWME/JL8Tusk86ERqrPHUyTwX5+9noifbDxNT7F8CPV3Rb/7rRmwz9UPU
         IUi8HYCAbh7paYTKpeca9XLSWV1v+UjOOhsVl3BsqcvwmKmQrD5SUnCE8hidKMzT5fli
         nM8xLkQRZbuugsDfhbFl+gMl4FGhgXMyckO71AWGOrk4zerQetv9qFJGG2EjiLJ08NUt
         tSgvD/wQoHZTmx8iwNu82jlLeXZsBbXYCjHiIu5kbuK3/qE4t85yvZtY4TwVrquiMf1d
         9RIg==
X-Gm-Message-State: AOAM531uFCmq50o7XIeQDHesORik0vz9MQfRpsud/o3+meb+XSp5NeDH
        R4P9FSIcIe+wujToCs/cDugnIg==
X-Google-Smtp-Source: ABdhPJwASPd1DN5CHX6YbOTJFLlYKFjsk0OLfbOytoFl/99XNsWjh2j7HqHE8qkJosCaZnHZ9sCB6g==
X-Received: by 2002:a17:90b:344:: with SMTP id fh4mr104771pjb.29.1628096234326;
        Wed, 04 Aug 2021 09:57:14 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id 19sm3440765pfw.203.2021.08.04.09.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 09:57:13 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
References: <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
 <20210804155747.cwayhjsdjc4zaubd@linutronix.de>
 <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
 <20210804122029.6c5c837a@oasis.local.home>
 <4ffb8f7c-085c-f6cc-e308-3f75b24b8e47@kernel.dk>
 <20210804164735.sq6sjejusa37abkw@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <71d37a7d-af53-945e-0c49-3cb902487df4@kernel.dk>
Date:   Wed, 4 Aug 2021 10:57:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804164735.sq6sjejusa37abkw@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 10:47 AM, Sebastian Andrzej Siewior wrote:
> On 2021-08-04 10:22:59 [-0600], Jens Axboe wrote:
>>
>> In that regard, I do still consider those patches out-of-tree, which
>> they are. And while I'm more sympathetic to them compared to other
>> out-of-tree code as there's a long term plan to get it all in, it's
>> still out-of-tree. Best solution here is probably to just carry that
>> particular change in the RT patchset for now.
> 
> So today in the morning I learned that there is a memory allocation in
> an IRQ-off section and now, a patch later, it is almost gone. So that
> makes me actually happy :)

1 out of 2 is better than 0 ;-)

> The spin_lock_irq() vs local_irq_disable() + spin_lock() is documented
> in Documentation/locking/locktypes.rst.
> That said I have no problem by carrying that patch in the RT-patchset
> and revisit it later.

Right, I suspect that was added as a pre RT patch dump at some point.
It's a newer thing. Is it actually possible to set PREEMPT_RT in the
mainline kernel? Looks like it depends on ARCH_SUPPORTS_RT and nobody
sets that.

So I agree that just carrying your solution in the RT patchset is fine
for now, we can revisit later.

-- 
Jens Axboe

