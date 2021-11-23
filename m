Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F26B45A0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhKWKyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:54:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52518 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbhKWKyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:54:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DC4E1218D9;
        Tue, 23 Nov 2021 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637664672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y9hV+kmum2huS7kuxDdT68UPA1vs5IyqKLLDFISWpdU=;
        b=ADxpI42PwLghvNr9l5A90zLun2pLSZiETyho7xdVE/6pso2IUVbZYzTnXaM+qm94NZldnI
        JkVNMu3/4CkbXOnB9vFJ2ktbferjpnsgsCvYqr/JdeUXfE/40lKrf9J2H2W0Ce58nHV9pO
        gkwigVOgMmhXdHPrtS2aify7wkHwgrE=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A3E2EA3B83;
        Tue, 23 Nov 2021 10:51:12 +0000 (UTC)
Date:   Tue, 23 Nov 2021 11:51:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] printk/console: Rename has_preferred_console to
 need_default_console
Message-ID: <YZzHoKLznX95p23v@alley>
References: <20211122132649.12737-1-pmladek@suse.com>
 <20211122132649.12737-3-pmladek@suse.com>
 <YZxO2I7D8uFQWKTF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZxO2I7D8uFQWKTF@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-11-23 11:15:52, Sergey Senozhatsky wrote:
> On (21/11/22 14:26), Petr Mladek wrote:
> > The logic around the variable @has_preferred_console made my head
> > spin many times. Part of the problem is the ambiguous name.
> > 
> > There is the variable @preferred_console. It points to the last
> > non-braille console in @console_cmdline array. This array contains
> > consoles preferred via the command line, device tree, or SPCR.
> > 
> > Then there is the variable @has_preferred_console. It is set to
> > "true" when @preferred_console is enabled or when a console with
> > tty binding gets enabled by default.
> > 
> > It might get reset back by the magic condition:
> > 
> > 	if (!has_preferred_console || bcon || !console_drivers)
> > 		has_preferred_console = preferred_console >= 0;
> > 
> > It is a puzzle. Dumb explanation is that it gets re-evaluated
> > when:
> > 
> > 	+ it was not set before (see above when it gets set)
> > 	+ there is still an early console enabled (bcon)
> > 	+ there is no console enabled (!console_drivers)
> > 
> > This is still a puzzle.
> > 
> > It gets more clear when we see where the value is checked. The only
> > meaning of the variable is to decide whether we should try to enable
> > the new console by default.
> 
> A nit: by "new console" you probably mean preferred_console. It sort
> of suggests that try_enable_new_console() was not such a bad name,
> may be, since we still refer to such consoles as "new" not "preferred".

By "new console" I mean the console that is passed being registered.
It is the console passed by @newcon parameter.

In compare, @preferred_console is only one. It is the last non-braille
consoles added by __add_preferred_console().

Outlook:

I have a followup patch set that renames @console_cmdline[] to
@preferred_consoles[]. The array includes consoles that are preferred
also by the device tree or SPCR. It is not only by the command line.

The patch also renames @preferred_console to @last_preferred_console.
It helps to distinguish it from the array name. Anyway, the last
console is just one of the preferred consoles. It is special only
because it should get associated with /dev/console.

The renaming causes a lot of noise. I am not sure if it is worth it.
It is currently done as the very last step (23rd patch) after
the rest of the logic is cleaned. But if you like it. I could
do it earlier.

Thanks for review.

Best Regards,
Petr
