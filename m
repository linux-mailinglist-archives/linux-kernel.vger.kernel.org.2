Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54293494A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhCYOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhCYOwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:52:40 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17A5C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:52:39 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id i126so1026120vsi.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCLGgJAKjLjI5ddp5Jx+57wqu5xxECcnAuNRZawig58=;
        b=mx+29ho7ycm8+QllWhmew29rye/m0r1+H3mer3m0RGn23pJdOCvHFW7tk1Fm3/mgSi
         p0CTehFJAES/LIFMxlsbGfeakvD4Qqdca1yEVEtOY6pMrlC1zFHKpmzBgwtjpZ0I9SGB
         2wNZYUBJ5REOohRaEbG0TV4pz3QKjR9Su6LrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCLGgJAKjLjI5ddp5Jx+57wqu5xxECcnAuNRZawig58=;
        b=SuDz8YYts80pwXjVs85jweViBKigtz6WlsHpqnSvU5UeCd/eb7PwXR7abWAMWIuIim
         Dsfk1ZkAs71m9vAR0BTZVMGBBxDgmx6l2QYnyBuhmCG+7U8IfaFutNWxgPN4m7EvxLDH
         qUCeFs2poWiXhhKg0+0/DVBpdulgIb07BL2bXcYek7q/5FseSH+ZE0zxMBPad4gQlqGI
         kq7k8AerWtO6EHl4rUmxXvrgI4OMW+eWJdcAivVgpI+7ujfYaObLI9w4PBiyJsm3LLwY
         aDZfatILHkq7XmJNwQ8acjwqXAfVyzK5jpUbo+Y92aA9+WnfMUOH8Vsqr5jQJq7c6vjY
         tfgw==
X-Gm-Message-State: AOAM532tW5JbGXnhwlPuP7Jfvo0votha0LzZJ7xwwkN+EOOOZfYGUEHc
        VyESLUH+L9wvklYXpnh30fvMLea4u56hRdmTC3TL0A==
X-Google-Smtp-Source: ABdhPJyMZ7+hzDX13eHsxwbk6uA8EAhPRCptc8WwFFINhCjTxMFXxulI+bsZ5Lz39az8S8z1BdRvm/p9QNhGlC3MkAc=
X-Received: by 2002:a67:ffc1:: with SMTP id w1mr5408105vsq.47.1616683959214;
 Thu, 25 Mar 2021 07:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210203124112.1182614-1-mszeredi@redhat.com> <20210203124112.1182614-2-mszeredi@redhat.com>
 <YFk08XPc2oNWoUWT@gmail.com>
In-Reply-To: <YFk08XPc2oNWoUWT@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 25 Mar 2021 15:52:28 +0100
Message-ID: <CAJfpeguhAfLiTi0DdYzU-y98TCJZn2GuHBJhkXGLWRCBU2GfSg@mail.gmail.com>
Subject: Re: [PATCH 01/18] vfs: add miscattr ops
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 1:24 AM Eric Biggers <ebiggers@kernel.org> wrote:

> > +int vfs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
> > +{
> > +     struct inode *inode = d_inode(dentry);
> > +     struct miscattr old_ma = {};
> > +     int err;
> > +
> > +     if (d_is_special(dentry))
> > +             return -ENOTTY;
> > +
> > +     if (!inode->i_op->miscattr_set)
> > +             return -ENOIOCTLCMD;
> > +
> > +     if (!inode_owner_or_capable(inode))
> > +             return -EPERM;
>
> Shouldn't this be EACCES, not EPERM?

$ git diff master.. | grep -C1 inode_owner_or_capable | grep
"^-.*\(EPERM\|EACCES\)" | cut -d- -f3 | sort | uniq -c
     12 EACCES;
      4 EPERM;

So EACCES would win if this was a democracy.  However:

"[EACCES]
Permission denied. An attempt was made to access a file in a way
forbidden by its file access permissions."

"[EPERM]
Operation not permitted. An attempt was made to perform an operation
limited to processes with appropriate privileges or to the owner of a
file or other resource."

The EPERM description matches the semantics of
inode_owner_or_capable() exactly.  It's a pretty clear choice.

Thanks,
Miklos
