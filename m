Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3667F4385D6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 00:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhJWWux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 18:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhJWWuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 18:50:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F9AC061714
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9g2tErlL7LnzYe+gFuxTumzb45DnMU0NhCfOnwA3Slc=; b=lO6yHMl6zQkM3Zj6Tte5iNdIeV
        2BES/2v62RD46zUZdp/q5yqCFfZnsUV/G/P0o97mb4iAM9AJd+6uG51oid+uVn1QfZUbsMkqKlGBz
        qY+22oE5gOewr0QZItqF3mZzTBfWG8bLnO5o/YvOdjGkWa/BjcV+KF96I246yhkJBmKPwHmEJzUtA
        HZ+SgUQVTubzCoJFUmE9axY/dtnwyyYAqm6Oe6Kg6djGod1M8DRvNbK8adSQMBYKZwsCQ+AJ2Rm1A
        MXN2Qv0G5gs7TtgHr8lilq11jmy90P1iOUf64QtX87H6CzupyfLel8DNNwF0aJR8WFl247fbqT2wl
        htxgl3NQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mePmM-00EwBX-8P; Sat, 23 Oct 2021 22:46:41 +0000
Date:   Sat, 23 Oct 2021 23:46:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>,
        Jordy Zomer <jordy@pwning.systems>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
Message-ID: <YXSQuiahbU7YyYrk@casper.infradead.org>
References: <00000000000062d0fc05cef24c57@google.com>
 <CACT4Y+aFvuvBew3c6gV9VwE5Fi_4tbPX9Am1xf628ynzKFFLeg@mail.gmail.com>
 <YXQp4MsT0EEKqMl/@kernel.org>
 <088FF23B-CD8E-4E53-B702-53E2C2382062@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <088FF23B-CD8E-4E53-B702-53E2C2382062@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2021 at 10:03:11AM -0700, Kees Cook wrote:
> On October 23, 2021 8:27:28 AM PDT, Mike Rapoport <rppt@kernel.org> wrote:
> >and my first reaction was to send a revert the untested commit 110860541f44
> >("mm/secretmem: use refcount_t instead of atomic_t"). 

I think you should.  This isn't a real problem.  And it abuses the
refcount_t interface.  Your hack is clever, but it's fundamentally
wrong.

