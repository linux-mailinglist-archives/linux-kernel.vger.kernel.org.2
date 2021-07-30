Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD3E3DB783
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 13:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbhG3LBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 07:01:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58554 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbhG3LBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 07:01:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 45C601FDCF;
        Fri, 30 Jul 2021 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627642903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ThOpI7C0pMIlV0++9QHZ7uva2O6QS4+sKxpDyiRGL/c=;
        b=Nd0Uj40MSt6N1IsjilGKhDJ59etMjE4cezlQchiF6L/vHhx0isLshmFDH9zPSAXBJYWpiP
        ujeeenV2n4tn90e7NSrkrFK8RDa9TRZ1HMoUMFUCziSDyeNS09rR6FRGBqfVWB95Hd2YYm
        A0GwstSy3q0AvtRxt47tsEBfbdSpHtg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E926AA3B87;
        Fri, 30 Jul 2021 11:01:42 +0000 (UTC)
Date:   Fri, 30 Jul 2021 13:01:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/2] printk: Add printk.console_verbose boot param
Message-ID: <YQPcFQci7p9lE50u@alley>
References: <20210713011511.215808-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713011511.215808-1-dima@arista.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-07-13 02:15:09, Dmitry Safonov wrote:
> v1 to v2 Changes:
> - Add printk.console_verbose boot parameter instead of compile-time
>   CONFIG_CONSOLE_LOGLEVEL_PANIC (see v1 discussion with Petr)
> - I didn't rename console_verbose() to console_verbose_panic() as
>   I need it to be always disabled regardless oops/panic/lockdep.
> - I noticed console_silent() which is unused for long time, remove it.
> 
> v1: https://lore.kernel.org/lkml/20210622143350.1105701-1-dima@arista.com/
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> 
> Dmitry Safonov (2):
>   printk: Remove console_silent()
>   printk: Add printk.console_verbose boot parameter

The patchset is comitted in printk/linux.git, branch
for-5.15-verbose-console.

Best Regards,
Petr
