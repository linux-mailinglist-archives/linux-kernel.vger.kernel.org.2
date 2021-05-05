Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1999F3744BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhEERAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:00:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:35698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235313AbhEEQvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:51:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7110AF0E;
        Wed,  5 May 2021 16:50:14 +0000 (UTC)
Date:   Wed, 5 May 2021 18:50:13 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Print out unknown kernel parameters
Message-ID: <YJLMxXp2f7YvjGJ9@zn.tnic>
References: <20210503213400.27360-1-ahalaney@redhat.com>
 <dfc44b3f-a810-cfbe-f13f-39548ab3fb08@infradead.org>
 <20210503184606.5e8461c0@gandalf.local.home>
 <YJFho3AasxxcD/hH@zn.tnic>
 <20210504152614.mgiihv4ukqajo3jb@halaneylaptop>
 <YJKpv6vjCcCkbzNT@zn.tnic>
 <20210505163728.oh7rqpdvxrdilmfk@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505163728.oh7rqpdvxrdilmfk@halaneylaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 11:37:28AM -0500, Andrew Halaney wrote:
> I actually did use that recommendation essentially, the patch I've sent
> is riding on the work done by unknown_bootoption() which is populated by
> iterating over over the different sections parameters can live in - so
> this is only printing out arguments that didn't match a known kernel
> parameter. Sorry if I didn't make that clear earlier, definitely was
> trying to listen to your advice.

Bah, don't take my "advice" too seriously - I'm just throwing out
guesses. :-)

So ok, unknown_bootoption() handles those and AFAICT, that gets passed
to parse_args() with the __start___param and __stop___param range.

But then there is that do_early_param() thing for early params, which
are different and which are between __setup_start and __setup_end -
i.e., the ones I meant above.

And that function doesn't do the unknown bootoption handling ;-\

More fun.

> I'll have to think about this some more (the "did you mean this
> parameter" part).. that seems like it might be more trouble than it is
> worth, but I admittedly haven't looked into those cheap algorithms you
> mentioned yet. The reason I say it might be more trouble than it is
> worth is because it is easy to say "why didn't my param work", then grep
> for it in dmesg and find it in the "Unknown command line parameters"
> list - that's sort of the workflow I imagined would happen when someone
> mucks with their kernel cli and doesn't get the intended result.

Oh sure - that's what I meant with "cheap". If it can't be done
elegantly and easily, just forget it. dmesg | grep is a lot easier. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
