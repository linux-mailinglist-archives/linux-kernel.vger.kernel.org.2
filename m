Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5866833E70A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCQCgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhCQCfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:35:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D945CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 19:35:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id j3so406224edp.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 19:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GvkSjbOflTYrrhQW/IujV+Vj77yNYWLHdlNlegrHH4E=;
        b=ASGp57d2AB3YJwzE0HztUK7znMoqHLdCpnr808cyahGXOlRg55T2zYUWxFwELsX85a
         rS35PH4RkUyQRe4gbJq52No3U0lb3SmDBGMBrHHk9qd67i95PxSvEvT+Mngdku3IDOLo
         nnwpKbepa9C5Dlkm18/FC8Ew/qk9tKjgUsJpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvkSjbOflTYrrhQW/IujV+Vj77yNYWLHdlNlegrHH4E=;
        b=b+r7of/6+UuI0FV7KYJzxFtuA7kv2c9de3HofRWzWMQqt9N8A+Fwy+np7D6EYq4vTs
         oNb3kYgoxgLOzSdsqmv8qb2H3O3wbPDsFe2lVg1CzFCabhHtk4bbAdqRM+Tjdbu9NuBq
         Ig0EU9v9qAb81JrrFtICQv/5MXywsSEXTOA6T7bWIhcCdNIunBPrzTkneBAPjCzdHMD7
         bBXzFfstcBPvkRLbf0k2shHjUGywU/UoftL0leIyhklxHy1X+55yJUsdAwmC5rImHeqt
         8f3/NW8OPgxcwsoKPQkB37nemy8RCtl3e0apGObqDOuRkT9M7kNWR4/Oz1J2nFYpHyMA
         cmuA==
X-Gm-Message-State: AOAM532+jrmoPEPapNbEYVXlxnmX6/uirK42JPHJCSrBzKLZlgFSH1fX
        LBRXYMefep0ixoxFE8RbKiy6ojcKokOa+Q==
X-Google-Smtp-Source: ABdhPJzStM2BaQiP8jtmHJKAiTPwZ9blhCC+L7RNMLs+3B0l8sDsWC3xN5bfDmhcTkmxZ1sESTnMyw==
X-Received: by 2002:aa7:da14:: with SMTP id r20mr38839441eds.181.1615948544408;
        Tue, 16 Mar 2021 19:35:44 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id z20sm5680422edd.0.2021.03.16.19.35.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 19:35:44 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id bf3so430972edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 19:35:44 -0700 (PDT)
X-Received: by 2002:a05:6512:398d:: with SMTP id j13mr922688lfu.41.1615948533286;
 Tue, 16 Mar 2021 19:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
 <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk>
 <20210316190707.GD3420@casper.infradead.org> <CAHk-=wjSGsRj7xwhSMQ6dAQiz53xA39pOG+XA_WeTgwBBu4uqg@mail.gmail.com>
 <887b9eb7-2764-3659-d0bf-6a034a031618@toxicpanda.com>
In-Reply-To: <887b9eb7-2764-3659-d0bf-6a034a031618@toxicpanda.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Mar 2021 19:35:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWoJhGeMn85LOh9FX-5d2-Upzmv1m2ZmYxvD31TKpUTA@mail.gmail.com>
Message-ID: <CAHk-=whWoJhGeMn85LOh9FX-5d2-Upzmv1m2ZmYxvD31TKpUTA@mail.gmail.com>
Subject: Re: [PATCH v4 02/28] mm: Add an unlock function for PG_private_2/PG_fscache
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 7:12 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
>
> Yeah it's just a flag, we use it to tell that the page is part of a range that
> has been allocated for IO.  The lifetime of the page is independent of the page,
> but is generally either dirty or under writeback, so either it goes through
> truncate and we clear PagePrivate2 there, or it actually goes through IO and is
> cleared before we drop the page in our endio.

Ok, that's what it looked like from my very limited "looking at a
couple of grep cases", but I didn't go any further than that.

> We _always_ have PG_private set on the page as long as we own it, and
> PG_private_2 is only set in this IO related context, so we're safe
> there because of the rules around PG_dirty/PG_writeback. We don't need
> it to have an extra ref for it being set.

Perfect. That means that at least as far as btrfs is concerned, we
could trivially remove PG_private_2 from that page_has_private() math
- you'd always see the same result anyway, exactly because you have
PG_private set.

And as far as I can tell, fscache doesn't want that PG_private_2 bit
to interact with the random VM lifetime or migration rules either, and
should rely entirely on the page count. David?

There's actually a fair number of page_has_private() users, so we'd
better make sure that's the case. But it's simplified by this but
really only being used by btrfs (which doesn't care) and fscache, so
this cleanup would basically be entirely up to the whole fscache
series.

Hmm? Objections?

            Linus
