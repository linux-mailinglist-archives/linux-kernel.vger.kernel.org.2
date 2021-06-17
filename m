Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4AD3AAFEF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhFQJln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:41:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45990 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFQJll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:41:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 295811FDBF;
        Thu, 17 Jun 2021 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623922773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T1d8fKCZblRlRuGrx5gobxG2lu2xoWw3TpshAwvJsEg=;
        b=L/5NyiqyhwKlxNcHVpXMlOFUWUv+3lGHSBehk19YGsEOU2zQmz8ihs/m63XgkHwmj3h2vw
        +e7sOR+d8z9FmuHTTiMNWI+IXXUglLemzivnzRdcX1uJ1rM+FwlBcsJ/hz7R+fbjDO61mj
        vq9Q7f88b68ZK+XX+tL7SlGoLXf/qAI=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D2FFCA3BB7;
        Thu, 17 Jun 2021 09:39:32 +0000 (UTC)
Date:   Thu, 17 Jun 2021 11:39:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v7 4/5] printk: Userspace format indexing support
Message-ID: <YMsYVBSQL6m63FQc@alley>
References: <e42070983637ac5e384f17fbdbe86d19c7b212a5.1623775748.git.chris@chrisdown.name>
 <202106171546.7koPrJBA-lkp@intel.com>
 <YMsJ6ORGRKmSlvJO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMsJ6ORGRKmSlvJO@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-17 11:38:00, Andy Shevchenko wrote:
> On Thu, Jun 17, 2021 at 03:36:08PM +0800, kernel test robot wrote:
> > Hi Chris,
> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on jeyu/modules-next]
> > [also build test WARNING on linux/master soc/for-next openrisc/for-next powerpc/next asm-generic/master driver-core/driver-core-testing linus/master v5.13-rc6 next-20210616]
> > [cannot apply to uml/linux-next tip/x86/core]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Chris-Down/printk-Userspace-format-indexing-support/20210617-101450
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-next
> 
> Not sure that has what Andrew keeps in his quilt.

Yup, it compiles fine on linux-next where the funtion is declared via
a patch from Andrew's tree.

Best Regards,
Petr
