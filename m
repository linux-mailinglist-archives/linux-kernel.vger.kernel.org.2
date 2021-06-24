Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9833C3B3207
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhFXPAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:00:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45166 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhFXPAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:00:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 81B021FD8E;
        Thu, 24 Jun 2021 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624546674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=blnuL8FHAkKFrWYRMNnLse/QkS7nab4SYQu/kJXj88Q=;
        b=kQFJmCWj3K41lNGwMWLRrTL3U9hFjEQUQufsM+2k4aPmDxPB47hv6WvFEFD/usOGIHLV56
        Q/Hu7k2CadxKD+Qe17Xmyx+9mmJiblbe9DyDQ0nqFccUSeEgtY5CWexNvSPanv4LSIiH56
        OzV7DhfA//yoqzEu9w6gaf/fv9TKNpw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5A85AA3BD7;
        Thu, 24 Jun 2021 14:57:54 +0000 (UTC)
Date:   Thu, 24 Jun 2021 16:57:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: syslog: close window between wait
 and read
Message-ID: <YNSdcvUrLio3L0OD@alley>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
 <20210624111148.5190-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624111148.5190-7-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-24 13:17:48, John Ogness wrote:
> Syslog's SYSLOG_ACTION_READ is supposed to block until the next
> syslog record can be read, and then it should read that record.
> However, because @syslog_lock is not held between waking up and
> reading the record, another reader could read the record first,
> thus causing SYSLOG_ACTION_READ to return with a value of 0, never
> having read _anything_.
> 
> By holding @syslog_lock between waking up and reading, it can be
> guaranteed that SYSLOG_ACTION_READ blocks until it successfully
> reads a syslog record (or a real error occurs).
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
