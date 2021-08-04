Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E115B3E01B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbhHDNJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:09:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40492 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhHDNJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:09:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E1C201FDE4;
        Wed,  4 Aug 2021 13:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628082575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jfc1glmNk6mG+Bc1zIFgTS0q4+36aTHycShX5n2xhXE=;
        b=BdGw+ny78RG5nDL/TedGAjW+8YssEHeLMzFlqwMmZ7AKu9eOH8DKs1Irq/EmPOQJ44J+E/
        IMRZCTWuaIj9PiUaobpYfSjT7ojr7BTRaT0CkDnFuaYbXNZTeniHBJ6NOqlKh3ofa5ZvHZ
        tNHGzJTrGpzW0B6jqQKGyutTcGUMevM=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C75E4A3B8D;
        Wed,  4 Aug 2021 13:09:35 +0000 (UTC)
Date:   Wed, 4 Aug 2021 15:09:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 05/10] printk: call boot_delay_msec() in
 printk_delay()
Message-ID: <YQqRj/D3kLno7JZO@alley>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <20210803131301.5588-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803131301.5588-6-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-08-03 15:18:56, John Ogness wrote:
> boot_delay_msec() is always called immediately before printk_delay()
> so just call it from within printk_delay().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
