Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F1842AD66
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 21:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhJLTo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 15:44:26 -0400
Received: from ms.lwn.net ([45.79.88.28]:53210 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233693AbhJLToZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 15:44:25 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1A07D867;
        Tue, 12 Oct 2021 19:42:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1A07D867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1634067743; bh=DhfzkKNemz6ltK5a1qeX50X3yxuyizjQJ4/MbR+l/Wg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZiCWb/jttP764R/kepx4XZtO5HZmDHWacvwFPlEK3LxexyMl5sA8Qg/PltsVZp6WM
         HFa/smlBiSt/9Md5QX9pnuRI8NNBooMmgrK1JzrgnplHMfmz1xhOkI0hinYJKbrXoR
         IZD6gWq8m+4TbJTT9jnFfqyO9AAKpdSNOENyPcZVnluMzKJ1j5CrRVFJlynL3FXVSp
         T4JhWkD73vrAzdX0O7v8luNYhyKGE2kO4SCvhRBPyC2ZTquHIQRoM6rGmSItO2z75N
         ftpg7HmmLO6jPkR1rl8weH+HguTl2PnUDe/xijcvNrIkxdAdr8c8T+hhtsikZQPXzm
         2fUCoQ+mxL9yw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jeff Layton <jlayton@kernel.org>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Documentation: remove reference to now removed
 mandatory-locking doc
In-Reply-To: <20211005100222.5499-1-jlayton@kernel.org>
References: <20211005100222.5499-1-jlayton@kernel.org>
Date:   Tue, 12 Oct 2021 13:42:22 -0600
Message-ID: <87ily2uj1d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> When I removed the document on mandatory locking from the tree, I missed
> removing the reference to it from the index file.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/index.rst | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index c0ad233963ae..bee63d42e5ec 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -29,7 +29,6 @@ algorithms work.
>     fiemap
>     files
>     locks
> -   mandatory-locking
>     mount_api
>     quota

So this is a fine change, but there's a couple more:

 - Documentation/filesystems/locks.rst still has a section on mandatory
   locking that, presumably, can just come out; it has a reference to
   the now-removed file.

 - There is also a reference (dated April 1996) in the pseudo-changelog
   comments at the head of fs/locks.c.  I'd take the whole pile out, but
   that's me...

Thanks,

jon
