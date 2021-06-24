Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019683B2EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhFXM3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:29:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51290 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXM3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:29:04 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2968C1FD40;
        Thu, 24 Jun 2021 12:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624537605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w6JmpUuxv5DehN6LeGC/SHnhAv1XLBZ6xTa2jgnOTbs=;
        b=pJoRnPVjCr4zKToRpyUsvYzkBH8NVr9XmJPMK9i0h5aqGFMGZ+JH8YxyUVrB9BN0JnqcdK
        FfptUwDcc7lkp3//2JYP8OB6F14rrJROYM31GiXmQQDYyfJKRkjIB88D0V+Gcm4r2MIXMh
        /beKBBWFRsj/0/vm4dp48Vu5WFmPm7c=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id F021B25D32;
        Thu, 24 Jun 2021 12:26:44 +0000 (UTC)
Date:   Thu, 24 Jun 2021 14:26:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH printk v3 1/6] lib/nmi_backtrace: explicitly serialize
 banner and regs
Message-ID: <YNR6BIW3mc07BL84@alley>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
 <20210624111148.5190-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624111148.5190-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-24 13:17:43, John Ogness wrote:
> Currently the nmi_backtrace is serialized against other CPUs because
> the messages are sent to the NMI buffers. Once these buffers are
> removed, only the dumped stack will be serialized against other CPUs
> (via the printk_cpu_lock).
> 
> Also serialize the nmi_backtrace banner and regs using the
> printk_cpu_lock so that per-CPU serialization will be preserved even
> after the NMI buffers are removed.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
