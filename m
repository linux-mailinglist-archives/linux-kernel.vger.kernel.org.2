Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624E438B199
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhETOYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 10:24:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:37520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231552AbhETOYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 10:24:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621520593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFckRBjFgcudfZ+bwyH6eJ24Xm63dj24QPHeROdMvVI=;
        b=iuB5F/1FXU9VvOrNu3zTiODEU4dkBzBLBjJOjh3VAbk61aIJhT2duBkHzUwEPQLhV8NbgG
        KnUKlnitg98nruj0jiiyxzY6aK0/KW2YwlyceCwXcZHUKSiH6aD6LgU4tp9zvl/XqGv7OL
        vB0nJ0cFzPKAW/NglsFacTLgA6Zwhaw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BEE36AC4B;
        Thu, 20 May 2021 14:23:13 +0000 (UTC)
Date:   Thu, 20 May 2021 16:23:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jon Mediero <jmdr@disroot.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: correctly exit module_kallsyms_on_each_symbol
 when fn() != 0
Message-ID: <YKZwzbkh2/qhLk+d@alley>
References: <20210520122326.18563-1-jmdr@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520122326.18563-1-jmdr@disroot.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-05-20 14:23:26, Jon Mediero wrote:
> Commit 013c1667cf78 ("kallsyms: refactor
> {,module_}kallsyms_on_each_symbol") replaced the return inside the
> nested loop with a break, changing the semantics of the function: the
> break only exits the innermost loop, so the code continues iterating the
> symbols of the next module instead of exiting.
> 
> Fixes: 013c1667cf78 ("kallsyms: refactor {,module_}kallsyms_on_each_symbol")
> Signed-off-by: Jon Mediero <jmdr@disroot.org>

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

> ---
> As far as I can tell the incorrect behaviour is not causing problems at
> the moment: module_kallsyms_on_each_symbol is no longer exported and the
> only existing caller (klp_find_object_symbol) does not care about the
> return value nor the extra iterations.

It would actually break livepatching a very subtle way.

klp_find_callback() must not longer get called when there are more
symbols of the same name and args->count matches the requested
args->pos. The buggy version will always find only the last
occurence of such a symbol name.

Best Regards,
Petr
