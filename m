Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD9734AE41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhCZSJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhCZSJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:09:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F4FC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:09:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a7so9767168ejs.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJYWZrUOznq0gpgX+7FMB7DloEhRAZMNbdCMtRU9Qgc=;
        b=o2nny/72vAvvu3xrH7brAGF8mlfk7Odb4OIATJAM4GtkSimXsGri85d7ZnWgnsR+pi
         RKXwu9zm92uG0OLTPMoDqrarq5wip8a/V9b64KeN09SP1KPWUkcZq81Sr6aXZT/ZO2IB
         6DCnrzYJTPzb/WuSdNP5cQeeF7P9xYRy2Qob1MZ9B7Z46Rmiabl+iCjAR1b08XG6wG+i
         EILmXXBUICz4XZJJ+yUoxDYdFDJQcsy7JhyghCTFHx4gO5LB/myplcKn0xyU1oW7YqD+
         GEeHufTFCBuyAY1LBhzHoyLEDmDW4ul80u8zSRXrgrk7SLeBA3pWoTQwVAgH4Kj9mowu
         37ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJYWZrUOznq0gpgX+7FMB7DloEhRAZMNbdCMtRU9Qgc=;
        b=MFhISsDieIauVDzANozXA86+BWPwuknT7it9eun0N1daqzrtjF2RMxdakqOaCTgxJV
         4ms1QLk2bQz4vSCOJnjLmIyGGFzFztem7ufk3YcGEagAGPj5p9pWAvcl7u4Vp9GfKddN
         5dkLwpv6c46p+ipmCLrmLlRrwXXwvsH2zA8ysjLwnd57b6HepPq6m1PgD1oZfjamPevG
         F9qATAtKXNkKtuTWUWibFscvavc90RRSbjYZcp2iANCADhHdxxHpzXKwfgDTA6Uq4mqk
         yFHGfN7iJ3aYKjRk+b1f2OizXOCKMS707qjPhz13m6vfd7+sl/SF7ENQmzgKoc6ILb6r
         sgOg==
X-Gm-Message-State: AOAM533qA6Va3us1BgIuhn7bIJPT0H26/jHSiypd9ZNbk7zoX0CpK13L
        NGamXRSDqsTU9O9DCtGn3k7kuBvLOyhzLmEv8bQQ+pv9zM0=
X-Google-Smtp-Source: ABdhPJyrMPX9Hu9Cddt1IC5mdi2AfAIfufvUOht7vRbfCSAB+9QKFnAtUccbaxh0zGkwtUKrAd8aTymLA4kJ2BkrNec=
X-Received: by 2002:a17:907:33cd:: with SMTP id zk13mr16676396ejb.224.1616782156485;
 Fri, 26 Mar 2021 11:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com> <20210323182520.2712101-1-bgeffon@google.com>
 <20210323182520.2712101-4-bgeffon@google.com> <9c0b4b2a-3678-186a-072a-280628e5da02@gmail.com>
In-Reply-To: <9c0b4b2a-3678-186a-072a-280628e5da02@gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Fri, 26 Mar 2021 11:08:40 -0700
Message-ID: <CADyq12wc9=dt5V=YEr+U9JLP1VObG_UOsGaQUDH88WAZH-4Txg@mail.gmail.com>
Subject: Re: [PATCH] mremap.2: MREMAP_DONTUNMAP to reflect to supported mappings
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,
It has not landed yet, it's currently in Andrew's mm tree. I can reach
out again when it makes it into Linus' tree.

Brian


On Thu, Mar 25, 2021 at 2:34 PM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
>
> Hello Brian,
>
> Is this already merged in Linux?  I guess not, as I've seen a patch of
> yous for the kernel, right?
>
> Thanks,
>
> Alex
>
> On 3/23/21 7:25 PM, Brian Geffon wrote:
> > mremap(2) now supports MREMAP_DONTUNMAP with mapping types other
> > than private anonymous.
> >
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >   man2/mremap.2 | 13 ++-----------
> >   1 file changed, 2 insertions(+), 11 deletions(-)
> >
> > diff --git a/man2/mremap.2 b/man2/mremap.2
> > index 3ed0c0c0a..72acbc111 100644
> > --- a/man2/mremap.2
> > +++ b/man2/mremap.2
> > @@ -118,16 +118,6 @@ This flag, which must be used in conjunction with
> >   remaps a mapping to a new address but does not unmap the mapping at
> >   .IR old_address .
> >   .IP
> > -The
> > -.B MREMAP_DONTUNMAP
> > -flag can be used only with private anonymous mappings
> > -(see the description of
> > -.BR MAP_PRIVATE
> > -and
> > -.BR MAP_ANONYMOUS
> > -in
> > -.BR mmap (2)).
> > -.IP
> >   After completion,
> >   any access to the range specified by
> >   .IR old_address
> > @@ -227,7 +217,8 @@ was specified, but one or more pages in the range specified by
> >   .IR old_address
> >   and
> >   .IR old_size
> > -were not private anonymous;
> > +were part of a special mapping or the mapping is one that
> > +does not support merging or expanding;
> >   .IP *
> >   .B MREMAP_DONTUNMAP
> >   was specified and
> >
>
> --
> Alejandro Colomar
> Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
> http://www.alejandro-colomar.es/
