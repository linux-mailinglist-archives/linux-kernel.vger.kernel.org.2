Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD00373D8A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhEEOVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:21:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:46586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232122AbhEEOVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:21:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2997AB209;
        Wed,  5 May 2021 14:20:52 +0000 (UTC)
Date:   Wed, 5 May 2021 16:20:47 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Print out unknown kernel parameters
Message-ID: <YJKpv6vjCcCkbzNT@zn.tnic>
References: <20210503213400.27360-1-ahalaney@redhat.com>
 <dfc44b3f-a810-cfbe-f13f-39548ab3fb08@infradead.org>
 <20210503184606.5e8461c0@gandalf.local.home>
 <YJFho3AasxxcD/hH@zn.tnic>
 <20210504152614.mgiihv4ukqajo3jb@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210504152614.mgiihv4ukqajo3jb@halaneylaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 10:26:14AM -0500, Andrew Halaney wrote:
> Definitely a matter of opinion, but with the kernel having specific
> ways to denote init destined parameters (anything after "--") I think
> an unconditional message is acceptable.

Or - and I had alluded to that on IRC - you *actually* know which params
are kernel params:

#define __setup_param(str, unique_id, fn, early)                        \
        static const char __setup_str_##unique_id[] __initconst         \
                __aligned(1) = str;                                     \
        static struct obs_kernel_param __setup_##unique_id              \
                __used __section(".init.setup")                         \
				^^^^^^^^^^^^^^^^^^

                __aligned(__alignof__(struct obs_kernel_param))         \
                = { __setup_str_##unique_id, fn, early }


all those guys in the above section.

So you'd have iterate over those and do some cheap version of those
autocorrect algorithms which guess which words you meant. For example,
if you have:

panik_on_oops instead of
panic_on_oops

the difference is one letter so it is likely a mistyped param rather
than something which goes to init or other random garbage and then you
warn.

Something like that.

It would need a lot of experimentation first, though, to see whether
this makes sense and it is workable at all.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
