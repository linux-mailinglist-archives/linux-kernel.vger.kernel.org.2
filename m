Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E283A1F2A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhFIVqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:46:55 -0400
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:36104 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229517AbhFIVqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:46:54 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 433A6181D330D;
        Wed,  9 Jun 2021 21:44:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 36D6727DD18;
        Wed,  9 Jun 2021 21:44:56 +0000 (UTC)
Message-ID: <7e0f67a63b7093f4d20e0c0ccb076d9244e26a9a.camel@perches.com>
Subject: Re: [PATCH 1/1] lib: remove leading spaces before tabs
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 09 Jun 2021 14:44:54 -0700
In-Reply-To: <CAHp75VfQq=RkjyZQsc-PHLTLRCzXovm-D_Z+Pp3A6vWGA-GKug@mail.gmail.com>
References: <20210608071430.12687-1-thunder.leizhen@huawei.com>
         <CAHp75VfuMJ5kfRDB4tE2zr2Em79HiwrDJVROnw+kD3H+QNM4sg@mail.gmail.com>
         <da4915c5-fa13-0cf2-f2d2-02779a64af1b@huawei.com>
         <8a70d592e14f93822bf40832c7374d8e491c3afc.camel@perches.com>
         <26ee1009-259d-07a6-495f-87557be9ed8a@huawei.com>
         <3211e76c-d2a0-1e26-940b-9710073ee7d4@huawei.com>
         <CAHp75VfQq=RkjyZQsc-PHLTLRCzXovm-D_Z+Pp3A6vWGA-GKug@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.40
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 36D6727DD18
X-Stat-Signature: 8om4onecwcrz4sz96w7c9hd1yoh5wn8g
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Tn48oXe7M/4mr8JvXoKiU8OIur1UVSA0=
X-HE-Tag: 1623275096-518481
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-09 at 13:30 +0300, Andy Shevchenko wrote:
> On Wed, Jun 9, 2021 at 9:21 AM Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
> > On 2021/6/9 13:15, Leizhen (ThunderTown) wrote:
> > > On 2021/6/9 0:03, Joe Perches wrote:
> > > > On Tue, 2021-06-08 at 17:00 +0800, Leizhen (ThunderTown) wrote:
> > > > > On 2021/6/8 16:44, Andy Shevchenko wrote:
> > > > > > On Tue, Jun 8, 2021 at 10:14 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> > > > > > > 
> > > > > > > 1) Run the following command to find and remove the leading spaces before
> > > > > > >    tabs:
> > > > > > >    find lib/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
> > > > > > 
> > > > > > Hint for the future, try to use what Git provides, for example `git
> > > > > > ls-files -- lib/`.
> > > > > 
> > > > > Okay, thanks. I learned a new trick.
> 
> > > > For instance:
> > > > 
> > > > $ git diff --stat lib
> > > > $ git ls-files lib/ | \
> > > >   xargs ./scripts/checkpatch.pl --types=SPACE_BEFORE_TAB --fix-inplace
> > 
> > I just tried it. It's too slow.
> 
> If checkpath accepts infinite positional arguments, then proper way of
> use (that's how I do with simple perl regexps) is to
> 
> scripts/checkpatch.pl --types=SPACE_BEFORE_TAB --fix-inplace -- $(git ls-files lib/)

That won't always work:

$ git ls-files | xargs | wc -c
2716737

Nothing accepts infinite positional arguments.
You are always limited by the maximum length of a command line

$ getconf ARG_MAX
2097152

xargs has:

$ xargs --show-limits
Your environment variables take up 3517 bytes
POSIX upper limit on argument length (this system): 2091587
POSIX smallest allowable upper limit on argument length (all systems): 4096
Maximum length of command we could actually use: 2088070
Size of command buffer we are actually using: 131072
Maximum parallelism (--max-procs must be no greater): 2147483647

> Seems like we have a shell lesson :-)

Maybe so.

Using xargs allows use of -P to invoke parallelism.
Or you could just use gnu parallel instead of xargs.

Using './scripts/checkpatch.pl -- $(git ls-files <path>)' will only
allow a single process to be invoked for the files to be scanned.



