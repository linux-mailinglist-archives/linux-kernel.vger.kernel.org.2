Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EB93A5102
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 23:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhFLVhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 17:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLVhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 17:37:17 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455F1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 14:35:17 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsBHd-007RTu-CV; Sat, 12 Jun 2021 21:35:13 +0000
Date:   Sat, 12 Jun 2021 21:35:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 4/9] gfs2: Fix mmap + page fault deadlocks (part 1)
Message-ID: <YMUokdiLMIpr8ee/@zeniv-ca.linux.org.uk>
References: <20210531170123.243771-1-agruenba@redhat.com>
 <20210531170123.243771-5-agruenba@redhat.com>
 <CAHk-=wiB9gvUsebmiOaRXzYVUxJDUt1SozGtRyxR_MDR=Nv7YQ@mail.gmail.com>
 <CAHc6FU4n_F9sPjP7getGRKLpB-KsZt_qhHctqwY5pJrxGxLr2w@mail.gmail.com>
 <YMOOZsBzg/6SKSzT@zeniv-ca.linux.org.uk>
 <YMUhpI/ZIuxvKCt8@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMUhpI/ZIuxvKCt8@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 09:05:40PM +0000, Al Viro wrote:

> Is the above an accurate description of the mainline situation there?
> In particular, normal read doesn't seem to bother with locks at all.
> What exactly are those cluster locks for in O_DIRECT read?

BTW, assuming the lack of contention, how costly is dropping/regaining
such cluster lock?
