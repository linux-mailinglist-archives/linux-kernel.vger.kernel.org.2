Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CDF31F969
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBSM3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:29:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:52252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSM3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:29:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613737726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPVvoCV1Bf1gR7HpS+oeom0KBPpn4Fsjocu4qgscl7E=;
        b=PEsRIec4d1onYzScP3yVA1WndI3NtHHoWAN0kkDtg9kSM7mu/8OqjQLYD7Q/K3OB4mAIfR
        O42zcSK4gOQ4Qpkd73YzJzPz/2NLzll+IShN78jIznIObMXDHEvktxRYbNeWZI3IeMCLSO
        SlxsnDZq176SPU0lJmnz20aBk39itN4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72D25ACBF;
        Fri, 19 Feb 2021 12:28:46 +0000 (UTC)
Date:   Fri, 19 Feb 2021 13:28:45 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 04/14] printk: consolidate
 kmsg_dump_get_buffer/syslog_print_all code
Message-ID: <YC+u/VBulmNmjbuz@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218081817.28849-5-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 09:18:07, John Ogness wrote:
> The logic for finding records to fit into a buffer is the same for
> kmsg_dump_get_buffer() and syslog_print_all(). Introduce a helper
> function find_first_fitting_seq() to handle this logic.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
