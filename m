Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C114C3FD8D8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbhIALfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbhIALfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:35:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E4EC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+dQK5IdXVw1yYS5o1jTuz3XuwDlTgndYHGD+Wfsq0ms=; b=tJ7GqxWClGIuXimww6oVVwdOwZ
        bEcpqk2eh+HJaRGutpm3ntp9EL7HJViLBto4AnIBKwTw5GW0I6i3HGgfIPBOrCHpl7Ycfvf1JLYu5
        WK1/MvmCmy9cMxl8l9A2Xi8cB7ISZw+jm39i0uC2ehzoSvDrCStqQ1dxJwHZhDwlAVWbvBzd11jUh
        YKrU3OA+mEi8rtu6FMi5YPygRmWqKXTIv+AeZ2zoT5WJJiZ2fLPu6aR+pOk9B+H6r8QSJHS30MTY/
        mSDQ0mtOSzcCA4KxvP30fMSxsXs6jvncU96COKT48mXxEIUuI4O4rVVqmRiVW0NrJlra1otklChW5
        tRNFgGqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLOTj-002Ev2-Ni; Wed, 01 Sep 2021 11:32:38 +0000
Date:   Wed, 1 Sep 2021 12:32:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com, linux-kernel@vger.kernel.org,
        Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YS9ky9XiR+JkqSDF@casper.infradead.org>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS7yjcqA6txFHd99@casper.infradead.org>
 <YS+AhXJGsniaHTS4@hsj>
 <YS+NXmDO0yqDEBmD@hsj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS+NXmDO0yqDEBmD@hsj>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 02:25:34PM +0000, Huang Shijie wrote:
> On Wed, Sep 01, 2021 at 01:30:45PM +0000, Huang Shijie wrote:
> > On Wed, Sep 01, 2021 at 04:25:01AM +0100, Matthew Wilcox wrote:
> > > On Wed, Sep 01, 2021 at 11:07:41AM +0800, Shijie Huang wrote:
> > > >     In the NUMA, we only have one page cache for each file. For the
> > > > program/shared libraries, the
> > > > remote-access delays longer then the  local-access.
> > > > 
> > > > So, is it possible to implement the per-node page cache for
> > > > programs/libraries?
> > > 
> > > At this point, we have no way to support text replication within a
> > > process.  So what you're suggesting (if implemented) would work for
> > 
> > I created a glibc patch which can do the text replication within a process.
> The "text replication" means the shared libraries, not program itself.

Is it really worthwhile to do only the shared libraries?
