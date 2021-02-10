Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F58316CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhBJRdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:33:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232742AbhBJRaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:30:35 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E796B64E05;
        Wed, 10 Feb 2021 17:29:52 +0000 (UTC)
Date:   Wed, 10 Feb 2021 12:29:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        akinobu.mita@gmail.com, glider@google.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/3][RESEND] add support for never printing hashed
 addresses
Message-ID: <20210210122951.6893fcd5@gandalf.local.home>
In-Reply-To: <cd421230-f6cd-fb79-64ad-d029bcee7b4e@i-love.sakura.ne.jp>
References: <20210210051814.845713-1-timur@kernel.org>
        <6da0be5a-7cb0-4943-e61f-7c3275e60cb6@i-love.sakura.ne.jp>
        <20210210111836.2468f10a@gandalf.local.home>
        <e996ff2f-d350-1399-bb6b-8373bf70e687@i-love.sakura.ne.jp>
        <20210210114633.1b755f6e@gandalf.local.home>
        <cd421230-f6cd-fb79-64ad-d029bcee7b4e@i-love.sakura.ne.jp>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 02:07:21 +0900
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> I'm not refusing to use kernel command line options. I'm expecting that we can
> also hardcode using kernel config options. Since boot-time switching via kernel
> command line options makes the kernel behave differently, less boot-time
> switching is better for avoiding unexpected problems (e.g. unintended LSM was
> enabled).

You could just add:

 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="make-printk-non-secret"

If you want it part of your config.

-- Steve
