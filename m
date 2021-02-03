Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBFC30DB56
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhBCNda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:33:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:56942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231771AbhBCNcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:32:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612359075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HJ/pOW2pVk+Tk6918Gy0+OyDDO46X5OQzgxUWG5pahc=;
        b=Id4M97LAkFluqXd6g9khC8yoH8+lZ0VBZqKPxCmsDtby8vls8jzpteun+HVfxu4EwgDYbs
        KohQVf3k5CD2DM9gPdYREx3L/gl01GdeDdzFPIUxmAi0rpY73no3tpcWmuKOlU/ipHKBQ1
        +Yu3fGsysMAaXToKiWUf4pfiUZJIInU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5945B048;
        Wed,  3 Feb 2021 13:31:15 +0000 (UTC)
Date:   Wed, 3 Feb 2021 14:31:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        akinobu.mita@gmail.com
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <YBqlooegQgEfPG4T@alley>
References: <20210202213633.755469-1-timur@kernel.org>
 <YBpyzxBYIYapHaDT@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBpyzxBYIYapHaDT@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-02-03 10:54:24, Petr Mladek wrote:
> On Tue 2021-02-02 15:36:33, Timur Tabi wrote:
> > If the make-printk-non-secret command-line parameter is set, then
> > printk("%p") will print addresses as unhashed.  This is useful for
> > debugging purposes.
> > 
> > A large warning message is displayed if this option is enabled,
> > because unhashed addresses, while useful for debugging, exposes
> > kernel addresses which can be a security risk.
> > 
> > Signed-off-by: Timur Tabi <timur@kernel.org>
> > ---
> >  lib/vsprintf.c | 34 ++++++++++++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> Please, add also entry into
> Documentation/admin-guide/kernel-parameters.txt.

Adding Andy and Rasmus into CC. They are official vsprintf
co-maintainers and reviewers (MAINTAINERS file).

Also please make sure that lib/test_printf.c will work with
the new option.

Best Regards,
Petr
