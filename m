Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3693A42C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhFKNNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:13:53 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:36764 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhFKNNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:13:52 -0400
Received: by mail-ua1-f53.google.com with SMTP id p9so2554596uar.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ULZVsXvT2HWlmGZYxfKYKgrZf9KLwBei15Frc9B25c=;
        b=nuOQjiPW7qizfzMdFAja/sKz6cdXjNB7Mn+HG80ezLRvTPTrXB5lxVMrVhybLt2m1b
         1MZM2J0iFj7Q6cawbgc95NUqlyLgzp0cgELPpnqEyJWL8YiUghB9oHHvEsKXTLvWDxLP
         JbrnAujJc5JHU0pKYSWXL5p6nmY44LrFjvsWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ULZVsXvT2HWlmGZYxfKYKgrZf9KLwBei15Frc9B25c=;
        b=e5AYxL0oCPBo6mXBB0DSaaZ4C7WunNoVshl/ZlKcr3qTCCnP0RA0rEBHulH3hDogM7
         dT+hPhTVkm8tdtQjdCjx1DSXnTm8ZhD3ncVkzU099EAbNQUEhrH7gvqKnP33J3XS/Bzs
         VmLBxzN4kxn9/9ch2ctiFVrezRwtoMJVl1ChHoRMjudMslmHqXMkQanZ8InH4XUAF595
         GCodxOKjSgxmriAPw6YTpXIluahIiA+jufaXr7iuBm55416PofuEwTouJH+zSEl/cCck
         UcFKGed+imk/DlDonkgWTcU7qUc5U8z8k04Fb87q4lBljTwlQMvqo0n/gg3CkJN09QXU
         WHgQ==
X-Gm-Message-State: AOAM531uemMVpUIy9UcLIvYKCWkBIwXzBSGkQpZFAbuznBD+D6B3m8Ow
        k/NsB3i30q8x00zhIqETUMTi63zUied3lDRCd3CaKA==
X-Google-Smtp-Source: ABdhPJxPS0mDaIGCeVXxm2D+lYVnEuJ1+nkfFx19XGdGkj34Eko9bByukiyVFRVwTUlEcr9jUqp3EPSD4r25mrVnFak=
X-Received: by 2002:ab0:2690:: with SMTP id t16mr2902103uao.9.1623417054643;
 Fri, 11 Jun 2021 06:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322865230.361452.5882168567975703664.stgit@web.messagingengine.com>
In-Reply-To: <162322865230.361452.5882168567975703664.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Jun 2021 15:10:44 +0200
Message-ID: <CAJfpegsVjpnhUm8-JzQgYigT6OHYXeui83ztrstCmcZLey1Y2g@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] kernfs: switch kernfs to use an rwsem
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 at 10:51, Ian Kent <raven@themaw.net> wrote:
>
> The kernfs global lock restricts the ability to perform kernfs node
> lookup operations in parallel during path walks.
>
> Change the kernfs mutex to an rwsem so that, when opportunity arises,
> node searches can be done in parallel with path walk lookups.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
