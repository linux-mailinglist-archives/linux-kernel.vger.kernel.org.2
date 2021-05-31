Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5F7396909
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 22:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhEaUhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 16:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230505AbhEaUhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 16:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622493325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZZGvag4gS3LveutNw9GWNhlWMDrqfgm2Lt6HFJ2ifE=;
        b=dH/WzE973ogIZuNHessZ+BF5xqhgiQ5qV3iM4OwUPqbOGsu7rAjKjskq1AmRKxsET6C0cG
        j4m8EYVEYqtSC5juCRV1XnHBMlSfojpkRfUK2ErwLXoVcd0WR+S6yut467PfOW6jKgri/v
        GMo3DVpMVSuPnfh+tvwnTmf3X+CrsLI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-7HttA5KePC2TFHwzapuB0g-1; Mon, 31 May 2021 16:35:23 -0400
X-MC-Unique: 7HttA5KePC2TFHwzapuB0g-1
Received: by mail-wm1-f70.google.com with SMTP id o82-20020a1ca5550000b029019ae053d508so360631wme.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 13:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AZZGvag4gS3LveutNw9GWNhlWMDrqfgm2Lt6HFJ2ifE=;
        b=NciC1K/in7jhJ/oIkDALBdVWdx6ZKdIz2oV9MPjScwFnRQiUliLA1fPTre+tbuzd24
         zOjBCILSu3jFT/hHJX+0YyJlARUJmjeg2tfzwnM8HCmAJAs11hvgF6pbE0YWsivFVWYY
         Yi9PAxaEJ6HKuShpx+5ekffhXMva0K1NKs6JgevGdkDSTeWAmZ7XfZN+P3lcyYNjHCDL
         e/a/aI/vUMlNOICsuCX2YPGQrhDYNZuCvGLBHv17O/KHBk3tXEC1yIKloab1+CB274M7
         w4Zcbi4+oE9MJgFW2vg7VMIHQpjTyM7/Nol396RNOg2ALKcxQs5BX/pqHCFZfQacOWVf
         bL/g==
X-Gm-Message-State: AOAM530/+8nr0a6xquWIzXnZCT4HM541/mkQJZ5YC9EDsZ9tmE+cUHpp
        BHEgWdZeJTmlNQpigg0fPFIQrAKzAWq+zFm0l+YHoP9mRZS2KmyaSQc0aHO4NkME3bObYHTOve/
        0CVISGNaUaivILBVlGjalmcy6X4siI6p9+cIq8IF5
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr5958372wrs.361.1622493322231;
        Mon, 31 May 2021 13:35:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCghc6o0pHYKdMW3nD81TNnCov9ASkx9dFfoB7DriNbRzdAlHameaORzL/Q2J5uPQXvJ6Z+rUz1LzzJR3X8/U=
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr5958359wrs.361.1622493322041;
 Mon, 31 May 2021 13:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210531170123.243771-1-agruenba@redhat.com> <CAHk-=wgX=fZ+y=SxBsod8CvZmZ0-X7vZ6dV6EgLPkpBXbt=nQQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgX=fZ+y=SxBsod8CvZmZ0-X7vZ6dV6EgLPkpBXbt=nQQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 31 May 2021 22:35:11 +0200
Message-ID: <CAHc6FU6uQsJaqxTzKMzR8j4a=T0R05LZCEv8-w-AP0gWyantNw@mail.gmail.com>
Subject: Re: [RFC 0/9] gfs2: handle page faults during read and write
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 7:57 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Sorry, I'm on a boat right now, with only a cellphone. Which is why this =
html mess email, and quick reply.
>
> Due to the html, this may get a bounce from the mailing list, and only ma=
ke it to the personal email recipients. Feel free to quote more just in cas=
e others didn't get my original email through the lists.
>
> I'll be out most of the day, but I'll try to take a deeper look this even=
ing.
>
> I'm the meantime, a couple of questions and comments..
>
> On Mon, May 31, 2021, 07:01 Andreas Gruenbacher <agruenba@redhat.com> wro=
te:
>>
>> here's a set of fixes for how gfs2 handles page faults during read and
>> write syscalls.
>
> So how much of this is due to the confusion you just introduced where you=
 pointlessly and incorrectly take an exclusive luck for write faults?
>
> See my reply to that pull request for why it's wrong and pointless.

Those are separate problems. If we treat a write fault as a filesystem
read and only take a read lock as you've explained in your other
reply, we'll still have some remaining locking mode incompatibilities
(gfs2_holder_is_compatible); we probably won't need
iov_iter_fault_in_writeable() though.

>>   The patch queue is ready for merging except for two
>> open issues.
>
>
> There is no way this series is acceptable for 5.13. This kind of change i=
s very much a merge window thing. Much much too late to make fundamental lo=
cking changes. Maybe it can then be backported to stable (including at that=
 point 5.13 of course) if it's been shown to be ok.
>
> This deadlock is not new, we've very much had the same kind of thing when=
 writing to a file in the generic filemap_write() function, where we take t=
he page lock and then copy from user space. If that copy faults, and needs =
the same page for the source due to an odd mmap issue (usually malicious), =
you get a deadlock on the page lock it you aren't careful.

Right, the deadlock isn't new, we just didn't know about it until Jan
Kara pointed it out.

It would be important to us to have the self-recursion case addressed
in 5.13 at least; that's the four patches up to and including "gfs2:
Fix mmap + page fault deadlocks (part 1)".

> I'm surprised that gfs2 hasn't seen this, I thought we had fstests for it=
. And I'd have expected that case to also trigger any internal gfs2 issues,=
 although it's possible that the generic code just does such a good job at =
avoiding the issue that we'd need another test for your case.

fstests didn't catch it, so I wrote a new test (not merged yet):

https://lore.kernel.org/fstests/20210531152604.240462-1-agruenba@redhat.com=
/

Thanks a lot,
Andreas

