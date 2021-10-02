Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2472241FD50
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 19:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhJBRLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 13:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBRLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 13:11:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11485C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PIjjyfrAuUl3SckZYoG4VeimIH7p/90CjZZXmE20Cgo=; b=fH/6WcI10IRMVg8JQGJ3sJdQnj
        P1aJ06rry0eCARtlxq4SE6Yf/i3OgdO0okKcobFSGuJrjqlxOi+abXshRyYdDKuplpBukmWxNncEp
        Yz5jVOGbMzevHDU6ehWfAiNQfR9ajItGJ7EzYCUYY2OLfJ+uTem/KlaoIuBX0GO68oKdZGgRVQydM
        wA0qvoT9woaDVDlgiQ5HIrvGbs+k5VzMEsq6ZDvczuxC/QernuTPSO0eNY9OY5CcYdQvfOIx2eWJS
        91PIK5hbzxvIOxBq+7TrBAQhPcG/HOsP/qv1DhvyJnmIK7JJIA2KF91Le0Z5Up6/azav/L5XRMytM
        tiECMvKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWiV7-00FDsY-J5; Sat, 02 Oct 2021 17:08:49 +0000
Date:   Sat, 2 Oct 2021 18:08:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Song Liu <song@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Message-ID: <YViSGYhn+zTShwFP@casper.infradead.org>
References: <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org>
 <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
 <67906bf5-4de9-8433-3d70-cc8fc5cc2347@linux.alibaba.com>
 <CAPhsuW4_-ju9QgB7J4imrhQvH6ZqoOkVtVOVX11Yk_ZRakwQ+A@mail.gmail.com>
 <3d264ed9-f8fd-60d4-7125-f9f745ebeb52@google.com>
 <YVXXq0ssvW6P525J@casper.infradead.org>
 <f889db88-7b7d-ddb0-a7ed-3eda85d3eb96@google.com>
 <CAHbLzkq7=FsXtp4YcjeruJwbYyhsRGCq+eC8uwC-Tg06JBTUUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkq7=FsXtp4YcjeruJwbYyhsRGCq+eC8uwC-Tg06JBTUUA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:39:14AM -0700, Yang Shi wrote:
> On Thu, Sep 30, 2021 at 9:49 AM Hugh Dickins <hughd@google.com> wrote:
> > I assume you're thinking of one of the fuzzer blkdev ones:
> > https://lore.kernel.org/linux-mm/CACkBjsbtF_peC7N_4mRfHML_BeiPe+O9DahTfr84puSG_J9rcQ@mail.gmail.com/
> > or
> > https://lore.kernel.org/lkml/CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com/
> >
> > I haven't started on those ones yet: yes, I imagine one or both of those
> > will need a further fix (S_ISREG() check somewhere if we're lucky; but
> > could well be nastier); but for the bug in this thread, I expect
> 
> Makes sense to me. We should be able to check S_ISREG() in khugepaged,
> if it is not a regular file, just bail out. Sounds not that nasty to
> me AFAIU.

I don't see why we should have an S_ISREG() check.  I agree it's not the
intended usecase, but it ought to work fine.  Unless there's something
I'm missing?
