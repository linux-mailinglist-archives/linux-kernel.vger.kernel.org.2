Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145633B223D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 23:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFWVLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 17:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhFWVLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 17:11:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8FD061164;
        Wed, 23 Jun 2021 21:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1624482528;
        bh=dWa1P5JrFB4uCUcML15b7T0lwnbl4Qi2VU6ZCyFcovs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=raF8KZVodlGYiIXIQUL36k8AosVaS1PPpusW/XE7qIs9UG3OGlT9JBdj8HgNkJmFM
         TS19/nfABKjbsfYiWx+zpSvylxujQqoi354GyN6Jfs57fkqS5P3F8bFjLWvFz0jPoV
         X8bfQxmASxX4pbWr2zRt4J14k1rlDOBfht1i9Nss=
Date:   Wed, 23 Jun 2021 14:08:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Mladek <pmladek@suse.com>
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
Message-Id: <20210623140847.6c548197dd03c6137a2b1a53@linux-foundation.org>
In-Reply-To: <YNBTrhErZsp0jKYG@alley>
References: <cover.1623775748.git.chris@chrisdown.name>
        <YMsfo3/b1LvOoiM0@alley>
        <YNBTrhErZsp0jKYG@alley>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 10:54:06 +0200 Petr Mladek <pmladek@suse.com> wrote:

> > Well, I would still like to get acks from:
> > 
> >    + Andy for the 1st patch
> >    + Jessica for the changes in the module loader code in 4th patch.
> 
> They provided the Acks, so that we could push it.
> 
> Andrew, this patchset depends on seq_file and string_helpers changes
> that are in -mm tree:
> 
> lib-string_helpers-switch-to-use-bit-macro.patch
> lib-string_helpers-move-escape_np-check-inside-else-branch-in-a-loop.patch
> lib-string_helpers-drop-indentation-level-in-string_escape_mem.patch
> lib-string_helpers-introduce-escape_na-for-escaping-non-ascii.patch
> lib-string_helpers-introduce-escape_nap-to-escape-non-ascii-and-non-printable.patch
> lib-string_helpers-allow-to-append-additional-characters-to-be-escaped.patch
> lib-test-string_helpers-print-flags-in-hexadecimal-format.patch
> lib-test-string_helpers-get-rid-of-trailing-comma-in-terminators.patch
> lib-test-string_helpers-add-test-cases-for-new-features.patch
> maintainers-add-myself-as-designated-reviewer-for-generic-string-library.patch
> seq_file-introduce-seq_escape_mem.patch
> seq_file-add-seq_escape_str-as-replica-of-string_escape_str.patch
> seq_file-convert-seq_escape-to-use-seq_escape_str.patch
> nfsd-avoid-non-flexible-api-in-seq_quote_mem.patch
> seq_file-drop-unused-_escape_mem_ascii.patch
> 
> 
> Would you mind to take this patchset via -mm tree as well, please?
> 
> You were not in CC. Should Chris send v8 with all the Acks and
> you in CC?

We're at -rc7, so I wouldn't be inclined to merge significant feature
work at this time.  I suggest a resend after -rc1, at which time the
above changes will be in mainline.
