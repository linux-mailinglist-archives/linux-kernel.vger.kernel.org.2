Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8828388955
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbhESI04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244386AbhESI0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:26:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6713DC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 01:25:35 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621412733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u36eElYQ61qgPnHnIW77jfB6ETs4x4TzUWV7BJytFlc=;
        b=XDIHd9P4roBxpYK9lu7ZodT3w/8A+9tB28DAc9MpOYXIMzEy78Bb1OhhT0BnQxGnw18Vf/
        Z4EzsRlCjbHqOTiauBI5vdSq51EnSLzdLS1MTDZoBxIeGb+e+nlwY3R2Yq2zc/v/vBme20
        YUHJtvf5wsMdDYTQpX2+Y1fg2D3SdjVHvNFD36jof+sSHYSL4xyx2EnRzWI+6aSIR2WtI6
        SJmwX9uENwHVxZ8aQT6aMglx47LzAAbr7dxEknnFnRMZHI1rbneu3rM4x9lX7Nl/zBJ13W
        tXqFQkqmHmGPDrAOd8cU/PjSvUisbeKL+fCmb9HHiYHnCkGK1rsBZBuuOJcSVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621412733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u36eElYQ61qgPnHnIW77jfB6ETs4x4TzUWV7BJytFlc=;
        b=OE+jR2lUPg37khu9z7smpuQmO/zo3bWhnp9+Mz+rWcAo3lizbaVOHKKU2Oj+e2suqP7nkj
        76JV0TWqA1DVvGDQ==
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>, pmladek@suse.com,
        senozhatsky@chromium.org, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, ruifeng.zhang1@unisoc.com,
        nianfu.bai@unisoc.com, orson.zhai@unisoc.com
Subject: Re: [PATCH v1 1/1] printk: always output coreid in caller information
In-Reply-To: <20210519063355.5147-1-ruifeng.zhang0110@gmail.com>
References: <20210519063355.5147-1-ruifeng.zhang0110@gmail.com>
Date:   Wed, 19 May 2021 10:25:32 +0200
Message-ID: <87v97ft9j7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ruifeng,

On 2021-05-19, Ruifeng Zhang <ruifeng.zhang0110@gmail.com> wrote:
> From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
>
> Sometimes we want to know which cpu the process is running
> on when the log output, rather than the thread id.  So add
> the processor id output always in the caller information.
>
> caller_id bitmap:
> [63:32] thread_id
> [31]    flags of in thread context
> [30:0]  processor id

The primary purpose of @caller_id is so that the printk-subsystem can
coordinate LOG_CONT messages.

Your patch is about logging/printing additional context attributes of
the printk-caller. This is something we have discussed before [0]. I
think this should be addressed at some point. But we need to come up
with a solution that is flexible and generic. We should not be touching
these core structures every time some new attribute needs to be printed.

Also, this patch is controversial for other reasons:

- it adds bitwise logic, when it could more easily just add a new field
  (for example, caller_cpu)

- it increases the size of all records by 4 bytes

- it changes the internal structure in a way that breaks existing crash
  tools

- for non-task contexts, the increased size is wasted

John Ogness

[0] https://lore.kernel.org/lkml/20200904082438.20707-1-changki.kim@samsung.com
