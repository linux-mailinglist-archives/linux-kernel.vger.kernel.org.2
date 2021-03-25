Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33E934864D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 02:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhCYBPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 21:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231225AbhCYBO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 21:14:58 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 002AB61A0A;
        Thu, 25 Mar 2021 01:14:56 +0000 (UTC)
Date:   Wed, 24 Mar 2021 21:14:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <mingo@redhat.com>, <jolsa@redhat.com>,
        <linux-kernel@vger.kernel.org>, <yangjihong1@huawei.com>,
        <xukuohai@huawei.com>, <zhangjinhao2@huawei.com>
Subject: Re: [PATCH 2/2] perf, ftrace: Fix use-after-free in
 __ftrace_ops_list_func()
Message-ID: <20210324211455.35beb1e2@oasis.local.home>
In-Reply-To: <20210324211123.64d72c02@oasis.local.home>
References: <20210317102529.226734-1-lihuafei1@huawei.com>
        <20210317102529.226734-3-lihuafei1@huawei.com>
        <20210324211123.64d72c02@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 21:11:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> And what you are saying is that we are not getting there, where the
> dynamically allocated perf ops is not set to be DYNAMIC?
> 
> That should be set as DYNAMIC if the ops was allocated, and can later
> be freed. This code was written specifically to handle perf.
> 
> Thus, NACK on the patch. I want to know exactly what went wrong instead
> of just saying "but the current interface unregister_ftrace_function()
> does not seem to guarantee this", let's actually fix the bug and not just paper over it!

Bah, I forgot to edit the claws-mail shortcut to disable "Ctrl-Enter"
to send the email, and went to hit Ctrl-L (to do the line wrapping) but
accidentally hit Ctrl-Enter instead, and sent this prematurely. And now
I forgot what else I was going to say. Sucks getting old.

-- Steve
 
