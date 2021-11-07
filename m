Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6523C44739B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 16:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhKGP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 10:59:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234767AbhKGP7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 10:59:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8169A61354;
        Sun,  7 Nov 2021 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636300579;
        bh=OWzsuQwUkOBhz5onISXoQowhU6UKf4yGXzeVaQ7luik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwPwAnsYjCuQtoJulDN6KqjAl+FvYrvBQW/hNLq4cMwXuhoFTnxOMWvBpYg3CXjec
         8kmdCCOL3zdO4WcItxIU9qDF9dGSDoxvcYHEEDIMe4tkGBZhj3Okgc2Z8RGub4C0GY
         l9PnEwVHInVWlfwWTFI0X6KaQqlbvbXHdL4Z02cu9eeXh7XNijWKQf++lxepd8nr9a
         VP3FPzI4XmpTZVHcLfyY7xSdMpkwYxrXrTgqQdP0Z7Gu+OuuCpOF22VuornwoXTHwL
         BhoIdcyUAY8tthg8V1i+ZVBkSiiayY1CW8bcrIVz3spc/4ovDAq7GcKVZj7DKOPvTF
         XxecoToLKPdSw==
Date:   Sun, 7 Nov 2021 16:56:16 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Norbert <nbrtt01@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Performance regression: thread wakeup time (latency) increased
 up to 3x
Message-ID: <20211107155616.GA269390@lothringen>
References: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com>
 <YWlBUVDy9gOMiXls@hirez.programming.kicks-ass.net>
 <5fe0ffa5-f2db-ca79-5a10-305310066ff9@gmail.com>
 <20211015100401.45833169@gandalf.local.home>
 <8691a8ec-410d-afe8-f468-eefe698c6751@gmail.com>
 <YW1ZjroFfmKM9HJe@hirez.programming.kicks-ass.net>
 <fff246da-2a10-3463-614c-e54cd8cf78e7@gmail.com>
 <ae2debfb-c780-7164-09ee-ea295004d173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae2debfb-c780-7164-09ee-ea295004d173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Norbert,

On Tue, Oct 19, 2021 at 12:01:32AM -0700, Norbert wrote:
> 
> On the thought that it might enter deeper idle/wait/sleep states:
> 
> The benchmark executes this test in a quite tight loop, except that so far
> it waited 1000 ns (with a mix of pause and rdtsc) before calling futex-wake,
> to make sure the other thread fully enters the futex-wait without taking any
> shortcuts.
> 
> Except when this "prepare time" is reduced to less than even 350 ns or so,
> the timings remain the same (they go up before they start going down).
> Surely in this situation the thread is at least not supposed to enter deeper
> states for such short waiting times.

Is it possible for you to share this benchmark so that I can try to reproduce?

Thanks!
