Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A5C3E01B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhHDNIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:08:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40054 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhHDNIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:08:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 538E61FDE4;
        Wed,  4 Aug 2021 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628082479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qQExGFNbnDyb1vIhuTYIqcpDwHFAckk2RCzx4GibNLs=;
        b=UyGcW7062yZG4Lm23sISZM3qO1Gud4G7rB56qnP4FnMZXWoMd3fuJvb7UajygnhABgZL7S
        t85CGvDT1lqbVkKtoB93XnzSY+Nt0LVJaeP8jDdzA9m8nogHLx1lybZWPvDjvn5sEUAwCA
        7fVLVDJoQOqG6CutDc/oJ+JwOB166k8=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0C350A3B84;
        Wed,  4 Aug 2021 13:07:59 +0000 (UTC)
Date:   Wed, 4 Aug 2021 15:07:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 04/10] printk: relocate printk_delay()
Message-ID: <YQqRLtadAJeD7c7f@alley>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <20210803131301.5588-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803131301.5588-5-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-08-03 15:18:55, John Ogness wrote:
> Move printk_delay() "as is" further up so that it can be used by
> new functions in an upcoming commit.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
