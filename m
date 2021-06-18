Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28F13ACE35
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhFRPC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:02:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38022 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhFRPC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:02:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4E4451FDE7;
        Fri, 18 Jun 2021 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624028417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y8ZaQr3Hg1tmY1ESaXoN1rX1Z4G2ErKX/EaIfe+IuhQ=;
        b=ZcjDJOYNYKJV9h03ZWEC5o81xjvFgBZYNKm68ZM0Xq9O+b33+sIc3kFUNb2RYMS4bmRzk3
        VgreMKS30kzMXO/2ba+vuJNsS5zEuzdwazhlVW/HunqfvxVDhqDHc/EsC5Haakkad7LgRZ
        F6JC7adnk+qUPWEorRfCNXXPonjt9yM=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1B86CA3B9F;
        Fri, 18 Jun 2021 15:00:17 +0000 (UTC)
Date:   Fri, 18 Jun 2021 17:00:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 4/5] printk: Userspace format indexing support
Message-ID: <YMy1AOpMkMpHuINI@alley>
References: <e42070983637ac5e384f17fbdbe86d19c7b212a5.1623775748.git.chris@chrisdown.name>
 <202106181930.0rU3pZgm-lkp@intel.com>
 <YMyPXXnDCZNC7Bp+@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMyPXXnDCZNC7Bp+@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-06-18 13:19:41, Chris Down wrote:
> kernel test robot writes:
> > > > include/linux/printk.h:219:5: error: static declaration of '_printk' follows non-static declaration
> 
> This issue already exists before this patch and has done for a very long
> time, just the error message changed. Let's fix it in a different series.

It is build when CONFIG_PRINTK is not set. Do I get it correctly?
Yes, I agree that it is an older problem and we could fix it later.

Best Regards,
Petr
