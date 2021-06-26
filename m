Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C203B4C00
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 04:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFZCj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 22:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFZCjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 22:39:55 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258ECC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 19:37:34 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwyCC-00CKWy-L1; Sat, 26 Jun 2021 02:37:24 +0000
Date:   Sat, 26 Jun 2021 02:37:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v2] ELF: add and use SUPPRESS_WARN_UNUSED_RESULT
Message-ID: <YNaS5AZDDpL3gJfe@zeniv-ca.linux.org.uk>
References: <YNYz+hVeqsQmiEqN@localhost.localdomain>
 <YNZG6N0W/7gjG7Gm@localhost.localdomain>
 <20210625163040.a15af04872959da9af161fca@linux-foundation.org>
 <CAHk-=whVa=nm_GW=NVfPHqcxDbWt4JjjK1YWb0cLjO4ZSGyiDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whVa=nm_GW=NVfPHqcxDbWt4JjjK1YWb0cLjO4ZSGyiDA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 07:05:58PM -0700, Linus Torvalds wrote:

> > Do we really care about userspace which relies upon an SVR4 quirk?  I
> > guess it's too hard to prove the no case, so it stays.
> 
> I think we can safely remove it. Doing a mmap() at address zero will
> not actually work anyway in any half-way modern Linux environment.
> 
> And I think the "map zeroes at NULL" wasn't even universal for SVr4.
> _Some_ binaries may have expected it, but I suspect it was the
> exception rather than the rule.
> 
> So I'd happily take a patch that just removes it. If nothing else, it
> would be trivial to put back if somebody screams, but I seriously
> doubt that is going to happen.

Wasn't there some emulator (dosemu? wine?) that relied upon that?
Said that, I could be easily wrong - half-asleep right now...
