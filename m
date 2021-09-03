Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D803E400164
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348371AbhICOnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235422AbhICOnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630680167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEFnIURrP2vwLaJ5HTfs71djy1e9bipR/GQhDMVx0Ic=;
        b=bAVFNyI0pzLKjOzg9YZn5dAcZquxCmuGpAOOvvU82xAWDbIEc/XloCD6txfplO6ZlzHk1A
        mf3MUDHV6FRvXTAOKDpL1RhjPKGHdWyLRWBSrVeV3aFfj267uiGySegfYJyfXqzo1Do/K0
        7P8m424H/HTLE2Y9UdVKRcQAIB2Z7Tk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-IOrMMNpCNyiK0-zEGhfWPg-1; Fri, 03 Sep 2021 10:42:46 -0400
X-MC-Unique: IOrMMNpCNyiK0-zEGhfWPg-1
Received: by mail-il1-f200.google.com with SMTP id h10-20020a056e020d4a00b00227fc2e6687so3659936ilj.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 07:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEFnIURrP2vwLaJ5HTfs71djy1e9bipR/GQhDMVx0Ic=;
        b=c2pYkYWOA8pnEB45TL5rhghYQPeyD2ynvaqfbOjQ1o3YQmfIYIwrwvlJG/65jm80iF
         tehpUZv8J3LXYzDsFakvFMquRDXCEScFfiuNbTFHR10liap1RARjLPOhot8AQHXZ+pKz
         nOVthpOG6bqOtikxLjawg4LuaJip/R0nZXjny9ToySdMF037v2LS8Gt0eACPqkIUEqG2
         oKftEZLlVbHuZnScG6urddBM9vhMzrCOWUo/6CyrK+gfMv8jx+UFbESC9Zz67ewMK7jo
         Eir7E4vKF1tmrVFe8AEWmVfrgONlmVqyYor82Wh3y0TnjCrLaiONLXraHMxbyn8vEwUD
         m1GA==
X-Gm-Message-State: AOAM531N1zOffP/XnkLUbFHLzW22bEo56fbpX5MDrCRQZeWo/bOWs8hu
        PUB6BLl/dA3O419P2W2YzHd7kg9lpYkv9Z4vQRqDHw8xIZ6mpx3BE0V2lLDPMvCDBA3TRwrwSSp
        ovxefDZkPhqTIHnLH/NOEQV7LB/d8uzO18oTvWCjk
X-Received: by 2002:a05:6e02:e53:: with SMTP id l19mr2910861ilk.108.1630680165299;
        Fri, 03 Sep 2021 07:42:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9AT6fUQTezOFBvhyEPkIypPYE9orVd8STwsCxlacI9c6iwGMMi7S2j+q9xU7COfmaPZaiMz+DVo3Ee2EyNoY=
X-Received: by 2002:a05:6e02:e53:: with SMTP id l19mr2910849ilk.108.1630680165078;
 Fri, 03 Sep 2021 07:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <YTDyE9wVQQBxS77r@redhat.com>
 <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com> <CAHc6FU5quZWQtZ3fRfM_ZseUsweEbJA0aAkZvQEF5u9MJhrqdQ@mail.gmail.com>
In-Reply-To: <CAHc6FU5quZWQtZ3fRfM_ZseUsweEbJA0aAkZvQEF5u9MJhrqdQ@mail.gmail.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Fri, 3 Sep 2021 10:42:34 -0400
Message-ID: <CAPL3RVH9MDoDAdiZ-nm3a4BgmRyZJUc_PV_MpsEWiuh6QPi+pA@mail.gmail.com>
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        David Gilbert <dgilbert@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, we could also look at supporting trusted.* xattrs over NFS.  I
don't know much about them, but it looks like it wouldn't be a lot of
work to specify, especially now that we've already got user xattrs?
We'd just write a new internet draft that refers to the existing
user.* xattr draft for most of the details.

--b.

On Fri, Sep 3, 2021 at 2:56 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> On Fri, Sep 3, 2021 at 8:31 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > On Thu, Sep 2, 2021 at 5:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > xfstests: generic/062: Do not run on newer kernels
> > >
> > > This test has been written with assumption that setting user.* xattrs will
> > > fail on symlink and special files. When newer kernels support setting
> > > user.* xattrs on symlink and special files, this test starts failing.
> >
> > It's actually a good thing that this test case triggers for the kernel
> > change you're proposing; that change should never be merged. The
> > user.* namespace is meant for data with the same access permissions as
> > the file data, and it has been for many years. We may have
> > applications that assume the existing behavior. In addition, this
> > change would create backwards compatibility problems for things like
> > backups.
> >
> > I'm not convinced that what you're actually proposing (mapping
> > security.selinux to a different attribute name) actually makes sense,
> > but that's a question for the selinux folks to decide. Mapping it to a
> > user.* attribute is definitely wrong though. The modified behavior
> > would affect anybody, not only users of selinux and/or virtiofs. If
> > mapping attribute names is actually the right approach, then you need
> > to look at trusted.* xattrs, which exist specifically for this kind of
> > purpose. You've noted that trusted.* xattrs aren't supported over nfs.
> > That's unfortunate, but not an acceptable excuse for messing up user.*
> > xattrs.
>
> Another possibility would be to make selinux use a different
> security.* attribute for this nested selinux case. That way, the
> "host" selinux would retain some control over the labels the "guest"
> uses.
>
> Thanks,
> Andreas
>

