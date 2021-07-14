Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0803C819B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbhGNJed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbhGNJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:34:31 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600E3C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:31:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s18so1786126pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=JEJuWryRLz1lYltDIr27T/XgjYKWMcQpjWG4c6CTN3Q=;
        b=rQy8/AZfgpYoiBHiMvVv7aC/Eyh9/sCr/a7Yg/PlzvWQIv4JDAAUdTeIOftQiYe4Uu
         OKR+qFabqzVPu94fqRUNM07V3yhhjZJn3Vv2kCps6UXdkxpxcYxokytMiMoiukv0FRyO
         92vihSoMQ+AhB/eFHe7Hi4FJB/E8ios9gSZ2/FPSL2VKzrAynJKtv9Q6QYcPDeeB33zq
         Rw4nQyGdLkfYGZQ9N6btA1AOsQJy3KRa6b1MZmFomvf2IJG1ek8v//QVqbBfL5dawvwV
         RjnhOcOInR5NIDp2ozFEAoBPiP7qVUKNEuxOf3FhNGXuSn32hEnUdZx3p+AY1XoNUJGO
         bCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=JEJuWryRLz1lYltDIr27T/XgjYKWMcQpjWG4c6CTN3Q=;
        b=XZD3FG82c/oHh22RZXZQUbaudam7wzsqVWs1NAG31f1g3k437R/4/bURTGSHEiH2eE
         wWDCfqwLw/0Sy4pIwuMwonJ51QOyBQW3wZwqe+QNIbNi5mRe2MNTFMPcuXhcKv9p7PEP
         nzuQzbrHYMcxIxjSl1qPzOi+HMJr7aXE1baqopxci3RshvKWg7vDx8wdkj/T/2g3wp5+
         duM2ZWexxi8rBn7OQtUf61IbV094mBGhoG+P9ZxNujmuFZka5+UYQd3qasaHiURd1PWK
         RyWbKaExvkwpgq5aHZPejsSzn0xzIhv1ALQv02O6pNUJ9LIQ35QS4dqILyjbD9Zg9M90
         TaZQ==
X-Gm-Message-State: AOAM533hSznOExnWp9oljUkvrNRBGa80Ysdhdu3vL/uebQMekTbMMJQ5
        nE9shxZ8y10O0E/oVk+/DGo=
X-Google-Smtp-Source: ABdhPJxhwxBb4+PJLdN98H/GKG/MPtyCnD6qlwZllOMyWQLNSFVs8QH9O0ixiJWdSiT395NUwSWwHw==
X-Received: by 2002:aa7:921a:0:b029:2cf:b55b:9d52 with SMTP id 26-20020aa7921a0000b02902cfb55b9d52mr9102280pfo.35.1626255099869;
        Wed, 14 Jul 2021 02:31:39 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n24sm5295763pjq.51.2021.07.14.02.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 02:31:39 -0700 (PDT)
Date:   Wed, 14 Jul 2021 06:31:09 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20210714092416.GE2725@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de> <20210713160748.090645860@linutronix.de> <20210714092416.GE2725@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [patch 22/50] rbtree: Split out the rbtree type definitions
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <802E332A-3EAD-42A0-A2E0-416344695937@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 14, 2021 6:24:16 AM GMT-03:00, Peter Zijlstra <peterz@infradead=2E=
org> wrote:
>On Tue, Jul 13, 2021 at 05:11:16PM +0200, Thomas Gleixner wrote:
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix=2Ede>
>>=20
>> rtmutex=2Eh needs the definition of struct rb_root_cached=2E rbtree=2Eh
>includes
>> kernel=2Eh which includes spinlock=2Eh=2E That works nicely for non-RT
>enabled
>> kernels, but on RT enabled kernels spinlocks are based on rtmutexes
>which
>> creates another circular header dependency as spinlocks=2Eh will
>require
>> rtmutex=2Eh=2E
>>=20
>> Split out the type definitions and move them into their own header
>file so
>> the rtmutex header can include just those=2E
>>=20
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix=2Ede>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix=2Ede>
>> ---
>>  include/linux/rbtree=2Eh       | 30 +-----------------------------
>>  include/linux/rbtree_types=2Eh | 34 ++++++++++++++++++++++++++++++++++
>
>This will mess up the tools/include/linux/ copy of these headers=2E=2E=2E

Please don't worry about that, it's a copy, done that way to avoid burdeni=
ng kernel developers, I'll check and adapt :-)

- Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
