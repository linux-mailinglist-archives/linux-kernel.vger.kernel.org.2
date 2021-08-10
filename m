Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269163E05C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhHDQVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhHDQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:21:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0054DC061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 09:20:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id z3so3533736plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Blsw9uJymYLfijyUNBinF5G6R0q4SvzsVQ23Eh4NoY0=;
        b=b8ww/tg4FYxDW9YfrSroZXnnfvDiBWdwhYJrRfy5bTjJKuhZr+K4PaGhqeC0D3Eny9
         bRs49N//zWRVTa0elwP6GnhMnxfmMjScc5qyWf5tAZId+pgYAP1Q1T9tQ3t36qDseYgM
         6im3qSctY7i9QZsreWXZsfUuZilwuBQBufogE9KYL27wYh0fNLZMEZr0qKso7vBrIGTb
         Pr5iFSFnbdvJaA6cKx9tovDhwk7qLbkbxZs5VbNv8ea3jt8mK3baEuLdTJN4sP+bPq48
         vGWpKWTU4Oza7zWRRDaSSYdAL8XV+CG9uemw+L9vmBkFgwyauirfoWJ/18ZuX6cDEUpW
         u6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Blsw9uJymYLfijyUNBinF5G6R0q4SvzsVQ23Eh4NoY0=;
        b=K7pCwufJP2VIkxSE3fI40RIyUo/uR2T2RCgN4ixc3KcJys/iZxyGu/S8pSK0l4A/AA
         tExTk44YwCzy2QF4CRkFJpuyDy1/MZpCEGnAM6w3oHu/UjTpVAyW+9li7XPwg29+b6II
         vGTnBp4awO07xD2A9FBmB9EZXTUY3GY8jnmtLFS0spId8dG0OsFOM0TKn3xb9Ci2vtXW
         j3R8QRCBS9VcFoZYhL8yJaKQH7DlgQBCAqZ72T6ZnGLOOaEEnUd0EpkJ0SSs0bMWGBuh
         l4ZfLTyVkb08VPBx02tuGfDr2mEs2gceR7gYg6GhWxIWyObgXRMEjMm6vMn6Emw2BAHZ
         htpA==
X-Gm-Message-State: AOAM533/zbQZ2g/4r4zOJe5guXq2Zg4wGRxwx6T26vtNXbnu6BFy1pLt
        eU+GEmIchdzvdKfKGdKdhqAYclS6zuEBzZUA
X-Google-Smtp-Source: ABdhPJzkJrewKqt+x4DZfi3kLYV4N6da8O0Wjb1KPYrYB3mTsqbJR7/a3TpKzsesHedSDullphFDyQ==
X-Received: by 2002:a62:8fd4:0:b029:3af:3fa7:c993 with SMTP id n203-20020a628fd40000b02903af3fa7c993mr399648pfd.77.1628094054432;
        Wed, 04 Aug 2021 09:20:54 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id 81sm3566837pfv.185.2021.08.04.09.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 09:20:53 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
 <20210804131731.GG8057@worktop.programming.kicks-ass.net>
 <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
 <20210804155747.cwayhjsdjc4zaubd@linutronix.de>
 <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
 <20210804162001.resdas32c6oy75o3@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d97c4305-d938-6b5f-073a-8d67a48fc9ae@kernel.dk>
Date:   Wed, 4 Aug 2021 10:20:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804162001.resdas32c6oy75o3@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 10:20 AM, Sebastian Andrzej Siewior wrote:
> On 2021-08-04 10:05:39 [-0600], Jens Axboe wrote:
>> So what do you propose in the interim? As far as io_uring is concerned,
>> it's not a _huge_ deal to do the IRQ dance, but it does bother me that
>> we're making things slightly worse for the mainline kernel just to make
>> the out-of-tree patches happy.
> 
> I'm sorry but I propose nothing other than the dance. I don't think
> PeterZ/ tglx will appreciate the ifdefery to avoid the IRQ-on/off here.
> I have no other ideas here.

Alright, I'll see if I can think of something. Don't like doing ifdefs
either, or enable checks - but at least it'd only hurt readability
slightly at that point.

-- 
Jens Axboe

