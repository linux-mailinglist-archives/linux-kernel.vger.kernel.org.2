Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D393AAE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFQIEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:04:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44916 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhFQIEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:04:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A6ED021AEB;
        Thu, 17 Jun 2021 08:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623916922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QuRd+Rm9kKcLReInbWdmYACphXEYgE1/HuvkFuZQQvo=;
        b=N6TrEofAQy1cEvER4RXKMBYNg+SavOX/W2EDfEW/jP58JHL6+8c8OLd7KMSUcSoOTfDgsc
        YgXXFyLGZnwORdYugn5tRRh823M9IH6G/eNVWbKvQalYz/WlixhCg+RLvPQUhXEqXGBUm5
        dsDE6b/r1bPc751tLGp4Y6qtU647LFA=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6BAECA3BB4;
        Thu, 17 Jun 2021 08:02:02 +0000 (UTC)
Date:   Thu, 17 Jun 2021 10:02:02 +0200
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
Subject: Re: [PATCH v7 3/5] printk: Rework parse_prefix into
 printk_parse_prefix
Message-ID: <YMsBemODBNwwooQw@alley>
References: <cover.1623775748.git.chris@chrisdown.name>
 <b22ba314a860e5c7f887958f1eab2649f9bd1d06.1623775748.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b22ba314a860e5c7f887958f1eab2649f9bd1d06.1623775748.git.chris@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-15 17:52:51, Chris Down wrote:
> parse_prefix is needed externally by later patches, so move it into a
> context where it can be used as such. Also give it the printk_ prefix to
> reduce the chance of collisions.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
