Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7312A3A0C8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbhFIGhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:37:31 -0400
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:55762 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232185AbhFIGh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:37:28 -0400
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id ECC8F837F24F;
        Wed,  9 Jun 2021 06:35:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id CCF4E17274;
        Wed,  9 Jun 2021 06:35:29 +0000 (UTC)
Message-ID: <f86508661238686a4998c7d9fae3a6c1ddd07ee5.camel@perches.com>
Subject: Re: [PATCH 1/1] lib: remove leading spaces before tabs
From:   Joe Perches <joe@perches.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Jun 2021 23:35:28 -0700
In-Reply-To: <3211e76c-d2a0-1e26-940b-9710073ee7d4@huawei.com>
References: <20210608071430.12687-1-thunder.leizhen@huawei.com>
         <CAHp75VfuMJ5kfRDB4tE2zr2Em79HiwrDJVROnw+kD3H+QNM4sg@mail.gmail.com>
         <da4915c5-fa13-0cf2-f2d2-02779a64af1b@huawei.com>
         <8a70d592e14f93822bf40832c7374d8e491c3afc.camel@perches.com>
         <26ee1009-259d-07a6-495f-87557be9ed8a@huawei.com>
         <3211e76c-d2a0-1e26-940b-9710073ee7d4@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.40
X-Stat-Signature: ypq1h8wadhgczt9utu6haupchcayzi9i
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: CCF4E17274
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18iu73MGMTn5O2HDR83wttBqz8DzH10L5E=
X-HE-Tag: 1623220529-352026
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-09 at 14:21 +0800, Leizhen (ThunderTown) wrote:
> On 2021/6/9 13:15, Leizhen (ThunderTown) wrote:
> > On 2021/6/9 0:03, Joe Perches wrote:
> > > On Tue, 2021-06-08 at 17:00 +0800, Leizhen (ThunderTown) wrote:
> > > > On 2021/6/8 16:44, Andy Shevchenko wrote:
> > > > > On Tue, Jun 8, 2021 at 10:14 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> > > > > > 
> > > > > > 1) Run the following command to find and remove the leading spaces before
> > > > > >    tabs:
> > > > > >    find lib/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
> > > > > 
> > > > > Hint for the future, try to use what Git provides, for example `git
> > > > > ls-files -- lib/`.
> > > > 
> > > > Okay, thanks. I learned a new trick.
> > > 
> > > Perhaps another 'trick'.
> > > 
> > > checkpatch has SPACE_BEFORE_TAB which does this for any spaces before
> > > a tab, not just at the start of lines.  But as you've no doubt seen,
> > > many maintainers do not care for this sort of whitespace only change
> > > so it's best to do this sparingly or only in drivers/staging/ paths.
> > 
> > I've always thought of kernel, mm, and lib as the core modules of Linux,
> > and they serve as showcases for successors. I'm not interested in making
> > coding style improvements unless it's a work-related driver that I
> > usually read.
> > 
> > > 
> > > For instance:
> > > 
> > > $ git diff --stat lib
> > > $ git ls-files lib/ | \
> > >   xargs ./scripts/checkpatch.pl --types=SPACE_BEFORE_TAB --fix-inplace
> 
> I just tried it. It's too slow.

Slow is relative.  checkpatch always does all its tests and then
only reports on the selected ones.

> The command I used earlier, removing the line start match "^", can also do that.
> 
> git ls-files lib/ | xargs sed -r -i 's/[ ]+\t/\t/'

Not quite.  

Equivalent perl code to checkpatch would be:

	while ($_) =~ s/(^.*) {8,8}\t/$1\t\t/) {}
	while ($_) =~ s/(^.*) +\t/$1\t/) {}

This would convert all 8 count of spaces before a tab to tab and then
remove any other spaces before tabs regardless of location in the line
and not just at the beginning of a line.

cheers, Joe


