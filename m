Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D1460139
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 20:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhK0TnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 14:43:13 -0500
Received: from shark4.inbox.lv ([194.152.32.84]:40260 "EHLO shark4.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhK0TlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 14:41:09 -0500
Received: from shark4.inbox.lv (localhost [127.0.0.1])
        by shark4-out.inbox.lv (Postfix) with ESMTP id F2BA2C00C0;
        Sat, 27 Nov 2021 21:37:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1638041873; bh=CxVW5OyFnBF8LJCDQd92GbUhILP9QZS1qZEDurcCUg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=PxGm7q9bj1vfiWO5phyo8TwyzQbV8aAD5GQYY7Nx4gdD7tVbZ46xldZgYjwZ0rjAY
         YUH1uxGEK223D88zaghMi8cqqbusbuxh93D4tp0yjQjEq+bNo4jPIDdecSZ848gI3b
         0rlqSM/d87OtEEMeQuuZEEbF0SjkgudjjtsqN3J0=
Received: from localhost (localhost [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id E5096C0079;
        Sat, 27 Nov 2021 21:37:52 +0200 (EET)
Received: from shark4.inbox.lv ([127.0.0.1])
        by localhost (shark4.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id uHOOBu8TJTQA; Sat, 27 Nov 2021 21:37:52 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id A56C5C0077;
        Sat, 27 Nov 2021 21:37:52 +0200 (EET)
Date:   Sun, 28 Nov 2021 04:37:36 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        vbabka@suse.cz, neilb@suse.de, akpm@linux-foundation.org,
        corbet@lwn.net, riel@surriel.com, hannes@cmpxchg.org,
        david@fromorbit.com, willy@infradead.org, hdanton@sina.com,
        penguin-kernel@i-love.sakura.ne.jp, oleksandr@natalenko.name,
        kernel@xanmod.org, michael@michaellarabel.com, aros@gmx.com,
        hakavlad@gmail.com
Subject: Re: mm: 5.16 regression: reclaim_throttle leads to stall in
 near-OOM conditions
Message-ID: <20211128043736.5a6dcc39@mail.inbox.lv>
In-Reply-To: <20211124143303.GH3366@techsingularity.net>
References: <20211124011954.7cab9bb4@mail.inbox.lv>
        <20211124103550.GE3366@techsingularity.net>
        <20211124195449.33f31e7f@mail.inbox.lv>
        <20211124115007.GG3366@techsingularity.net>
        <20211124214443.5c179d34@mail.inbox.lv>
        <20211124143303.GH3366@techsingularity.net>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: AJqEQ3AB6gpL2qWiSfBh5uXlxd+0XlwguDuDrrA34GxYtrbfst9zbm2WHJicZw/5LSPD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think there might be an unwritten mm law now that someone is always
> unhappy with OOM behaviour :(

It's okay if someone isn't happy with the default values.

It is not okay if there is no way to get the desired behavior using
tunables. And the problem is quite solvable [1].

[1] https://lore.kernel.org/linux-mm/20101028191523.GA14972@google.com/
