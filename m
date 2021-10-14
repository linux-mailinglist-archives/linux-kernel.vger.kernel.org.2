Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B550742DA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhJNNdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhJNNdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:33:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 749B360EE9;
        Thu, 14 Oct 2021 13:31:10 +0000 (UTC)
Date:   Thu, 14 Oct 2021 09:31:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v4 2/5] connector: use __get_task_comm in
 proc_comm_connector
Message-ID: <20211014093108.3fdf22bd@gandalf.local.home>
In-Reply-To: <CALOAHbA8OkrPfWJbYv7Kr988QGHsV0KaHxZwWWimRh6oJDy-8A@mail.gmail.com>
References: <20211013102346.179642-1-laoar.shao@gmail.com>
        <20211013102346.179642-3-laoar.shao@gmail.com>
        <20211013101921.0843aaf0@gandalf.local.home>
        <CALOAHbCt+rLiPE4_zZO_f5sKybKwYntqupx_L9V_J+yByoFvOw@mail.gmail.com>
        <20211013222418.7ea9727d@oasis.local.home>
        <202110132148.523C3EA@keescook>
        <CALOAHbA8OkrPfWJbYv7Kr988QGHsV0KaHxZwWWimRh6oJDy-8A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 17:26:16 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> > > But that should probably be a separate patch.  
> >
> > strscpy_pad() is the right thing here -- it'll retain the NUL-fill
> > properties of strncpy and terminate correctly.
> >  
> 
> strscpy_pad() can also work, and seems more simple.

I'm fine either way. As long as the string that is updated is terminated.

-- Steve
