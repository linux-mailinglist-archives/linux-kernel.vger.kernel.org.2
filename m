Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D9E32BE49
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385436AbhCCRTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:19:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:45704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357156AbhCCNhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:37:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614778545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RZqAZHKG2PMcZ+Q+nU8NL4rkzsBwV8mdUQeaJyCBeC8=;
        b=upuPLkqROziOq97II1tpER6z6w/aH4Jr6eVO0Rr+wEB8wQylT7hHaFDFw7zQXp3ylLp1iv
        8JP22TwVi0r6AoHlnhkAmd/XOEJ5sb9kEPIniaALVeijdcRlR4hG8wQ69+RavzAVHMoM46
        ypQUKnxcZE0cpOlx5fdR74shoiyjCL4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E74F3AE1F;
        Wed,  3 Mar 2021 13:35:44 +0000 (UTC)
Date:   Wed, 3 Mar 2021 14:35:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v4 07/15] printk: introduce CONSOLE_LOG_MAX
Message-ID: <YD+QsDDD1yENlMuj@alley>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
 <20210303101528.29901-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303101528.29901-8-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-03 11:15:20, John Ogness wrote:
> Instead of using "LOG_LINE_MAX + PREFIX_MAX" for temporary buffer
> sizes, introduce CONSOLE_LOG_MAX. This represents the maximum size
> that is allowed to be printed to the console for a single record.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
