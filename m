Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CED3229BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 12:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhBWLxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:53:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:36944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232475AbhBWLwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:52:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614081111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7NkPoHDcgI3KAGkL1UErqNzJK8MJAPWriCo8v2VZd4g=;
        b=NANoy0YojXUXblaLh75i/wcQe8u6dDkLGO5jFUveJA8778gTimRP/7hROJZQyXGMHjXdh4
        6u1x3mj5AZ+6hwrfNYXN3zf0BQ3882CZqQksoP7M79upinEolwLF7MI/Y+Z512BmhyvKYM
        +HIJw/yqSJbxskdcQ0zxYIoTkiArnf8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0E4FAE57;
        Tue, 23 Feb 2021 11:51:50 +0000 (UTC)
Date:   Tue, 23 Feb 2021 12:51:50 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 12/14] printk: kmsg_dump: remove _nolock()
 variants
Message-ID: <YDTsVq20e4UJcryB@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-13-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218081817.28849-13-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 09:18:15, John Ogness wrote:
> kmsg_dump_rewind() and kmsg_dump_get_line() are lockless, so there is
> no need for _nolock() variants. Remove these functions and switch all
> callers of the _nolock() variants.
> 
> The functions without _nolock() were chosen because they are already
> exported to kernel modules.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
