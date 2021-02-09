Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB803158BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 22:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhBIVh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 16:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhBITIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:08:01 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814F6C061356
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:06:59 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f1so30076608lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tHDrQ7k7QBExa6hxOU6qMztojmSPjc893LQ4fde7dg=;
        b=akIN38EhQAi1EJYSeLBzpY86D4HcP1JFpL9GOZ+0RTnCkorkEfcVrIAVKTL3jMnG1S
         wB2qolfwaFv21H7u2zEEkvnFpGX1nEHeJ1S4J1sfz5c5YnXEdHBQ4kH64G0jT9/l9/e6
         eD4OPnbfiSTjG9KsSbeEkIcjaKRrzYZYK/x80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tHDrQ7k7QBExa6hxOU6qMztojmSPjc893LQ4fde7dg=;
        b=bsuRHztl2XbjmYLaJeL051bIK7ingCJjLldQrmqlhlxp+uRQKr/2b2MP910h9GQI0R
         J+Zq2KkqBk3yMFu9kBt8VfsVqZU06OsjZVamWF3tUSpuWf/25TVMuvD5lfIruHxW5OEV
         AlkWhoIzzGWKxUF8aoYFFtq6awwr3AYemykyBw7Fp/r5/KoUTThj2uK7LyB0TIWRn7ZJ
         6NMXZZW7QhFNLrg/B59wR24K/yHXsY0SHD2/oxbX8j2RxsG2ySDGiGj9H46F6RGU8IWp
         +ERi1UOnZ5gZ4pQ7IyRmUEK+YtJyb39auqs1Qvqs7Uup0nI1346Wm4C+20tN5trB8iDJ
         FxPQ==
X-Gm-Message-State: AOAM530QbEllPWT4fbdjXbwP/RfHgsz39aB5xvC2ZiF6RWLzdjk44iGW
        dED3wqoRTfsdWILA/lZAJx5DEcWGvbesnw==
X-Google-Smtp-Source: ABdhPJzsIXg7+AK1iK+qgCScbiDyTr4ME3IweW4Q1MGFaYj/VKvpczcuDSuV+JhMBvHr7aztjRuvTg==
X-Received: by 2002:a19:e41:: with SMTP id 62mr9179658lfo.128.1612897617903;
        Tue, 09 Feb 2021 11:06:57 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id t27sm1241212ljk.132.2021.02.09.11.06.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:06:57 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id f1so30076536lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:06:57 -0800 (PST)
X-Received: by 2002:a19:c14c:: with SMTP id r73mr13646015lff.201.1612897616810;
 Tue, 09 Feb 2021 11:06:56 -0800 (PST)
MIME-Version: 1.0
References: <591237.1612886997@warthog.procyon.org.uk>
In-Reply-To: <591237.1612886997@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Feb 2021 11:06:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
Message-ID: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I'm looking at this early, because I have more time now than I will
have during the merge window, and honestly, your pull requests have
been problematic in the past.

The PG_fscache bit waiting functions are completely crazy. The comment
about "this will wake up others" is actively wrong, and the waiting
function looks insane, because you're mixing the two names for
"fscache" which makes the code look totally incomprehensible. Why
would we wait for PF_fscache, when PG_private_2 was set? Yes, I know
why, but the code looks entirely nonsensical.

So just looking at the support infrastructure changes, I get a big "Hmm".

But the thing that makes me go "No, I won't pull this", is that it has
all the same hallmark signs of trouble that I've complained about
before: I see absolutely zero sign of "this has more developers
involved".

There's not a single ack from a VM person for the VM changes. There's
no sign that this isn't yet another "David Howells went off alone and
did something that absolutely nobody else cared about".

See my problem? I need to be convinced that this makes sense outside
of your world, and it's not yet another thing that will cause problems
down the line because nobody else really ever used it or cared about
it until we hit a snag.

                  Linus
