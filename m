Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005A03B1ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFWQlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhFWQlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:41:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57217C061766
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:38:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i1so5170824lfe.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TUutKG4F+W5pEfTyRo0eILmARbQ2r9tO+kogVemQTQg=;
        b=Nj8NqarWd1i9ntoq5E6MFTQKr/NV5AymNo/Lpnvk9s6flsvmof6do3TgtloBjwWlBg
         YRpgayr4oLJ89OzULoT2NSt8hwTwTcoSb8ffKZ2/Kn2sDqDF6YIDtEQqjym4MbMVoEvF
         4367aOslrYvM0CEkk7g0E2cddPkD4ooco0IoQqewJjMoYGkFwMm7Ki5Da7Rqe/9DSe0d
         lXflO7nowCXNqs7A3AtGZh7S7b8il3UoOH/TyKkAT1DXjNHZu31Sd7lfM3YY8BWnSbUo
         RdT0PYcvmyYvjDX4WHgheZOZQOjo/PalJUiUlyf3e3dDx1B7UJbjTJpay0Ydqc+9Miyz
         dlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUutKG4F+W5pEfTyRo0eILmARbQ2r9tO+kogVemQTQg=;
        b=MhxqKYtsDw9I/Na05K69TJ2uga6VZy8R+VHY0vEf0yrohlxbqOBQWM7AV5WKomiLxK
         BkUpaDrgPAAypuiY9L9m0wfJM2J5BK3wOdhYqrhYARB6L5boaksRFoBUZS4pff1+COOz
         Mrojuv5gK5NubzFxgTEygr1QvpXSt3Zcoi58w9YqCytdZveBBfi9zNzG4p8fiv4zV+Av
         75CB+EagHgdwfr2kOREaEUZwUAx+vRVwOM0qDrpr4ES2LoDYBZfc70uM2UpscTpyQL2L
         5bf3jnIGuiNKIP6LLHK6lUZtHFn8giuTuN0lH8ZoeJJ7gDt0oMT6YyuSFfSjRGulXDEU
         3eKw==
X-Gm-Message-State: AOAM5317nz1G5p4t+ZXrqhmJrMF0GkbfXb5Ln3DCmoXWSizxeAU87+MZ
        OimfAplGYAInDUd8aaO+Ofs=
X-Google-Smtp-Source: ABdhPJwktWT0yn7Ci7FhnYW5SIXFGq/LqL6I3Dr2Mps5mokPWXhrc8lzgAZQ6M36Q6EPVBlBAXApjg==
X-Received: by 2002:a05:6512:3049:: with SMTP id b9mr351134lfb.205.1624466326736;
        Wed, 23 Jun 2021 09:38:46 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.155])
        by smtp.gmail.com with ESMTPSA id t24sm17475ljc.45.2021.06.23.09.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 09:38:46 -0700 (PDT)
Date:   Wed, 23 Jun 2021 19:38:42 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+0a89a7b56db04c21a656@syzkaller.appspotmail.com
Subject: Re: [PATCH] jfs: fix GPF in diFree
Message-ID: <20210623193842.5f164966@gmail.com>
In-Reply-To: <319afbd1-afc0-bae3-c446-3530505e7b21@oracle.com>
References: <20210606142405.31047-1-paskripkin@gmail.com>
        <319afbd1-afc0-bae3-c446-3530505e7b21@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 09:13:07 -0500
Dave Kleikamp <dave.kleikamp@oracle.com> wrote:

> On 6/6/21 9:24 AM, Pavel Skripkin wrote:
> > Avoid passing inode with
> > JFS_SBI(inode->i_sb)->ipimap == NULL to
> > diFree()[1]. GFP will appear:
> 
> I'm a little curious how we get as far as creating and freeing 
> non-special inodes if ipimap == NULL.
> 
> > 
> > 	struct inode *ipimap = JFS_SBI(ip->i_sb)->ipimap;
> > 	struct inomap *imap = JFS_IP(ipimap)->i_imap;
> > 
> > JFS_IP() will return invalid pointer when ipimap == NULL
> > 
> > Call Trace:
> >   diFree+0x13d/0x2dc0 fs/jfs/jfs_imap.c:853 [1]
> >   jfs_evict_inode+0x2c9/0x370 fs/jfs/inode.c:154
> >   evict+0x2ed/0x750 fs/inode.c:578
> >   iput_final fs/inode.c:1654 [inline]
> >   iput.part.0+0x3fe/0x820 fs/inode.c:1680
> >   iput+0x58/0x70 fs/inode.c:1670
> 
> Is there more to the stack trace? Is this part of a failed mount()?
> 

Hi, Dave!

Yes, it was caused by mount fail. Log:

[  924.076873][ T8430] jfs_mount: diMount(ipaimap) failed w/rc = -5

So, it's errout21 label in jfs_mount(). I guess, It's early failure and
some fields wasn't initialized properly. I don't really remember my
debug results, because it was a long time ago, but I can do some debug
work again if needed!


Thanks for feedback!

> > 
> > Reported-and-tested-by:
> > syzbot+0a89a7b56db04c21a656@syzkaller.appspotmail.com
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>ipimap == NULL
> 
> I don't doubt that this happened, so I'll apply the patch which is 
> obviously safe.
> 
> > ---
> >   fs/jfs/inode.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> > index 6f65bfa9f18d..b0eb9c85eea0 100644
> > --- a/fs/jfs/inode.c
> > +++ b/fs/jfs/inode.c
> > @@ -151,7 +151,8 @@ void jfs_evict_inode(struct inode *inode)
> >   			if (test_cflag(COMMIT_Freewmap, inode))
> >   				jfs_free_zero_link(inode);
> >   
> > -			diFree(inode);
> > +			if (JFS_SBI(inode->i_sb)->ipimap)
> > +				diFree(inode);
> >   
> >   			/*
> >   			 * Free the inode from the quota
> > allocation.
> > 




With regards,
Pavel Skripkin
