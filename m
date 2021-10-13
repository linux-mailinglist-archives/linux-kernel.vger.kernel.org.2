Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A69D42BF04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhJMLiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:38:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhJMLiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:38:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F00A61056;
        Wed, 13 Oct 2021 11:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634124957;
        bh=0AS/yLP2yK3sTdbiZCSQM1HW9SITjeso/NdzJ9aa4do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hChzRU33BtRxo+ygIVPKDciZUAPaDqCbUnOnriCdJlfDrSUvuT11dD5XLb0xd3CYf
         1U5pakay/5eaUhbbCCSGX7C525pUC6197yAC7akBiOxyt2wltnZuxIHXgmwTRaJ53f
         5XUWsy/aN0m/AMGHlsnqQSyLxFWQIeWF1ijIWRac=
Date:   Wed, 13 Oct 2021 13:35:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Jason Baron <jbaron@akamai.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Cromie <jim.cromie@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Trivial dynamic debug fixups
Message-ID: <YWbEm1Eq8BlpIQ7V@kroah.com>
References: <20210920205444.20068-1-ahalaney@redhat.com>
 <670b5afa-0d76-7e78-2b31-f1d4355dd026@akamai.com>
 <YWBrXZrqdoETlqWG@kroah.com>
 <20211008162707.nc6vr22srcmga5fp@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008162707.nc6vr22srcmga5fp@halaneylaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 11:27:07AM -0500, Andrew Halaney wrote:
> On Fri, Oct 08, 2021 at 06:01:33PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Oct 08, 2021 at 11:58:57AM -0400, Jason Baron wrote:
> > > Adding Greg to this (should have added him earlier)
> > > 
> > > Greg, if you are ok with this series, we'd like to have it added
> > > to -next.
> > 
> > What series?
> > 
> > Have a pointer to it?  It would help if it was actually sent to me if
> > people want it applied...
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Sorry Greg, that's probably my bad.. still getting used to the kernel's
> workflow.
> 
> Here's the lore link: https://lore.kernel.org/all/20210920205444.20068-1-ahalaney@redhat.com/
> 
> Did I do something silly when sending the patches? I basically
> just added everyone manually when using git send-email.
> 
> I found who to add via:
> 
>     ahalaney@halaneylaptop ~/git/linux (git)-[master] % ./scripts/get_maintainer.pl 0002-dyndbg-Remove-support-for-ddebug_query-param.patch                                     :(
>     Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION,commit_signer:1/2=50%)
>     Jason Baron <jbaron@akamai.com> (maintainer:DYNAMIC DEBUG)
>     Martin Kepplinger <martink@posteo.de> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:1/3=33%,removed_lines:1/5=20%)
>     Andrew Halaney <ahalaney@redhat.com> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:2/3=67%,removed_lines:4/5=80%)
>     "Paul E. McKenney" <paulmck@kernel.org> (commit_signer:14/89=16%,authored:7/89=8%,added_lines:44/527=8%)
>     Thomas Gleixner <tglx@linutronix.de> (commit_signer:11/89=12%)
>     Andrew Morton <akpm@linux-foundation.org> (commit_signer:11/89=12%)
>     Peter Zijlstra <peterz@infradead.org> (commit_signer:8/89=9%,removed_lines:13/137=9%)
>     Will Deacon <will@kernel.org> (commit_signer:7/89=8%)
>     "Maciej W. Rozycki" <macro@orcam.me.uk> (added_lines:90/527=17%)
>     Muchun Song <songmuchun@bytedance.com> (added_lines:28/527=5%)
>     Viresh Kumar <viresh.kumar@linaro.org> (removed_lines:14/137=10%)
>     Robin Murphy <robin.murphy@arm.com> (removed_lines:13/137=9%)
>     Randy Dunlap <rdunlap@infradead.org> (removed_lines:10/137=7%)
>     Lu Baolu <baolu.lu@linux.intel.com> (removed_lines:10/137=7%)
>     linux-doc@vger.kernel.org (open list:DOCUMENTATION)
>     linux-kernel@vger.kernel.org (open list)
> 
> 
> per patch, and I just hit the maintainers and the lists specified
> since I figured the commit_signers don't care. Did I goof up?

No, that's all correct.  It's up to the maintainers to then route your
patches to the proper tree.

If they want me to take them, great, I'll be glad to do so, but I need
them to send them to me :)

thanks,

greg k-h
