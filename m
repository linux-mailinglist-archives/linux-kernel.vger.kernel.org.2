Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA9642098C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhJDKzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231167AbhJDKzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:55:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D853260F9B;
        Mon,  4 Oct 2021 10:53:15 +0000 (UTC)
Date:   Mon, 4 Oct 2021 12:53:13 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     dbueso@suse.de, jamorris@linux.microsoft.com,
        keescook@chromium.org, ktkhai@virtuozzo.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
        varad.gautam@suse.com
Subject: Re: [PATCH V2] ipc: add set_ownership() and permissions() callbacks
 for posix mqueue sysctl
Message-ID: <20211004105313.k55766idkyoo6jvt@wittgenstein>
References: <20210824120523.s5qnzt643yvgugpv@wittgenstein>
 <20210827101206.5810-1-ran.xiaokai@zte.com.cn>
 <20210913144047.4v5jquhyysnnlfvh@wittgenstein>
 <6142a2ac.1c69fb81.6dcc6.61f8@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6142a2ac.1c69fb81.6dcc6.61f8@mx.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 01:49:31AM +0000, CGEL wrote:
> esOn Mon, Sep 13, 2021 at 04:40:47PM +0200, Christian Brauner wrote:
> > On Fri, Aug 27, 2021 at 03:12:06AM -0700, CGEL wrote:
> > > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > > 
> > > When a non-root user process creates a user namespace and ipc namespace
> > > with command "unshare -Ur -i", and map the root user inside
> > > the user namesapce to the global owner of user namespace.
> > > The newly created user namespace OWNS the ipc namespace,
> > > So the root user inside the user namespace should have full access
> > > rights to the ipc namespace resources and should be writable to
> > > the ipc mqueue sysctls.
> > > 
> > > v2:
> > >   - update commit msg.
> > >   - fix the coding style issue.
> > > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > > ---
> > 
> > David,
> > 
> > are you happy with this too? If so I'd pick this up.
> > 
> 
> Hi Christian,
> 
> Is there a xx-next branch for this kind patch?
> We will try to fixes other issues like this, so we could tag the follow-up
> patches with the branch name.

Hm, sorry that message slipped through the pre-mid-and post-conference
cracks.  I'll added the patches now for testing. See:

https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=kernel.fixes

Christian
