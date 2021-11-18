Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F356E456065
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhKRQaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhKRQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:30:09 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C6CC061748
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pjZR40SghMbXazmVkswNYKLL8Oa6wp6d3+uvy6rXGrI=;
        t=1637252829; x=1638462429; b=BXda4ev4jm9Eqg398plgeI9+4SAY0wbTtGSYLE6A7AVNTyP
        ADndKjqlBLrdF3vlJ+XByyRBZ2esJ6cYRUqsshh1Cb15budoNqto7JnxnWf72H0HH9Sg6w2Iv50kW
        iOaOrQUQttPZw2G3uVFq9KNvUd2fAUEnmi7GcSfmUnV6fW0WNLTOnYy4zuEldS7XxuEf89daEb4Px
        p0bIs2qJUHbEloWIAYwKbSia3n+SINDDVsfe1gLIJAU1qkG8g6zR7dyl7PFuQ7z2lfTJh9FmFoWkv
        P7mbGLJbL6jwz2WsOriF9Wc+pWD4n0gjXL703DObZ1YepRYlp8bT8loxpHy2ga0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mnkFR-00H3rj-3t;
        Thu, 18 Nov 2021 17:26:53 +0100
Message-ID: <21f86e2bc817b6ec0c7a9194a4fefb1d55e3040b.camel@sipsolutions.net>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-um@lists.infradead.org
Date:   Thu, 18 Nov 2021 17:26:51 +0100
In-Reply-To: <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net>
References: <202111180219.YkyoBMpf-lkp@intel.com>
         <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
         <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
         <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-18 at 17:00 +0100, Peter Zijlstra wrote:
> On Wed, Nov 17, 2021 at 11:40:35AM -0800, Eric Dumazet wrote:
> > On Wed, Nov 17, 2021 at 10:55 AM Eric Dumazet <edumazet@google.com> wrote:
> > > 
> > > On Wed, Nov 17, 2021 at 10:46 AM kernel test robot <lkp@intel.com> wrote:
> > > > 
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> > > > head:   d31c3c683ee668ba5d87c0730610442fd672525f
> > > > commit: d31c3c683ee668ba5d87c0730610442fd672525f [1/1] x86/csum: Rewrite/optimize csum_partial()
> > > > config: um-x86_64_defconfig (attached as .config)
> > > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > > > reproduce (this is a W=1 build):
> > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=d31c3c683ee668ba5d87c0730610442fd672525f
> > > >         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> > > >         git fetch --no-tags tip x86/core
> > > >         git checkout d31c3c683ee668ba5d87c0730610442fd672525f
> > > >         # save the attached .config to linux build tree
> > > >         make W=1 ARCH=um SUBARCH=x86_64
> > > > 
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > 
> > > > All errors (new ones prefixed by >>):
> > > > 
> > > >    arch/x86/um/../lib/csum-partial_64.c: In function 'csum_partial':
> > > > > > arch/x86/um/../lib/csum-partial_64.c:98:12: error: implicit declaration of function 'load_unaligned_zeropad' [-Werror=implicit-function-declaration]
> > > >       98 |   trail = (load_unaligned_zeropad(buff) << shift) >> shift;
> > > >          |            ^~~~~~~~~~~~~~~~~~~~~~
> > > >    cc1: some warnings being treated as errors
> > > > 
> > > > 
> > > 
> > > Hmmm... it seems we need to guard this with CONFIG_DCACHE_WORD_ACCESS ?
> > 
> > Perhaps something like the following ?
> 
> Dear um folks, is this indeed the best solution? It's a bit sad to have
> to add this to x86_64, but if that's the way it is...
> 

I guess we can add load_unaligned_zeropad() or even just somehow add the
include with it (asm/word-at-a-time.h) from x86?

johannes
