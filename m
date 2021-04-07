Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3B356B18
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbhDGLYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:24:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:39542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234598AbhDGLYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:24:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617794674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EX89A7I8KJ0WNWHj7E773fhDOiKl0/iF1rrIuwsuKt4=;
        b=ZI8eSMhy8X6aezbX0iS8SXUWNkXQWkt1ZcSe0w84MhW+MYGEq5g+OqX9FiKc23EgAbGyVS
        Ze6J3MDvBgRBwLG1LGIVVTFZByyMTcoarCmc8BHW+bNoh1DibTHNcelwKUVQNR1GhUD5nV
        gs5THGBftS/USBlpAp/F5MIQNeVbtJo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8482FB120;
        Wed,  7 Apr 2021 11:24:34 +0000 (UTC)
Date:   Wed, 7 Apr 2021 13:24:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Timur Tabi <timur@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] printk: clarify the documentation for plain pointer
 printing
Message-ID: <YG2WcallnIMRBtvw@alley>
References: <20210225164639.27212-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225164639.27212-1-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-25 17:46:39, Vlastimil Babka wrote:
> We have several modifiers for plain pointers (%p, %px and %pK) and now also
> the no_hash_pointers boot parameter. The documentation should help to choose
> which variant to use. Importantly, we should discourage %px in favour of %p
> (with the new boot parameter when debugging), and stress that %pK should be
> only used for procfs and similar files, not dmesg buffer. This patch clarifies
> the documentation in that regard.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

The patch has been committed into printk/linux.git, branch for-5.13.

Best Regards,
Petr
