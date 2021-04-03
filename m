Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E653635347F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 17:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhDCPVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 11:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236364AbhDCPVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 11:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617463299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0vsf++MBJa1jivteBPSF/34krmYzVn/gmykMb/mq8dg=;
        b=ZaeKXpIB/7uNa+fqySsmiBOU3rzQcheQ4UfOsDOdYgfuNhjC7Nm54Mfacth+RLMgbMRSy+
        9slgwrLyS/HaWfA9upIGqfZN9iN8oMLCwIGx+xBXHgvDxmll4TkWYyVUirLW/ttyzMOEmf
        EtTgSjOKnoGL/ObFbtxFLzo45dM5T4c=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-0eOVKpLNMqGwNyrESsVB2w-1; Sat, 03 Apr 2021 11:21:37 -0400
X-MC-Unique: 0eOVKpLNMqGwNyrESsVB2w-1
Received: by mail-yb1-f200.google.com with SMTP id g7so5856614ybm.13
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 08:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vsf++MBJa1jivteBPSF/34krmYzVn/gmykMb/mq8dg=;
        b=qDB+/n9cTnZMCvSNd9C3YPdhguMaJ0kFAO1R15SQsaKrwnRswlyBHHs7vKb23c6Vix
         pHT34knMcqyU7v796r9pFarCim1cGSyA6KnYkNAhatMxhPSlQhl0GX9TbnsqRimDJ2hv
         8eEt0/SNm3lcIRE/Q8CwXpFHvrnmP+DlrgyMoe8vSM5/qkjQ3c2rkh2jel6txyEQEgSc
         6lhTZCq9p0VpyaP7p4i1pj0wXhKqpGUo0lBpq/n/tXn5uUxq/bHliYYaYDcDtcu+QUx0
         mcGHv35qNpJ9O56Ooy4IlvAGVMrxYHlDurJ53FZ0dFv79JzRjGf0w5OLD0Bd1WVEYosv
         l8bg==
X-Gm-Message-State: AOAM530TLzF7I/cZnkYkDP/HPEYe9QHrp3noElOKkuKPCsgF91ARO45S
        cAvbNIMJEMXlW1P4QPGNwUAectGwHUWd1yBJPGlWoQDRYq4a8DkfeU8r5ft+qV8Qr4i5DB5PKPU
        dnzYisIMl2h2EdvPtdJg2cNHHOj9CcjZlSv3Nsdup
X-Received: by 2002:a25:2f8a:: with SMTP id v132mr19737455ybv.227.1617463297368;
        Sat, 03 Apr 2021 08:21:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweNaoqZkAs/HxZilG78ocsi0GHzFpO5xzV+B11PkgNrpXgetqHqwaKaz2WcyDodNj7gqVjYaseQtUBh2TpXmg=
X-Received: by 2002:a25:2f8a:: with SMTP id v132mr19737440ybv.227.1617463297156;
 Sat, 03 Apr 2021 08:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <3c63e34b-e54f-9b01-bad4-8fde8528a64d@linux.microsoft.com> <CAHC9VhTD2iXw7CkxgwnOx1zNN_AqMV+x1Vy8FijdMQE1m4AOJA@mail.gmail.com>
In-Reply-To: <CAHC9VhTD2iXw7CkxgwnOx1zNN_AqMV+x1Vy8FijdMQE1m4AOJA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 3 Apr 2021 17:21:24 +0200
Message-ID: <CAFqZXNvZCiE=cKhjBqvxOmebDi3vNr0gS563cCMqTTwpcM6JAw@mail.gmail.com>
Subject: Re: [BUG] Oops in sidtab_context_to_sid
To:     Paul Moore <paul@paul-moore.com>
Cc:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 4:33 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Apr 2, 2021 at 6:35 PM Vijay Balakrishna
> <vijayb@linux.microsoft.com> wrote:
> >
> > Seeing oops in 5.4.83 sidtab_context_to_sid().  I checked with Tyler (copied),  he said it might be
> >
> > https://lore.kernel.org/selinux/CAFqZXNu8s5edDbSZuSutetTsy58i08vPuP2h-n9=kT34HcPc4w@mail.gmail.com/
> >
> > Ondrej, can you confirm?  Unfortunately, we don't have a on demand repro.
>
> I'm guessing this may be the problem that Tyler reported earlier and
> which appeared to be fixed by the patch below:
>
> https://lore.kernel.org/selinux/20210318215303.2578052-3-omosnace@redhat.com

Nope, if that's really 5.4.83 with no extra backports, then it can't
be this issue as it has been introduced only in v5.10.

Looking at the code in 5.4.83, my initial guess is that it could be a
memory ordering race between
sidtab_reverse_lookup()/sidtab_rcache_push() and
sidtab_rcache_search(). I think the sidtab_rcache_push() call at
security/selinux/ss/security.c:326 should in fact be after the
smp_store_release() call. Note that the sidtab_rcache_*() functions
have been replaced in commit 66f8e2f03c02 ("selinux: sidtab reverse
lookup hash table") with a different mechanism, which AFAICT doesn't
have the same issue.

If that's really it, it will likely be *very* hard to reproduce, so
you may be unable to verify the fix.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

