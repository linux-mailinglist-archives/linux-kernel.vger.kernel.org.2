Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2F30BB53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhBBJra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:47:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:38352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhBBJqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:46:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612259126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VLkAmkVZu+dsIUbEUs+/UPoodj7Ew0rSL0U0gP/5HOg=;
        b=hceuj3PoNYpVsY2pJPk16YyCR4HgxDmbdnE/2aG6uSRQsr5CaAgtw1EmCrh4aee83lKf34
        zKi7NOMdgH84WRSo41luCPc8nV2xPF1UEP4qlKa4s9N5VSU8gem0RH3vAZBmgskszHb+QQ
        mezu5IDWpcQFERLAY1sxgBrMcXj/Y+4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA417AE87;
        Tue,  2 Feb 2021 09:45:25 +0000 (UTC)
Date:   Tue, 2 Feb 2021 10:45:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 12/12] printk: kmsg_dump: remove _nolock()
 variants
Message-ID: <YBkfNarSIrjxPwaJ@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
 <20210126211551.26536-13-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126211551.26536-13-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-01-26 22:21:51, John Ogness wrote:
> kmsg_dump_rewind() and kmsg_dump_get_line() are lockless, so there is
> no need for _nolock() variants. Remove these functions and switch all
> callers of the _nolock() variants.
> 
> The functions without _nolock() were chosen because they are already
> exported to kernel modules.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Makes perfect sense. Just please move the printk_safe enter/exit
calls from the previous patch into this one. Of course, only if
you still want to keep them for now.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
