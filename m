Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0F322AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhBWM4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:56:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:32928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232572AbhBWM4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:56:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614084928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gi4KI8h8VmK5KQ8A6jKLJk6g8zUXryxb1ZYKIbT7EEQ=;
        b=C36sH01KDbPrp5+WvX0OtX9KJqVagR8MFiwpP+oS9L/W3Yi+6L0jqQ8WiY29vYZW/GclS6
        /60pu1dOtvtYtaouKchh8KnX8Ixail45Lax4LB4J+gH3SRGrRlONFI6QfX5EqpV7HgMngw
        JSEz6QMCL1IKsIFf1PXsKc+ndE/lFMY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07CAAAE65;
        Tue, 23 Feb 2021 12:55:28 +0000 (UTC)
Date:   Tue, 23 Feb 2021 13:55:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 14/14] printk: console: remove unnecessary
 safe buffer usage
Message-ID: <YDT7Py1rbCRzlaao@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-15-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218081817.28849-15-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 09:18:17, John Ogness wrote:
> Upon registering a console, safe buffers are activated when setting
> up the sequence number to replay the log. However, these are already
> protected by @console_sem and @syslog_lock. Remove the unnecessary
> safe buffer usage.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
