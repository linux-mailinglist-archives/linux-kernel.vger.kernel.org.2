Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62CE437E89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 21:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhJVTYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 15:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbhJVTYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:24:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD027C061767
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:21:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d3so5296794edp.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MIYbiqTAgOZcVD7o78/iMiC5v0PdYgNzQoieL1dnhA=;
        b=NpDhMd+K20exoXtDQK8VxJJZx2jeiKfduhNixPkqDW3AhUt9xwYIfDXlKXTXwxZNO2
         rNDgVo6Zt+p6dmQo5I+h/tgPznlF+wHZKxE1z8e+Cg4jyabcAJUUy8ldhvdjRTw7E0CK
         ZCzjOxlNRUs2SJlFmk4Z3ttWsxuy0Et3Uj530=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MIYbiqTAgOZcVD7o78/iMiC5v0PdYgNzQoieL1dnhA=;
        b=R0BSE22EsF1yEhF9/Wu0IAQ6AUsltxzS75Tfx7sSDTFMDbsT4M3I6w3RDBDUUbY+qS
         Drdp+tojawsxcPpRXzyANJQ6F8/fkQBQ4UcKV4DtJkZIyhz45R2Iy6QL5UWKhIsm4ERC
         D/20b+qG5ld4094w4Nl4UrXeF4P3HUemtIl0sPf0eG/DvIndcmYC8Yh9LB4k5+F8MDQ1
         3X34NLBe4HxZME0p9QwHF7KFLJttNNMOus86NFFcKF5veVIoSFNYgMUqoI9WyUIphoo1
         hPO/wyrq1Twcbxn74dMguDP+4CVo7T13ztIapfb/PATb+d0GurvG7SlDFCIAbXROspyq
         ZvxQ==
X-Gm-Message-State: AOAM531px6AtK+430tZ4O0LYG7+3CQ0zq7u5iSZ01ZuHChtyJzXYeUXV
        PFOvkNwfTBZxm5V4iiM9wUbqUtEEegU7jCS29wg=
X-Google-Smtp-Source: ABdhPJwOLz5hNo5wR5S3xPAAoNXyUkRj0HmSCIGokFF1mYNisiXCV1zsG/xoBsu9kOQL3HFKSyHztg==
X-Received: by 2002:a17:906:5a47:: with SMTP id my7mr1731624ejc.128.1634930502014;
        Fri, 22 Oct 2021 12:21:42 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id u4sm4067605ejc.19.2021.10.22.12.21.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 12:21:41 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id d3so5296611edp.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:21:41 -0700 (PDT)
X-Received: by 2002:a19:ad0c:: with SMTP id t12mr1362164lfc.173.1634930491229;
 Fri, 22 Oct 2021 12:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 09:21:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com>
Message-ID: <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com>
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

On Fri, Oct 22, 2021 at 8:58 AM David Howells <dhowells@redhat.com> wrote:
>
> David Howells (52):
>       fscache_old: Move the old fscache driver to one side
>       fscache_old: Rename CONFIG_FSCACHE* to CONFIG_FSCACHE_OLD*
>       cachefiles_old:  Move the old cachefiles driver to one side

Honestly, I don't see the point of this when it ends up just being
dead code basically immediately.

You don't actually support picking one or the other at build time,
just a hard switch-over.

That makes the old fscache driver useless. You can't say "use the old
one because I don't trust the new". You just have a legacy
implementation with no users.

              Linus
