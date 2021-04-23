Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F1C3693E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbhDWNm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239066AbhDWNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619185300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ze4ahKnbOCWiAxmHjTl9e5R83LN6smcdaohyYDqcddU=;
        b=fp7Oef53LaQhcuftmC4ubwd+u80b+Lm62u7sVrmBDO2RxLkvFOaIwDNifMmhsYplE43QQw
        SnyyNpa9/VNwpMAocQYr7jiChpt5qO81qyd7MqNOyF4rjA8cHKBM7Yp3oiQlQOvK7pyiPX
        Iws9inRj++ru3YyMO8zs+FDBBjKG1fI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-a3OFT671P1Kk7yjIB-EPUQ-1; Fri, 23 Apr 2021 09:41:38 -0400
X-MC-Unique: a3OFT671P1Kk7yjIB-EPUQ-1
Received: by mail-yb1-f199.google.com with SMTP id e8-20020a2587480000b02904e5857564e2so24263802ybn.16
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ze4ahKnbOCWiAxmHjTl9e5R83LN6smcdaohyYDqcddU=;
        b=lZQwOF0QhEqtm8FHcDtXwEoUycEDvQTsMxhuzGMK20mPoy7m9DOnN8+jn36K7CF7dS
         9HulBPRLZlzW7LN6mXqiDGeEtqk4pDwECGoUCrgx/0IJL65ZuXR3huIaXo7PvYUmt3qT
         crpvuN9R4tQ4axWFTZcNMW1t9yAVZ4ue69nHjGtgpOOJU/aNCadZRK0CnhqY36AoxVUm
         GVoU2cT+6LNdKxs4TF/h2mdAep1krFv9V6PPgjKvhOJY8zfZa3u5VcrlqoQLAahnejKD
         KlNA+Fi9oqH6oi//ABYsVsZvFxtS6vgWJacCcM9N8qa9PypfoCDiblIFWyH8MxDgsc7H
         XIxg==
X-Gm-Message-State: AOAM53224Vw5mbPmyVSwxcVh6GYU+q68mi5DMO6vH5UJOYpJFfZz8rLy
        HbcYArj69bcGz+XbXF1/Cf0MAB1HnQV1KU0x/LRfB63Z3HJTsjg6P4u8SPh2+Q0tQ5a8uMVuPVe
        zakK4k5cxzXg6vyrBf1wj51KVYzILNccgc73cL2eC
X-Received: by 2002:a25:9085:: with SMTP id t5mr4967875ybl.26.1619185298026;
        Fri, 23 Apr 2021 06:41:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXNaViuyykB129+lJhNJo0S+WHcmw5kglqQvAOEW3Lkacoqm9Vvdzv9iHggDm7UBpnmciENcf5DP8f3KFEXko=
X-Received: by 2002:a25:9085:: with SMTP id t5mr4967852ybl.26.1619185297789;
 Fri, 23 Apr 2021 06:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210421171446.785507-1-omosnace@redhat.com> <20210421171446.785507-3-omosnace@redhat.com>
 <CAEjxPJ5ksqrafO8uaf3jR=cjU5JnyQYmn_57skp=WXz7-RcbVQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5ksqrafO8uaf3jR=cjU5JnyQYmn_57skp=WXz7-RcbVQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 23 Apr 2021 15:41:25 +0200
Message-ID: <CAFqZXNv4gKFN5FV_Z8U82cOzauBggaqPE0WZZUdnNRxCQ3PVPw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] selinux: add capability to map anon inode types
 to separate classes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 3:21 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Apr 21, 2021 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Unfortunately, the approach chosen in commit 29cd6591ab6f ("selinux:
> > teach SELinux about anonymous inodes") to use a single class for all
> > anon inodes and let the policy distinguish between them using named
> > transitions turned out to have a rather unfortunate drawback.
> >
> > For example, suppose we have two types of anon inodes, "A" and "B", and
> > we want to allow a set of domains (represented by an attribute "attr_x")
> > certain set of permissions on anon inodes of type "A" that were created
> > by the same domain, but at the same time disallow this set to access
> > anon inodes of type "B" entirely. Since all inodes share the same class
> > and we want to distinguish both the inode types and the domains that
> > created them, we have no choice than to create separate types for the
> > cartesian product of (domains that belong to attr_x) x ("A", "B") and
> > add all the necessary allow and transition rules for each domain
> > individually.
> >
> > This makes it very impractical to write sane policies for anon inodes in
> > the future, as more anon inode types are added. Therefore, this patch
> > implements an alternative approach that assigns a separate class to each
> > type of anon inode. This allows the example above to be implemented
> > without any transition rules and with just a single allow rule:
> >
> > allow attr_x self:A { ... };
> >
> > In order to not break possible existing users of the already merged
> > original approach, this patch also adds a new policy capability
> > "extended_anon_inode_class" that needs to be set by the policy to enable
> > the new behavior.
> >
> > I decided to keep the named transition mechanism in the new variant,
> > since there might eventually be some extra information in the anon inode
> > name that could be used in transitions.
> >
> > One minor annoyance is that the kernel still expects the policy to
> > provide both classes (anon_inode and userfaultfd) regardless of the
> > capability setting and if one of them is not defined in the policy, the
> > kernel will print a warning when loading the policy. However, it doesn't
> > seem worth to work around that in the kernel, as the policy can provide
> > just the definition of the unused class(es) (and permissions) to avoid
> > this warning. Keeping the legacy anon_inode class with some fallback
> > rules may also be desirable to keep the policy compatible with kernels
> > that only support anon_inode.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> NAK.  We do not want to introduce a new security class for every user
> of anon inodes - that isn't what security classes are for.
> For things like kvm device inodes, those should ultimately use the
> inherited context from the related inode (the /dev/kvm inode itself).
> That was the original intent of supporting the related inode.

Hmm, so are you implying that anon inodes should be thought of the
same as control /dev nodes? I.e. that even though there may be many
one-time actual inodes created by different processes, they should be
thought of as a single "static interface" to the respective kernel
functionality? That would justify having a common type/label for all
of them, but I'm not sure if it doesn't open some gap due to the
possibility to pass the associated file descriptors between processes
(as AFAIK, these can hold some context)...

I thought this was supposed to resemble more the way BPF, perf_event,
etc. support was implemented - the BPF and perf_event fds are also
anon inodes under the hood, BTW - where each file descriptor is
considered a separate object that inherits the label of its creator
and there is some class separation (e.g. bpf vs. perf_event).

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

