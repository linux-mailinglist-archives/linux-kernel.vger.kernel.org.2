Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575BE31EE87
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhBRSlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:41:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:45266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbhBRQTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:19:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613665123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DdxtEHQWRuGOyqeqjzfogKc9APwsFbzVKcq6nQiyY7M=;
        b=EN1HZ8hn2fIfgyZVC1ffDZpkZbMj6vcqx0UQzXFQ4dZ5l5IlkHnc83bZWANKbChpxzBip+
        YS24uAcS8tq2JEI9VpMUK2WHVWljCXOWFE9kXI+qlJDXBvYPcBANKvDtip9Edd4prwhaC/
        kXCUFyOZjqto7Xi1lZ3E8oJyxTkthAU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C965ACF6;
        Thu, 18 Feb 2021 16:18:43 +0000 (UTC)
Date:   Thu, 18 Feb 2021 17:18:42 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 02/14] printk: kmsg_dump: remove unused
 fields
Message-ID: <YC6TYn1lzgDql2Qq@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218081817.28849-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 09:18:05, John Ogness wrote:
> struct kmsg_dumper still contains some fields that were used to
> iterate the old ringbuffer. They are no longer used. Remove them
> and update the struct documentation.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
