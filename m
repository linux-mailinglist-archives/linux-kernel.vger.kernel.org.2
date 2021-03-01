Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9512327E03
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhCAMOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:14:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:38358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233678AbhCAMOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:14:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614600803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LWX81NIq8f0HTlR41F5ulW5ntyY1umPX6Os1jeLcYFM=;
        b=gc7eXgRA/Xx5chcA0AF7OhdTuhhQSZOlXMDwi64gv4faa+qK6VmoTL261F9SMvxlIAeKrw
        dNTT2UM1I3EwF8Z53er9Q3dLXo4UgBlrF9mW7FMazfDGE9CCF+qFe53tGa/526leU//SCT
        5EdgRfsqvfqwPkp5urITZeZfz/8qr9w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 659CEADCA;
        Mon,  1 Mar 2021 12:13:23 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:13:22 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH next v3 02/15] mtd: mtdoops: synchronize kmsg_dumper
Message-ID: <YDzaYqrk3Dv37uDa@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
 <20210225202438.28985-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225202438.28985-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-25 21:24:25, John Ogness wrote:
> The kmsg_dumper can be called from any context and CPU, possibly
> from multiple CPUs simultaneously. Since the writing of the buffer
> can occur from a later scheduled work queue, the oops buffer must
> be protected against simultaneous dumping.
> 
> Use an atomic bit to mark when the buffer is protected. Release the
> protection in between setting the buffer and the actual writing in
> order for a possible panic (immediate write) to be written during
> the scheduling of a previous oops (delayed write).

Just to be sure. You did not use spin lock to prevent problems
with eventual double unlock in panic(). Do I get it correctly,
please?

> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Anyway, it looks good to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
