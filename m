Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A8E447BE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbhKHIgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:36:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57756 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbhKHIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:36:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 242211FD4B;
        Mon,  8 Nov 2021 08:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636360447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XYhcVxXFPLhTErqWW2gZT46JyGw/U45f/n1whUsMfKc=;
        b=RCEIRJJFOGyCtJLH25HG/3w874B3PWrK4xEXUyP4zILGF42PUTN5iDtPlKyo1n38PCZAzA
        JKrUdVoC3xaG/zQRhxwnFaYDJH/mI3NlZeQGfBpXphc+Rd0eYHTJbYIutlAfe5o2BjjKOd
        1SX4MHSkiKqdtIlwULwNqz82lGmm1wg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F18FDA3B84;
        Mon,  8 Nov 2021 08:34:06 +0000 (UTC)
Date:   Mon, 8 Nov 2021 09:34:06 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: restore flushing of NMI buffers on remote CPUs
 after NMI backtraces
Message-ID: <YYjg/s6oSzZ26Uv+@alley>
References: <20211107045116.1754411-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107045116.1754411-1-npiggin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-11-07 14:51:16, Nicholas Piggin wrote:
> printk from NMI context relies on irq work being raised on the local CPU
> to print to console. This can be a problem if the NMI was raised by a
> lockup detector to print lockup stack and regs, because the CPU may not
> enable irqs (because it is locked up).
> 
> Introduce printk_trigger_flush() that can be called another CPU to try
> to get those messages to the console, call that where printk_safe_flush
> was previously called.
> 
> Fixes: 93d102f094be ("printk: remove safe buffers")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

We should add also

     Cc: stable@vger.kernel.org # 5.15

No need to resent the patch. I could add it when pushing.

Plan: I am going to wait one or more days for a potential feedback
and ack from John. Then I am going to push this into printk/linux.git.
IMHO, it makes sense to get this into 5.16-rc1 or rc2.

Thank you both a lot for nailing this down and for the fix.

Best Regards,
Petr
