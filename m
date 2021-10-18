Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE897431733
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhJRL1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhJRL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:27:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF40C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 04:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LwGfNXapR6UMR3h1JoejKGv6nS6hMbfIvTOu9Gkeccs=; b=O3K10iB4Eb2DYZP1H2cTmLZXAX
        j2vCBneyHCVG5B+WGOAAlk9Ee+BWmy9sCJDmdGg0lNP2b6eA5Isb8He23BH9T0UyrBU5wR8gpvsZA
        XuH7ObmPcxzOHKCUC8DbDoD81Ni1YSR05nbWrFmJo+BLPLAC/HqVbdK+su1wDi/K20XQp1/Cu1OAq
        1HwniX3UgOpS27bg0L/4wZN4StmrV5MSRVGCUrzNS34W0UGDv3AOyqFM5SGEsK9mcCN5q24tus8Zj
        xbRZFucRSCrTQ9Ky653baObydXcfRKHYx4oU5NMxgxiPxVXvcU+ef1Q15rFkp9x7dQ88crjDIiaRk
        CxzoeQ+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcQlL-00AXUz-Mp; Mon, 18 Oct 2021 11:25:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 675A7300221;
        Mon, 18 Oct 2021 13:25:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50FD52C4A3AE4; Mon, 18 Oct 2021 13:25:02 +0200 (CEST)
Date:   Mon, 18 Oct 2021 13:25:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Norbert <nbrtt01@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, frederic@kernel.org
Subject: Re: Performance regression: thread wakeup time (latency) increased
 up to 3x
Message-ID: <YW1ZjroFfmKM9HJe@hirez.programming.kicks-ass.net>
References: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com>
 <YWlBUVDy9gOMiXls@hirez.programming.kicks-ass.net>
 <5fe0ffa5-f2db-ca79-5a10-305310066ff9@gmail.com>
 <20211015100401.45833169@gandalf.local.home>
 <8691a8ec-410d-afe8-f468-eefe698c6751@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8691a8ec-410d-afe8-f468-eefe698c6751@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 09:08:58PM -0700, Norbert wrote:

> > > > On Fri, Oct 15, 2021 at 12:43:45AM -0700, Norbert wrote:
> > > > > Performance regression: thread wakeup time (latency) increased up to 3x.
> > > > > 
> > > > > Happened between 5.13.8 and 5.14.0. Still happening at least on 5.14.11.

> So git-bisect finally identified the following commit.
> The performance difference came in a single step. Times were consistent with
> my first post either the slow time or the fast time,
> as far as I could tell during the bisection.
> 
> It is a bit unfortunate that this comes from an attempt to reduce OS noise.
> 
> -----------------------------------------------------
> commit a5183862e76fdc25f36b39c2489b816a5c66e2e5
> Author: Yunfeng Ye <yeyunfeng@huawei.com>
> Date:   Thu May 13 01:29:16 2021 +0200
> 
>     tick/nohz: Conditionally restart tick on idle exit
> 
>     In nohz_full mode, switching from idle to a task will unconditionally
>     issue a tick restart. If the task is alone in the runqueue or is the
>     highest priority, the tick will fire once then eventually stop. But that
>     alone is still undesired noise.
> 
>     Therefore, only restart the tick on idle exit when it's strictly
>     necessary.
> 
>     Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>     Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>     Acked-by: Peter Zijlstra <peterz@infradead.org>
>     Link:
> https://lore.kernel.org/r/20210512232924.150322-3-frederic@kernel.org
> -----------------------------------------------------
> 
> Is there anything else to do to complete this report?

So it _could_ be you're seeing increased use of deeper idle states due
to less noise. I'm forever forgetting what the most friendly tool is for
checking that (powertop can I think), Rafael?

One thing to try is boot with idle=halt and see if that makes a
different.

Also, let me Cc all the people involved.. the thread starts:

  https://lkml.kernel.org/r/035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com
