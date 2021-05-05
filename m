Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA494374699
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbhEERVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:21:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:55388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238102AbhEERJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:09:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7F149B0EA;
        Wed,  5 May 2021 17:08:09 +0000 (UTC)
Date:   Wed, 5 May 2021 19:08:12 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Print out unknown kernel parameters
Message-ID: <YJLQ/FAMTP/EhxOX@zn.tnic>
References: <20210503213400.27360-1-ahalaney@redhat.com>
 <dfc44b3f-a810-cfbe-f13f-39548ab3fb08@infradead.org>
 <20210503184606.5e8461c0@gandalf.local.home>
 <YJFho3AasxxcD/hH@zn.tnic>
 <20210504152614.mgiihv4ukqajo3jb@halaneylaptop>
 <YJKpv6vjCcCkbzNT@zn.tnic>
 <20210505163728.oh7rqpdvxrdilmfk@halaneylaptop>
 <YJLMxXp2f7YvjGJ9@zn.tnic>
 <20210505165542.tpptt5g7ffxcfmxe@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505165542.tpptt5g7ffxcfmxe@halaneylaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 11:55:42AM -0500, Andrew Halaney wrote:
> Ah, but don't worry! It is handled, just secretly:
>     unknown_bootoption()->obsolete_checksetup() walks __setup_start
> :)

Eww, and there's a had_early_param - run-this-function-only-one-time
clumsy thing. Here's another area that could use a cleanup.

> Still worth considering, so at least lemme ponder it for a day instead
> of being lazy.

Take your time - that's one of those fun projects where no one's
breathing down your neck.

And remember to have fun, as we say. :-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
