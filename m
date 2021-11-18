Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DBB455E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhKROdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233139AbhKROde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:33:34 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 109B6613DB;
        Thu, 18 Nov 2021 14:30:33 +0000 (UTC)
Date:   Thu, 18 Nov 2021 09:30:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@openvz.org
Subject: Re: [PATCH] tracing: fix va_list breakage in trace_check_vprintf()
Message-ID: <20211118093032.31c06b11@gandalf.local.home>
In-Reply-To: <ae2254dd-dcc8-3375-e8d6-efb73e280574@virtuozzo.com>
References: <20211117183720.15573-1-nikita.yushchenko@virtuozzo.com>
        <20211117183827.4989cfab@gandalf.local.home>
        <ae2254dd-dcc8-3375-e8d6-efb73e280574@virtuozzo.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 07:57:33 +0300
Nikita Yushchenko <nikita.yushchenko@virtuozzo.com> wrote:

> What I don't like here is - trace_check_vprintf() will still extract wrong positional arguments, and use 
> the result as part of it's logic.
> 
> Although with your change such use becomes a no-op, this is unintuitive and can turn easily into real 
> problems with future changes.

That trace_check_vprintf() is just full of unintuitive logic ;-)

Which is why I prefer to keep any remnants of that code in that code and
not spread it around. 

> 
> And, the above comment is inexact...  why we can't test? We can, testing code does no depend on 
> iter->seq. What we can't is - reliably extract str to test.
> 
> If testing seq->full condition is preferred over forcibly consuming args from va_list, then such a test 
> shall be done before trace_check_vprintf() tries to use va_arg(). Will submit a patch doing that.

I'm happy with that patch, but can you please resend it as a top level
patch and not a reply, otherwise my patchwork doesn't catch it and my
scripts will not work on it.

Thanks,

-- Steve
