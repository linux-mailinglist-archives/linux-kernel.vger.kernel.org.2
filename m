Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E103CEDE1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358747AbhGSUAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 16:00:06 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:50894 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386854AbhGSTlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:41:45 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5Zhu-0027kw-64; Mon, 19 Jul 2021 20:17:42 +0000
Date:   Mon, 19 Jul 2021 20:17:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v2 5/6] iov_iter: Introduce ITER_FLAG_FAST_ONLY flag
Message-ID: <YPXd5gKCjhr3thJ/@zeniv-ca.linux.org.uk>
References: <20210718223932.2703330-1-agruenba@redhat.com>
 <20210718223932.2703330-6-agruenba@redhat.com>
 <CAHk-=wh3p41a-=7FFf36sYBQP750ys6CKi0S7JNiCSatY5-7og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh3p41a-=7FFf36sYBQP750ys6CKi0S7JNiCSatY5-7og@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:29:35PM -0700, Linus Torvalds wrote:
> On Sun, Jul 18, 2021 at 3:40 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > Introduce a new ITER_FLAG_FAST_ONLY flag
> 
> I think the code is fine, but I think it might be best to call this
> "ITER_FLAG_NOIO" or something like that.
> 
> The "FAST_ONLY" name makes sense in the context of
> "get_user_pages_fast()" where we have that "fast" naming (and the long
> history too). But I don't think it makes much sense as a name in the
> context of iov_iter.

This code has never been tested with current lib/iov_iter.c as it is
in mainline.  Or had been in -next during the last cycle.  It won't
apply at all.

Sure, I can try to port that series over to the current mainline, but
I'd rather see that done (and tested) by the series author...
