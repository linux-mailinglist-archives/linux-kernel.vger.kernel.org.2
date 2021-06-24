Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2D3B2F75
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhFXM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:58:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60536 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhFXM6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:58:06 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 92BE421986;
        Thu, 24 Jun 2021 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624539346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dLLHFzfm50RSkiAjN/HrgY4nObJsrbvcWNrlMkDYW74=;
        b=mG7SQoudASw5dBgrwS/TBK1WY4Bj6UX2q4Ha6iipzhvRZIJD7gzd/pUbIG6NA5mlUTnGUB
        3OFlMSdOKjSnj83aAyuyISUNPa+jmkMQ++cO0K7+4mn5DpFnbqTBnVf8596uhV4jLR5YLx
        mteyO7Ay3U2gdMa+d2Z3OUwDF9oNcc8=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id 6713B25CCD;
        Thu, 24 Jun 2021 12:55:46 +0000 (UTC)
Date:   Thu, 24 Jun 2021 14:55:45 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 2/6] printk: track/limit recursion
Message-ID: <YNSA0cuioVGMPe0d@alley>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
 <20210624111148.5190-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624111148.5190-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-24 13:17:44, John Ogness wrote:
> Currently the printk safe buffers provide a form of recursion
> protection by redirecting to the safe buffers whenever printk() is
> recursively called.
> 
> In preparation for removal of the safe buffers, provide an alternate
> explicit recursion protection. Recursion is limited to 3 levels
> per-CPU and per-context.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

It looks pretty straightforward.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
