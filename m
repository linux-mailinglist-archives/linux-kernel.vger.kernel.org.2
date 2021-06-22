Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDCF3AFD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 08:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFVGvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 02:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhFVGvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 02:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624344526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xmraLWMMpUxRRdYTYdUQ1uuQO8AbwKkAU0NHYrh72eo=;
        b=h/cHHN5ccM625d5UNKiwhyu/S5cMxtxFvowZbhzFM3g6VhHPqSABmeb0FH3WmR073CcAn1
        vzqp4xKiXlInDwoo9IB1XBbwHFbZEMF5fuP6r/+OWKn22lu6ijPfO2sh6YUBLprlqQF66y
        ui38EwQAy0ZwzdhC0/MCuA5IX+niDYs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-q5Q7E9NJOc-JVEz-1cZSSA-1; Tue, 22 Jun 2021 02:48:44 -0400
X-MC-Unique: q5Q7E9NJOc-JVEz-1cZSSA-1
Received: by mail-wr1-f72.google.com with SMTP id l6-20020a0560000226b029011a80413b4fso6002250wrz.23
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 23:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmraLWMMpUxRRdYTYdUQ1uuQO8AbwKkAU0NHYrh72eo=;
        b=IE2kiAuFCp6Ymod0urXhzsbyoHRM0CnTj6+A0mJm7+E5ri8d9bPR0EqZiF70JiSMXw
         hGvDCdceXuyO+pFpe4NPNaT7cdwtVdqupHPbbZLXJ1k244rmJNfzVsz1n1Ra+3rfD2JN
         weF9Hm2yKsAZtNWFPKBA/kqwQ3QlOnZpot7Htt3/QZHJgyCOUsOlA6gd/uZ7gg5NZg9I
         aM/pPxuHErVDDMULM+/2ndQYNA0B1miUAgQTpx+AZ7a8Caa35HfzUmIL3GM4S1hLv7wU
         OMQuLslcC1g1+bEFxp/pwXrB3+33NVkIKcFeH5DAyOkcYf/K7sLv+xJWbxz0c5KlIbi1
         /IDQ==
X-Gm-Message-State: AOAM5331VPNn9UfxCUj90Id6Rc4XjP8NJitUpfrudkk4hY3S5QTRrhQA
        hFDuyErusJPHGB/dtSscXxKdK1WfUIMh6HC6WLMbjhUu14YdRZbOT7xlsOIvCJSLw6E223W8eNl
        sTPnFlMUzpRrvyCQJ/PXG+LmAg++M11QJqX7dVyUe
X-Received: by 2002:a5d:47af:: with SMTP id 15mr2688901wrb.289.1624344523588;
        Mon, 21 Jun 2021 23:48:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzd2FZ6E5eeGyaZjUNatElP6YHoFT1oLzYwouSlDO4Hf2iNZL5IDigTxUsYCjq2uTwfzIRZqH/wZnhL5QgGxU=
X-Received: by 2002:a5d:47af:: with SMTP id 15mr2688887wrb.289.1624344523452;
 Mon, 21 Jun 2021 23:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210611111231.7750bb60@canb.auug.org.au> <20210622113835.58589c3d@canb.auug.org.au>
In-Reply-To: <20210622113835.58589c3d@canb.auug.org.au>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 22 Jun 2021 08:48:32 +0200
Message-ID: <CAHc6FU5QKTVNos5x2uWZ8oCaMu6CEkqpan_zS6i1U2XqRpWyKQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gfs2 tree with the vfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 3:38 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Steven,
>
> On Fri, 11 Jun 2021 11:12:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the gfs2 tree got conflicts in:
> >
> >   Documentation/filesystems/porting.rst
> >   include/linux/uio.h
> >   lib/iov_iter.c
> >
> > between various commits from the vfs tree and the same, older version,
> > of the commits from the gfs2 tree.
> >
> > I fixed it up (I used the vfs tree versions) and can carry the fix as
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts.
>
> I got more conflicts today.
>
> Can we please get that (old, buggy) version of this topic branch
> removed from the gfs2 tree

Done.

Thanks,
Andreas

