Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21697336F99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhCKKKE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Mar 2021 05:10:04 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:44591 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhCKKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:09:57 -0500
Received: from relay13.mail.gandi.net (unknown [217.70.178.233])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A6C273A39D0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:51:22 +0000 (UTC)
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay13.mail.gandi.net (Postfix) with ESMTPSA id 6CEA98000D;
        Thu, 11 Mar 2021 09:50:56 +0000 (UTC)
Date:   Thu, 11 Mar 2021 10:50:55 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH next v4 02/15] mtd: mtdoops: synchronize kmsg_dumper
Message-ID: <20210311105055.4a0e864d@xps13>
In-Reply-To: <20210303101528.29901-3-john.ogness@linutronix.de>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
        <20210303101528.29901-3-john.ogness@linutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

John Ogness <john.ogness@linutronix.de> wrote on Wed,  3 Mar 2021
11:15:15 +0100:

> The kmsg_dumper can be called from any context and CPU, possibly
> from multiple CPUs simultaneously. Since the writing of the buffer
> can occur from a later scheduled work queue, the oops buffer must
> be protected against simultaneous dumping.
> 
> Use an atomic bit to mark when the buffer is protected. Release the
> protection in between setting the buffer and the actual writing in
> order for a possible panic (immediate write) to be written during
> the scheduling of a previous oops (delayed write).
> 
> An atomic bit (rather than a spinlock) was chosen so that no
> scheduling or preemption side-effects would be introduced. The MTD
> kmsg_dumper may dump directly or it may be delayed (via scheduled
> work). Depending on the context, different MTD callbacks are used.
> For example, mtd_write() expects to be called in a non-atomic
> context and may take a mutex.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
