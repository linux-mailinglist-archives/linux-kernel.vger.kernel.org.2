Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1038FEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhEYKSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:18:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:46896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229976AbhEYKSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:18:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621937835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VnId6KTgtAKRyp960m434sL8GeuKQ0y0o1xplOwof3M=;
        b=pT23XcvIiWw1vXDF2CGmG9v1Sa5FrdAvFiBme+8HLw1PpGVyxRfRLEcq9OX2nBjoETxbyY
        652Kj0xyNK84RA0tP7pMunNbmcx4fx3uTjKQlkUqD84lWPuqawbDBsBnpw8zmoKwP3yfrH
        RlYx77RH8XimDs4w/L7iCUl9AgiY3pM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CE18AEEE;
        Tue, 25 May 2021 10:17:15 +0000 (UTC)
Date:   Tue, 25 May 2021 12:17:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 1/4] string_helpers: Escape double quotes in
 escape_special
Message-ID: <YKzOqjGuUIew+xd1@alley>
References: <cover.1621338324.git.chris@chrisdown.name>
 <56771f7dafd884d8d2ffcf104104a0c2522391d4.1621338324.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56771f7dafd884d8d2ffcf104104a0c2522391d4.1621338324.git.chris@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-05-18 13:00:32, Chris Down wrote:
> >From an abstract point of view, escape_special's counterpart,

The first line starts with '<'. I guess that it is a typo ;-)

> unescape_special, already handles the unescaping of blackslashed double
> quote sequences.

Yup. Makes sense.

> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

I agree with Andy that you should double check the existing users and
add a note that none is affected.

With it, feel free to add:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
