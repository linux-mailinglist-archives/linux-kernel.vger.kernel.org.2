Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3416A3675BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 01:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343724AbhDUXd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 19:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbhDUXdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 19:33:25 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3E0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 16:32:50 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n184so18047267oia.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mjeTptpVRQKd8eJ9YpoO4cSXIwH3yt1hKUuvdlKvrfY=;
        b=weL6F9nvlqhleHju6lWz+bK16A/7SxLEiiw9sCILjkyNIoNv4G2Zs019TBhdF2P136
         g4HvNawsB8Gu2wiHZKky7mtcuLBBy0QdXeQxlkMckghvFIdR/kd61C9GYvqd6REs98Og
         WZiLIXojk0zvPYqa7HuDn6U4mwhPVeiKQlCBsb3A16ivVci8UJ72cowl5Co3wh3PTv+G
         RJVJvnkzdznBXLnJsHxDkGFHnpk92l0IRhfISPDgoMLBvoL7YmviL2sObpwWRqxmrGYc
         W9o6lbUE0h6AukyIUr0sKjWkn3To7hwm6k99GhvFnOD2zyTyuxgo016FZpt+at2kpMn0
         V9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mjeTptpVRQKd8eJ9YpoO4cSXIwH3yt1hKUuvdlKvrfY=;
        b=Sys/oQTn+H+DGa3+q3SbuCyR9H3RRGf3Vv6iDyJ3icFekHyb7zQ4ptFi2A9fUYTOtV
         fOM+5/dEm3UVeJgjFHOAM/WTilmwwLeh4zKH8RVoLM8b3qU3uJbinCa1phfVNc+0H/qr
         a2jAq6b5hCcuSQCWAkwhpFuV8tyIZKdn8xYPE+JRW29aeg0QU//Ldj+MbmPmrHl4yNWh
         bGj6xLd1D6XEQstlvFDo8fOXYVMIBsxgbJKulHDu1olZp4cPKRrDMSpwISeowBFCNXpU
         ZLS/j9q6DlB3icHpTQKHvUt+F9s5ft+nLcrPqL2PW1QPD6fwyZ3FEHZVe/jvokh5y06H
         6BGg==
X-Gm-Message-State: AOAM532FZd3UrttHmCzZod/5nXBsIx9BcmiUb+E32tZ6bwQXVaF5onYQ
        YtJJ898K4QWZxI9jyJFB2euHF59YfCmiNLq4
X-Google-Smtp-Source: ABdhPJzPOO2xAEgn635Lcmmko4yGulV651GNE7k6fZSI+cCOiCZPCtsBPjql13G43GfM+tylpJrFJQ==
X-Received: by 2002:aca:fdc7:: with SMTP id b190mr317029oii.14.1619047969412;
        Wed, 21 Apr 2021 16:32:49 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id t19sm229596otm.40.2021.04.21.16.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 16:32:49 -0700 (PDT)
Date:   Wed, 21 Apr 2021 18:32:39 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Michael Halcrow <mhalcrow@google.com>
Subject: Re: [PATCH 053/190] Revert "ecryptfs: replace BUG_ON with error
 handling code"
Message-ID: <20210421233239.GA177816@sequoia>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-54-gregkh@linuxfoundation.org>
 <YIBM8hiBLFO+JJr/@zeniv-ca.linux.org.uk>
 <20210421161329.GD4991@sequoia>
 <YIBa3L88Ak1vBM4Y@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIBa3L88Ak1vBM4Y@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-21 17:03:24, Al Viro wrote:
> On Wed, Apr 21, 2021 at 11:13:29AM -0500, Tyler Hicks wrote:
> 
> > > It *is* functionally harmless, AFAICS, but only because the condition
> > > is really impossible.  However,
> > > 	* it refers to vague (s)tool they'd produced, nevermind that
> > > all they really do is "find BUG_ON(), replace with returning an error".
> > > 	* unlike BUG_ON(), the replacement does *NOT* document the
> > > fact that condition should be impossible.
> > > IMO either should be sufficient for rejecting the patch.
> > 
> > I agree that it was not a malicious change. There are other places
> > within the same function that return -EINVAL and the expectation is that
> > errors from this function should be handled safely.
> 
> Umm...  Assuming that failure exits in the callers will function properly
> if those conditions are true.  Which is not obvious at all.
> 
> > That said, I can find no real-world reports of this BUG_ON() ever being
> > a problem and I don't think that there's any actual need for this
> > change. So, I'm alright with it being reverted considering the
> > circumstances.
> 
> AFAICS, at least some parts of that BUG_ON() are provably impossible
> (e.g. NULL crypt_stat would've oopsed well upstream of the only call
> of that function).  ECRYPTFS_STRUCT_INITIALIZED is set after
> ecryptfs_alloc_inode() and never cleared, i.e. it should be present
> in ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat.flags for
> all inodes.  And crypt_stat we are passing to that thing is
> calculated as &(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat),
> which is another reason why it can't be NULL.

I agree.

> 
> Incidentally, what's ecryptfs_setattr() doing with similar check?
> It had been introduced in e10f281bca03 "eCryptfs: initialize crypt_stat
> in setattr", which claims
>     Recent changes in eCryptfs have made it possible to get to ecryptfs_setattr()
>     with an uninitialized crypt_stat struct.  This results in a wide and colorful
>     variety of unpleasantries.  This patch properly initializes the crypt_stat
>     structure in ecryptfs_setattr() when it is necessary to do so.
> and AFAICS at that point the call of ecryptfs_init_crypt_stat() in
> ecryptfs_alloc_inode() had already been there and EXCRYPTFS_STRUCT_INITIALIZED
> had been (unconditionally) set by it.  So how could that check trigger in
> ecryptfs_setattr()?  No direct calls of that function (then as well as now),
> it's only reachable as ecryptfs_{symlink,dir,main}_iops.setattr.  The first
> two could only end up set by ecryptfs_interpose(), for inode returned by
> iget5_locked() (i.e. one that had been returned by ->alloc_inode()),
> the last is set by ecryptfs_init_inode(), called by ecryptfs_inode_set(), 
> passed as callback to iget5_locked() by the same ecryptfs_interpose().
> IOW, again, the inode must have been returned by ->alloc_inode().
> 
> I realize that it had been a long time ago, but... could somebody
> recall what that patch had been about?  Michael?

I looked through the commits that proceeded e10f281bca03 and the only
thing I can think of is the addition of "passthrough" mode where the
lower, encrypted data can be directly read from the eCryptfs mount. It
was introduced in commit e77a56ddceee ("[PATCH] eCryptfs: Encrypted
passthrough"), several months before e10f281bca03. However, I don't see
how it would have left us with an uninitialized crypt_stat in setattr.

Tyler

> Commit in question contains another (and much bigger) chunk; do
> the comments in commit message refer to it?  Because it really
> looks like
> 	if (!(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
> 		ecryptfs_init_crypt_stat(crypt_stat);
> part in ecryptfs_setattr() is a confusing no-op...
