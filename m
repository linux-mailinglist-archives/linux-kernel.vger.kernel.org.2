Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FF535B6F4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 23:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhDKVIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 17:08:36 -0400
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:36066 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235005AbhDKVIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 17:08:35 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id EBD491DF1;
        Sun, 11 Apr 2021 21:08:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 532C12550F1;
        Sun, 11 Apr 2021 21:08:16 +0000 (UTC)
Message-ID: <9a9246c417587f17009543f8048d5f9b7a2ed68f.camel@perches.com>
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
From:   Joe Perches <joe@perches.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Alexander Monakov <amonakov@ispras.ru>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sun, 11 Apr 2021 14:08:14 -0700
In-Reply-To: <87o8ekioo4.fsf@jogness.linutronix.de>
References: <20210410211152.1938-1-amonakov@ispras.ru>
         <e884200f-55a4-59b5-4311-964e6ddc94d1@molgen.mpg.de>
         <alpine.LNX.2.20.13.2104111410340.11104@monopod.intra.ispras.ru>
         <87o8ekioo4.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 532C12550F1
X-Spam-Status: No, score=0.10
X-Stat-Signature: eagcefjgbbk7hk8ng65r7rhy6cygbpet
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/lZU62XoRvdiKemSYJQ3VV6E25IAI9M3o=
X-HE-Tag: 1618175296-55556
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-04-11 at 21:52 +0200, John Ogness wrote:
> I'd rather fix dev_info callers to allow pr_cont and then fix any code
> that is using this workaround.

Assuming you mean all dev_<level>() uses, me too.

> And if the print maintainers agree it is OK to encourage
> pr_cont(LOGLEVEL "...") usage, then people should really start using
> that if the loglevel on those pieces is important.

I have no stong feeling about the use of pr_cont(<KERN_LEVEL>
as valuable or not.  I think it's just a trivial bit that
could be somewhat useful when interleaving occurs.

A somewhat better mechanism would be to have an explicit
cookie use like:

	cookie = printk_multipart_init(KERN_LEVEL, fmt, ...);
	while (<condition>)
		printk_multipart_cont(cookie, fmt, ...);
	printk_multipark_end(cookie, fmt, ...);

And separately, there should be a pr_debug_cont or equivalent.


