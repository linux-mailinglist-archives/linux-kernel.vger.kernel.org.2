Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143FA39FBA5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhFHQFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:05:17 -0400
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:36712 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233781AbhFHQFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:05:11 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 814DF181D2FE9;
        Tue,  8 Jun 2021 16:03:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 4D53B315D7D;
        Tue,  8 Jun 2021 16:03:15 +0000 (UTC)
Message-ID: <8a70d592e14f93822bf40832c7374d8e491c3afc.camel@perches.com>
Subject: Re: [PATCH 1/1] lib: remove leading spaces before tabs
From:   Joe Perches <joe@perches.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Jun 2021 09:03:14 -0700
In-Reply-To: <da4915c5-fa13-0cf2-f2d2-02779a64af1b@huawei.com>
References: <20210608071430.12687-1-thunder.leizhen@huawei.com>
         <CAHp75VfuMJ5kfRDB4tE2zr2Em79HiwrDJVROnw+kD3H+QNM4sg@mail.gmail.com>
         <da4915c5-fa13-0cf2-f2d2-02779a64af1b@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D53B315D7D
X-Spam-Status: No, score=-1.40
X-Stat-Signature: 5zstpcb6zhdgwrmininm7xscnfx68ebd
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX188P+J6BqCSfwqIJ5GsRv+a9oTpYG3oKeQ=
X-HE-Tag: 1623168195-826292
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-06-08 at 17:00 +0800, Leizhen (ThunderTown) wrote:
> On 2021/6/8 16:44, Andy Shevchenko wrote:
> > On Tue, Jun 8, 2021 at 10:14 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> > > 
> > > 1) Run the following command to find and remove the leading spaces before
> > >    tabs:
> > >    find lib/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
> > 
> > Hint for the future, try to use what Git provides, for example `git
> > ls-files -- lib/`.
> 
> Okay, thanks. I learned a new trick.

Perhaps another 'trick'.

checkpatch has SPACE_BEFORE_TAB which does this for any spaces before
a tab, not just at the start of lines.  But as you've no doubt seen,
many maintainers do not care for this sort of whitespace only change
so it's best to do this sparingly or only in drivers/staging/ paths.

For instance:

$ git diff --stat lib
$ git ls-files lib/ | \
  xargs ./scripts/checkpatch.pl --types=SPACE_BEFORE_TAB --fix-inplace
<checkpatch output>
$ git diff --stat lib
 lib/atomic64_test.c             |   2 +-
 lib/bitmap.c                    |   4 +-
 lib/btree.c                     |   4 +-
 lib/decompress_bunzip2.c        |   6 +-
 lib/fonts/font_mini_4x6.c       | 512 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------
 lib/locking-selftest.c          |  12 ++--
 lib/lockref.c                   |   2 +-
 lib/lru_cache.c                 |   2 +-
 lib/math/rational-test.c        |   2 +-
 lib/nlattr.c                    |   4 +-
 lib/raid6/neon.c                |   2 +-
 lib/raid6/sse2.c                |  12 ++--
 lib/reed_solomon/reed_solomon.c |   4 +-
 lib/scatterlist.c               |   4 +-
 lib/string.c                    |   4 +-
 lib/test_firmware.c             |   2 +-
 lib/test_kmod.c                 |   2 +-
 lib/test_overflow.c             |   2 +-
 lib/textsearch.c                |   2 +-
 lib/ts_bm.c                     |   2 +-
 lib/zlib_deflate/deflate.c      |   2 +-
 21 files changed, 294 insertions(+), 294 deletions(-)


