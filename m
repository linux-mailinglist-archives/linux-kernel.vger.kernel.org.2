Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24F13512F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhDAKAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:00:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:45160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234083AbhDAKAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:00:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617271205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nS11drbBOUeGpe07WzalDt/lnrjMk6susFn10riCnYQ=;
        b=acwt7bsq2jp4J6dc4Q4lCyMWleg8pXHsumpqgemsGhLOjgDaib71Ag7ILtNIwQBhrHMJyp
        q1uF4gd525zr7on1/e5SbLSgF8mnUBJXwjbqhr63y4+YjOf3LSgvfbClJ5H15Mv8rP1THW
        hx/DH8H2PBth9Q5Uc3muIcqznZtD/JA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4622B025;
        Thu,  1 Apr 2021 10:00:05 +0000 (UTC)
Date:   Thu, 1 Apr 2021 12:00:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 1/5] printk: track/limit recursion
Message-ID: <YGWZpYE5diVLVzju@alley>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
 <20210330153512.1182-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330153512.1182-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-30 17:35:08, John Ogness wrote:
> Currently the printk safe buffers provide a form of recursion
> protection by redirecting to the safe buffers whenever printk() is
> recursively called.
> 
> In preparation for removal of the safe buffers, provide an alternate
> explicit recursion protection. Recursion is limited to 3 levels
> per-CPU and per-context.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
