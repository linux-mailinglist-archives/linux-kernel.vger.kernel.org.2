Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3966B3AADAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFQHe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:34:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55512 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhFQHez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:34:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C39371FDAE;
        Thu, 17 Jun 2021 07:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623915167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1KNh9awo7kO6txbFNMCKkWZktEbShy4xlE/ypui7qw=;
        b=s5DQJdCit0YbdgnC0zZLxHBhMnHzCb0Frv9UAFo6//rfM5oR75+zFBdnb1YyDNk8jR5EjJ
        Fpo9dCKRMIAmWplORNj15LdpGIYf3l+VzzzGYrFKl8d6dBSp2OOMEdAsXXRf6UisJVa/pp
        rnEH6lufuIyftIjJatEOr7SL8ojBZfw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 21FFBA3BC8;
        Thu, 17 Jun 2021 07:32:47 +0000 (UTC)
Date:   Thu, 17 Jun 2021 09:32:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] scripts: add spelling_sanitizer.sh script
Message-ID: <YMr6nv1G+bq235nR@alley>
References: <20210616122507.896-1-thunder.leizhen@huawei.com>
 <20210616122507.896-2-thunder.leizhen@huawei.com>
 <87bl85yi68.fsf@meer.lwn.net>
 <4c8ca535-398c-0d19-5242-27ed1d3905ec@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c8ca535-398c-0d19-5242-27ed1d3905ec@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-17 09:11:05, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/6/16 22:53, Jonathan Corbet wrote:
> > Zhen Lei <thunder.leizhen@huawei.com> writes:
> > 
> >> The file scripts/spelling.txt recorded a large number of spelling
> >> "mistake||correction" pairs. These entries are currently maintained in
> >> order, but the results are not strict. In addition, when someone wants to
> >> add some new pairs, he either sort them manually or write a script, which
> >> is clearly a waste of labor. So add this script. For all spelling
> >> "mistake||correction" pairs, sort based on "correction", then on "mistake",
> >> and remove duplicates. Sorting based on "mistake" first is not chosen
> >> because it is uncontrollable.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  scripts/spelling_sanitizer.sh | 27 +++++++++++++++++++++++++++
> >>  1 file changed, 27 insertions(+)
> >>  create mode 100755 scripts/spelling_sanitizer.sh
> >>
> >> diff --git a/scripts/spelling_sanitizer.sh b/scripts/spelling_sanitizer.sh
> >> new file mode 100755
> >> index 000000000000..603bb7e0e66b
> >> --- /dev/null
> >> +++ b/scripts/spelling_sanitizer.sh
> >> @@ -0,0 +1,27 @@
> >> +#!/bin/sh -efu
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +
> >> +# To get the traditional sort order that uses native byte values
> > 
> > So I am of the naive opinion that everything we drop into scripts/
> > should start with a comment saying why it exists and how to use it.
> > Otherwise how are people going to benefit from it?
> 
> Rigth, I will add the description, thanks.

Ideally, please add also some -h/--help option that would print a short
description and usage.

Best Regards,
Petr
