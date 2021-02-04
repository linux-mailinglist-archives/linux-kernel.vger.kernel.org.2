Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DFD30FFDF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBDWGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:06:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhBDWGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:06:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 932E364F8C;
        Thu,  4 Feb 2021 22:05:32 +0000 (UTC)
Date:   Thu, 4 Feb 2021 17:05:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <20210204170530.46b23b21@gandalf.local.home>
In-Reply-To: <20210204214944.GA13103@amd>
References: <20210202201846.716915-1-timur@kernel.org>
        <20210204204835.GA7529@amd>
        <20210204155423.2864bf4f@gandalf.local.home>
        <20210204214944.GA13103@amd>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 22:49:44 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> This machine is insecure. Yet I don't see ascii-art *** all around..
> 
> "Kernel memory addresses are exposed, which is bad for security."
> would be quite enough, I'd say...

Well, the alternative is that you go back to patching your own kernel, and
we drop this patch altogether.

The compromise was to add this notice, to make sure that this doesn't get
set normally.

Changing the wording is fine, but to keep the option from being "forgotten
about" by a indiscrete message isn't going to fly.

-- Steve
 
