Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2B3966D2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhEaRXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbhEaRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:23:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC3CC0467D0
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WyW/lgrXio1io+DdNIzucbTsMb/tqw0RVBeZR+N/DxI=; b=kVButqd6qa8XUaZiEQJ2AHwgSm
        Oll0ADKUMrhHydehguXaRtm4DssUmGVJk74wdmb184v6QQdladqtxbfwxKY6SNNO0vF6LgM9AYe+V
        GrDUHgQjJ1qxelecxOB/AMN3/binSj5N8KDiwxvcMP0NgZwRKo5VRwmA9RNBrzOW6qKOaBO3lUfRk
        ocVKqxDuYIfBJw/z3xJNsdZ5nsY/a3iUwa/Lqg5serIkzk4PY9dLYTCv2BITPxeVmRlxipKWLlljx
        HX9lUIKFRT9n70mv0bbfn/zhUJx3gZkgSo+WRRtlsQN3fwpqKEtQ6oZS3BcXgFSRot3cNqdA0Tz2o
        DXmO1iww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lnk9X-002JEO-Sm; Mon, 31 May 2021 15:48:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3BEC300223;
        Mon, 31 May 2021 17:48:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E437F2C45692F; Mon, 31 May 2021 17:48:36 +0200 (CEST)
Date:   Mon, 31 May 2021 17:48:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hailong Liu <liuhailongg6@163.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: Re: [PATCH] sched/debug:fix stale comments of sched_debug
Message-ID: <YLUFVBJgaQBSsbAM@hirez.programming.kicks-ass.net>
References: <20210530025145.13527-1-liuhailongg6@163.com>
 <YLSUw2Kkq946LQam@smile.fi.intel.com>
 <48a36f92-e8cf-d62b-e4d5-bf6911bcbbcf@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48a36f92-e8cf-d62b-e4d5-bf6911bcbbcf@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 10:09:36PM +0800, Hailong Liu wrote:
> Based on your suggestion, I checked and it turned out that PROC_FS is not
> the correct dependency, but DEBUG_FS. 

You should check again...
