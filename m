Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD2230A54B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhBAK13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:27:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:35066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232290AbhBAK12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:27:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612175201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HcYuIPJxvFYv5QNbcW9iQ1RF+MJphc58zNc70PwN3M8=;
        b=jroby34NQvFAIo/UBsJqgs/M+jC53xDSbLP2KQhmTBxVauvM9SAQqgZg1LYw6ZKT6YN7qJ
        hHalDufw6nquiQykcKmNe5uA8la3WK+A5CDO8H41kH3rgWJ3d8aMccUK/bGLxi+mZfh67S
        GF84pS2gh3z6mIZ+Q145532/rW5pWlw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 955B6AFDB;
        Mon,  1 Feb 2021 10:26:41 +0000 (UTC)
Date:   Mon, 1 Feb 2021 11:26:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 09/12] um: synchronize kmsg_dumper
Message-ID: <YBfXYYKSHiH4eyI3@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
 <20210126211551.26536-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126211551.26536-10-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-01-26 22:21:48, John Ogness wrote:
> In preparation for removing printk's @logbuf_lock, dumpers that have
> assumed to be protected against parallel calls must provide their own
> synchronization. Add a locally static spinlock to synchronize the
> kmsg_dump call and temporary buffer usage.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
