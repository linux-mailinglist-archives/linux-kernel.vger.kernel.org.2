Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870DC350C82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhDACTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhDACTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:19:15 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA267C061574;
        Wed, 31 Mar 2021 19:19:15 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRmvQ-001X5H-Kb; Thu, 01 Apr 2021 02:19:12 +0000
Date:   Thu, 1 Apr 2021 02:19:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/namespace: corrent/improve kernel-doc notation
Message-ID: <YGUtoI+rsdm1cKWr@zeniv-ca.linux.org.uk>
References: <20210318025227.4162-1-rdunlap@infradead.org>
 <87r1jvjclp.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1jvjclp.fsf@meer.lwn.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 02:24:18PM -0600, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
> > Fix kernel-doc warnings in fs/namespace.c:
> >
> > ./fs/namespace.c:1379: warning: Function parameter or member 'm' not described in 'may_umount_tree'
> > ./fs/namespace.c:1379: warning: Excess function parameter 'mnt' description in 'may_umount_tree'
> > ./fs/namespace.c:1950: warning: Function parameter or member 'path' not described in 'clone_private_mount'
> >
> > Also convert path_is_mountpoint() comments to kernel-doc.
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > ---
> > Jon, Al has OK-ed you to merge this patch (and the next one, please).
> >
> >  fs/namespace.c |   14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> An actual acked-by would have been nice, oh well.  Meanwhile, I've
> applied them with fixes to the typos in both changelogs :)

Generally speaking, I'm only glad to leave handling kernel-doc patches
to somebody else, especially when they are that trivial ;-)

Anyway,
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
