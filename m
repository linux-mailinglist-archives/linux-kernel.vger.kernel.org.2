Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D0D3D65B3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbhGZQrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbhGZQqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:46:55 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD013C09B12B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:15:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id f12so12205024ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nCFSPU1gol0E4rDrQO0oADKpQ2235snVgYBEAYRF9Y=;
        b=FxPJdanONOHHlkh8d+J5uVuVxTrNApcx9MiCzLB+nhd8tO35LqWJyHr+nxkh4eWigS
         ZNzz6/AWWNqMLc+6W91Fb7ndI1UZV6LZf2IS1/3v1vXYt+73u2Zxzb6gTHcdLl3xf0YV
         A1H174iotHYgi5TQ4Xu9vzheCPDn7kIx+3FPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nCFSPU1gol0E4rDrQO0oADKpQ2235snVgYBEAYRF9Y=;
        b=k7MSTC/ghLHJJky3lxKhAgLouC2vqx1KVP3GpPK1hFQMiPrJzZkjZemEanskG+bmss
         wtp1gcXS87DRAxpDHgeGtv+6Lr1M28+hU8BxFlee1qdGHO5PhoCeollTE4tRetyBzFLK
         MCPkAGCJ7ez39IDfbp0QR4p+k2t1HUB0IAdhrR1a3s2QPbR2VzDSbMbRznsceGbXFj1b
         cToK0gph+3UaQ64muumwBod8oHflzcTO2SX1MsvCOk3jRtrULU5pVecWKz3rx92ZRWam
         xhC+1hMKnB4YkzErTwiqNVenV2U7Vb36buRFmjcdxxsBQ5686DZS+Rwwtqg/8lq33FW2
         NDAA==
X-Gm-Message-State: AOAM530tf4U2qB3FPgjdA1HfmX+02ROJ0vU7X9v7WGEr1BSjEXKRUtxT
        H2p7C93CpnGx2aHXzymKKm1eAaWnaT3YJB+b
X-Google-Smtp-Source: ABdhPJyXIw9IUDxiREo9SalblWzS14f+l05i849bkbt/VqNJSTwXsqXdiz0HgWzqSLcsKecxP3iA6A==
X-Received: by 2002:a2e:b522:: with SMTP id z2mr13026074ljm.278.1627319749847;
        Mon, 26 Jul 2021 10:15:49 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id j2sm21048ljc.49.2021.07.26.10.15.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 10:15:48 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id m9so12151465ljp.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:15:47 -0700 (PDT)
X-Received: by 2002:a2e:3212:: with SMTP id y18mr12834084ljy.220.1627319747365;
 Mon, 26 Jul 2021 10:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210723205840.299280-1-agruenba@redhat.com> <20210723205840.299280-2-agruenba@redhat.com>
 <20210726163326.GK20621@quack2.suse.cz>
In-Reply-To: <20210726163326.GK20621@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Jul 2021 10:15:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqOZmRT_gmAS+K9sA7EYCKM9BYzvJMhy1_P6JaaVGvfA@mail.gmail.com>
Message-ID: <CAHk-=wgqOZmRT_gmAS+K9sA7EYCKM9BYzvJMhy1_P6JaaVGvfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] iov_iter: Introduce fault_in_iov_iter helper
To:     Jan Kara <jack@suse.cz>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 9:33 AM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 23-07-21 22:58:34, Andreas Gruenbacher wrote:
> > +     gup_flags = FOLL_TOUCH | FOLL_POPULATE;
>
> I don't think FOLL_POPULATE makes sense here. It makes sense only with
> FOLL_MLOCK and determines whether mlock(2) should fault in missing pages or
> not.

Yeah, it won't hurt, but FOLL_POPULATE doesn't actually do anything
unless FOLL_MLOCK is set. It is, as you say, a magic flag just for
mlock.

The only ones that should matter are FOLL_WRITE (for obvious reasons)
and FOLL_TOUCH (to set the accessed and dirty bits, rather than just
th protection bits)

                   Linus
