Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE131372CA6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhEDPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:01:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:41704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhEDPBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:01:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F506B200;
        Tue,  4 May 2021 15:00:54 +0000 (UTC)
Date:   Tue, 4 May 2021 17:00:51 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Print out unknown kernel parameters
Message-ID: <YJFho3AasxxcD/hH@zn.tnic>
References: <20210503213400.27360-1-ahalaney@redhat.com>
 <dfc44b3f-a810-cfbe-f13f-39548ab3fb08@infradead.org>
 <20210503184606.5e8461c0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210503184606.5e8461c0@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 06:46:06PM -0400, Steven Rostedt wrote:
> Note, the issue this is trying to solve is to catch "typos" when someone
> adds a parameter. Perhaps we should add a parameter called "check" and/or a
> config option to always check.

Well, actually, you want this checking to always happen and
unconditionally at that.

The fact that we cannot differentiate between params given to init vs
mistyped params, makes it harder to solve elegantly.

> > > +void print_unknown_bootoptions(void)

static

> > > +{
> > > +	const char *const *p;
> > > +
> > > +	if (panic_later || (!argv_init[1] && !envp_init[2]))
> > > +		return;
> > > +
> > > +	pr_notice("Unknown command line parameters:\n");
> > > +	for (p = &argv_init[1]; *p; p++)
> > > +		pr_notice("    %s\n", *p);
> > > +	for (p = &envp_init[2]; *p; p++)
> > > +		pr_notice("    %s\n", *p);
> > > +}
> 
> Perhaps make this one line, like "Kernel command line:" has.

Yap, only one newline at the end pls.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
