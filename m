Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B294A3681CB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhDVNt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhDVNt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:49:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C1FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 06:48:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u21so68915776ejo.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPXeKwdFlap14vs28Y4vSZZ6ciyFAPkqMaUPkDvcMVI=;
        b=g2Pegb2i5gH3n3l6hJjATWdi3iSRPPKWPvRDvTEh8fnjREBUy3Z+0lTtD7iRSCwtpO
         S6dk13ah5C7pNR+BxWjdF6CJEI1hJyjvHx1Excbh3MwvJEZkYb01U+PfxKwolPBMnMsv
         Uf4wboM3zz38RxIWdXdh/+f4aD7yUPbRZnGPDyct+BqSiufuihPwMrQXYU56rZ/HSMho
         hjJXDE1oQRmqQ9/P6odaumqtoOOIFhSqdg2yqS/k4Hs4Dl8RzQvdHOaurHCemzRmIpb4
         AARZ71ZmZjBKfLp2YsS4SNt/r/SQ6xa94MiIPNffXi+ZAa3e5efNCDW1v6g23jdlXSnH
         eigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPXeKwdFlap14vs28Y4vSZZ6ciyFAPkqMaUPkDvcMVI=;
        b=Zsp0b5/0ZE6XqAHSqrM091wA1DRxrjvDbOWaRb6Poqlw+EW8ZSu5ID7iamlGEUFzRT
         i24xX9qdc/WoOenBN3UAUoocV9rfsM4FFH+8IJScytVnXuYL9rk+WjD3InxzhZAcYlQa
         OwgG889S7z+s2lci+5OF6edNwRuFQyrbQzWpdZw0UtgVvs2EebUHRVI758V+Jh7Pd2cr
         Wvp618lVc+f36rRlJsz4BBjwkl12VioKgShR/+fpEMUI4VjLRvdX2TV1ZKqaW/9xD2kd
         la8Df29D7vFT2jwZ4H4nE1OtfTERg9t7yKSmNZKyBAvXsRk24pykxlbGol4DSX9N1Wfj
         sZyw==
X-Gm-Message-State: AOAM533Ukj7x1Jj5lzXi6Bqyo8g1Q+skN0AJl/pErZqwyPHioVn4RDZP
        4ecxwjgp2zf+EtJB63iMhQBXxZfKLlReWfAR4eIx
X-Google-Smtp-Source: ABdhPJzNjMPp6FcBf0oyaEMYIveL5pHdZ5Je333l9k3fLxHGpk6Jx7BPpTUP8ch+2YwXiWuNcvvo3mw84daOnYGoymk=
X-Received: by 2002:a17:907:16a3:: with SMTP id hc35mr3468498ejc.488.1619099331254;
 Thu, 22 Apr 2021 06:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210421171446.785507-1-omosnace@redhat.com> <CAHC9VhTFPHO7YtTxSZNcEZwoy4R3RXVu-4RrAHRtv8BVEw-zGA@mail.gmail.com>
 <CAFqZXNts94w-hMhzCjKW5sHrVw2pw2w7cMQ3+Q2suJ_XUUpUwg@mail.gmail.com>
In-Reply-To: <CAFqZXNts94w-hMhzCjKW5sHrVw2pw2w7cMQ3+Q2suJ_XUUpUwg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Apr 2021 09:48:41 -0400
Message-ID: <CAHC9VhS8F-3X6p2pmjvd0ripnpf=oRAA0G5bmE4yrdi-4sDyDw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] selinux,anon_inodes: Use a separate SELinux class
 for each type of anon inode
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 7:40 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Apr 21, 2021 at 10:38 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Apr 21, 2021 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > This series aims to correct a design flaw in the original anon_inode
> > > SELinux support that would make it hard to write policies for anonymous
> > > inodes once more types of them are supported (currently only userfaultfd
> > > inodes are). A more detailed rationale is provided in the second patch.
> > >
> > > The first patch extends the anon_inode_getfd_secure() function to accept
> > > an additional numeric identifier that represents the type of the
> > > anonymous inode being created, which is passed to the LSMs via
> > > security_inode_init_security_anon().
> > >
> > > The second patch then introduces a new SELinux policy capability that
> > > allow policies to opt-in to have a separate class used for each type of
> > > anon inode. That means that the "old way" will still
> >
> > ... will what? :)
>
> Whoops, I thought I had gone over all the text enough times, but
> apparently not :) It should have said something along the lines of:
>
> ...will still work and will be used by default.

That's what I figured from my quick glance at the code, but I wanted
to make sure.

> > I think it would be a very good idea if you could provide some
> > concrete examples of actual policy problems encountered using the
> > current approach.  I haven't looked at these patches very seriously
> > yet, but my initial reaction is not "oh yes, we definitely need this".
>
> An example is provided in patch 2. It is a generalized problem that we
> would eventually run into in Fedora policy (at least) with the
> unconfined_domain_type attribute and so far only hypothetical future
> types of anon inodes.

Yes, I read the example you provided in patch 2, but it was still a
little too abstract for my liking.  I have the same concern that
Stephen mentioned, I was just giving you an opportunity to show that
in this case the additional object classes were warranted.

-- 
paul moore
www.paul-moore.com
