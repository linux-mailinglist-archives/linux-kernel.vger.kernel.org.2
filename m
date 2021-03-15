Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90333B36B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhCONO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCONOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:14:47 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE222C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 06:14:46 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id z65so16267266vsz.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IpQmsQmwP07n7XM/oRApl7doOzXfiJ6Bu1zNbhk/39k=;
        b=mgoOqqUJ7y0PsiCNRiWoJuVBzC0v2z8pc64OFxFninFmUPhNBhvvciEbJlBKl9tNBE
         N+l3LwDvPMb3AxLnlxBobNbDLTqoDgYlYwcr3ADHXEVnM9wwvo2Ptq3wM04VUokreVZo
         /rKrP/5E2NQs5y+OBT5XHIUCogGhRVILidOC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IpQmsQmwP07n7XM/oRApl7doOzXfiJ6Bu1zNbhk/39k=;
        b=Ht6W3uM5FFeERjFDxVpmRSU82XgD9rUGyK060ZajBhvie61zGvbXI4OBCi1KI7WUyt
         d1Pkc6MefSEW/TQE/Uo6rCwgJ53jblmEDFmWBosLdLcpzAmFZhq+7gBzph2KNZDoRlzk
         OCnb51b8Zj5JvXKZE7B/PuHojsPJxbGC1k5Ydji/zIwvT3Ot6nm8eJFlXjLwoZkb1qlG
         i2FJOVDXIiFcHn/G6m2ddW3aN6MWOjsrS4PeClsE5bWktOXUh/cwGar0KFKW/5c0cJyl
         iENcVm8wmNJvh0JuJ/xg2sJb7MaflvIqUtNlkGbQYfg7waZkU2FVa3HBwoEEpjqVqOgU
         mGsw==
X-Gm-Message-State: AOAM531O+m60BpXAXtdpmVO5ekm0+Jbfx0hDyG0Tt+/yl1A/nBJMLHFl
        kAKzJ02xvYsZ0Q9/dOtbb9Yai9kREqSzQH/3xDAKpg==
X-Google-Smtp-Source: ABdhPJypkUXvOBm/N7VaCipn7J+yso1uxDQvzsMYyOPCzU3D3idPNkHp5Y+pYfAlSF4GYbjT620NM6cTsEamEZRi9vw=
X-Received: by 2002:a67:8793:: with SMTP id j141mr5072390vsd.7.1615814086066;
 Mon, 15 Mar 2021 06:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
In-Reply-To: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 15 Mar 2021 14:14:35 +0100
Message-ID: <CAJfpegsb9XrUct5zawN+kS_DSfowBf2BnrZzG+cQXUvsGZZuow@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] vfs: Use an xarray instead of inserted bookmarks
 to scan mount list
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 1:07 PM David Howells <dhowells@redhat.com> wrote:
>
>
> Hi Al, Mikl=C3=B3s,
>
> Can we consider replacing the "insert cursor" approach we're currently
> using for proc files to scan the current namespace's mount list[1] with
> something that uses an xarray of mounts indexed by mnt_id?
>
> This has some advantages:
>
>  (1) It's simpler.  We don't need to insert dummy mount objects as
>      bookmarks into the mount list and code that's walking the list doesn=
't
>      have to carefully step over them.
>
>  (2) We can use the file position to represent the mnt_id and can jump to
>      it directly - ie. using seek() to jump to a mount object by its ID.

What happens if the mount at the current position is removed?

Thanks,
Miklos
