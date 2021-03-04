Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90C232D840
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbhCDRCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbhCDRCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:02:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495CCC061574;
        Thu,  4 Mar 2021 09:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qIBoOhh/fZXBJ35SD/nSzc5eMRYGvJII0mRKZROq3lk=; b=CY38NRjAgjGmSkYqbuB7sNcVu0
        1C7Ywp3pPmHh0b+ymOQ6P7gEfb3Wn6SecZV58Xo8g8MzF5yVJa7EqQEZnupnv8aP7WUPMyP26XsR3
        QAZJ9OodsoHdFu+j9jQiKrvx6dPj1PuIE2s+RDXwx+BY9Sw55U9ZNA7m/VO8X0ZB2Pn8FDPbayA/e
        0qDCpXTOpR6vkSKi2YrstSGyFAfyYMVqAdujMvDwS6G9M0xdddB8NuHeEkImBekKa1lgeUe5ClIMJ
        V+jNv5fYaz1rsML/Fm3fVjolfW38urPW/mRnYSQxmlyGPXR8F+hg4PHRM+RUAUjTTGUKQpO4+oGGG
        z+zYc0YQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lHrLI-007txw-NJ; Thu, 04 Mar 2021 17:01:04 +0000
Date:   Thu, 4 Mar 2021 17:00:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
Message-ID: <20210304170052.GK2723601@casper.infradead.org>
References: <20210301174749.1269154-1-swboyd@chromium.org>
 <20210301174749.1269154-6-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301174749.1269154-6-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 09:47:47AM -0800, Stephen Boyd wrote:
> Example:
> 
>  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)

Would the first 12 characters instead of all 40 make it more palatable
without reducing its utility?
And I feel it should be within the [], so maybe this:

WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e5]

