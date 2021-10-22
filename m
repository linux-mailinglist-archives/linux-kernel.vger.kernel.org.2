Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D736437F50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhJVU1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhJVU12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:27:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE10C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 13:25:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id n7so782119ljp.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 13:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VL4lca6iHsx6oQ/wg6H7clLpP/uNe7ZsGNa7hBqT+88=;
        b=Xm2NbmUwKJoW+515TkyEWt2nuCvePzoqxLYJAFPnOe+lbdK5JzMmyaBBRaBeBIIVr6
         5Y2Ltv7T1OVUR3yQVc1hEpZ4faavbhalIte0tSbwN89GggYecoOBuJphVvusUfCFdqxX
         UgjPbDpPnxZpf2xYUJtsUcqxyBe+gW6XgMyZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VL4lca6iHsx6oQ/wg6H7clLpP/uNe7ZsGNa7hBqT+88=;
        b=XUPiicrhTtS56ttKoajPn9s1+kGAsjG+Pjcu7YwM9fSIT3Q8lUwE8DW9ZzJqffgrkR
         /IKQBZNoZ5PNEuj3zTyH9YF8b0WWJk8aLJZaAdWG8AXZT2mmlZ8jr9KV+UHCnmiaAo8m
         7SSfepHQefw/5OixtbLVjwIFe8Eih8kOWR90Gio9qvBN8J/uLR/xKm9QcPrmKqKg2hPL
         AFLhFmk24zVjrCpj38b1oHUi2MiyhVCS9hVfnCBrwD0rfQld/iBHpXuV2eLsoftG/GQm
         8rxgqJSRfpq0CH0pOfGoBVrf6K59CQ+05xoR+u3qADhnKwo1LowbnzEcKvsYdDywcQBh
         Q4/w==
X-Gm-Message-State: AOAM531mmnLoDc+9uDinJjMek2nxC0exaAqtJaDl4omXQQHk9xoH1byG
        DEHdBYBtZT5W7qupA1c+3mkwLqcWy8Q3VS6BEhI=
X-Google-Smtp-Source: ABdhPJwlpHsKPmzFYAiGx/tRVlpsVw9GZ1Odn5aT0Vu9nhZKmSbBxQCrjGbixJ724iDX81/cUTC8xw==
X-Received: by 2002:a2e:9c94:: with SMTP id x20mr2069659lji.5.1634934308951;
        Fri, 22 Oct 2021 13:25:08 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id i12sm823691lfb.234.2021.10.22.13.25.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 13:25:08 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id o26so1075183ljj.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 13:25:08 -0700 (PDT)
X-Received: by 2002:a2e:9945:: with SMTP id r5mr2174611ljj.249.1634934297582;
 Fri, 22 Oct 2021 13:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
 <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com>
 <1041557.1634931616@warthog.procyon.org.uk> <CAHk-=wg2LQtWC3e4Z4EGQzEmsLjmk6jm67Ga6UMLY1MH6iDcNQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg2LQtWC3e4Z4EGQzEmsLjmk6jm67Ga6UMLY1MH6iDcNQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 10:24:41 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi7K64wo4PtROxq_cLhfq-c-3aCbW5CjRfnKYA439YFUw@mail.gmail.com>
Message-ID: <CAHk-=wi7K64wo4PtROxq_cLhfq-c-3aCbW5CjRfnKYA439YFUw@mail.gmail.com>
Subject: Re: [PATCH v2 00/53] fscache: Rewrite index API and management system
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 9:58 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> and if (c) is the thing that all the network filesystem people want,
> then what the heck is the point in keeping dead code around? At that
> point, all the rename crap is just extra work, extra noise, and only a
> distraction. There's no upside that I can see.

Again, I'm not a fan of (c) as an option, but if done, then the
simplest model would appear to be:

 - remove the old fscache code, obviously disabling the Kconfig for it
for each filesystem, all in one fell swoop.

 - add the new fscache code (possibly preferably in sane chunks that
explains the parts).

 - then do a "convert to new world order and enable" commit
individually for each filesystem

but as mentioned, there's no sane way to bisect things, or have a sane
development history in this kind of situation.

                Linus
