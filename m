Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0C2315BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbhBJBLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbhBIWhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:37:02 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A7AC06121C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 13:25:32 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id w36so17014492lfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 13:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NXrj70SaJJJRtMQWC0+3w4cmGywCfZjtndBL9rb8Bo=;
        b=g8n7RWB/hph+MNS6KsfC0GffC4feoLtbwfzXkMDO5VGlvyK682yT02RPRIOW6hieUR
         nxG1Mlzbyp5mtI1Do4dwBB4pr2NfNtLSNxuXGIfX+Az+7iAT6uxAH+/kuEuPZoNDiHrT
         JX8A9+J4I4DIw7KDC1ACDk8XTP+nwuXWBZL+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NXrj70SaJJJRtMQWC0+3w4cmGywCfZjtndBL9rb8Bo=;
        b=doHFSEx0AO4sT3tsqeAPTmdTerAud4Hm05c0E+WKzmWYNoJZfMC+NuJ0rFPHRKGf/v
         QrFZlJbqSjXIxc4XxnLYziBBIJn3MjW/8nRkqKXExkZdLRDe41G7wd4T4ffSRfQOU3UG
         T6VLOqkXNjeOydCx/OAoUgF4rKaG0pD4oteKfXNOJOHWr/hFPzdWQSUFcB+ZXuN9Azra
         P3863/4yakW4n+GO69tW76F9TCV8gNdC3HFDVBjTvPyIQlqs+Ou2apXSKS98QwTCszbT
         DWnfXJxBxPyDGivh9+i7C4LpDsjycqcUT7eG8FBonMCalm/Xs3feXycRN1/bTh5IJgCH
         CBxA==
X-Gm-Message-State: AOAM53137XINZlUJM8KQ68u7UnAEmOqIwqRpy8CK9d3LRRKIeTJ8pxrZ
        ExlCypyixL3xH9jsKaZBT+cWaqMvk4kKpw==
X-Google-Smtp-Source: ABdhPJzHxaGIFIWlgruYYh5StTYhkFy4WFl+M7RUObzQaM6MiB1sgq3BdndC3AW0qbfoOySxLOAkeA==
X-Received: by 2002:a05:6512:234d:: with SMTP id p13mr14062543lfu.87.1612905930630;
        Tue, 09 Feb 2021 13:25:30 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m7sm2736561lfg.289.2021.02.09.13.25.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 13:25:30 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id f1so30640435lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 13:25:30 -0800 (PST)
X-Received: by 2002:a2e:b1c8:: with SMTP id e8mr15253931lja.251.1612905557284;
 Tue, 09 Feb 2021 13:19:17 -0800 (PST)
MIME-Version: 1.0
References: <591237.1612886997@warthog.procyon.org.uk> <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
 <20210209202134.GA308988@casper.infradead.org>
In-Reply-To: <20210209202134.GA308988@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Feb 2021 13:19:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com>
Message-ID: <CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
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

On Tue, Feb 9, 2021 at 12:21 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Yeah, I have trouble with the private2 vs fscache bit too.  I've been
> trying to persuade David that he doesn't actually need an fscache
> bit at all; he can just increment the page's refcount to prevent it
> from being freed while he writes data to the cache.

Does the code not hold a refcount already?

Honestly, the fact that writeback doesn't take a refcount, and then
has magic "if writeback is set, don't free" code in other parts of the
VM layer has been a problem already, when the wakeup ended up
"leaking" from a previous page to a new allocation.

I very much hope the fscache bit does not make similar mistakes,
because the rest of the VM will _not_ have special "if fscache is set,
then we won't do X" the way we do for writeback.

So I think the fscache code needs to hold a refcount regardless, and
that the fscache bit is set the page has to have a reference.

So what are the current lifetime rules for the fscache bit?

             Linus
