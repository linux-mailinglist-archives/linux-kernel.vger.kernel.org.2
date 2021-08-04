Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB43E05D0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbhHDQXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbhHDQXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:23:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFBEC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 09:23:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so6277113pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KDf4S7vuVJwPHUuA2uOwMFtaC8lnY+PpQtbeQuDG6qk=;
        b=K8xx7Gwt90YL5tpn+pg1F1XwRNwbg/3sOwmML189OUSTLCAYGybq+ezWdh+iW8rcur
         jJz+5jmiI4WtqT9rO/Ox5jJPUZmIo4I+de5jYIjia0crWrmcDYlpUcAbo6ejSCEU0LXG
         q0ePKUGqApxbGpTiYuHM5sulMlEyxPhPjWWoKVRLsRaJQ10l7JjqfNX4sw03aI3QWbmQ
         q7FirZt1qNIcqnK8sJA+0p5InRQwhMapXzGJZDoPjBxmB3BMorvwQ/5F+2Osx7c1qk5p
         gNdu7HZBN0GZl2CBND1eNJ0UIDjtudEh2aPeXj3FbmICOt0yS89jAxr5qekMhOGo/+aK
         wMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KDf4S7vuVJwPHUuA2uOwMFtaC8lnY+PpQtbeQuDG6qk=;
        b=X0uDJk7aRTR1uRKAD4ASTxiaJF+UES42B50UwELMuegoSq2KjD8JIn6ZK4FNVmswew
         G8u4F/WLcHxU32cBENHmSQN4oyJ5et+6hM6cAExIbBEekVDHRuG8y4ywQtTeiYp8FWgg
         5zLwKR9hMDnvhJpDZkvP6/CMy3OuHIYWOq5aXefYV+PH5r4bTKJ6oTrcgo1+sSb3oAHV
         EEBQDDV7x2GAl8XJgG2GifUYwDDG+zi+hgU1zxNidE6Pdv9inKtP7+Itt4ddduKCXukW
         1F6GGWrObxCfOnnOP9bD1FDsJosagszuvz5bvmoMw1x8GBpLvNZQjMBw4H4vWF7SOoUh
         kH0A==
X-Gm-Message-State: AOAM531to1QFtajk2y51X4iiJyPdWzJ8l46JKI0hfxiaG+l2ic38NKZD
        w7Fb77+K/0YTZta43jAd17fMoA==
X-Google-Smtp-Source: ABdhPJxyQStlQynjCVKg8OadBGr6XpSuvMNaXEahcITQr5ZhH7KVkhFBSvVMx04csvIB9chzwdInTA==
X-Received: by 2002:a62:584:0:b029:32e:3b57:a1c6 with SMTP id 126-20020a6205840000b029032e3b57a1c6mr435156pff.13.1628094181407;
        Wed, 04 Aug 2021 09:23:01 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id w2sm6685972pjt.14.2021.08.04.09.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 09:23:00 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
References: <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
 <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
 <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
 <20210804131731.GG8057@worktop.programming.kicks-ass.net>
 <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
 <20210804155747.cwayhjsdjc4zaubd@linutronix.de>
 <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
 <20210804122029.6c5c837a@oasis.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ffb8f7c-085c-f6cc-e308-3f75b24b8e47@kernel.dk>
Date:   Wed, 4 Aug 2021 10:22:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804122029.6c5c837a@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 10:20 AM, Steven Rostedt wrote:
> On Wed, 4 Aug 2021 10:05:39 -0600
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> So what do you propose in the interim? As far as io_uring is concerned,
>> it's not a _huge_ deal to do the IRQ dance, but it does bother me that
>> we're making things slightly worse for the mainline kernel just to make
>> the out-of-tree patches happy.
> 
> Note that the purpose of these patches are to be able to bring those
> out-of-tree patches into the kernel such that they are no longer
> out-of-tree.

Sure, I realize that. And I've always been accommodating to making
pieces of code more RT friendly, I just don't like doing it for cases
where we are making mainline worse.

In that regard, I do still consider those patches out-of-tree, which
they are. And while I'm more sympathetic to them compared to other
out-of-tree code as there's a long term plan to get it all in, it's
still out-of-tree. Best solution here is probably to just carry that
particular change in the RT patchset for now.

-- 
Jens Axboe

