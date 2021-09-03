Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201AD3FFAC4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 08:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347514AbhICG5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 02:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347516AbhICG5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630652181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CMU0FH7DhLi0oHnmcQCBzsX4HoHYqzZdV2dtgL7VZJc=;
        b=ImvSd75lhKyg+s6ZZKV5gbBfyYHXh7u+7vvpkv8dnmBYGFkWVMHqlJZcV7CJ0JPXD/x//m
        2xLAA0fHHKUlCw4Iy7fhoXbmfOsVKJJSPrilK5owMMOpJlRmltVF8VRvaANk83vu4cLCmI
        0etvoKkfNy6TOo78KDLE3RtG6XSRenI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-vD7W8U9QPh6xkIikXOLB7Q-1; Fri, 03 Sep 2021 02:56:21 -0400
X-MC-Unique: vD7W8U9QPh6xkIikXOLB7Q-1
Received: by mail-wm1-f71.google.com with SMTP id y188-20020a1c7dc5000000b002e80e0b2f87so2263665wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 23:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMU0FH7DhLi0oHnmcQCBzsX4HoHYqzZdV2dtgL7VZJc=;
        b=aKY9i6WoYLChw+zznTbesYbNor0WJ3OTIs5Yb/JgiTEgQcXeNovWYsqJI+XLZJ/rXb
         /x+KLkPoKkHiUzfBB3TWB+G0R8f+zrGIKNbEXWPq9v7A0JWi2i6raRTRAYHa9+cATpAH
         no52oFMIssS24YrAc6wHCrqo7eK52bGrYclg2Utn4NloY8wvb1q8/2B4vWasW2GaoRTx
         g6NdM1tQx2zjrw8LCfXhvMUT2NW0mY0VXQfY8aXMSGighGOQzQ1T3BkmAuOL0M7ovUAK
         LAxNM4AK7brCHltC6R6mjqAjTINqLBCnp3TIe6fj6dJa0roYZlrYiennGRJMe6FChE2z
         1i4w==
X-Gm-Message-State: AOAM533uGmuVeYb8OkHeGLTg5tPG9vqZk1RceMscpxUT3FSZjHWw1HCB
        QSot7yIcUh1jKC1K6YmWLpBF6kSDKnLnzeh7VIsTHHPRHOlYq8/aYg51uneLYJw7jFlhX6MVnJY
        AsWaMndj2qJMv9Awq8kVBCACz96i+dlCgBq6A945V
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr1757635wms.27.1630652179845;
        Thu, 02 Sep 2021 23:56:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEMgRhDhAirpF+1BwSzCXJ2JmOX/csrcn3G6xdkU4jNs0c3KyXpXRLPYTJcObTec0xa9Qcz/PI2DFfXbdCfYE=
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr1757607wms.27.1630652179603;
 Thu, 02 Sep 2021 23:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <YTDyE9wVQQBxS77r@redhat.com>
 <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
In-Reply-To: <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 3 Sep 2021 08:56:08 +0200
Message-ID: <CAHc6FU5quZWQtZ3fRfM_ZseUsweEbJA0aAkZvQEF5u9MJhrqdQ@mail.gmail.com>
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
        "Fields, Bruce" <bfields@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 8:31 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> On Thu, Sep 2, 2021 at 5:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > xfstests: generic/062: Do not run on newer kernels
> >
> > This test has been written with assumption that setting user.* xattrs will
> > fail on symlink and special files. When newer kernels support setting
> > user.* xattrs on symlink and special files, this test starts failing.
>
> It's actually a good thing that this test case triggers for the kernel
> change you're proposing; that change should never be merged. The
> user.* namespace is meant for data with the same access permissions as
> the file data, and it has been for many years. We may have
> applications that assume the existing behavior. In addition, this
> change would create backwards compatibility problems for things like
> backups.
>
> I'm not convinced that what you're actually proposing (mapping
> security.selinux to a different attribute name) actually makes sense,
> but that's a question for the selinux folks to decide. Mapping it to a
> user.* attribute is definitely wrong though. The modified behavior
> would affect anybody, not only users of selinux and/or virtiofs. If
> mapping attribute names is actually the right approach, then you need
> to look at trusted.* xattrs, which exist specifically for this kind of
> purpose. You've noted that trusted.* xattrs aren't supported over nfs.
> That's unfortunate, but not an acceptable excuse for messing up user.*
> xattrs.

Another possibility would be to make selinux use a different
security.* attribute for this nested selinux case. That way, the
"host" selinux would retain some control over the labels the "guest"
uses.

Thanks,
Andreas

