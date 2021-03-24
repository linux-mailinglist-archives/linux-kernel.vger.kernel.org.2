Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6783479D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhCXNqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhCXNp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:45:59 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE62BC0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:45:59 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id c13so7850183uao.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUFyhgX5lTiFtnumWIqv5+ST/JL7zHH1di1jLEAniOE=;
        b=feuvdoZB0KoWgkMdq2aH6yVFYEEeELg6t8RC60g3MDH3jsokzX3n6hMkMY/+7VaZMq
         tXkIXW9Hpi5vmrmkTf9NWUWvPh+aZ4SycejWgeI97DnUuKOIIw+EAPw8g0PlP7Mn0tno
         cw0MAWzyc7PKqpaYEjIIt3aAKupGGJDiyAEy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUFyhgX5lTiFtnumWIqv5+ST/JL7zHH1di1jLEAniOE=;
        b=Lcp5haSXjUDlWjq6sgnBSA1IvibLuoBYHq4CLKQearyf7MApZ5SvDfvir0v94+qInS
         1uFSvuqPXT9OgZGlQ2u7Ti16hC6ICBC2E+ay3SnQpAMV5xvat5ktauRKc9YPa0+kvtM+
         vIGdgNzcjHJf9EnF+IZvuLpQUjLxJOVmCd6dlo85TFU7v3gz8gC7inAeJbdOHlNBzYd/
         JTDLC+1BYgqNpiWM3odG6Xdp/0TwOmXtsvSzo5RmzYDS1S5rTUAZmQXx1NDeDgqg2i6E
         I7uOBZPqKMFE0mB1JGYN8Q2vaaAfvLXL8Gc1MuBZCBQR+bIGGbvU3p8CS6Di7zpe9ONg
         Xqzw==
X-Gm-Message-State: AOAM533ambroq322WsGwhVPbTK02oTqO43mg6ZV5uBSufNA09aya2iOv
        Mz+/n5a/WUNzZq3LP79Hiar+9xZEOiOKQfKMIooV8Q==
X-Google-Smtp-Source: ABdhPJyuUqNKT649JUGhrIAsyDnVuNySGilvK+exN/zEkLA5rMT/GwlWIs+rPEF3qas8lWL6UooGDqEu6O+cNTBCsKY=
X-Received: by 2002:ab0:738e:: with SMTP id l14mr1808128uap.72.1616593558885;
 Wed, 24 Mar 2021 06:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210322144916.137245-1-mszeredi@redhat.com> <20210322144916.137245-2-mszeredi@redhat.com>
 <YFrH098Tbbezg2hI@zeniv-ca.linux.org.uk> <CAJfpegvy-bSoorAnPVRUxGjR5s10sJp3qRS0K-O91PcDvLSEPg@mail.gmail.com>
 <YFsv63/2auZZs3ec@zeniv-ca.linux.org.uk>
In-Reply-To: <YFsv63/2auZZs3ec@zeniv-ca.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Mar 2021 14:45:46 +0100
Message-ID: <CAJfpegvwchyTgaV0R=YA+ASOgROpuHmFVgjveaOn6VdC+GCHsg@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] vfs: add miscattr ops
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 1:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Mar 24, 2021 at 09:45:02AM +0100, Miklos Szeredi wrote:

> > Isn't structure initialization supposed to zero everything not
> > explicitly initialized?
>
> All fields, but not the padding...

Ah...  while the structure is unlikely to change, I'll switch to
memset to be safe.

>
> > The one in io_uring() seems wrong also, as a beast needing
> > file_dentry() should never get out of overlayfs and into io_uring:
>
> That one would be wrong in overlayfs as well - we'd better had the
> same names in all layers...

Right.

Thanks,
Miklos
