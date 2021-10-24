Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29978438712
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 07:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhJXFka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 01:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhJXFk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 01:40:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE9E360C4A;
        Sun, 24 Oct 2021 05:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635053888;
        bh=rjQWlX3TCvMDgEHLTPEDl04VRpnK/72Rf+QAmajZC6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OWdrVFBebnH1ElaX1rUDLya9cgAkyp9NAbj2xxAxQsKvHCjhy7JjfQdfhTus79Gdw
         80fF/zu6ODHzdOozSbaaCzh2pmk7XpEkuoCAD8igIfPS5e7FfqQedKqdx7x/a4CvT7
         DhrGFcGwCX4zHrNKGy4119S2L1tPw/PAKZb256YRY3N8aUsEpurYXhW1QxnrXCRqHu
         MEq0SQ82aJPtKjXXcf1X7U3RMk0opYbQB+NvTzJksACiR2zWRz8mUO1KoMX2XqzEjR
         Vkej9yY1V8M2y0TmmmB/+MYytzGcU/Q92ERPakZi2d9DD4UQ6gdiXJxseLrcJi45A+
         vkksxN4hYUzxQ==
Date:   Sun, 24 Oct 2021 08:37:59 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>,
        Jordy Zomer <jordy@pwning.systems>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
Message-ID: <YXTxN5skPPFPvScP@kernel.org>
References: <00000000000062d0fc05cef24c57@google.com>
 <CACT4Y+aFvuvBew3c6gV9VwE5Fi_4tbPX9Am1xf628ynzKFFLeg@mail.gmail.com>
 <YXQp4MsT0EEKqMl/@kernel.org>
 <088FF23B-CD8E-4E53-B702-53E2C2382062@chromium.org>
 <YXSQuiahbU7YyYrk@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXSQuiahbU7YyYrk@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2021 at 11:46:18PM +0100, Matthew Wilcox wrote:
> On Sat, Oct 23, 2021 at 10:03:11AM -0700, Kees Cook wrote:
> > On October 23, 2021 8:27:28 AM PDT, Mike Rapoport <rppt@kernel.org> wrote:
> > >and my first reaction was to send a revert the untested commit 110860541f44
> > >("mm/secretmem: use refcount_t instead of atomic_t"). 
> 
> I think you should.  This isn't a real problem. 

Do you mean that creation of 4 billion of file descriptors is not feasible?

-- 
Sincerely yours,
Mike.
