Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0F8354898
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 00:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbhDEWZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 18:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233086AbhDEWZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 18:25:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96472613D6;
        Mon,  5 Apr 2021 22:25:22 +0000 (UTC)
Date:   Mon, 5 Apr 2021 18:25:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Subject: Re: [PATCH v2 5/5] tracing: Add "func_no_repeats" option for
 function tracing
Message-ID: <20210405182521.07f0d1ab@gandalf.local.home>
In-Reply-To: <20210329130533.199507-6-y.karadz@gmail.com>
References: <20210329130533.199507-1-y.karadz@gmail.com>
        <20210329130533.199507-6-y.karadz@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 16:05:33 +0300
"Yordan Karadzhov (VMware)" <y.karadz@gmail.com> wrote:

> If the option is activated the function tracing record gets
> consolidated in the cases when a single function is called number
> of times consecutively. Instead of having an identical record for
> each call of the function we will record only the first call
> following by event showing the number of repeats.
> 
> Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
> 
> fix last

You seem to have left the above extra text "fix last" in both versions.

But the rest of the patch looks fine.

-- Steve
