Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84AA3B40A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhFYJh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:37:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47436 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhFYJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:37:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9F7761FE67;
        Fri, 25 Jun 2021 09:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624613706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o42d1dGuPFyadZRMsGPu1xZA6lvdaKH30P8L794IIbc=;
        b=DzD2yZNyqUYsGHrdRAiDWXkohQXam7Xm3vb+WkS4Wstc36qQrZzyJLukyI401GGw7sQ8Qg
        d6WXNfGkiVq1sIk0XZlahiyx474QbERdSkJ+/Y6tXvrAsYj8sZ4frmtTsmOyhr/8LrOIGV
        j8S3RavrHQNXlvhLbB+73wBRhBHPIvU=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 52DB6A3BF8;
        Fri, 25 Jun 2021 09:35:06 +0000 (UTC)
Date:   Fri, 25 Jun 2021 11:35:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v7 0/5] printk: Userspace format indexing support
Message-ID: <YNWjSkJa6y7G+fNj@alley>
References: <cover.1623775748.git.chris@chrisdown.name>
 <YMsfo3/b1LvOoiM0@alley>
 <YNBTrhErZsp0jKYG@alley>
 <20210623140847.6c548197dd03c6137a2b1a53@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623140847.6c548197dd03c6137a2b1a53@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-06-23 14:08:47, Andrew Morton wrote:
> On Mon, 21 Jun 2021 10:54:06 +0200 Petr Mladek <pmladek@suse.com> wrote:
> 
> > > Well, I would still like to get acks from:
> > > 
> > >    + Andy for the 1st patch
> > >    + Jessica for the changes in the module loader code in 4th patch.
> > 
> > They provided the Acks, so that we could push it.
> > 
> > Andrew, this patchset depends on seq_file and string_helpers changes
> > that are in -mm tree:
> > 
> > lib-string_helpers-switch-to-use-bit-macro.patch
> > lib-string_helpers-move-escape_np-check-inside-else-branch-in-a-loop.patch
> > lib-string_helpers-drop-indentation-level-in-string_escape_mem.patch
> > lib-string_helpers-introduce-escape_na-for-escaping-non-ascii.patch
> > lib-string_helpers-introduce-escape_nap-to-escape-non-ascii-and-non-printable.patch
> > lib-string_helpers-allow-to-append-additional-characters-to-be-escaped.patch
> > lib-test-string_helpers-print-flags-in-hexadecimal-format.patch
> > lib-test-string_helpers-get-rid-of-trailing-comma-in-terminators.patch
> > lib-test-string_helpers-add-test-cases-for-new-features.patch
> > maintainers-add-myself-as-designated-reviewer-for-generic-string-library.patch
> > seq_file-introduce-seq_escape_mem.patch
> > seq_file-add-seq_escape_str-as-replica-of-string_escape_str.patch
> > seq_file-convert-seq_escape-to-use-seq_escape_str.patch
> > nfsd-avoid-non-flexible-api-in-seq_quote_mem.patch
> > seq_file-drop-unused-_escape_mem_ascii.patch
> > 
> > 
> > Would you mind to take this patchset via -mm tree as well, please?
> > 
> > You were not in CC. Should Chris send v8 with all the Acks and
> > you in CC?
> 
> We're at -rc7, so I wouldn't be inclined to merge significant feature
> work at this time.  I suggest a resend after -rc1, at which time the
> above changes will be in mainline.

Fair enough. Let's postpone this patchset for 5.15. I am going to
push it into the printk tree after the 5.14 merge window.

Best Regards,
Petr
