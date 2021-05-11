Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3127437A5FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhEKLtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 07:49:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:59398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhEKLtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 07:49:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620733687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E77vEFrSkLVZEEYzBk3YTtVmGYYbCEngbIKXJXgn1lE=;
        b=FNKlUt0qKP32FkKDSjrlOl6Sj4jbJTnqDhgVkis/5HueyFUMy8THzXQVH+tlqPzA6eAp+4
        AXbvT6dCpaGb/pCnMLjaokfdl4GXL5yqkWfD2wmXCC7jZqel7+xnUKJXK3JmahwhZ3Z/72
        5KgGPpFq70MJRQXZ0D0W3XZdygmA7AQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2EC02B1B5;
        Tue, 11 May 2021 11:48:07 +0000 (UTC)
Date:   Tue, 11 May 2021 13:48:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, kexec@lists.infradead.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sasha Levin <sashal@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>,
        x86@kernel.org, Christoph Hellwig <hch@infradead.org>,
        peter enderborg <peter.enderborg@sony.com>
Subject: Re: [PATCH v6 00/13] Add build ID to stacktraces
Message-ID: <YJpu9mC8J+Kb6qWg@alley>
References: <20210511003845.2429846-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-05-10 17:38:32, Stephen Boyd wrote:
> This series adds the kernel's build ID[1] to the stacktrace header
> printed in oops messages, warnings, etc. and the build ID for any module
> that appears in the stacktrace after the module name. The goal is to
> make the stacktrace more self-contained and descriptive by including the
> relevant build IDs in the kernel logs when something goes wrong. This
> can be used by post processing tools like script/decode_stacktrace.sh
> and kernel developers to easily locate the debug info associated with a
> kernel crash and line up what line and file things started falling apart
> at.

The entire series looks good to me.

I reviewed carefully only the 5th patch touching printk/kallsyms/module
code. I just scanned over the other patches touching kernel code
and did not notice any obvious problem. I did not check the changes
in decode_stacktrace.sh at all.

I tried to get stacktraces on x86_64 and it worked as expected.

Best Regards,
Petr
