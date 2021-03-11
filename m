Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F885337505
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhCKOFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233836AbhCKOEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:04:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA4B864F35;
        Thu, 11 Mar 2021 14:04:40 +0000 (UTC)
Date:   Thu, 11 Mar 2021 09:04:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Cao jin <jojing64@gmail.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, keescook@chromium.org, vbabka@suse.cz
Subject: Re: [PATCH] bootconfig: Update prototype of setup_boot_config()
Message-ID: <20210311090439.394c5293@gandalf.local.home>
In-Reply-To: <20210311185021.cd7a42057c8500755e3732a7@kernel.org>
References: <20210311085213.27680-1-jojing64@gmail.com>
        <20210311185021.cd7a42057c8500755e3732a7@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 18:50:21 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 11 Mar 2021 16:52:13 +0800
> Cao jin <jojing64@gmail.com> wrote:
> 
> > Parameter "cmdline" has no use, drop it.  
> 
> OK, this looks good to me.

Why is this using boot_command_line instead of what is passed in, which
might be different?

-- Steve
